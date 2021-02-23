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

public plugin_init() {
    register_plugin(PLUGIN, VERSION, AUTHOR );
    register_clcmd("say /gamemaster", "GameMasterMenu", ADMIN_MENU, "- easy game management");
}

public GameMasterMenu(uid, level, cid) {

    new message[50];
    format(message, charsmax(message), "[GMMHandler] uid: %i level: %s cid: %s", uid, level, cid);
    say(message);

    if (cmd_access(uid, level, cid, 0)) {

        new MenuInstance = MakeGameMasterMenu(uid, "Game Master Menu", "GameMasterMenuItemHandler");

        menu_setprop(MenuInstance, MPROP_NUMBER_COLOR, "\y");
        menu_display(uid, MenuInstance);
    }

    return PLUGIN_HANDLED;
}

MakeGameMasterMenu(uid, const MenuTitle[], const MenuHandler[]) {

    new message[50];
    format(message, charsmax(message), "[MakeGMM] uid: %i MenuTitle: %s MenuHandler: %s", uid, MenuTitle, MenuHandler);
    say(message);

    new MenuInstance = menu_create(MenuTitle, MenuHandler);
    new bool:isSuperAdmin;

    isSuperAdmin = !!(get_user_flags(uid) & ADMIN_RCON);

    if (isSuperAdmin) {
        menu_additem(MenuInstance, "Add 5 easy bots for CT", "", 0);
        menu_additem(MenuInstance, "Add 5 easy bots for T", "", 0);
        menu_additem(MenuInstance, "Add 5 normal bots for CT", "", 0);
        menu_additem(MenuInstance, "Add 5 normal bots for T", "", 0);
    }

    return MenuInstance;
}

public GameMasterMenuItemHandler(uid, MenuInstance, MenuItem) {

    new message[50];
    format(message, charsmax(message), "[GMMItemHandler] uid: %i MenuInstance: %s MenuItem: %s", uid, MenuInstance, MenuItem);
    say(message);

    if (MenuItem  == MENU_EXIT) {
        menu_destroy(MenuInstance);
        return PLUGIN_HANDLED;
    }

    // menu_item_getinfo(MenuInstance, MenuItem, ItemCallback, ItemCallback);
    menu_destroy(MenuInstance);
    return PLUGIN_HANDLED;
}

public say(message[]) {
    new final_message[128]
    format(final_message, charsmax(final_message), "[JOIN ALERT] %s", message)
    log_message(final_message)
}
