class DefaultEventhandlers;
class CfgPatches {
    class life_server {
        units[] = {"C_man_1"};
        weapons[] = {};
        requiredAddons[] = {"A3_Data_F","A3_Soft_F","A3_Soft_F_Offroad_01","A3_Characters_F"};
        fileName = "life_server.pbo";
        author = "Tonic";
    };
};

class CfgFunctions {
    class MySQL_Database {
        tag = "DB";
        class MySQL
        {
            file = "\life_server\Functions\MySQL";
            class numberSafe {};
            class mresArray {};
            class queryRequest{};
            class asyncCall{};
            class insertRequest{};
            class updateRequest{};
            class mresToArray {};
            class insertVehicle {};
            class bool {};
            class mresString {};
            class updatePartial {};
            class betUpdate {};
        };
    };

    class Life_System {
        tag = "life";
        class Wanted_Sys {
            file = "\life_server\Functions\WantedSystem";
            class wantedFetch {};
            class wantedPerson {};
            class wantedBounty {};
            class wantedRemove {};
            class wantedAdd {};
            class wantedCrimes {};
            class wantedProfUpdate {};
        };

        //Bounty Hunter
        class Bounty_Sys {
            file = "\life_server\Functions\BountySystem";
            class amountBounty {};
            class bountyRemove {};
            class bountyAdd {};
            class bountyFetch {};
            class bountyProfUpdate {};
			class bountyCrimes {};
			class bountyAmountGather {};
        };

        class Visdb {
            file = "\life_server\Functions\Vis";
            class vehicleInfoUpdate {};
        };

        class Jail_Sys {
            file = "\life_server\Functions\Jail";
            class jailSys {};
			class jailTimer {};
			class jailPlayer {};
            class JailBreakRemove {};
            class JailBreakFix {};
            class JailBreakHandle {};
        };

        class Client_Code {
            file = "\life_server\Functions\Client";
        };
    };

    class TON_System {
        tag = "TON";
        class Systems {
            file = "\life_server\Functions\Systems";
            class managesc {};
            class cleanup {};
            class huntingZone {};
            class getID {};
            class vehicleCreate {};
            class spawnVehicle {};
            class getVehicles {};
            class vehicleStore {};
            class vehicleDelete {};
            class spikeStrip {};
            class transferOwnership {};
            class federalUpdate {};
            class chopShopSell {};
            class clientDisconnect {};
            class cleanupRequest {};
            class setObjVar {};
            class keyManagement {};
            class vehicleUpdate {};
            class recupkeyforHC {};
            class handleBlastingCharge {};
            class terrainSort {};
            class handleBlastingChargeBank {};
            class insureCar {};
            class serverVehicleStore {};
        };

        class Housing {
            file = "\life_server\Functions\Housing";
            class addHouse {};
            class addContainer {};
            class deleteDBContainer {};
            class fetchPlayerHouses {};
            class initHouses {};
            class sellHouse {};
            class sellHouseContainer {};
            class updateHouseContainers {};
            class updateHouseTrunk {};
            class houseCleanup {};
            class houseGarage {};
        };

        class vAH
		{
			file = "\life_server\Functions\vAH";
			class vAH_init;
			class vAH_update;
		};

        class Smartphone
        {
            file = "\life_server\Functions\Smartphone";
            class handleMessages {};
            class msgRequest {};
        };

        class Gangs {
            file = "\life_server\Functions\Gangs";
            class insertGang {};
            class queryPlayerGang {};
            class removeGang {};
            class updateGang {};
            class gangCash {};
        };

        class Actions {
            file = "\life_server\Functions\Actions";
            class pickupAction {};
        };

        class PlayTime {
            file = "\life_server\Functions\PlayTime";
            class setPlayTime {};
            class getPlayTime {};
        };
    };
};

class CfgVehicles {
    class Car_F;
    class CAManBase;
    class Civilian;
    class Civilian_F : Civilian {
        class EventHandlers;
    };

    class C_man_1 : Civilian_F {
        class EventHandlers: EventHandlers {
            init = "(_this select 0) execVM ""\life_server\fix_headgear.sqf""";
        };
    };
};