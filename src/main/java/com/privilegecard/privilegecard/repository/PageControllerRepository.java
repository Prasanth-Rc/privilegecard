package com.privilegecard.privilegecard.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.privilegecard.privilegecard.entity.LoginUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface PageControllerRepository extends JpaRepository<LoginUser, Long> {

    @Query(value = "SELECT m.menulinkname " +
            "FROM usermanager.menus m " +
            "WHERE m.menuid = :menuId", nativeQuery = true)
    String findPageByMenuId(@Param("menuId") Long menuId);
}
