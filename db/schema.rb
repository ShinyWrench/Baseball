# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150709021154) do

  create_table "AllstarFull", id: false, force: true do |t|
    t.string  "playerID",    limit: 9,  default: "", null: false
    t.integer "yearID",                 default: 0,  null: false
    t.integer "gameNum",                default: 0,  null: false
    t.string  "gameID",      limit: 12
    t.string  "teamID",      limit: 3
    t.string  "lgID",        limit: 2
    t.integer "GP"
    t.integer "startingPos"
  end

  create_table "Appearances", id: false, force: true do |t|
    t.integer "yearID",              default: 0,  null: false
    t.string  "teamID",    limit: 3, default: "", null: false
    t.string  "lgID",      limit: 2
    t.string  "playerID",  limit: 9, default: "", null: false
    t.integer "G_all"
    t.integer "GS"
    t.integer "G_batting"
    t.integer "G_defense"
    t.integer "G_p"
    t.integer "G_c"
    t.integer "G_1b"
    t.integer "G_2b"
    t.integer "G_3b"
    t.integer "G_ss"
    t.integer "G_lf"
    t.integer "G_cf"
    t.integer "G_rf"
    t.integer "G_of"
    t.integer "G_dh"
    t.integer "G_ph"
    t.integer "G_pr"
  end

  create_table "AwardsManagers", id: false, force: true do |t|
    t.string  "playerID", limit: 10,  default: "", null: false
    t.string  "awardID",  limit: 75,  default: "", null: false
    t.integer "yearID",               default: 0,  null: false
    t.string  "lgID",     limit: 2,   default: "", null: false
    t.string  "tie",      limit: 1
    t.string  "notes",    limit: 100
  end

  create_table "AwardsPlayers", id: false, force: true do |t|
    t.string  "playerID", limit: 9,   default: "", null: false
    t.string  "awardID",              default: "", null: false
    t.integer "yearID",               default: 0,  null: false
    t.string  "lgID",     limit: 2,   default: "", null: false
    t.string  "tie",      limit: 1
    t.string  "notes",    limit: 100
  end

  create_table "AwardsShareManagers", id: false, force: true do |t|
    t.string  "awardID",    limit: 25, default: "", null: false
    t.integer "yearID",                default: 0,  null: false
    t.string  "lgID",       limit: 2,  default: "", null: false
    t.string  "playerID",   limit: 10, default: "", null: false
    t.integer "pointsWon"
    t.integer "pointsMax"
    t.integer "votesFirst"
  end

  create_table "AwardsSharePlayers", id: false, force: true do |t|
    t.string  "awardID",    limit: 25, default: "", null: false
    t.integer "yearID",                default: 0,  null: false
    t.string  "lgID",       limit: 2,  default: "", null: false
    t.string  "playerID",   limit: 9,  default: "", null: false
    t.float   "pointsWon"
    t.integer "pointsMax"
    t.float   "votesFirst"
  end

  create_table "Batting", id: false, force: true do |t|
    t.string  "playerID",  limit: 9, default: "", null: false
    t.integer "yearID",              default: 0,  null: false
    t.integer "stint",               default: 0,  null: false
    t.string  "teamID",    limit: 3
    t.string  "lgID",      limit: 2
    t.integer "G"
    t.integer "G_batting"
    t.integer "AB"
    t.integer "R"
    t.integer "H"
    t.integer "2B"
    t.integer "3B"
    t.integer "HR"
    t.integer "RBI"
    t.integer "SB"
    t.integer "CS"
    t.integer "BB"
    t.integer "SO"
    t.integer "IBB"
    t.integer "HBP"
    t.integer "SH"
    t.integer "SF"
    t.integer "GIDP"
    t.integer "G_old"
  end

  create_table "BattingPost", id: false, force: true do |t|
    t.integer "yearID",              default: 0,  null: false
    t.string  "round",    limit: 10, default: "", null: false
    t.string  "playerID", limit: 9,  default: "", null: false
    t.string  "teamID",   limit: 3
    t.string  "lgID",     limit: 2
    t.integer "G"
    t.integer "AB"
    t.integer "R"
    t.integer "H"
    t.integer "2B"
    t.integer "3B"
    t.integer "HR"
    t.integer "RBI"
    t.integer "SB"
    t.integer "CS"
    t.integer "BB"
    t.integer "SO"
    t.integer "IBB"
    t.integer "HBP"
    t.integer "SH"
    t.integer "SF"
    t.integer "GIDP"
  end

  create_table "CollegePlaying", id: false, force: true do |t|
    t.string  "playerID", limit: 9
    t.string  "schoolID", limit: 15
    t.integer "yearID"
  end

  create_table "Fielding", id: false, force: true do |t|
    t.string  "playerID", limit: 9, default: "", null: false
    t.integer "yearID",             default: 0,  null: false
    t.integer "stint",              default: 0,  null: false
    t.string  "teamID",   limit: 3
    t.string  "lgID",     limit: 2
    t.string  "POS",      limit: 2, default: "", null: false
    t.integer "G"
    t.integer "GS"
    t.integer "InnOuts"
    t.integer "PO"
    t.integer "A"
    t.integer "E"
    t.integer "DP"
    t.integer "PB"
    t.integer "WP"
    t.integer "SB"
    t.integer "CS"
    t.float   "ZR"
  end

  create_table "FieldingOF", id: false, force: true do |t|
    t.string  "playerID", limit: 9, default: "", null: false
    t.integer "yearID",             default: 0,  null: false
    t.integer "stint",              default: 0,  null: false
    t.integer "Glf"
    t.integer "Gcf"
    t.integer "Grf"
  end

  create_table "FieldingPost", id: false, force: true do |t|
    t.string  "playerID", limit: 9,  default: "", null: false
    t.integer "yearID",              default: 0,  null: false
    t.string  "teamID",   limit: 3
    t.string  "lgID",     limit: 2
    t.string  "round",    limit: 10, default: "", null: false
    t.string  "POS",      limit: 2,  default: "", null: false
    t.integer "G"
    t.integer "GS"
    t.integer "InnOuts"
    t.integer "PO"
    t.integer "A"
    t.integer "E"
    t.integer "DP"
    t.integer "TP"
    t.integer "PB"
    t.integer "SB"
    t.integer "CS"
  end

  create_table "HallOfFame", id: false, force: true do |t|
    t.string  "playerID",    limit: 10, default: "", null: false
    t.integer "yearID",                 default: 0,  null: false
    t.string  "votedBy",     limit: 64, default: "", null: false
    t.integer "ballots"
    t.integer "needed"
    t.integer "votes"
    t.string  "inducted",    limit: 1
    t.string  "category",    limit: 20
    t.string  "needed_note", limit: 25
  end

  create_table "Managers", id: false, force: true do |t|
    t.string  "playerID", limit: 10
    t.integer "yearID",              default: 0,  null: false
    t.string  "teamID",   limit: 3,  default: "", null: false
    t.string  "lgID",     limit: 2
    t.integer "inseason",            default: 0,  null: false
    t.integer "G"
    t.integer "W"
    t.integer "L"
    t.integer "rank"
    t.string  "plyrMgr",  limit: 1
  end

  create_table "ManagersHalf", id: false, force: true do |t|
    t.string  "playerID", limit: 10, default: "", null: false
    t.integer "yearID",              default: 0,  null: false
    t.string  "teamID",   limit: 3,  default: "", null: false
    t.string  "lgID",     limit: 2
    t.integer "inseason"
    t.integer "half",                default: 0,  null: false
    t.integer "G"
    t.integer "W"
    t.integer "L"
    t.integer "rank"
  end

  create_table "Master", primary_key: "playerID", force: true do |t|
    t.integer  "birthYear"
    t.integer  "birthMonth"
    t.integer  "birthDay"
    t.string   "birthCountry", limit: 50
    t.string   "birthState",   limit: 2
    t.string   "birthCity",    limit: 50
    t.integer  "deathYear"
    t.integer  "deathMonth"
    t.integer  "deathDay"
    t.string   "deathCountry", limit: 50
    t.string   "deathState",   limit: 2
    t.string   "deathCity",    limit: 50
    t.string   "nameFirst",    limit: 50
    t.string   "nameLast",     limit: 50
    t.string   "nameGiven"
    t.integer  "weight"
    t.float    "height"
    t.string   "bats",         limit: 1
    t.string   "throws",       limit: 1
    t.datetime "debut"
    t.datetime "finalGame"
    t.string   "retroID",      limit: 9
    t.string   "bbrefID",      limit: 9
  end

  create_table "Pitching", id: false, force: true do |t|
    t.string  "playerID", limit: 9, default: "", null: false
    t.integer "yearID",             default: 0,  null: false
    t.integer "stint",              default: 0,  null: false
    t.string  "teamID",   limit: 3
    t.string  "lgID",     limit: 2
    t.integer "W"
    t.integer "L"
    t.integer "G"
    t.integer "GS"
    t.integer "CG"
    t.integer "SHO"
    t.integer "SV"
    t.integer "IPouts"
    t.integer "H"
    t.integer "ER"
    t.integer "HR"
    t.integer "BB"
    t.integer "SO"
    t.float   "BAOpp"
    t.float   "ERA"
    t.integer "IBB"
    t.integer "WP"
    t.integer "HBP"
    t.integer "BK"
    t.integer "BFP"
    t.integer "GF"
    t.integer "R"
    t.integer "SH"
    t.integer "SF"
    t.integer "GIDP"
  end

  create_table "PitchingPost", id: false, force: true do |t|
    t.string  "playerID", limit: 9,  default: "", null: false
    t.integer "yearID",              default: 0,  null: false
    t.string  "round",    limit: 10, default: "", null: false
    t.string  "teamID",   limit: 3
    t.string  "lgID",     limit: 2
    t.integer "W"
    t.integer "L"
    t.integer "G"
    t.integer "GS"
    t.integer "CG"
    t.integer "SHO"
    t.integer "SV"
    t.integer "IPouts"
    t.integer "H"
    t.integer "ER"
    t.integer "HR"
    t.integer "BB"
    t.integer "SO"
    t.float   "BAOpp"
    t.float   "ERA"
    t.integer "IBB"
    t.integer "WP"
    t.integer "HBP"
    t.integer "BK"
    t.integer "BFP"
    t.integer "GF"
    t.integer "R"
    t.integer "SH"
    t.integer "SF"
    t.integer "GIDP"
  end

  create_table "Salaries", id: false, force: true do |t|
    t.integer "yearID",             default: 0,  null: false
    t.string  "teamID",   limit: 3, default: "", null: false
    t.string  "lgID",     limit: 2, default: "", null: false
    t.string  "playerID", limit: 9, default: "", null: false
    t.float   "salary"
  end

  create_table "Schools", primary_key: "schoolID", force: true do |t|
    t.string "name_full"
    t.string "city",      limit: 55
    t.string "state",     limit: 55
    t.string "country",   limit: 55
  end

  create_table "SeriesPost", id: false, force: true do |t|
    t.integer "yearID",                 default: 0,  null: false
    t.string  "round",        limit: 5, default: "", null: false
    t.string  "teamIDwinner", limit: 3
    t.string  "lgIDwinner",   limit: 2
    t.string  "teamIDloser",  limit: 3
    t.string  "lgIDloser",    limit: 2
    t.integer "wins"
    t.integer "losses"
    t.integer "ties"
  end

  create_table "Teams", id: false, force: true do |t|
    t.integer "yearID",                    default: 0,  null: false
    t.string  "lgID",           limit: 2,  default: "", null: false
    t.string  "teamID",         limit: 3,  default: "", null: false
    t.string  "franchID",       limit: 3
    t.string  "divID",          limit: 1
    t.integer "Rank"
    t.integer "G"
    t.integer "Ghome"
    t.integer "W"
    t.integer "L"
    t.string  "DivWin",         limit: 1
    t.string  "WCWin",          limit: 1
    t.string  "LgWin",          limit: 1
    t.string  "WSWin",          limit: 1
    t.integer "R"
    t.integer "AB"
    t.integer "H"
    t.integer "2B"
    t.integer "3B"
    t.integer "HR"
    t.integer "BB"
    t.integer "SO"
    t.integer "SB"
    t.integer "CS"
    t.integer "HBP"
    t.integer "SF"
    t.integer "RA"
    t.integer "ER"
    t.float   "ERA"
    t.integer "CG"
    t.integer "SHO"
    t.integer "SV"
    t.integer "IPouts"
    t.integer "HA"
    t.integer "HRA"
    t.integer "BBA"
    t.integer "SOA"
    t.integer "E"
    t.integer "DP"
    t.float   "FP"
    t.string  "name",           limit: 50
    t.string  "park"
    t.integer "attendance"
    t.integer "BPF"
    t.integer "PPF"
    t.string  "teamIDBR",       limit: 3
    t.string  "teamIDlahman45", limit: 3
    t.string  "teamIDretro",    limit: 3
  end

  create_table "TeamsFranchises", primary_key: "franchID", force: true do |t|
    t.string "franchName", limit: 50
    t.string "active",     limit: 2
    t.string "NAassoc",    limit: 3
  end

  create_table "TeamsHalf", id: false, force: true do |t|
    t.integer "yearID",           default: 0,  null: false
    t.string  "lgID",   limit: 2, default: "", null: false
    t.string  "teamID", limit: 3, default: "", null: false
    t.string  "Half",   limit: 1, default: "", null: false
    t.string  "divID",  limit: 1
    t.string  "DivWin", limit: 1
    t.integer "Rank"
    t.integer "G"
    t.integer "W"
    t.integer "L"
  end

end
