package com.privilegecard.privilegecard.entity;

import java.io.Serializable;

/**
 * Plain DTO. Mapped from native query via @SqlResultSetMapping("MenuMapping")
 * declared on LoginUser.
 */
public class MenuContent implements Serializable {

    private static final long serialVersionUID = 1L;

    private long mainMenuId;
    private long subMenuId;
    private long popupMenuId;

    private String mainMenuName;
    private String subMenuName;
    private String popupMenuName;

    private String subMenuPage;
    private String popupMenuPage;

    public MenuContent() {}

    /**
     * Constructor used by @ConstructorResult — column order MUST match
     * the @ColumnResult list in "MenuMapping".
     */
    public MenuContent(Long mainMenuId,
                       Long subMenuId,
                       Long popupMenuId,
                       String mainMenuName,
                       String subMenuName,
                       String popupMenuName,
                       String subMenuPage,
                       String popupMenuPage) {
        this.mainMenuId    = mainMenuId   == null ? 0L : mainMenuId;
        this.subMenuId     = subMenuId    == null ? 0L : subMenuId;
        this.popupMenuId   = popupMenuId  == null ? 0L : popupMenuId;
        this.mainMenuName  = mainMenuName;
        this.subMenuName   = subMenuName;
        this.popupMenuName = popupMenuName;
        this.subMenuPage   = subMenuPage;
        this.popupMenuPage = popupMenuPage;
    }

    public long getMainMenuId() { return mainMenuId; }
    public void setMainMenuId(long mainMenuId) { this.mainMenuId = mainMenuId; }

    public long getSubMenuId() { return subMenuId; }
    public void setSubMenuId(long subMenuId) { this.subMenuId = subMenuId; }

    public long getPopupMenuId() { return popupMenuId; }
    public void setPopupMenuId(long popupMenuId) { this.popupMenuId = popupMenuId; }

    public String getMainMenuName() { return mainMenuName; }
    public void setMainMenuName(String mainMenuName) { this.mainMenuName = mainMenuName; }

    public String getSubMenuName() { return subMenuName; }
    public void setSubMenuName(String subMenuName) { this.subMenuName = subMenuName; }

    public String getPopupMenuName() { return popupMenuName; }
    public void setPopupMenuName(String popupMenuName) { this.popupMenuName = popupMenuName; }

    public String getSubMenuPage() { return subMenuPage; }
    public void setSubMenuPage(String subMenuPage) { this.subMenuPage = subMenuPage; }

    public String getPopupMenuPage() { return popupMenuPage; }
    public void setPopupMenuPage(String popupMenuPage) { this.popupMenuPage = popupMenuPage; }
}