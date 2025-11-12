# Works with "Super Mario 2 1998 (Unl) [!]"

import sys

def get32(data,offset):
    return (data[offset]<<24) + (data[offset+1]<<16) + (data[offset+2]<<8) + data[offset+3]

def ext_chunk(fn,data,start,end):
    gn = "GFX/"+fn+".gfx"
    print(gn)
    g = open(gn,"wb")
    g.write(data[start:end])

filename = sys.argv[1]

f = open(filename,"rb")
fd = f.read()

_SP  = get32(fd,0)
_RST = get32(fd,4)

if (_SP == 0x200) and (_RST == 0xF3660):
    print("Looking at the header,")
    print("This ROM seems to be the correct one.")
    print("\nExtraction will start now!")
else:
    print("I don't think this is the correct ROM.")
    print("Aborting.")

# here is the list:

ext_chunk("tiles_11",fd,0x616EE,0x6360E)
ext_chunk("tiles_12",fd,0x641CE,0x6562E)
ext_chunk("tiles_11_bonus",fd,0x657AE,0x664EE)
ext_chunk("tiles_13",fd,0x664EE,0x685EE)
ext_chunk("tiles_14",fd,0x685EE,0x6A1AE)
ext_chunk("tiles_12_bonus",fd,0x6A32E,0x6B06E)

ext_chunk("tiles_21",fd,0x6B06E,0x6CD4E)
ext_chunk("tiles_22",fd,0x6D44E,0x6E32E)
ext_chunk("tiles_23",fd,0x6E32E,0x6FDEE)
ext_chunk("tiles_24",fd,0x6FDEE,0x7234E)

ext_chunk("tiles_31",fd,0x724CE,0x7402E)
ext_chunk("tiles_32",fd,0x741AE,0x7530E)
ext_chunk("tiles_33",fd,0x7530E,0x762EE)
ext_chunk("tiles_34",fd,0x7646E,0x785AE)

ext_chunk("tiles_41",fd,0x7872E,0x7AFEE)
ext_chunk("tiles_42",fd,0x7B16E,0x7C46E)
ext_chunk("tiles_43",fd,0x7C5EE,0x7E2CE)
ext_chunk("tiles_44",fd,0x7E44E,0x8050E)

ext_chunk("tiles_51",fd,0x31BBE,0x33B3E)
ext_chunk("tiles_52",fd,0x33B3E,0x35A7E)
ext_chunk("tiles_53",fd,0x35A7E,0x377FE)
ext_chunk("tiles_54",fd,0x3797E,0x399FE)

ext_chunk("tiles_61",fd,0x39B7E,0x3B2BE)
ext_chunk("tiles_62",fd,0x3B43E,0x3C5BE)
ext_chunk("tiles_63",fd,0x3C73E,0x3D67E)
ext_chunk("tiles_64",fd,0x3D7FE,0x3F5FE)

ext_chunk("tiles_71",fd,0x3F77E,0x428BE)
ext_chunk("tiles_72",fd,0x42A3E,0x437BE)
ext_chunk("tiles_73",fd,0x437BE,0x4527E)
ext_chunk("tiles_74",fd,0x4527E,0x4705E)

ext_chunk("tiles_81",fd,0x4705E,0x48F9E)
ext_chunk("tiles_82",fd,0x4911E,0x4B27E)
ext_chunk("tiles_83",fd,0x4B3FE,0x4C63E)
ext_chunk("tiles_841",fd,0x4C7BE,0x4E25E)
ext_chunk("tiles_842",fd,0x4E3DE,0x4FE7E)
ext_chunk("tiles_843",fd,0x4FFFE,0x51A9E)
ext_chunk("tiles_844",fd,0x51A9E,0x52B1E)
ext_chunk("tiles_845",fd,0x52B1E,0x545BE)

ext_chunk("mvt11",fd,0x6404E,0x641CE)
ext_chunk("mvt12",fd,0x6562E,0x657AE)
ext_chunk("mvt14",fd,0x6A1AE,0x6A32E)

ext_chunk("mvt21",fd,0x6CD4E,0x6CECE)
ext_chunk("mvt24",fd,0x7234E,0x724CE)

ext_chunk("mvt31",fd,0x7402E,0x741AE)
ext_chunk("mvt33",fd,0x762EE,0x7646E)
ext_chunk("mvt34",fd,0x785AE,0x7872E)

ext_chunk("mvt41",fd,0x7AFEE,0x7B16E)
ext_chunk("mvt42",fd,0x7C46E,0x7C5EE)
ext_chunk("mvt43",fd,0x7E2CE,0x7E44E)

ext_chunk("mvt53",fd,0x377FE,0x3797E)
ext_chunk("mvt54",fd,0x399FE,0x39B7E)

ext_chunk("mvt61",fd,0x3B2BE,0x3B43E)
ext_chunk("mvt62",fd,0x3C5BE,0x3C73E)
ext_chunk("mvt63",fd,0x3D67E,0x3D7FE)
ext_chunk("mvt64",fd,0x3F5FE,0x3F77E)

ext_chunk("mvt71",fd,0x428BE,0x42A3E)

ext_chunk("mvt81",fd,0x48F9E,0x4911E)
ext_chunk("mvt82",fd,0x4B27E,0x4B3FE)
ext_chunk("mvt83",fd,0x4C63E,0x4C7BE)
ext_chunk("mvt841",fd,0x4E25E,0x4E3DE)
ext_chunk("mvt842",fd,0x4FE7E,0x4FFFE)

ext_chunk("ending",fd,0x5465E,0x5623E)
ext_chunk("gameover",fd,0x5623E,0x57EFE)
ext_chunk("transition",fd,0x57EFE,0x592FE)

ext_chunk("mario",fd,0x5C2FE,0x5CC5E)
ext_chunk("luigi",fd,0x5B99E,0x5C2FE)
ext_chunk("mario_tall",fd,0x5ACBE,0x5B99E)
ext_chunk("luigi_tall",fd,0x59FDE,0x5ACBE)
ext_chunk("mario_fire",fd,0x592FE,0x59FDE)

ext_chunk("sprites_any",fd,0x5F576,0x61656)
ext_chunk("sprites_casual",fd,0x5DC56,0x5F576)
ext_chunk("sprites_castle",fd,0x5CCF6,0x5DC56)

ext_chunk("title",fd,0x6360E,0x6404E)
ext_chunk("spring_princess",fd,0x6CECE,0x6D44E)

ext_chunk("sonic",fd,0xE3E66,0xE5246)
