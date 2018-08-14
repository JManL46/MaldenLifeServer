/*
    Author: [Utopia] Amaury
    Altis DEV: https://altisdev.com/user/amauryd
    Web site: www.the-programmer.com
    Teamspeak 3: ts.the-programmer.com
    Steam: « Une Vache Sur CS – Maxence », please leave a message on my profile who says the exact reason before adding me.

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.

    License number:
    Server's name:
    Owner's name:
*/
params ["_point", "_start", "_end"];

private _n = _end vectorDiff _start;
private _pa = _start vectorDiff _point;
private _c = _n vectorMultiply ((_pa vectorDotProduct _n) / (_n vectorDotProduct _n));
private _d = _pa vectorDiff _c;

sqrt (_d vectorDotProduct _d);