package com.privilegecard.privilegecard.repository;

import com.privilegecard.privilegecard.entity.LoginUser;
import com.privilegecard.privilegecard.entity.MenuContent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface LoginUserRepository extends JpaRepository<LoginUser, Long> {

    /* ============================================================
     * Used by ErpUserDetailsService — load user WITHOUT password
     * ============================================================ */
    @Query(value = "SELECT s.digitalsignature, s.employeeid, s.aliasname, e.employeename, e.employeecode, " +
            "       e.designationid, c.designationname, d.departmentid, d.departmentname, o.officeid, " +
            "       e.divisionid, dv.divisionname, o.officename, o.officecategoryid, o.officenamewithtrust, " +
            "       ec.attributevalue AS servermode, TO_CHAR(CURRENT_DATE, 'DD-MM-YYYY') AS currentdate, " +
            "       TO_CHAR(CURRENT_TIMESTAMP, 'DD-MM-YYYY HH24:MI:SS') AS currentdatetime " +
            "FROM usermanager.signature s " +
            "JOIN usermanager.employees e        ON s.employeeid   = e.employeeid " +
            "JOIN usermanager.departments d      ON d.departmentid = e.departmentid " +
            "JOIN usermanager.designations c     ON c.designationid= e.designationid " +
            "JOIN workforce.divisions dv         ON dv.divisionid  = e.divisionid " +
            "LEFT JOIN erpsystem.vuoffices o     ON o.officeid     = e.officeid " +
            "JOIN usermanager.erpconfig ec       ON ec.configid    = 1 " +
            "WHERE UPPER(s.aliasname) = UPPER(:aliasName) " +
            "  AND s.validitystatus = 1", nativeQuery = true)
    LoginUser findByAlias(@Param("aliasName") String aliasName);


    /* ============================================================
     * Used by ErpUserDetailsService — retrieve password hash
     * ============================================================ */
    @Query(value = "SELECT s.password FROM usermanager.signature s " +
            "WHERE UPPER(s.aliasname) = UPPER(:aliasName) " +
            "  AND s.validitystatus = 1", nativeQuery = true)
    String findPasswordHashByAlias(@Param("aliasName") String aliasName);


    /* ============================================================
     * MENUS
     * ============================================================ */
    @Query(value = "SELECT mm.menuid AS mainmenuid,  COALESCE(sm.menuid, 0) AS submenuid, COALESCE(pm.menuid, 0) AS popupmenuid, " +
            "                mm.menudisplayname AS mainmenuname, COALESCE(sm.menudisplayname, '') AS submenuname, " +
            "                COALESCE(pm.menudisplayname, '') AS popupmenuname, " +
            "                COALESCE(sm.menulinkname, '')    AS submenupage, " +
            "                COALESCE(pm.menulinkname, '')    AS popupmenupage " +
            "            FROM usermanager.menus mm " +
            "            JOIN usermanager.modulewiseusers uwmr ON uwmr.moduleid = mm.moduleid AND uwmr.employeeid = :employeeId " +
            "            LEFT JOIN usermanager.menus sm ON mm.menuid = sm.parentmenuid AND sm.menulevel = 2 " +
            "            LEFT JOIN usermanager.menus pm ON sm.menuid = pm.parentmenuid AND pm.menulevel = 3 " +
            "            WHERE mm.menulevel = 1  AND ( " +
            "                    sm.menuid IN (SELECT um1.menuid FROM usermanager.userwisemenuaccessrights um1 WHERE um1.employeeid = :employeeId)\n" +
            "                 OR pm.menuid IN (SELECT um2.menuid FROM usermanager.userwisemenuaccessrights um2 WHERE um2.employeeid = :employeeId)\n" +
            "              ) " +
            "            ORDER BY mm.menusortnumber, mm.menudisplayname, sm.menusortnumber, sm.menudisplayname, pm.menusortnumber, pm.menudisplayname", nativeQuery = true)
    List<MenuContent> findMenusNative(@Param("employeeId") long employeeId);


    /* ============================================================
     * USER LOG — LOGIN
     * ============================================================ */
    @Modifying
    @Transactional
    @Query(value = """
        INSERT INTO usermanager.userlog
            (officeid, employeeid, loginoutdatetime, accesstype, logouttype, ipaddress)
        VALUES (:officeId, :employeeId, CURRENT_TIMESTAMP, :accessType, :logoutType, :ipAddress)
        """, nativeQuery = true)
    void recordLogin(@Param("officeId")   long officeId,
                     @Param("employeeId") long employeeId,
                     @Param("accessType") int accessType,
                     @Param("logoutType") int logoutType,
                     @Param("ipAddress")  String ipAddress);

    default void recordLogin(long officeId, long employeeId, String ipAddress) {
        recordLogin(officeId, employeeId, 2, 1, ipAddress);
    }


    /* ============================================================
     * USER LOG — LOGOUT
     * ============================================================ */
    @Modifying
    @Transactional
    @Query(value = """
        INSERT INTO usermanager.userlog
            (officeid, employeeid, loginoutdatetime, accesstype, logouttype, ipaddress)
        VALUES (:officeId, :employeeId, CURRENT_TIMESTAMP, :accessType, :logoutType, :ipAddress)
        """, nativeQuery = true)
    void recordLogout(@Param("officeId")   long officeId,
                      @Param("employeeId") long employeeId,
                      @Param("accessType") int accessType,
                      @Param("logoutType") int logoutType,
                      @Param("ipAddress")  String ipAddress);

    default void recordLogout(long officeId, long employeeId, String ipAddress) {
        recordLogout(officeId, employeeId, 2, 1, ipAddress);
    }
}