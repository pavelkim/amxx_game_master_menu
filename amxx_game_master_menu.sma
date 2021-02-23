/*

	Menu plugin
	Implements easy bot and map management

	TODO:
	- Implement everything

*/

#define PLUGIN "Game Master Menu"
#define AUTHOR "Pavel Kim"
#define VERSION "0.0.0"

#include <amxmodx>
#include <amxmisc>

new Array: ManageItems;

public plugin_init() {

    ManageItems = ArrayCreate(1);
    new ManageItem[] = {"Add 5 easy bots for CT", "1", "40", "2", "1", "1" };
    new TempManageItem[64];

    // ArrayPushArray(ManageItems, ManageItem);
    // ArrayGetArray(ManageItems, 0, TempManageItem, charsmax(TempManageItem));
    // server_print("[GMM] [DEBUG] ARRAY: %s", TempManageItem);

    register_plugin(PLUGIN, VERSION, AUTHOR );
    register_clcmd("say /gamemaster", "GameMasterMenuInit", ADMIN_MENU, "- easy game management");
}

public plugin_end() {
    ArrayDestroy(ManageItems);
}

public GameMasterMenuInit(uid, level, cid) {

    new message[90];
    format(message, charsmax(message), "[Init] uid: %i level: %s cid: %s", uid, level, cid);
    say(message);

    if (cmd_access(uid, level, cid, 0)) {

        new MenuInstance = MakeGameMasterMenu(uid, "Game Master Menu", "GameMasterMenuItemHandler");

        menu_setprop(MenuInstance, MPROP_NUMBER_COLOR, "\y");
        menu_display(uid, MenuInstance);
    }

    return PLUGIN_HANDLED;
}

MakeGameMasterMenu(uid, const MenuTitle[], const MenuHandler[]) {

    new message[90];
    format(message, charsmax(message), "[MakeMenu] uid: %i MenuTitle: %s MenuHandler: %s", uid, MenuTitle, MenuHandler);
    say(message);

    new MenuInstance = menu_create(MenuTitle, MenuHandler);
    new bool:isSuperAdmin;

    isSuperAdmin = !!(get_user_flags(uid) & ADMIN_RCON);

    if (isSuperAdmin) {
        menu_additem(MenuInstance, "Add 5 easy bots for CT", "1", 0);
        menu_additem(MenuInstance, "Add 5 easy bots for T", "2", 0);
        menu_additem(MenuInstance, "Add 5 normal bots for CT", "3", 0);
        menu_additem(MenuInstance, "Add 5 normal bots for T", "4", 0);
    }

    return MenuInstance;
}

public GameMasterMenuItemHandler(uid, MenuInstance, MenuItem) {

    new message[250];
    format(message, charsmax(message), "[ItemHandler] uid: %i MenuInstance: %s MenuItem: %s", uid, MenuInstance, MenuItem);
    say(message);

    if (MenuItem  == MENU_EXIT) {
        menu_destroy(MenuInstance);
        return PLUGIN_HANDLED;
    }


    new ItemCallbackData[16], ItemDisplayText[64];
    new ItemAccessLevel, ItemCallback;
    menu_item_getinfo(MenuInstance, MenuItem, ItemAccessLevel, ItemCallbackData, charsmax(ItemCallbackData), ItemDisplayText, charsmax(ItemDisplayText), ItemCallback);

    server_cmd("pb add 40 2 1 1");
    server_cmd("pb add 50 2 1 1");
    server_cmd("pb add 45 2 1 1");

    format(message, charsmax(message), "[MenuItemInfo] MenuInstance='%s' MenuItem='%s' ItemAccessLevel='%s' ItemCallbackData='%s' ItemDisplayText='%s' ItemCallback='%s'", MenuInstance, MenuItem, ItemAccessLevel, ItemCallbackData, ItemDisplayText, ItemCallback);
    say(message);
    
    menu_destroy(MenuInstance);
    return PLUGIN_HANDLED;
}

public say(message[]) {
    new final_message[255]
    format(final_message, charsmax(final_message), "[GMM] %s", message)
    log_message(final_message)
}
