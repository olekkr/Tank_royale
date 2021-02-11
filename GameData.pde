//<>// //<>//
class Player {
  boolean self = true;
  int Id = 0;
  int[] Pos = {0, 0};
  String DisplayName = "player1";
  int HP = 100;
  String CurrentPowerup = "";
  int TimeSincePowerupObtained = -1;
  int Kills = 0;
  float[] Velocity = {0, 0};
  int[] CurrentChunk = {0, 0};
}
class GameData {
  int[] MapSize = {1024, 1024};
  ArrayList<int[]> SpawnPoints= new ArrayList<int[]>();
  int MaxHP;
  float FireRate;
  int BulletDmg;
  float BulletSpeed;
  float Movementspeed;
  int MaxPlayers;
  float PlayerRadius;
  boolean CheatsEnabled = true;
  String[] EnabledPowurups;
  int UpdateRate;
  int Chunksize;

  GameData () {
  }


  void export() {
    JSONObject json;
    JSONObject metaJson;
    JSONObject contentJson;

    json = new JSONObject();
    metaJson = new JSONObject();
    contentJson = new JSONObject();
    //contentjson
    //  mapsize
    JSONArray mapsizee = new JSONArray();
    mapsizee.setInt(0, MapSize[0]);
    mapsizee.setInt(1, MapSize[1]);
    metaJson.setJSONArray("MapSize", mapsizee);

    //MaxPlayers
    metaJson.setInt("MaxPlayers", MaxPlayers);

    // spawns
    JSONArray spawnP = new JSONArray();
    JSONArray spawnPs = new JSONArray();
    for (int i = 0; i < SpawnPoints.size(); i++) {
      spawnP = new JSONArray();
      spawnP.append(SpawnPoints.get(i)[0]); //x
      spawnP.append(SpawnPoints.get(i)[1]); //y
      spawnPs.append(spawnP);
    }
    metaJson.setJSONArray("SpawnPoints", spawnPs);

    //maxHP
    metaJson.setInt("MaxHP", 50);

    //FireRate
    metaJson.setFloat("FireRate", 0.75);

    //Bulletdmg
    metaJson.setInt("BulletDMG", 35);

    //BulletSpeed
    metaJson.setFloat("BulletSpeed", 1.7);

    //MovementSpeed
    metaJson.setFloat("MovementSpeed", 1.0);

    //PlayerRadius
    metaJson.setInt("PlayerRadius", 30);

    //CheatsEnabled
    metaJson.setBoolean("CheatsEnabled", false);

    //EnabledPowerups
    JSONArray PowerUps = new JSONArray();
    metaJson.setJSONArray("EnabledPowurups", PowerUps);

    //ChunkSize
    metaJson.setInt("ChunkSize", 4); 
    //means 4x4

    //Updaterate
    metaJson.setInt("updateRate", 30);
    json.setJSONObject("meta", metaJson);




    saveJSONObject(json, "new.json");
  }

  void load() {
    JSONObject json = loadJSONObject("new.json");
    JSONObject meta = json.getJSONObject("meta");

    JSONArray mapSize = meta.getJSONArray("MapSize");
    MapSize[0] = mapSize.getInt(0);
    MapSize[1] = mapSize.getInt(1);


    MaxPlayers = meta.getInt("MaxPlayers");

    JSONArray spawns = meta.getJSONArray("SpawnPoints");
    SpawnPoints.clear();
    for (int i = 0; i < spawns.size(); i++) {
      JSONArray spawn = spawns.getJSONArray(i);
      assert(spawn.size() == 2);
      int[] newInt = new int[2];
      newInt[0] = spawn.getInt(0);
      newInt[1] = spawn.getInt(1);
      int[] add =  newInt.clone();
      SpawnPoints.add(add);
    }

    MaxHP = meta.getInt("MaxHP");
    FireRate = meta.getFloat("FireRate");
    BulletDmg = meta.getInt("BulletDMG");
    BulletSpeed = meta.getFloat("BulletSpeed");
    Movementspeed = meta.getFloat("MovementSpeed");
    PlayerRadius = meta.getFloat("PlayerRadius");
    CheatsEnabled = meta.getBoolean("CheatsEnabled");
    EnabledPowurups = meta.getJSONArray("EnabledPowurups").getStringArray();
    UpdateRate = meta.getInt("updateRate");
    Chunksize = meta.getInt("ChunkSize");
  }
}
