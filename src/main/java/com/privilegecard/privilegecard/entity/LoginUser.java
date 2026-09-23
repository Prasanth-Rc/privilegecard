package com.privilegecard.privilegecard.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.List;

@Entity

public class LoginUser implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "digitalsignature")
    private long digitalSignature;

    @Column(name = "employeeid")
    private long employeeId;

    @Column(name = "aliasname")
    private String aliasName;

    @Column(name = "employeename")
    private String employeeName;

    @Column(name = "employeecode")
    private String employeeCode;

    @Column(name = "departmentid")
    private long departmentId;

    @Column(name = "departmentname")
    private String departmentName;

    @Column(name = "designationid")
    private long designationId;

    @Column(name = "designationname")
    private String designationName;

    @Column(name = "divisionid")
    private long divisionId;

    @Column(name = "divisionname")
    private String divisionName;

    @Column(name = "officeid")
    private long officeId;

    @Column(name = "officename")
    private String officeName;

    @Column(name = "officecategoryid")
    private long officeCategoryId;

    @Column(name = "officenamewithtrust")
    private String officeNameWithTrust;

    @Column(name = "servermode")
    private String serverMode;

    @Column(name = "currentdate")
    private String currentDate;

    @Column(name = "currentdatetime")
    private String currentDateAndTime;

    @Transient private String displayCurrentDate;
    @Transient private String ipAddress;
    @Transient private String sessionId;
    @Transient private String loginDate;
    @Transient private String loginTime;
    @Transient private List<MenuContent> menus;

    /** Required by JPA */
    public LoginUser() {}

    /**
     * Constructor used by @ConstructorResult — column order MUST match
     * the @ColumnResult list in "LoginUserMapping".
     */
    public LoginUser(
            Long digitalSignature,
            Long employeeId,
            String aliasName,
            String employeeName,
            String employeeCode,
            Long designationId,
            String designationName,
            Long departmentId,
            String departmentName,
            Long divisionId,
            String divisionName,
            Long officeId,
            String officeName,
            Long officeCategoryId,
            String officeNameWithTrust,
            String serverMode,
            String currentDate,
            String currentDateAndTime) {

        this.digitalSignature    = digitalSignature == null ? 0L : digitalSignature;
        this.employeeId          = employeeId == null ? 0L : employeeId;
        this.aliasName           = aliasName;
        this.employeeName        = employeeName;
        this.employeeCode        = employeeCode;
        this.designationId       = designationId == null ? 0L : designationId;
        this.designationName     = designationName;
        this.departmentId        = departmentId == null ? 0L : departmentId;
        this.departmentName      = departmentName;
        this.divisionId          = divisionId == null ? 0L : divisionId;
        this.divisionName        = divisionName;
        this.officeId            = officeId == null ? 0L : officeId;
        this.officeName          = officeName;
        this.officeCategoryId    = officeCategoryId == null ? 0L : officeCategoryId;
        this.officeNameWithTrust = officeNameWithTrust;
        this.serverMode          = serverMode;
        this.currentDate         = currentDate;
        this.currentDateAndTime  = currentDateAndTime;
        this.displayCurrentDate  = currentDate;
    }

    // ----- getters / setters -----

    public long getDigitalSignature() { return digitalSignature; }
    public void setDigitalSignature(long digitalSignature) { this.digitalSignature = digitalSignature; }

    public long getEmployeeId() { return employeeId; }
    public void setEmployeeId(long employeeId) { this.employeeId = employeeId; }

    public String getAliasName() { return aliasName; }
    public void setAliasName(String aliasName) { this.aliasName = aliasName; }

    public String getEmployeeName() { return employeeName; }
    public void setEmployeeName(String employeeName) { this.employeeName = employeeName; }

    public String getEmployeeCode() { return employeeCode; }
    public void setEmployeeCode(String employeeCode) { this.employeeCode = employeeCode; }

    public long getDepartmentId() { return departmentId; }
    public void setDepartmentId(long departmentId) { this.departmentId = departmentId; }

    public String getDepartmentName() { return departmentName; }
    public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }

    public long getDesignationId() { return designationId; }
    public void setDesignationId(long designationId) { this.designationId = designationId; }

    public String getDesignationName() { return designationName; }
    public void setDesignationName(String designationName) { this.designationName = designationName; }

    public long getDivisionId() { return divisionId; }
    public void setDivisionId(long divisionId) { this.divisionId = divisionId; }

    public String getDivisionName() { return divisionName; }
    public void setDivisionName(String divisionName) { this.divisionName = divisionName; }

    public long getOfficeId() { return officeId; }
    public void setOfficeId(long officeId) { this.officeId = officeId; }

    public String getOfficeName() { return officeName; }
    public void setOfficeName(String officeName) { this.officeName = officeName; }

    public long getOfficeCategoryId() { return officeCategoryId; }
    public void setOfficeCategoryId(long officeCategoryId) { this.officeCategoryId = officeCategoryId; }

    public String getOfficeNameWithTrust() { return officeNameWithTrust; }
    public void setOfficeNameWithTrust(String officeNameWithTrust) { this.officeNameWithTrust = officeNameWithTrust; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }

    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }

    public String getLoginDate() { return loginDate; }
    public void setLoginDate(String loginDate) { this.loginDate = loginDate; }

    public String getLoginTime() { return loginTime; }
    public void setLoginTime(String loginTime) { this.loginTime = loginTime; }

    public String getCurrentDate() { return currentDate; }
    public void setCurrentDate(String currentDate) { this.currentDate = currentDate; }

    public String getDisplayCurrentDate() { return displayCurrentDate; }
    public void setDisplayCurrentDate(String displayCurrentDate) { this.displayCurrentDate = displayCurrentDate; }

    public String getCurrentDateAndTime() { return currentDateAndTime; }
    public void setCurrentDateAndTime(String currentDateAndTime) { this.currentDateAndTime = currentDateAndTime; }

    public String getServerMode() { return serverMode; }
    public void setServerMode(String serverMode) { this.serverMode = serverMode; }

    public List<MenuContent> getMenus() { return menus; }
    public void setMenus(List<MenuContent> menus) { this.menus = menus; }
}