## 三国战纪2 - 斗轉星旋

### 基于「三国战纪2」100 版本修改


一、68000 代码：斗轉星旋.X68 `68K 补丁`

二、ARM 数据：斗轉星旋.ARM.X68 `ARM 补丁`

三、IDA 数据库：

- 100版.M68K.i64 `Bios V2 + PROM 的部分 68K 代码分析`
- 100版.ARM.i64 `External ARM 的少量代码分析`
- KOV2.ASIC.i64 `Internal ARM 的极少代码分析`

四、Tiles 字库：

- 字庫.X68 `字库表格`
- v110.tile `游戏字库，生命槽等 8x8 Text Tiles`

五、声音采样：v110.sample `新增神剑伏魔录音乐`

六、MAME 模拟器驱动：

```
# src\mame\drivers\pgm.cpp

// 三國戰紀2斗轉星旋/Sānguó zhàn jì 2 Dòu Zhuǎn Xīng Xuán (China; Traditional Chinese)
// region provided by internal ARM rom
GAME( 2021, kov2110,      pgm,       pgm_arm_type2,          kov2,      pgm_arm_type2_state, init_pgm,        ROT0,   "Modification", "Knights of Valour 2 / Sanguo Zhan Ji 2 / Sangoku Senki 2 (ver. 110, 100, 100HK)", MACHINE_IMPERFECT_SOUND | MACHINE_SUPPORTS_SAVE ) // 11/29/00 11:03:08 V100 (Ext. Arm V100, Int. Arm V100HK)

ROM_START( kov2110 )
	ROM_REGION( 0x600000, "maincpu", 0 ) /* Swapped 68000 Code - (PGM BIOS V2 ROM + Game ROM V100) - */
	ROM_LOAD( "v110.68k",    0x000000, 0x600000, CRC(85BE4873) SHA1(9E2F2269AF01FD6DA01FD6BB077FF196B31CCCD5) )

	ROM_REGION( 0x4000, "prot", 0 ) /* ARM protection ASIC - internal rom */
	ROM_LOAD( "v110.asic", 0x000000, 0x04000,  CRC(85D3E321) SHA1(9093B55D37BF9C270FFCA8A5692797F4901DE30D) )

	ROM_REGION32_LE( 0x400000, "user1", 0 ) /* Decrypted external ARM data */
	ROM_LOAD( "v110.arm",   0x000000, 0x400000,   CRC(B98860F9) SHA1(A6AA36BF997D68F3A14ADB2F01461D47975DDFB9) )

	ROM_REGION( 0xa00000, "tiles", 0 ) /* 8x8 Text Tiles + 32x32 BG Tiles */
	ROM_LOAD( "v110.tile", 0x000000, 0xa00000, CRC(095E6D0F) SHA1(D22200D5A7C42E7224D8BD022E500913874C0806) )

	ROM_REGION16_LE( 0x4000000, "sprcol", 0 ) /* Sprite Colour Data */
	ROM_LOAD( "v110.sprcol",   0x0000000, 0x4000000, CRC(BB6FF991) SHA1(A7A3CAD765F7A874E6454E1CEEE24A8443573367) )

	ROM_REGION16_LE( 0x1000000, "sprmask", 0 ) /* Sprite Masks + Colour Indexes */
	ROM_LOAD( "v110.sprmask",   0x0000000, 0x1000000,  CRC(6A6AA4D7) SHA1(BDC7ACC43D929D8D175F02D9FF6B9AC6A7890A94) )

	ROM_REGION( 0x1000000, "ics", 0 ) /* Samples - (8 bit mono 11025Hz) - */
	ROM_LOAD( "v110.sample",   0x0000000, 0x1000000, CRC(96F7F0BB) SHA1(E83B76AE0CCA2148337B33431DA01F42C60CDC4D) )
ROM_END
```



##### 注：由于本人并非程序员，代码注释若有词不达意之处请多谅解。