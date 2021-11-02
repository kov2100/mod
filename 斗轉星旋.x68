*--------------------------------------------------------------------------------------
* 標題：三國戰紀 2 - 斗轉星旋（ kov2100 修改版）
* 日期：2021 年 10 月 17 日
* 作者：伯勞食夢
* 討論：游戲討論QQ群 197216616
* 攻略：https://docs.qq.com/doc/DZk5aZUZneUNNbHdP
* 平台：游聚游戏 | 畅玩空间
*--------------------------------------------------------------------------------------

; =============== 全局設定 ==================================================

START:

ROMBase		SET		$500000	; ROM 擴容基址
RAMBase		SET		$81D000	; RAM 擴容基址

PGMBIOSV1	SET		0
PGMBIOSV2	SET		1

; ---------------------------------------------------------------------------
	IFNE	PGMBIOSV1

F3Key		SET		$4CE
sub_7F9E	SET		$7F6A
sub_7966	SET		$7932
off_18790	SET		$18514
byte_803765	SET		$803763

	ENDC
; ---------------------------------------------------------------------------
	IFNE	PGMBIOSV2

F3Key		SET		$4D0
sub_7F9E	SET		$7F9E
sub_7966	SET		$7966
off_18790	SET		$18790
byte_803765	SET		$803765

	ENDC

; =============== 基礎調整 ==================================================

	* 遊戲設定

		ORG $10023A	; F3 鍵直接進入 [OPERATOR SETTING]
			dc.l	$12D194

		ORG $12D1DA	; 新菜單
			jsr		sub_16524C

		ORG $143238	; 投幣後進行遊戲初始化
			jsr		sub_139BC8

	* 瓦片貼圖

		ORG $145364	; 預寫色盤|16色
			jsr		sub_14B004
		ORG $14D034	; 角色24P死亡後清除頭像、等級等顯存
			moveq	#$1F,d3	; 橫坐標

		ORG $124E14	; 敵將角色頭像色表號
			movea.l	#byte_1EB296,a0
		ORG $14AD9C	; 我方角色頭像色表號
			movea.l	#byte_1EB296,a0

		ORG $2B43E0	; 頭像坐標
			dc.w	$00,$34,$00,$34	; 橫坐標
			dc.w	$00,$00,$1A,$1A	; 縱坐標

		ORG $2B43F0	; 姓名坐標
			dc.w	$04,$2E,$04,$2E	; 橫坐標
			dc.w	$00,$00,$1A,$1A	; 縱坐標
		ORG $30DEDA	; 姓名瓦片貼圖重新排版
			;		C-----1-----2-----3-----4-----5-----6-----7-----8-----9-----A-----B
			dc.w	$629, $61E, $61F, $620, $621, $622, $623, $624, $625, $626, $627, $628	; 關羽
			dc.w	$635, $62A, $62B, $62C, $62D, $62E, $62F, $630, $631, $632, $633, $634	; 張飛
			dc.w	$641, $636, $637, $638, $639, $63A, $63B, $63C, $63D, $63E, $63F, $640	; 趙雲
			dc.w	$64D, $642, $643, $644, $645, $646, $647, $648, $649, $64A, $64B, $64C	; 黃忠
			dc.w	$659, $64E, $64F, $650, $651, $652, $653, $654, $655, $656, $657, $658	; 馬超
			dc.w	$665, $65A, $65B, $65C, $65D, $65E, $65F, $660, $661, $662, $663, $664	; 孔明
			dc.w	$671, $666, $667, $668, $669, $66A, $66B, $66C, $66D, $66E, $66F, $670	; 貂蟬
			dc.w	$67D, $672, $673, $674, $675, $676, $677, $678, $679, $67A, $67B, $67C	; 周瑜
			dc.w	$689, $67E, $67F, $680, $681, $682, $683, $684, $685, $686, $687, $688	; 龐統
			dc.w	$695, $68A, $68B, $68C, $68D, $68E, $68F, $690, $691, $692, $693, $694	; 孫權
			dc.w	$6A1, $696, $697, $698, $699, $69A, $69B, $69C, $69D, $69E, $69F, $6A0	; 孫姬
			dc.w	$6AD, $6A2, $6A3, $6A4, $6A5, $6A6, $6A7, $6A8, $6A9, $6AA, $6AB, $6AC	; 曹操
			dc.w	$6AE, $6AF, $6B0, $6B1, $6B2, $6B3, $6B4, $6B5, $6B6, $6B7, $6B8, $6B9	; 司馬懿
			dc.w	$6C5, $6BA, $6BB, $6BC, $6BD, $6BE, $6BF, $6C0, $6C1, $6C2, $6C3, $6C4	; 程昱
			dc.w	$6D1, $6C6, $6C7, $6C8, $6C9, $6CA, $6CB, $6CC, $6CD, $6CE, $6CF, $6D0	; 曹彰
			dc.w	$6DD, $6D2, $6D3, $6D4, $6D5, $6D6, $6D7, $6D8, $6D9, $6DA, $6DB, $6DC	; 曹仁
			dc.w	$6E9, $6DE, $6DF, $6E0, $6E1, $6E2, $6E3, $6E4, $6E5, $6E6, $6E7, $6E8	; 曹洪
			dc.w	$6EA, $6EB, $6EC, $6ED, $6EE, $6EF, $6F0, $6F1, $6F2, $6F3, $6F4, $6F5	; 夏侯淵
			dc.w	$6F6, $6F7, $6F8, $6F9, $6FA, $6FB, $6FC, $6FD, $6FE, $6FF, $700, $701	; 夏侯惇
			dc.w	$70D, $702, $703, $704, $705, $706, $707, $708, $709, $70A, $70B, $70C	; 牛金
			dc.w	$719, $70E, $70F, $710, $711, $712, $713, $714, $715, $716, $717, $718	; 許褚
			dc.w	$725, $71A, $71B, $71C, $71D, $71E, $71F, $720, $721, $722, $723, $724	; 張郃
			dc.w	$731, $726, $727, $728, $729, $72A, $72B, $72C, $72D, $72E, $72F, $730	; 張遼
			dc.w	$732, $733, $734, $735, $736, $737, $738, $739, $73A, $73B, $73C, $73D	; 太史慈
			dc.w	$749, $73E, $73F, $740, $741, $742, $743, $744, $745, $746, $747, $748	; 甘寧
			dc.w	$755, $74A, $74B, $74C, $74D, $74E, $74F, $750, $751, $752, $753, $754	; 周泰
			dc.w	$761, $756, $757, $758, $759, $75A, $75B, $75C, $75D, $75E, $75F, $760	; 黃蓋
			dc.w	$76D, $762, $763, $764, $765, $766, $767, $768, $769, $76A, $76B, $76C	; 呂蒙
			dc.w	$779, $76E, $76F, $770, $771, $772, $773, $774, $775, $776, $777, $778	; 徐晃
			dc.w	$785, $77A, $77B, $77C, $77D, $77E, $77F, $780, $781, $782, $783, $784	; 呂布
			dc.w	$791, $786, $787, $788, $789, $78A, $78B, $78C, $78D, $78E, $78F, $790	; 孟獲
			dc.w	$79D, $792, $793, $794, $795, $796, $797, $798, $799, $79A, $79B, $79C	; 孟優
			dc.w	$79E, $79F, $7A0, $7A1, $7A2, $7A3, $7A4, $7A5, $7A6, $7A7, $7A8, $7A9	; 沙摩柯
			dc.w	$7B5, $7AA, $7AB, $7AC, $7AD, $7AE, $7AF, $7B0, $7B1, $7B2, $7B3, $7B4	; 左慈

		ORG $2B442A	; 等級坐標
			dc.w	$15,$21,$15,$21	; 橫坐標
			dc.w	$01,$01,$1A,$1A	; 縱坐標
		ORG $14CB78	; 取消顯示瓦片[LV]
			movea.l	$2EC(a3),a2	; 顯存地址
			bra.s	$14CBCE
		ORG $14CC02	; 等級數字始終兩位數
			jsr		sub_14CC02
			bra.s	$14CC34

		ORG $2B441A	; 分數坐標
			dc.w	$0B,$24,$0B,$24	; 橫坐標
			dc.w	$00,$00,$1B,$1B	; 縱坐標
		ORG $2B3CC0	; 分數坐標|賽馬
			dc.w	$0B,$24,$0B,$24	; 橫坐標
			dc.w	$00,$00,$1B,$1B	; 縱坐標
		ORG $14CF18	; 空白分數瓦片貼圖
			addi.w	#-$1,d0
		ORG $14AFD0	; 分數數字貼圖基址
			addi.l	#$C9C8,d0
		ORG $14CF4C	; 設定分數色盤
			jsr		sub_14CF4C

		ORG $2B43D0	; 生命數坐標
			dc.w	$15,$21,$15,$21	; 橫坐標
			dc.w	$02,$02,$19,$19	; 縱坐標
		ORG $14ABCC	; 打印生命數目
			jsr		sub_14ABCC
			bra.w	$14AC96
		ORG $14ACF4	; 僅打印兩個貼圖
			pea		(2).w

		ORG $2B440A	; 生命槽坐標
			dc.w	$03,$23,$03,$23	; 橫坐標
			dc.w	$02,$02,$19,$19	; 縱坐標
		ORG $14CF8E	; 我方數顯生命值
			jsr		sub_14CF8E
			jmp		(a0)

		ORG $2B51F4	; 士氣槽坐標
			dc.w	$0A,$23,$0A,$23	; 橫坐標
			dc.w	$01,$01,$1A,$1A	; 縱坐標
		ORG $16602C	; 3P/4P士氣條取消垂直翻轉
			moveq	#0,d3

		ORG $2ABD50	; 角色狀態位選中道具圖片坐標
			dc.l	$00BA,$00F4,$00BA,$00F4
			dc.l	$0008,$0008,$00C9,$00C9
		ORG $2ABD70	; 角色狀態位選中道具數目坐標
			dc.l	$00BC,$00F6,$00BC,$00F6
			dc.l	$0000,$0000,$00D9,$00D9

		ORG $14C14E	; 遊戲內24P選擇新角色時[SELECT]橫坐標
			mulu.w	#$16,d4
			bra.s	$14C14E+8
		ORG $14C244	; 遊戲內24P死命續幣時[SELECT]橫坐標
			mulu.w	#$16,d4
			bra.s	$14C244+8
		ORG $14C814	; 遊戲內24P選擇新角色時[倒計時數字]橫坐標
			mulu.w	#$16,d5
			bra.s	$14C814+8

		ORG $101354	; 報錯"STACK %08X "色表號
			pea		(2).w
		ORG $1013A0	; 報錯"%04X %04X %04X %04X"色表號
			pea		(2).w

	* 敵將血槽

		ORG $107604	; 場景內選新人時取消刷新第四組16色|騰出佔用
			jsr		nullsub

		ORG $124E40	; 敵將頭像右移
			pea		(1).w		; 橫坐標
			clr.l	-(sp)		; 畫頭像
			jsr		$1494C2		; 畫貼圖
			lea		$20(sp),sp
			clr.l	-$10(a6)	; 區域編號
			dc.w	0,0			; 佔位
		ORG $124F28	; 敵將姓名右移
			pea		(5).w		; 橫坐標

		ORG $124F78	; 設定敵將血槽 | 打印血槽
			jsr		sub_124F78
			bra.w	$125128

		ORG $1062DC	; 調整敵將血槽 | 分配瓦片
			jsr		sub_1256E8	; 顯示敵將位目、生命值、招降計時

		* ORG $165C9C	; 設定降將計時條使用第14組16色 | 騰出十組
		* 	ori.b	#$1C,3(a2)
		* ORG $165CC0	; 設定降將計時條使用第14組16色 | 騰出十組
		* 	ori.b	#$1C,3(a2)
		* ORG $165CE4	; 設定降將計時條使用第14組16色 | 騰出十組
		* 	ori.b	#$1C,3(a2)

	* 士氣系統

		ORG $165FE4	; 士氣條色表號|同我方生命槽色表
			moveq	#5,d4
		ORG $166482	; 不滿氣色表號
			pea		(5).w
		ORG $1664A4	; 滿士氣色表號
			pea		(4).w
		ORG $165FA4	; 賽馬時滿士氣
			pea		(4).w
		ORG $165EFC	; 消耗士氣條時
			pea		(5).w
		ORG $1664FC	; 消耗士氣值時
			ori.b	#$A,3(a0)
		ORG $166546	; 補充士氣值時
			ori.b	#$A,3(a0)

		ORG $10B2D0	; 消滅一敵兵增加三士氣，最大士氣值[$48|#72]
			pea 	(3).w
		ORG $11EA3A	; 每次只需消耗[#24]士氣，滿氣分三次消耗完
			tst.b	(byte_810A06).l	; 青龍神器開關
			bne.s	$11EA72			; 不消耗士氣
			moveq	#$18,d0			; 消耗[#24]士氣
			cmp.w	$208(a3),d0
			bgt.s	$11EA76
			bra.s	$11EA64			; neg.b d0					
		ORG $166440	; 三段式士氣條
			jsr		sub_166440
		ORG $1660C6	; 切換場景後修正士氣條顯存
			jsr		sub_1660C6

	* 遊戲難度

		ORG $1461FA	; 右下角顯示難度等信息
			jsr		sub_1461FA
		ORG $14B332	; 取消顯示CREDIT
			RTS

		ORG $15E72C	; 玩家數目難度寄存
			move.b  (ram_0001).l,d0
		ORG $15C61E	; 計算玩家數目模式[1]
			jsr		sub_15C61E
		ORG $15C2E0	; 計算玩家數目模式[2]
			jsr		sub_15C2E0
		ORG $15C9EE	; 計算玩家數目模式[3]
			jsr		sub_15C61E
		ORG $15CE4E	; 計算玩家數目模式[4]
			jsr		sub_15CE4E

		* ORG $11B2E2	; 最终攻击力追加[難度8-0%|7-6.25%|1-43.75%]
		* 	jsr		sub_11B2E2

	* 標題時間

		ORG $145574	; 遊戲時間修正百秒打印
			jmp		sub_145574

		ORG $1460D2	; 遊戲時間TIME常駐 | 現實1秒=60/101遊戲秒
			bra.s	$1460E8
		ORG $134A90	; 對話框重置對應區域顯存時避開時間顯存
			pea		(9).w	; 參考群雄 $13E59C
			pea		($30).w
			pea		(9).w
			pea		(8).w
		ORG $145558	; 關底清除 [TIME] 坐標下移
			pea		(6).w

		ORG $145FDE	; 打印遊戲名稱 [斗轉星旋] | 色表$1A
			jsr		sub_1573CE
		ORG $14556C	; 關底清除遊戲名稱
			jsr		sub_15747E
		ORG $15D142	; 我方動作二重影子起僅取色表[$B]
			NOP
		ORG $10A5AC	; 敵方動作二重影子起僅取色表[$B]
			NOP
		* ORG $38DEDE	; 博望坡地雷區遇人箭 | 箭升空色表編號 $1B
		* 	dc.b	0,$D8	; $14E136
		* ORG $38DE42	; 博望坡地雷區遇人箭 | 箭下落色表編號 $1B
		* 	dc.b	0,$D8	; $14E136
		* ORG $38FFEC	; 江陵道追擊黃蓋馬車的弧形箭 | 取消新增色盤
		* 	dc.l	$38FF24
		* ORG $390006	; 江陵道追擊黃蓋馬車的弧形箭 | 共用 $1C 色表
		* 	dc.b	0,$E0

	* 版本攻略

		ORG $143D24	; 版本編號 | 遊戲攻略 | 打印隱藏人物
			jsr		sub_143D2E	; 版本攻略
			jsr		sub_1439AC	; 隱藏人物
			bra.s	$143D50
		ORG $144E38	; [版本攻略] 覆蓋空白字符
			pea		(asc_2FD66A).l
			pea		(3).w
			pea		(2).w
			pea		(1).w
			pea		(3).w
		ORG $143DF8	; 開啟隱藏人物選擇權限
			jsr		sub_144284

		; 取消投幣閃爍提示
		ORG $14C3FC
			jsr		nullsub
		ORG $14C55C
			jsr		nullsub
		ORG $14C59A
			jsr		nullsub
		ORG $14C5EC
			jsr		nullsub

		ORG $12CDBC	; 區域 | 繁體
			move.b	#1,($816324).l
			moveq	#1,d0
			RTS
		ORG $1CE318	; 警告畫面
			dc.b	'  CHINA  ',0,0,0,0,0
		; 0012CE2A | 留名系統 | 拼音輸入
		ORG $132F12
			bra.s	$132F3C
		ORG $130576
			bra.s	$130588
		ORG $12FCF0
			bra.s	$12FD58
		ORG $12FBA0
			bne.s	$12FBDE
		ORG $12FAB8
			bne.s	$12FAE8
		ORG $12FB06
			bra.s	$12FB3E
		ORG $1333D6
			bra.s	$133440

	* 漏洞修復

		ORG $1450C2	; 修復敵方上圓弧(⌒)異常走位
			jsr		sub_133566

		ORG $123BE8	; 特殊技補充品根據在場角色類型判斷掉落[1] | 策略、魔法、援軍令、武將技
			cmpi.b	#$6, D2
			bge.s	$123BFC
			jsr		sub_123F0E
		ORG $123D78	; 特殊技補充品根據在場角色類型判斷掉落[2] | 撿起后掉落
			cmpi.b	#$6, D2
			bge.s	$123D8C
			jsr		sub_123F0E
		ORG $123F0E	; 特殊技補充品根據在場角色類型判斷掉落[3]
			cmpi.b	#$6, D2
			bge.s	$123F22
			jsr		sub_123F0E
		ORG $1241D8	; 特殊技補充品根據在場角色類型判斷掉落[4]
			cmpi.b	#$6, D2
			bge.s	$1241EC
			jsr		sub_123F0E

		ORG $29EC8C	; 0507北彝陵密道右雙兵敵兵表第三、四條毒蛇坐標修正
			dc.l	$29EA6C
		ORG $29ECA0	; 0507北彝陵密道右坐標修正 | 共用坐標
			dc.l	$29EA78

		ORG $122A86	; 滾石計消耗士氣
			jsr		$11EA2E

		ORG $156ED4	; 修正障礙物的敵我攻擊判定：僅判定我方（如「刺拒馬」）
			move.w  #1,$6C(a0)

		ORG $1B298C	; 修復0700南郡城门前右上角起步無法登上冲车 | 調整屏幕視野 | 參考107
			jsr		sub_1B3246
			bra.s	$1B2A0A

		ORG $124BA0	; 修復曹操天斷劍白屏BUG | 避免重複刷屏
			jsr		sub_124BA0
			jmp		(a0)

		ORG $11D220	; 援軍退場機關僅判定敵方
			jsr		sub_11D220

		ORG $109D1A	; RORO USE
			cmpi.w	#7,d1			; 敵人OBJ上限[7]
			bcs.s	$109CD0
			jsr		(sub_109D20).l	; 強制清除[1]敵人
			bra.s	$109CC6			; 重新分配OBJ序號

		ORG $14E004	; OBJECT DYNAMIC USE
			moveq	#80-8,d0		; 上限[-8]容錯
			cmp.l	d2,d0
			bgt.s	$14DFA2
			move.l	($81B9B0).l,-(sp)	; 0014DFB8
			jsr		($14E464).l		; 強制清除[1]機關
			addq.l	#4,sp
			bra.w	$14DF98			; 重新分配OBJ序號

		ORG $123AE0	; RESOURCE ERROR:WEAPON USE
			moveq	#42-8,d0		; 上限[-8]容錯
			cmp.l	d1,d0
			bgt.s	$123A96
			jsr		(sub_12482A).l	; 清除地面[1]可攜帶物品
			bra.s	$123A8C			; 重新分配OBJ序號

		ORG $11C10E	; RESOURCE ERROR:FOOD USE
			moveq	#12-2,d0		; 上限[-2]容錯
			cmp.l	d1,d0
			bgt.s	$11C0CA
			jsr		(sub_11C82C).l	; 清除地面[1]不可攜物品
			bra.s	$11C0C0			; 重新分配OBJ序號

		ORG $12222A	; 恢復術清除混亂符
			jsr		sub_12222A
			bra.s	$12224A

		ORG $15828A	; 執行動作腳本時修正角色高度
			jsr		sub_15828A

		ORG $13DB50
			jsr		sub_13DB50
			bra.s	$13DBA0

; =============== 斗轉星移 ==================================================

	* 關卡場景

		ORG $133968	; 跳過顯示章節目
			bra.s	$13399E
		ORG $1339C2	; 只顯示章節標題
			bra.w	$133838

		ORG $146D32	; 取消寫入下一章節|第十三個敵將前進行賽馬
			dcb.w	3,$4E71	; NOP佔位|取消刷新下一章節
			cmpi.b	#13,(ram_000C).l	; 賽馬|$D
		ORG $1469A0	; 關卡開頭取消場景置零
			dcb.w	3,$4E71	; NOP佔位

		ORG $14690C	; 刷新音樂曲目前必須重寫音樂組
			NOP

		ORG $14BC6C	; 新角色進場等級與經驗
			jsr		sub_146DD2

		ORG $10FBCC	; [關底結算]結算敵將分數值、經驗值時計算編號
			jsr		sub_10FBCC
		ORG $10FC16	; 擊殺敵兵分數值、經驗值按照[原玩家數目寄存]計算
			jsr		sub_15E72C

		ORG $14705E	; [關底結算]擊殺敵將時計算分數基址
			jsr		sub_14705E
			bra.s	$147072
		ORG $147042	; 擊殺敵將得分按照[原玩家數目寄存]計算
			jsr		sub_15E72C

		ORG $147926	; [關底結算]剩餘時間每秒獎勵[1650經驗值]
			lsl.l	#1,d0
		ORG $1479C4	; [關底結算]每次每個敵將獎勵[20000經驗值]
			move.l	#20000,d1

		ORG $14649C	; [關底結算]取消A面道具+1
			jsr		nullsub
		ORG $2B4368	; 任務經驗值表
			dc.l	$000088B8,$000F4240,$0007A120
			dc.l	$000C3500,$000C3500,$000F4240
			dc.l	$00003E80,$00003E80,$00015F90
			dc.l	$000088B8,$00007530,$000222E0
			dc.l	$00027100,$00035B60,$00015F90
			dc.l	$00027100,$0003F7A0,$000222E0
			dc.l	$000493E0,$00035B60,$00007530
			dc.l	$0007A120,$0003F7A0,$000493E0

			; 81835C | 0502南彝陵 | 攔截候騎
			; 81835E | 0100博望坡 | 火烧博望
			; 818360 | 0203白河上游 | 招降敵將

			; 818362 | 0504華容道 | 招降敵將
			; 818364 | 0603南郡道 | 招降敵將
			; 818366 | 0703大廳 | 招降敵將

			; 818368 | 0200新野城左 | 火烧新野
			; 81836A | 0202白河水壩 | 水淹白河
			; 81836C | 0204屋頂 | 屋頂進密室

			; 81836E | 0300襄江 | 携民渡江
			; 818370 | 0301長坂坡去程 | 长坂救少主
			; 818372 | 0302江夏 | 保护刘琦

			; 818374 | 0400南坪山碼頭 | 摆脱追兵
			; 818376 | 040B曹魏戰船 | 火烧连环
			; 818378 | 0411東吳船艙右密室 | 復活鐵甲

			; 81837A | 0500烏林 | 追擊逃兵
			; 81837C | 0507北彝陵密道左 | 引爆炸藥
			; 81837E | 0503葫蘆口上坡 | 阻止滾石

			; 818380 | 0600山寨 | 直取弓兵
			; 818382 | 0605四神獸密室 | 白虎密室
			; 818384 | 0606火焰洞密室 | 智取寶盒

			; 818386 | 0700南郡城門 | 力取南郡
			; 818388 | 0702長廊密道 | 白兔密室
			; 81838A | 0707下水道密室 | 青龍寶藏

		ORG $145FF2	; 不同關卡中敵人的攻擊AI
			move.b	(ram_000D).l,d0	; 當前同階關卡
			move.l	d0,-(sp)
			jsr		sub_1130E0		; 關卡AI設定

		ORG $146DA0	; 隨機下一場景|結束當前周目
			jsr		sub_162410

	* 0100博望坡

		ORG $175D12	; 進度#9
			move.b	#1,(ram_0027).l	; 打開敵將生命保險
			clr.w	$81AA12.l		; 博望坡天亮計時器
			jsr		sub_1A7EAC		; 敵將出場
			move.l	(ram_000E+2).l,($81C744).l	; 敵將一OBJ
			pea		($7D).w			; 進度+1
			bra.w	$1766E6
		ORG $175D4A	; 進度#10
			jsr		sub_1A7EAC		; 詐逃前對戰敵將

		ORG $175EB8	; 博望坡天亮詐逃時暫停招降計時
			jsr		sub_175EB8		; 暫停速殺計時器
			bra.s	$175EC4
		ORG $175F2A	; 對話判斷敵將
			jsr		sub_175F2A
		ORG $175F38	; 撤退過程中切換背景音樂2
			jsr		sub_175F38
		ORG $175FB8	; 撤退后繼續速殺計時器|恢復原背景音樂
			jsr		sub_175FB8

		ORG $175F60	; 博望坡死亡敵人不追擊|修復無敵死兵
			jsr		sub_176A96

		ORG $175FDC	; 進度#13
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$1766EC			; 繼續循環
			jsr		sub_1450EA		; [0100博望坡]任務獎賞|關底結算
			bra.w	$1766EE

		ORG $1EAAAE	; 刪除第一章敵將死亡設定|比如爆物
			dc.l	nullsub

	* 0202白河水壩

		ORG $17CA88	; 進度#6
			beq.s	$17CAC8		; 是否清兵
			jsr		sub_1A7EAC	; 敵將出場
			move.l	(ram_000E+2).l,$81B648	; 敵將一OBJ
			pea     ($7D).w
			jsr		$13A27E		; 下一進度
			addq.l	#4,sp
			bra.s	$17CAC8		; 水淹白河

		ORG $17CAD0	; 進度#7
			jsr		$17CEC0		; 水淹白河劇情
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$17CB36
			jsr		sub_1450EA	; [0202白河水壩]任務獎賞|關底結算
			bra.w	$17CB38

		ORG $1EAB2E	; 刪除第二章敵將死亡設定|比如爆物
			dc.l	nullsub

	* 0203白河上游

		ORG $17D6E0	; 進度
			dc.w	$17D884-$17D6D4	; #6
			dc.w	$17D862-$17D6D4	; #7

		ORG $17D862
		* [進度#7]原進度#6
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$17D986
			jsr		sub_175D3A	; 是否至少速殺一敵將
			move.w	d0,($818360).l	; 0203白河上游[招降敵將]任務
			jsr		sub_1450EA	; [0203白河上游]任務獎賞|關底結算
			bra.w	$17D988
		* [進度#6]$17D884
			jsr		$12EF80
			tst.l	d0
			beq.w	$17D986			
			pea		($7D).w
			jsr		$13A27E		; 下一進度#7
			addq.l	#4,sp
			bra.w	$17D986

	* 0205新野城右

		ORG $17EDBC	; 進度#6
			pea		($7D).w
			jsr		$13A27E		; 下一進度#7
			addq.l	#4,sp
			bra.w	$17EEAE

		ORG $17EDE6	; 進度#7
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$17EEAE
			jsr		sub_1450EA	; [0205新野城右]任務獎賞|關底結算
			bra.w	$17EEB0

	* 0208屋頂密室

		ORG $180BB8 ; 進度#0
			move.l	#8,$81B9D8.l	; 原代碼
			pea		($7D).w
			jsr		$13A27E			; 下一進度
			addq.l	#4,sp
			bra.w	$180C82

		ORG $180BF4 ; 進度#2
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$180C82
			jsr		sub_1450EA		; [0208屋頂密室]任務獎賞|關底結算
			bra.w	$180C84

	* 0300襄江

		ORG $181774	; 進度#27
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1817B2
			jsr		sub_1450EA	; [0300襄江]任務獎賞|關底結算
			bra.w	$1817B4

	* 0301長坂坡

		ORG $182FBA	; 進度#17
			jsr		sub_183E66		; 敵將出場設定
			addq.b	#1,($81B952).l	; 下一進度
			bra.w	$18304C
		* word_2AF810	; 「阿斗在我手中，汝等不可輕舉妄動。」
		* word_2AF832	; "撞擊敵將(張郃)以救少主"

		ORG $182810	; 長坂坡進度#18同#19偏移
			dc.w	$182FEC-$1827EC
		ORG $182FEC	; 進度#19
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$18304C
			jsr		sub_1450EA		; [0301長坂坡]任務獎賞|關底結算
			bra.w	$18304E

		ORG $28A68C	; 取消原版長坂坡爆物
			dc.l	nullsub

	* 0302江夏

		ORG $1856D4	; 下一進度#13
			bne.s	$1856E4			

		ORG $1856EE	; 進度#13
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1857B8
			jsr		sub_1450EA	; [0302江夏]任務獎賞|關底結算
			bra.w	$1857BA

		ORG $28A6A8	; [原版爆物]改[劉琦贈物]
			dc.l	sub_18571E
		ORG $166CFC	; 劉琦贈天師道袍
			pea		($4E).w

	* 0400南坪山碼頭

		ORG $188378	; 進度#19
			addq.l	#4,sp			; 平衡堆棧
			move.b	#1,($81C6FC).l	; 原代碼
			bra.s	$1883AE			; 下一進度

		ORG $1883B8	; 進度#20
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$18843C
			jsr		sub_1450EA		; [0400南坪山碼頭]任務獎賞|關底結算
			bra.w	$18843E

	* 0403東吳戰船

		ORG $18F160 ; 進度#4
			jsr		$13A646			; 主循環|左慈退場
			jsr		$19021E			; 機關左慈是否存在
			tst.l	d0
			beq.s	$18F160
			jsr		$13A646			; 主循環|清除左慈
			clr.b	($81AD24).l
			clr.l	($81AE10).l
			jsr		sub_1A7EAC		; 敵將出場
			jsr		$1878EA			; 我方可行動
			move.b	#1,($81B5E0).l	; 敌人可行动
			move.b	#1,($81B93C).l	; 敵方可攻擊
			bra.s	$18F1C2			; 下一進度

		ORG $18F1D2 ; 進度#5
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$18F350
			jsr		sub_1450EA	; [0403東吳戰船]任務獎賞|關底結算
			bra.w	$18F352

		ORG $28F430	; 對戰敵將時敵兵不掉落金錢
			dc.l	($176F1C).l

		ORG $1EAC2E	; 刪除第四章敵將死亡設定|比如爆物
			dc.l	nullsub

	* 040B曹魏戰船

		ORG $1946EE ; 進度#7
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$194AD4
			jsr		sub_1450EA	; [040B曹魏戰船]任務獎賞|關底結算
			bra.w	$194AD6

		ORG $28F4DC	; 取消原版爆物
			dc.l	nullsub
		ORG $28F4D8	; 對戰敵將時敵兵不掉落金錢
			dc.l	$176F1C

	* 0500烏林

		ORG $199D32	; 進度#3
			cmpi.w	#2,(ram_000A).l	; 敵將是否出場完畢
			bcc.w	$19A41A			; 下一進度
			move.b	#1,(ram_0027).l	; 打開敵將生命保險
			jsr		sub_1A7EAC		; 敵將出場
			bra.w	$19A420			; 繼續循環

		ORG $199D80	; 進度#4
			jsr		sub_199D80		; 烏林前段|對戰敵將|敵將逃跑
			bra.w	$19A420

		ORG $199CB6	; 進度#5
			dc.w	$19A18E-$199CAC	; 追擊路綫指示

		ORG $19A1EC	; 進度#8
			jsr		sub_19A1EC		; 敵將補充生命值
			bra.s	$19A222			; 持續刷兵
		ORG $10FB0E	; 原版檢查敵將生命值上限
			move.l	a2,-(sp)
			jsr		sub_1A87EC		; 計算敵將生命值
			addq.l	#4,sp
		
		ORG $19A272	; 進度#9
			jsr		sub_19A272		; 繼續對戰敵將|任務[追擊逃兵]
			bra.w	$19A41A

		ORG $19A2F0	; 進度#10
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$19A420
			jsr		sub_1450EA		; [0500烏林]任務獎賞|關底結算
			bra.w	$19A422

		ORG $1EACAE	; 刪除第五章敵將死亡設定|比如爆物
			dc.l	nullsub

	* 0501北彝陵

		ORG $19B2CC	; 進度#24
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.s	$19B304
			jsr		sub_1450EA	; [0501北彝陵]任務獎賞|關底結算
			bra.w	$19B306

	* 0504華容道

		ORG $19D39A	; 0504華容道下一進度#19
			jsr		nullsub

		ORG $19D3AA	; 進度#19
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$19D434
			jsr		sub_175D3A		; 是否至少速殺一敵將
			move.w	d0,($818362).l	; 0504華容道[招降敵將]任務
			jsr		sub_1450EA		; [0504華容道]任務獎賞|關底結算
			bra.w	$19D436
	
	* 0502南彝陵>>0505江陵道

		ORG $1A0A6E	; 進度#10
			clr.w	(ram_000B).l	; 取消出兵
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$1A0BA4
			move.w	#1,($80D030).l	; 解封道具
			pea		$13A646.l		; 3秒主循環
			pea		($B4).w
			jsr		$100EA4.l
			addq.l  #8,sp
			jsr		sub_1450EA		; [0505江陵道]任務獎賞|關底結算
			bra.w	$1A0BA6

	* 0508葫蘆口

		ORG $1A7428	; 下一進度#6
			bra.s	$1A747C

		ORG $1A7494	; 進度#6
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.s	$1A7482
			jsr		sub_1450EA	; [0508葫蘆口]任務獎賞|關底結算
			bra.w	$1A766C

	* 0600山寨|0604油江
		* 0600山寨
		ORG $1A806A	; 進度#7
			bra.w	$1A83F2			; 下一進度

		ORG $1A80BA	; 進度#8
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$1A83F8
			pea		$13A646.l
			pea		$B4.w			; 主循環3秒
			jsr		$100EA4.l
			addq.l	#8,sp
			addq.b	#1,($81B046).l	; 下一進度#9
			jsr		sub_1AFB8E		; 隨機下一敵將|結束當前周目
			bra.w	$1A83FA

		* 0604油江

		ORG $1ADA48	; 進度#6
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1ADA76		; 檢查洪水計時器
			move.w	#1,($81B604).l	; 油江敵將已擊殺
			jsr		sub_1450EA	; [0604油江]任務獎賞|關底結算
			bra.w	$1ADF50
		ORG $1ADA84	; 取消原版刷兵
			bra.w	$1ADF4E

		ORG $1AE982	; 清除左向左慈後檢查是否擊殺敵將
			jsr		sub_1AE982
			beq.s	$1AE99C		; 洪水程序下一進度
			bne.w	$1AEB44		; 退出洪水程序
		ORG $1ADA9A	; 已經擊殺敵將則取消洪水
			jsr		sub_1AE982
			beq.s	$1ADAD4		; 繼續洪水
			jsr		sub_1A7EAC	; 敵將爆物
			tst.l	d0
			beq.w	$1ADF4E
			move.w	#1,($81B604).l	; 油江敵將已擊殺
			jsr		sub_1450EA	; [0604油江]任務獎賞|關底結算
			bra.w	$1ADF50

		ORG $1AE94A	; 左慈出屏前敵人東撤|洪水進度#1
			jsr		sub_1AE94A
		ORG $1AE8B0	; 左慈從左側重新出現|洪水進度#2
			dc.w	$1AEA4C-$1AE8AC
		ORG $1AEA82	; 校正堆棧
			lea		$18(sp),sp
		ORG $1AED86	; 每個角色水沖後減30生命值
			jsr		sub_1AED86

		ORG $16E05E	; 左慈洪水中敵將保持動作
			bra.s	$16E084
		ORG $1AEBD6	; 左慈洪水後敵方設定
			lea		$C(sp),sp	; 校正堆棧
			jsr		sub_1AEBD6
			bra.s	$1AEC28

		ORG $1ADDC8	; 左慈洪水后取消刷新敵兵表
			subq.l	#8,sp		; 平衡堆棧
			bra.s	$1ADE2A
		ORG $1ADCDE	; 0604油江下竹筏後擴大左版[1]
			pea		($1BE).w
			bra.s	$1ADCE8
		ORG $1ADE68	; 0604油江下竹筏後擴大左版[2]
			pea		($1BE).w
		ORG $1ADE76	; 進度#10
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1ADF4E		; 繼續循環
			jsr		sub_1450EA	; [0604油江]任務獎賞|關底結算
			bra.w	$1ADF50

		ORG $1EAD2E	; 刪除第六章敵將死亡設定|比如爆物
			dc.l	nullsub

		ORG $29FBBE	; 0604油江基礎時間|死命後重置的計時數
			dc.w	$63

	* 0601火焰洞

		ORG $1A9B10	; 下一進度#8
			bra.s	$1A9B38

		ORG $1A9B42	; 進度#8
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1A9C86
			jsr		sub_1450EA	; [0601火焰洞]任務獎賞|關底結算
			bra.w	$1A9C88

	* 0602古墓|0605四神獸密室

		ORG $1AFB8E	; 進度#9
			jsr		sub_1A7EAC		; 對戰敵將[0605四神獸密室]
			tst.l	d0
			beq.w	$1AFD8C
			addq.b	#1,($81B108).l	; 下一進度[0602古墓]
			jsr		sub_1AFB8E		; 隨機下一敵將|結束當前周目
			bra.w	$1AFD8E


		ORG $1AB002	; 進度#11
			move.w	#$19,(ram_0013).l	; 古墓序號#$19
			move.w	#1,$81B5E8.l		; 關閉藍蠍機關
			bra.s	$1AB08C				; 下一進度

		ORG $1AB096	; 進度#12
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1AB1D0
			jsr		sub_1450EA	; [0602古墓]任務獎賞|關底結算
			bra.w	$1AB1D2

	* 0603南郡道

		ORG $1ACB88	; 進度#9
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$1ACC5E
			jsr		sub_175D3A		; 是否至少速殺一敵將
			move.w	d0,($818364).l	; 0603南郡道[招降敵將]任務
			jsr		sub_1450EA		; [0603南郡道]任務獎賞|關底結算
			bra.w	$1ACC60

	* 0704南郡城後方>>0700南郡城門

		ORG $1B2204	; 進度#18
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1B22F0
			jsr		sub_1450EA	; [0700南郡城門]任務獎賞|關底結算
			bra.w	$1B22F2

	* 0703大廳

		ORG $1B5480	; 進度#6
			move.w	#$384,($81B1AE).l	; 0703大廳末暗箭頻率
			pea		(3).w
			pea		($2B733A).l			; 殿前黑豹群
			jsr		$12EF1A
			addq.l	#8,sp
			bra.w	$1B5536				; 下一進度#7

		ORG $1B55D2	; 進度#7
			jsr		sub_1A7EAC		; 對戰敵將
			tst.l	d0
			beq.w	$1B568C
			jsr		sub_175D3A		; 是否至少速殺一敵將
			move.w	d0,($818366).l	; 0703大廳[招降敵將]任務
			jsr		sub_1450EA		; [0703大廳]任務獎賞|關底結算
			bra.w	$1B568E

		ORG $1EADAE	; 刪除第七章敵將死亡設定|比如爆物
			dc.l	nullsub

	* 0705下水道

		ORG $1B7A78 ; 取消進度07[原許褚出場設定]
			dc.w	$1B80A6-$1B7A6A

		ORG $1B7E04 ; 進度#9
			jsr		sub_1B84EA	; 排水管機關
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1B80AC
			jsr		sub_1450EA	; [0705下水道]任務獎賞|關底結算
			bra.w	$1B80AE

	* 0701前庭|0706長廊

		ORG $1B44D2	; 0701前庭對戰敵將[進度#10]
			jsr		sub_1A7EAC	; 對戰敵將
			tst.l	d0
			beq.w	$1B45A6
			jsr		sub_1AFB8E	; 隨機下一敵將
			tst.l	d0
			bne.w	$1B45A8		; 結束當前周目
			jsr		sub_1B44D2	; 下一場景路線指示標
			bra.s	$1B4534		; 下一進度


		ORG $1B8CD6	; 進度#10
			bsr.w	($1B8992).l		; 繼續佈置機關
			jsr		(sub_1A7EAC).l	; 對戰敵將
			tst.l	d0
			beq.w	$1B8D9A
			jsr		(sub_1450EA).l	; [0706長廊]任務獎賞|關底結算
			; 關閉機關
			* pea		(1).w
			* jsr		($1B91D8).l
			* pea		(1).w
			* jsr		($1B907E).l
			* clr.l	-(sp)
			* jsr		($1B91D8).l
			* clr.l	-(sp)
			* jsr		($1B907E).l
			* lea		$10(sp),sp
			bra.w	$1B8D9C

; =============== 地轉星旋 ==================================================

	* 0100博望坡[隨人雷]

		* word_2AF438	; 0100博望坡開場諸葛亮軍令

		ORG $175BFA	; 0100博望坡第二段[隨人雷]機關
			jsr		sub_175BFA
		ORG $175C92	; 0100博望坡第三段[隨人雷]機關
			jsr		sub_175BFA

		ORG $17843E	; 0101地雷區佈置[遇人箭]
			jsr		sub_17843E
		ORG $17865C	; 0101地雷區清除[遇人箭]
			jsr		sub_17865C

		ORG $177854	; 0100博望坡詐降炸藥換地雷
			lea		$C(sp),sp	; 校正堆棧
			jsr		sub_177854	; 佈置地雷
			bra.w	$177968
	
	* 0200新野城

		* 新野城放火動作
		ORG $25143A	; 關羽
			dc.w	$0111
			dc.l	dword_250AD4,$01000800,0,0
		ORG $256804	; 張飛
			dc.w	$0111
			dc.l	dword_255EAA,$01000800,0,0
		ORG $25BD20	; 趙雲
			dc.w	$0111
			dc.l	dword_25B3C6,$01000800,0,0
		ORG $26140C	; 黃忠
			dc.w	$0111
			dc.l	dword_255EAA,$01000800,0,0
		ORG $2671DE	; 馬超
			dc.w	$0111
			dc.l	dword_26686C,$01000800,0,0
		ORG $26C6FE	; 孔明
			dc.w	$0111
			dc.l	dword_26BC6C,$01000800,0,0
		ORG $27170E	; 貂蟬
			dc.w	$0111
			dc.l	dword_270DA4,$01000800,0,0
		ORG $276C2E	; 龐統
			dc.w	$0111
			dc.l	dword_2762CC,$01000800,0,0
		ORG $27C8CE	; 孫權
			dc.w	$0111
			dc.l	dword_27BF74,$01000800,0,0
		ORG $17C134	; 火烧新野城：每个玩家最低14次连按
			lsl.l   #3,d0

		ORG $17F956	; 進入[0206武器庫密室]時重置寄存
			jsr		sub_17F956
		ORG $17FC82	; 普通攻擊[03XX]對龍頭機關有效
			dcb.w	4,$4E71	; NOP佔位
		ORG $289BF2	; 墻壁石板一擊即開
			dc.b	$1,0
		ORG $17F7DA	; 判斷是否進入武器庫
			jsr		sub_17F7DA
			tst.b	d0
		ORG $17F81E	; 取消原版進入標記
			jsr		nullsub
		ORG $17FB7E	; 各角色進入武器庫取得的武器
			jsr		sub_17FB7E

		ORG $284DD8	; 屋頂[炸彈兵]機關[單兵]
			dc.l	$FF070000,sub_17C21C
		ORG $284F14	; 屋頂[炸彈兵]機關[雙兵]
			dc.l	$FF070000,sub_17C21C

		ORG $17C3F2	; 火球車
			jsr		sub_17C21C
			
		ORG $17C2D2	; 新野城一衝車
			jsr		sub_17C21C
		ORG $17F308	; 新野城二衝車[1]
			jsr		sub_17C21C
		ORG $17F4CE	; 新野城二衝車[2]
			jsr		sub_17C21C

		ORG $17EA1A	; 取消新野城二場景火
			dcb.w	3,$4E71	; NOP佔位

	* 0204屋頂[雙鷹]

		ORG $1DE57E	; 0200新野城左關閉[0204屋頂]入口
			dc.l	nullsub

		ORG $17E602	; 0204屋頂切換場景段時[雙鷹]機關[1]
			jsr		sub_1B6E5A
		ORG $17E694	; 0204屋頂切換場景段時[雙鷹]機關[2]
			jsr		sub_1B6E5A

		ORG $17E3E8	; 0204新野城屋頂進入前佈置老鷹機關
			jsr		sub_17E3E8

		ORG $17E5C6	; 0204屋頂第一段加入老鷹機關
			jsr		sub_1B6E5A.l	; 觸發老鷹機關
			jsr		$12EF80.l
			tst.l	d0
			beq.w	$17E8AA
		ORG $17E64E	; 0204屋頂第二段加入老鷹機關
			jsr		sub_17E64E

		ORG $17E2B8	; 0204[於屋頂進入0208密室]任務
			jsr		sub_17E2B8
		ORG $17E7EA	; 0204下屋頂進入0208密室
			pea		(8).w
		ORG $2827A8	; 0208屋頂密室進場動作
			dc.l	sub_2827A8

	* 0202白河水壩[雙鷹]

		ORG $17C8F4	; 0202白河川[雙鷹]機關[1]
			jsr		sub_1B6E5A
		ORG $17C968	; 0202白河川[雙鷹]機關[2]
			jsr		sub_1B6E5A
		ORG $17C99C	; 0202白河川[雙鷹]機關[3]
			jsr		sub_1B6E5A
		ORG $17CA2C	; 0202白河川[雙鷹]機關[4]
			jsr		sub_1B6E5A
		ORG $17CA64	; 0202白河川[雙鷹]機關[5]
			jsr		sub_1B6E5A
	
		ORG $285E1E	; 0202白河川新增薤葉芸香2
			dc.w	$3D3E
		ORG $286406	; 新增薤葉芸香3
			dc.w	$5F3E
		ORG $17C9F6	; 取消佈置站立曹仁
			bsr.w	$17C540

		ORG $17CF6C	; 0202白河川第二章節第二任務[水淹白河]
			movea.l	$58(a2),a0
			cmpi.b	#2,(a0)		; 是否敵兵
			beq.s	$17CFB2
			jsr		sub_17CF6C	; 水沖敵將之動作
			bra.s	$17CFEA
		ORG $17CFD2	; 跳過原版任務判斷
			bra.s	$17CFEA

		ORG $17D0C8	; 水壩拆毀後暫停速殺計時器
			jsr		sub_17D0C8
		ORG $17D070	; 水淹白河後繼續速殺計時器
			jsr		sub_17D070

		ORG $17CF00	; 水淹白河時強制收回援軍
			tst.w	$BE(a2)		; 是否換將狀態
			beq.s	$17CF14
			clr.w	$20A(a2)	; 換將時間置零
			bra.s	$17CF4A

		ORG $17D08A	; 非本武攻擊對水壩有效
			jsr		sub_17D08A
			bra.s	$17D0A4

	* 0203白河上游[三胖火甲車]

		ORG $17DA02	; 0203白河上游[三胖火甲車]
			jsr		sub_17DA02
			tst.l	d0
			beq.w	$17DAEA

		ORG $1DFC32	; 0203白河上游小寶箱[包子]
			dc.w	$82

	* 0300襄江[箭雨]

		ORG $181550	; 0300襄江中段[箭雨]機關
			jsr		sub_181550
		ORG $1815CC	; 0300襄江後段[箭雨]機關
			jsr		sub_181550

		ORG $181B0C	; 老者[1]換胖子
			pea     ($1F332C).l
		ORG $166BAE	; 老者[2]是否幸存
			jsr		sub_166BAE
		ORG $181616	; 第三章節第一任務[携民渡江]
			jsr		sub_181616
			bra.w	$1817B2
		* word_2AF5D6	; 「將軍義薄雲天，請接受老夫家傳寶器。」

	* 0301長坂坡[敵兵陣型]

		ORG $182BA2	; 0301長坂坡取消見糜夫人條件之一[難民任務]
			bra.s	$182BCE

		ORG $182ED4	; 0301長坂坡取消[青釭劍]鐵甲步兵陣
			bra.s	$182F0A

	* 0302江夏[火鴉]

		ORG $185148	; 0302江夏[火鴉]
			jsr		sub_185148

		ORG $28A69C	; 0302江夏中段加入[火鴉]機關
			dc.l	sub_18530E

	* 0403東吳戰船[左慈]

		ORG $18A964	; 0403東吳戰船左慈設定
			jsr		sub_18A964
		ORG $18D550	; 0406東吳戰船左慈設定
			jsr		sub_18D550

		ORG $18D3F6	; 0406東吳戰船取消引箭弓兵
			RTS
		ORG $18D52E	; 取消弓兵引箭
			dc.w	$18D5B2-$18D52A

		ORG $18CDD4	; 0405東吳左船艙[03類普攻]擊打燈盞可開啟0410密室
			dcb.w	8,$4E71	; NOP佔位
		ORG $18C360	; 替換0410為[0411東吳船艙右密室]
			pea		($11).w
		ORG $1954AE	; 出密室回0405東吳戰船船艙
			pea		(5).w	
		ORG $2B721E	; [0411東吳船艙右密室]單兵雙兵同表
			dcb.l	2,$00296A70
		ORG $196438	; [撞擊復活鐵甲步兵得鹤羽宝衣]任務
			jsr		sub_196438
			bra.s	$19645E

		ORG $18F0F8	; 取消原版甘寧出場
			jsr		nullsub
		ORG $1908A0	; 蜀船鐵甲兵替換為長兵
			pea		($38A682).l
		ORG $1908B2	; 長兵動作[燒死]
			move.l	#$38A5EA,$2C(a2)
		ORG $293664	; 左慈出場
			dc.l	$F0070000,sub_190140
		ORG $24CC7C	; 出場動作完直接離開
			dc.l	$F0040103

	* 040B曹魏戰船[隨人箭]

		ORG $18B808	; 跳過040E連環船1
			pea		($F).w
		ORG $189B8E	; 跳過040C/040E
			pea		($F).w

		ORG $1930C4	; 040D曹魏戰船船艙[03類普攻]擊打燈盞可開啟0412密室
			dcb.w	8,$4E71	; NOP佔位
		ORG $18C114	; 替換0412為[0410東吳船艙左密室]
			pea		($10).w
		ORG $19549E	; 出密室回040D曹魏戰船船艙
			pea		($D).w
		ORG $1954E6	; 進入0410不重置火燒連環船任務
			jsr		nullsub		

		ORG $1944A6	; 040F連環船[隨人箭]機關
			jsr		sub_1944A6

	* 0500烏林[排三箭]

		ORG $199CDE	; 0500烏林前段[排三箭]機關
			jsr		sub_199CDE
		ORG $19A222	; 0500烏林中段[排三箭]機關
			jsr		sub_199CDE

	* 0501北彝陵[落石]

		ORG $1EAC9A	; 第五章初始化
			dc.l	(sub_19956A).l

		ORG $19B116	; 固定劇情[徐晃破石]
			NOP
		ORG $19B18A	; 北彝陵進度04>05前>06[取消打開后段路綫]
			bra.s	$19B196
		ORG $2981D0	; 0501北彝陵二進場角色設定
			dc.l	sub_2981D0
		ORG $2981BC	; 0501北彝陵二進場地圖設定
			dc.l	sub_2981BC
		ORG $19AFDA	; 北彝陵進度05偏移到[打開後段路綫]05后>07>08
			dc.w	$19B1C8-$19AFD0

		ORG $1A5E6C	; 0507北彝林密室左[隨人暗箭]頻率統一為1P
			move.b	#$76,($81AFEE).l
			bra.s	$1A5E8A
		ORG $1A5F78	; 0507北彝林密室左[引爆炸藥]任務
			jsr		sub_1A5F78
			rts

		ORG $19A94E	; 0501北彝陵前段[滑石]機關頻率
			move.w	#$1E,($81AF40).l

		ORG $1C5272	; [落石]機關傷害值
			dc.b	$0F,$00	; 機關指針$22(1C5250)
		ORG $1A492C	; 0507北彝陵密道中1[落石]機關
			jsr		sub_1A492C
		ORG $1A498E	; 0507北彝陵密道中2[落石]機關
			jsr		sub_1A492C
		ORG $1A4BA2	; 0507北彝陵密道右1[落石]機關
			jsr		sub_1A492C
		ORG $1A4D74	; 0507北彝陵密道右2[落石]機關
			jsr		sub_1A492C
		ORG $1A4E34	; 0507北彝陵密道左[落石]機關
			jsr		sub_1A492C

		ORG $2981D4	; 0501北彝陵基礎時間
			dc.w	99	; 死命後重置的計時數

	* 0503葫蘆口[滾石]

		ORG $1A2E4E	; 0506葫蘆口密室>0508葫蘆口下坡|0507北彝陵密道>0501北彝陵二
			jsr		sub_1A2E4E

		ORG $1A3FBE	; 0503葫蘆口密室鐵盒|蚩尤戰甲
			move.w	#$46,$DE(a2)

		ORG $29B402	; 0503葫蘆口上坡入口處單兵與雙兵同敵兵表
			dc.l	$29B2F0
		ORG $29B2F0	; 0503葫蘆口上坡入口處敵兵表
			dc.l	$FF120101,$FF0F0100,$FF0C0000
			dc.l	$FF050104,$003837DE,$00000104,$0029B1B4,$FF0B001E	; 第一隊工兵毀樁
			dc.l	$FF050105,$003837DE,$00000105,$0029B1C0,$FF0B001E,$FF0F0100
			dc.l	$FF050102,$00370D1A,$00020102,$0029B1CC,$FF0B001E,$FF0C0100
			dc.l	$FF050102,$00370D1A,$00020102,$0029B1D8,$FF0B001E
			dc.l	$FF050104,$003837DE,$00000104,$0029B1B4,$FF0A0100,$FF0F0100,$FF0C0000
			dc.l	$FF050103,$00394464,$00000103,$0029B1F0,$FF0B001E,$FF0F0101
			dc.l	$FF050103,$00394464,$00000103,$0029B1FC,$FF0B001E
			dc.l	$FF050103,$00394464,$00000103,$0029B208,$FF0F0100,$FF0B001E,$FF0C0100
			dc.l	$FF050104,$003837DE,$00000104,$0029B1B4,$FF0B001E	; 第二隊工兵出現
			dc.l	$FF050105,$003837DE,$00000105,$0029B1C0,$FF0B001E
			dc.l	$FF050104,$003837DE,$00000104,$0029B1B4,$FF0A0000,$FF130000
		ORG $19C632	; 是否完成[阻止滾石]任務
			jsr		sub_19C632

		ORG $1A7180	; 0508葫蘆口下坡[出兵>滾石]
			dc.w	$1A72C2-$1A7180	; [1]賦兵
			dc.w	$1A72E6-$1A7180	; [2]出兵
			dc.w	$1A71B2-$1A7180	; [0]滾石
			dc.w	$1A7308-$1A7180	; [3]滾石
		ORG $1A72E6	; 0508葫蘆口下坡提前刷新敵兵表
			jsr		sub_1A72E6		; 敵兵表刷新
			bra.s	$1A72F0
		ORG $29FAFA	; 0508葫蘆口下坡出口處單兵與雙兵同敵兵表
			dc.l	$29F752
		ORG $29F752	; 0508葫蘆口下坡出口處敵兵表取消刷兵間隔
			dc.l	$FF120100,$FF0F0101,$FF0C0400
			dc.l	$FF050100,$003837DE,$00000100,$0029F6A2
			dc.l	$FF050100,$003837DE,$00000100,$0029F6AE
			dc.l	$FF050100,$003837DE,$00000100,$0029F6BA
			dc.l	$FF050100,$003837DE,$00000100,$0029F6C6,$FF0F0100
			dc.l	$FF050103,$00394464,$00000103,$0029F6D2,$FF0F0101
			dc.l	$FF050103,$00394464,$00000103,$0029F6DE,$FF0A0000,$FF130000

	* 0504華容道[時間刷兵]

		ORG $19CFD0	; 0504華容道進場初始時間[10秒]
			jsr		sub_19CFD0
		ORG $29821C	; 0504華容道擊殺[1]個敵兵獎勵[1]個遊戲秒
			dc.l	sub_19D43A

		ORG $19D126	; 取消夏侯雙王
			bra.s	$19D15C
		ORG $19D1F4	; 取消樹上徐晃
			addq.b	#1,$81AF5E.l	
			bra.w	$19D434
		ORG $19D262	; 取消郃晃雙王
			bra.s	$19D2A2

	* 0502南彝陵>>0505江陵道[封禁道具]

		ORG $19B9A2	; 0502南彝陵[三鉄騎陣]
			jsr		sub_19B9A2
		ORG $19BA74	; 0502南彝陵[三鉄騎陣]機關頻率[2.5秒/次]
			move.w	#150,($81AF4E).l
		ORG $19BB64	; 0502南彝陵中段[三鉄騎陣]機關
			beq.w	$19BB14

		ORG $19BC88	; 0502南彝陵>0505江陵道
			pea		(5).w

		ORG $37B372	; 0502南彝陵[金甲候騎1]色盤[$14F5A4]
			dc.l	$F05A0000,off_34677C	; 設定色盤
		ORG $19B824	; 0502南彝陵[金甲候騎2]
			pea		(3).w	; 色盤編號0003
		ORG $19B8D6	; 0502南彝陵[攔截候騎]任務
			jsr		sub_19B8D6

		ORG $1A0490	; 取消黃蓋求救對話
			jsr		sub_1A0490	; 禁止使用道具和必殺
		ORG $1A067E	; 進度01[黃蓋領駕追曹賊]
			jsr     $1578e4.l		; 封禁我方行動力
			jsr     $1a232a.l
			pea     $3e.w
			pea     $18.w			; 黃蓋說
			jsr     $1343d6.l		; 對話框
			jsr     $1a2358.l		; 黃蓋離場
			jsr     $1578da.l		; 解封我方行動力
			jsr     $10f516.l		; 解封敵方行動力
			pea     $14.w			; 20遊戲秒清兵
			jsr     $145a86.l
			lea     $C(A7), A7		; 平衡堆棧
			addq.b  #1, $81af76.l	; 江陵道進度02
			bra.w	$1a0ba4			; 循環
		ORG $1A06E8	; 進度02[限時清兵上馬車]
			jsr     $12ef80.l
			tst.l   D0				; 是否清完兵
			beq.w	$1a0ba4
			pea		(1).w
			pea		(6).w
			pea		($96).w
			pea		($180).w
			clr.l	-(sp)
			jsr		$12E93C			; 路線指示
			pea		($13).w
			pea		($1DE5E6).l
			clr.l	-(sp)
			jsr		$157748			; 傳送門
			lea		$20(sp),sp
			addq.b	#1,($81AF76).l	; 下一進度
			bra.w	$1A0BA4			; 循環
		ORG $1A0A0C	; 取消張遼追擊
			jsr		nullsub
		ORG $1A215E	; 取消掉落蚩尤戰甲
			jsr		nullsub
	
	* 0600山寨|0604油江[暗矛]
		* 0600山寨
		ORG $1A7EE6	; 取消周泰裂車劇情
			jsr		nullsub
		ORG $1A7B42	; 取消寨頂右縱坐標3A魏長兵[第二個]
			bra.s   $1a7b46

		ORG $1A8D10	; 投火球車的長兵作撤離以免佔用敵兵OBJ
			pea		($282F8C).l

		ORG $1A817E	; 進度#9
			move.w  #$1, $81B04C.l	; 取道油江
			move.w	#$18, (ram_0013).l	; 油江序號#$18
			jsr		sub_1A81F2		; 橋樑處敵兵
			bra.s	$1A8214

		ORG $1A8424	; 0600山寨橋樑處擊殺[紫色弓兵]即爆物
			tst.w	$6C(a2)			; 是否擊殺
			bne.s	$1A8484
			movea.l	$58(a2),a0
			cmpi.b	#$30,1(a0)		; 是否弓兵
			bne.s	$1A8484
			move.w	#1,($818380).l	; 第六章節第一任務[直取弓兵]
			bra.s	$1A8466			; 掉落物品
		ORG $1A8466	; 0600山寨橋樑處[紫色弓兵]
			clr.l	-(sp)
			pea		($35).w			; 玄武神器
			clr.l	-(sp)
			move.w	$22(a2),d0
			move.l	d0,-(sp)
			move.w	$20(a2),d0
			move.l	d0,-(sp)
			jsr		($123B96).l
			lea		$14(sp),sp

		ORG $38E304	; 弓兵[0000][無敵]觸發騰空
			dc.w	$0006	; 觸發動作
			dc.l	off_38E270,$01000800,$0,$0
			dc.w	$0007	; 騰空動作
			dc.l	$0038E3A0,$02000000,$0,$0
		ORG $371B44	; 男弓蠻兵[0003]射擊後退兵
			dc.w	$0006
			dc.l	off_371898,$01000000,$0,$0

		* 0604油江
		ORG $1AD972	; 0604油江竹筏下[暗矛]機關
			jsr		sub_10F4EA	; 敵方可行動可攻擊
			jsr		sub_1890C0	; 暗矛機關

		ORG $1AD9EC	; 關閉暗矛|進度#5
			move.l	#$CB2,($81B0D2).l	; 原代碼[左慈洪水計時]
			clr.w	($81B604).l			; 油江敵將待擊殺
			cmpi.b	#4,($81A326).l		; 難度[1-4]
			bls.w	$1ADF48				; 取消
			jsr		($18921C).l			; 關閉暗矛
			bra.w	$1ADF48

	* 0602古墓[鉄刺橫柱][鉄刺滾球]|0605四神獸密室

		ORG $1EAD1A	; 第六章初始化
			dc.l	(sub_1A7688).l

		ORG $1AAE06	; 0602古墓前段[鉄刺橫柱]機關
			jsr		sub_1AA9F4	; 鉄刺橫柱
			subq.w	#1,($81B9E0).l

		ORG $1AA8F0	; 0602古墓中段根據時間來觸發[鉄刺滾球]機關
			jsr		sub_1AA8F0
		ORG $1AC78A	; 刷兵不觸發機關時間重置
			RTS

		ORG $1AAD52	; 15只藍蠍子
			jsr		$10F32A

		ORG $1AF400	; 四神獸密室層25秒/12遊戲秒
			pea		($4BC).w

		ORG $1B02C4	; 取消兩個虎嘯雕塑
			bra.s	$1B02F8
		ORG $1AF11A	; 0605[白虎密室]任務|爆物
			jsr		sub_1AF11A
		ORG $1AFA7A	; 進度#8
			move.l	(ram_0019).l,-(sp)	; 任務計時器
			jsr		$100E62
			addq.l	#4,sp
			tst.l	d0
			bne.w	$1AFD8C
			jsr		($11C82C).l		; 清除地面不可攜物品
			jsr		($12482A).l		; 清除地面可攜帶物品
			addq.b	#1,($81B108).l	; 下一進度
			bra.w	$1AFD8C


	* 0601火焰洞[地火]

		ORG $2A15AC	; 0601火焰洞[地火]機關最高頻率
			dc.l	$F0010000	; 刪除[$F0022600,$40000000]

		ORG $1B117A	; 0606火焰洞密室牛頭雕像[智取寶盒]任務
			jsr		sub_1B117A
		ORG $1B11A0	; 寶盒內朱雀神器
			move.w	#$34,$DE(a2)
		ORG $1B11DA	; 0606火焰洞密室落石擊毀寶盒的倒計時
			move.l	#90,($81B14E).l

	* 0603南郡道[男弓蠻兵陣]

		ORG $1AC8D4	; 0603南郡道開啟[男弓蠻兵陣]機關
			jsr		sub_1AC8D4
			NOP

		ORG $1ACB04	; 關閉三男弓蠻兵陣|下一進度#9
			clr.w	($81B0C2).l
			bra.s	$1ACB7E

		ORG $1AC96C	; [男弓蠻兵陣]機關3秒/次
			move.b	#$B4,($81B0C1).l
		ORG $1AD120	; 四個一組
			moveq	#4,d0

	* 0704南郡城後方[山賊兵投彈]>>0700南郡城門

		ORG $1EAD9A	; 第七章初始化
			dc.l	(sub_1B182C).l

		ORG $1B6BEA	; 0704南郡城後方[山賊兵投彈]機關
			jsr		sub_1B6C2C	; 中後段保留機關
			bra.s	$1B6BFE
		ORG $1B6C60	; 0704南郡城後方[山賊兵投彈]機關橫坐標[全屏]
			pea		($6F).w	; 橫坐標隨機加值
		* ORG $1B6C76	; 0704南郡城後方[山賊兵投彈]機關縱坐標[全屏]
		* 	pea		($A).w	; 縱坐標隨機加值

		ORG $1B68C8	; 0704南郡城後方取消老鷹機關[1]
			jsr		nullsub
		ORG $1B6904	; 0704南郡城後方取消老鷹機關[2]
			jsr		nullsub
		ORG $1B6950	; 0704南郡城後方取消老鷹機關[3]
			jsr		nullsub
		ORG $1B69BE	; 0704南郡城後方取消老鷹機關[4]
			jsr		nullsub
		ORG $1B69F8	; 0704南郡城後方取消老鷹機關[5]
			jsr		nullsub
		ORG $1B6A66	; 0704南郡城後方取消老鷹機關[6]
			jsr		nullsub
		ORG $1B6AA0	; 0704南郡城後方取消[老鷹|山賊兵投彈]機關[7]
			jsr		$1B6C34	; 後段關閉[山賊兵投彈]機關

		ORG $1B6AEE	; 城後方傳送門指示標朝下偏右
			jsr		sub_1B6AEE
		ORG $1B68C2	; 延遲關閉指示標
			dc.w	$1B6B1C-$1B68AE	; 玩家通過傳送門
			dc.w	$1B6B06-$1B68AE	; 關閉路線指示標
		ORG $1B669E	; 背身向上走進傳送門
			pea		($D).w
		ORG $1B6B82	; 0704南郡城後方>0700南郡城門
			pea		(0).w

		ORG $1B1E3A	; 取消對話框|正面攻城0
			jsr		nullsub
			moveq	#0,d2

		ORG $1B2314	; 0700南郡城門第三段[火甲車]機關
			jsr		sub_1B2E50
		ORG $1B305C	; 0700南郡城門第三段[菜刀車]機關
			jsr		sub_1B305C
			beq.w	$1B3104

		ORG $1B34C2	; 0700南郡城門四五段[拋石機|排三箭|城頂投炸彈]機關
			jsr		sub_1B34C2

		ORG $1B37F2	; 0700南郡城門[力取南郡]任務|取消城門前的傳送
			tst.b	($81C6F8).l	; 任務衝車是否出現
			beq.s	$1B3838
			move.w	#1,($818386).l	; 第七章節第一任務[力取南郡]
			bra.s	$1B3838

		ORG $1B219A
			jsr		($1B37D2).l	; 城門是否攻破[取消斷橋]
			tst.l	d0
			beq.w	$1B22F0		; 城門未攻破則跳出循環
			clr.b	($817DFC).l	; 敵兵表重複次數清零
			pea		(1).w
			jsr		($10f602).l	; 退兵
			addq.l	#4,sp
			; $1B21B8|等待退兵完成
			pea		($13A646).l
			pea		(60).w		; 1秒主循環
			jsr		($100EA4).l
			addq.l  #8,sp
			cmpi.b	#7-3,($817DF9).l	; 三兵容錯
			bhi.s	$1B21B8
			jsr		($12E9D8).l	; 原代碼
			bra.s	$1B21F4		; 下一進度[#17]

	* 0705下水道[水雷]

		ORG $1B7674	; 0705下水道[水雷]機關擴大縱範圍
			pea		($29).w			; 縱坐標隨機加值
			jsr		$1024B0
			addq.l	#4,sp
			addi.l	#$BB,d0
			move.l	d0,-(sp)		; Y
			move.w	($D0A000).l,d0
			ext.l	d0
			add.l	#$300,d0		; 橫坐標到屏幕右側外
		ORG $1B7A3E	; 0705下水道前中段[水雷]機關
			jsr		sub_1B7A3E

		ORG $1B73BA	; 默認開啟下水道密室
			bra.s	$1B73C6
		ORG $1B972C	; 0707下水道密室[小寶箱内隨機物品]
			jsr		sub_1B972C		
			bra.s	$1B9762
		ORG $1B9A16	; 0707下水道密室[青龍寶藏]任務
			clr.l	-(sp)
			pea		($32).w			; 青龍神器
			clr.l	-(sp)
			pea		($C8).w
			pea		($FF).w
			jsr		($123B96).l
			lea		$18(sp),sp		; 1+5
			move.w	#1,($81838A).l	; 第七章節第三任務[青龍寶藏]
			move.w	#1,($81B23E).l	; 原代碼
			bra.s	$1B9A9A

	* 0701前庭>>0706長廊

		ORG $1B43C6	; 0701前庭白兔出現
			bsr.w	$1B4146
			clr.w	($81B192).l
			bra.w	$1B45A6

		ORG $1B4282	; 0701前庭階梯垂直距離範圍
			addi.w  #$140,d0
		ORG $1B4806	; 0701前庭階梯燃燒彈機關頻率
			jsr		sub_1B4806

		ORG $1B481E	; 0701前庭階梯[炸彈兵]機關
			jsr		sub_1B481E

		ORG $1B403A	; 0701前庭[保護白兔]
			jsr		sub_1B403A
			Nop
		ORG $1B45DC	; 0701前庭白兔是否變玄武神器
			jsr		sub_1B45DC
			bra.s	$1B460C
		ORG $124872	; 0702長廊密道白兔食用薤葉芸香
			cmpi.w	#$3E,$DE(a0)
		ORG $1B4914	; 0702長廊密道>>0706長廊
			pea		(6).w

		ORG $1BA576	; 0708白兔密室進場動作設定
			pea     (5).w
			pea     (2).w 		; 向前走[動作0205]
			clr.l   -(sp)		; 朝右
			clr.l	-(sp)		; 竪坐標
			move.w	d2,d0
			move.w	d0,d1
			lsl.w	#2,d0
			add.w	d1,d0
			addi.w	#$C0,d0		; 縱坐標
			move.l	d0,-(sp)
			move.w	d2,d0
			move.w	d0,d1
			lsl.w	#2,d0
			add.w	d1,d0
			move.w	#$28,d1		; 橫坐標
			sub.w	d0,d1
			move.l	d1,-(sp)
			bra.s	$1BA5B2
		ORG $1BA48E	; 0708[白兔密室]停止進場動作|任務|毒蝎敵兵表
			jsr		sub_1BA48E
		ORG $1BAB96	; 0708[白兔密室]取消掉落補給
			bra.w	$1BAC28
		ORG $1BA842	; 0708[白兔密室]任務|毒蝎敵兵表
			jsr		sub_1BA842
			bra.w	$1BA8DE
		ORG $1BA86E	; 白兔密室下蹲時間縮短10秒
			pea     (5).w
		ORG $2AB47E	; 白兔密室各角色掉落道具
			dc.b	$18, $18, $18, $20, $23, $26, $29, 0, $2C, $33	; 馬超青釭劍$23|孫權白虎神器$33

		ORG $1BA8B6	; 0708白兔密室>>0706長廊
			pea		(6).w
		ORG $2A4786	; 0706長廊兩進場動作設定
			dc.l	sub_1B4C8C
		ORG $1B88A8	; 0706長廊二進場調整屏幕視野
			jsr		sub_1B88A8
		ORG $1B88F8	; 0706長廊二進場進度設定
			jsr		sub_1B88F8

		ORG $1B893A	; 0706長廊[火羅電網]機關
			jsr		sub_1B893A
		ORG $1B8C84
			bsr.w	($1B8992).l			; 佈置機關
			jsr		($12EF80).l			; 敵方出兵
			tst.l	d0
			beq.w	$1B8D9A
			move.w	#$1A, (ram_0013).l	; 長廊序號#$1A
			addq.b	#1,($81B202).l		; 下一進度
			bra.w	$1B8D9A

	* 0703大廳[暗箭]

		ORG $2A4722	; 0703大廳前中段[暗箭]機關
			dc.l	sub_1B52DE
		ORG $1B527C	; 0703大廳開場暗箭
			move.w	#$B4,($81B1AE).l

		ORG $1B5452	; 取消寶座孫權與豹雕
			jsr		nullsub

		ORG $2A8476	; 刪除機關中的孫權笑聲
			dc.l	$002A83A6

	* 場景切換判斷玩家數量|始終打開屏幕縱視野

		ORG $15B824	; 始終打開屏幕縱視野
			bge.s	$15B886	; $15771A

		ORG $14623C	; 死命後倒計時
			jsr		sub_15E72C.l

		ORG $175B94
			jsr		sub_15E72C.l

		ORG $1786AC
			jsr		sub_15E72C.l

		ORG $179780
			jsr		sub_15E72C.l

		ORG $17B23E
			jsr		sub_15E72C.l

		ORG $17B2C6
			jsr		sub_15E72C.l

		ORG $17B350
			jsr		sub_15E72C.l

		ORG $17D8C2
			jsr		sub_15E72C.l

		ORG $17E786
			jsr		sub_15E72C.l

		ORG $17E810
			jsr		sub_15E72C.l

		ORG $17FA90
			jsr		sub_15E72C.l

		ORG $180758
			jsr		sub_15E72C.l

		ORG $181180
			jsr		sub_15E72C.l

		ORG $182DE6
			jsr		sub_15E72C.l

		ORG $184BB8
			jsr		sub_15E72C.l

		ORG $1876BE
			jsr		sub_15E72C.l

		ORG $1876F4
			jsr		sub_15E72C.l

		ORG $1899B6
			jsr		sub_15E72C.l

		ORG $18A582
			jsr		sub_15E72C.l

		ORG $18AC12
			jsr		sub_15E72C.l

		ORG $18ACB0
			jsr		sub_15E72C.l

		ORG $18B4A4
			jsr		sub_15E72C.l

		ORG $18B542
			jsr		sub_15E72C.l

		ORG $18C9E2
			jsr		sub_15E72C.l

		ORG $18CA6E
			jsr		sub_15E72C.l

		ORG $18D708
			jsr		sub_15E72C.l

		ORG $18DE0C
			jsr		sub_15E72C.l

		ORG $18E638
			jsr		sub_15E72C.l

		ORG $18E6E4
			jsr		sub_15E72C.l

		ORG $1917EA
			jsr		sub_15E72C.l

		ORG $191888
			jsr		sub_15E72C.l

		ORG $1923FC
			jsr		sub_15E72C.l

		ORG $192C1A
			jsr		sub_15E72C.l

		ORG $192CA6
			jsr		sub_15E72C.l

		ORG $193C66
			jsr		sub_15E72C.l

		ORG $19582C
			jsr		sub_15E72C.l

		ORG $196640
			jsr		sub_15E72C.l

		ORG $196B0C
			jsr		sub_15E72C.l

		ORG $199856
			jsr		sub_15E72C.l

		ORG $19ABEC
			jsr		sub_15E72C.l

		ORG $19B20C
			jsr		sub_15E72C.l

		ORG $19B424
			jsr		sub_15E72C.l

		ORG $19C5D0
			jsr		sub_15E72C.l

		ORG $1A035C
			jsr		sub_15E72C.l

		ORG $1A0766
			jsr		sub_15E72C.l

		ORG $1A0AF6
			jsr		sub_15E72C.l

		ORG $1A2A26
			jsr		sub_15E72C.l

		ORG $1A2BC8
			jsr		sub_15E72C.l

		ORG $1A2C14
			jsr		sub_15E72C.l

		ORG $1A2D3A
			jsr		sub_15E72C.l

		ORG $1A4A10
			jsr		sub_15E72C.l

		ORG $1A4BF0
			jsr		sub_15E72C.l

		ORG $1A4C90
			jsr		sub_15E72C.l

		ORG $1A4DC2
			jsr		sub_15E72C.l

		ORG $1A4F0E
			jsr		sub_15E72C.l

		ORG $1A4FAE
			jsr		sub_15E72C.l

		ORG $1A50CC
			jsr		sub_15E72C.l

		ORG $1A6530
			jsr		sub_15E72C.l

		ORG $1A83AA
			jsr		sub_15E72C.l

		ORG $1A997E
			jsr		sub_15E72C.l

		ORG $1A9C22
			jsr		sub_15E72C.l

		ORG $1AB178
			jsr		sub_15E72C.l

		ORG $1ADEF2
			jsr		sub_15E72C.l

		ORG $1AF806
			jsr		sub_15E72C.l

		ORG $1AF9FE
			jsr		sub_15E72C.l

		ORG $1AFD1E
			jsr		sub_15E72C.l

		ORG $1B1598
			jsr		sub_15E72C.l

		ORG $1B3970	; 0700南郡城城門擊打次數
			jsr		sub_15E72C.l

		ORG $1B454E	; 0701前庭至長廊入口
			jsr		sub_15E72C.l

		ORG $1B4F16
			jsr		sub_15E72C.l

		ORG $1B6B2E
			jsr		sub_15E72C.l

		ORG $1B8054
			jsr		sub_15E72C.l

		ORG $1B8D2A
			jsr		sub_15E72C.l

		ORG $1B9ADE
			jsr		sub_15E72C.l

		ORG $1BA7FC	; 0708白兔密室出口
			jsr		sub_15E72C.l

		ORG $17C0C4	; 0200新野城左火箭陣起(手人數)	
			jsr		sub_15E72C.l

		ORG $17C0F0	; 0200新野城左火箭陣中(火箭數)
			jsr		sub_15E72C.l

		ORG $17C12C	; 0200新野城左火箭陣收(手人數)
			jsr		sub_15E72C.l

		* ORG $1B29F0	; 0700南郡城門前衝車
		* 	jsr		sub_15E72C.l

; =============== 劇情調整 ==================================================

	* 序章大綱

		ORG $1EAA18	; 序章大綱
			dc.w	$100
			dc.l	sub_1742EA		; 序章初始化
			dc.l	sub_1742EC		; 序章地圖設定
			dc.l	sub_17430C		; 序章卷軸進度
			dc.l	sub_17432C		; 序章切換場景
			dc.l	sub_17434C		; 序章敵兵死亡
			dc.l	sub_174370		; 序章敵將死亡
			dc.l	sub_174394		; 序章進場動作
			dc.l	1
			dc.l	sub_1743B8		; 序章基礎時間
			dc.l	sub_1743D6		; 序章
			dcb.w	$2B,0

	
	* 序章劇情[0003]|樊城奪糧左慈尋徒

		ORG $175412	; 跑馬序言>序章劇情
			pea		(3).w	; 下一場景

		ORG $14D322	; 序章[0003]取消打印角色信息貼圖
			jsr		sub_145F3A
		ORG $14D410	; 序章[0003]取消打印角色生命數顯
			jsr		sub_145F3A
		* sub_145574	; 序章[0003]取消打印遊戲時間
		* sub_1573CE	; 序章[0003]取消打印遊戲名稱
		* sub_1461FA	; 序章[0003]取消打印難度信息


	* 終章劇情[0004]|青龍密室戰真呂布
	* 左慈攜人遁入青室|sub_1CB978

	* 終章魔王真呂布|NewChief

		ORG $1BFF74	; 真呂布[0A]必殺攻擊力表|03類動作
			dc.b	$0E,$10,$1A,$1E,$18,$14,$20,$18,$12,  0,  0,  0,$38,$28,$0C,  0,$10,  0,  0,  0
				* 03-00| 01| 02| 03| 04| 05| 06| 07| 08| 09| 0A| 0B| 0C| 0D| 0E| 0F| 10| 11| 12

		ORG $1C046A	; 真呂布[0A]必殺攻擊力表|06類動作
			dc.b	$28,$28,$1C,$1C,  0,  0,  0,  0,  0,  0,  0,  0,  0

		ORG $1E2FCE	; 真呂布[0A]敵對我之傷害加成表
			dc.b 	$40,$40,$40,$40,$40,$40,$40,  0,$40,$40	; 0-9

		ORG $1E622A	; 真呂布[0A]各屬性攻擊對其加成
			dc.b	$20,$20,$20,$20,$20,$20

		ORG $1CCFA4	; 毒屬性色盤
			dc.l	word_388A6C
		ORG $1CD0B0	; 冰電屬性色盤
			dc.l	$00311534
		ORG $1CD1BC	; 火屬性色盤
			dc.l	$00311574


	* 詞句表擴充搬運

		ORG $134048
			movea.l	#off_2B09A2,a0
		ORG $13427A
			movea.l	#off_2B09A2,a0
		ORG $1346C0
			movea.l	#off_2B09A2,a0
		ORG $134710
			movea.l	#off_2B09A2,a0
		ORG $134DFE
			movea.l	#off_2B09A2,a0
		ORG $134E4E
			movea.l	#off_2B09A2,a0

	* 對話字庫調整

		ORG $1343F4	; 對話數提高上限
			cmpi.l	#$139,d5

		ORG $134688	; [2*2]繁體字庫金字色盤
			pea		(3).w

		ORG $32180A	; [2*2]繁體字庫青言色盤
			dc.w	$8BF4,$8BF4,$8BF4,$8BF4,$8BF4,$8BF4,$8BF4,$8BF4
			dc.w	$8BF4,$8BF4,$8BF4,$8BF4,$8BF4,$8026,$8BF4,$0000

		ORG $32182A	; 對話字體|繁體字庫
			dc.w	$E80,1	; 貼圖容量
			dc.l	word_31D4C2	; [2*2]繁字貼圖組合表

	* 敵將出場退場對話|sub_1343D6

		ORG $31D47E	; 真呂布對話框頭像圖片|原小童
			dc.l	$0000300B,$0A400000
		ORG $1CF4E4	; 真呂布對話框頭像色盤
			dc.l	$0031D22E
		ORG $2B0C2E	; 真呂布對話框姓名|off_2B09A2
			dc.l	word_2B03A8

		ORG $10FB7C	; 敵將雙殺保護|生命值強制不清零
			jsr		sub_10FB7C

		ORG $209D94	; 曹仁起身/死亡對話|向後動作
			dc.w	$0805
			dc.l	dword_209B76,$01003800,0,0
		ORG $209E48	; 曹仁起身/死亡對話|向前動作
			dc.w	$080F
			dc.l	dword_209B76,$01003800,0,0

		ORG $22497C	; 張遼起身/死亡對話|向後動作
			dc.w	$0805
			dc.l	dword_22477E,$01003800,0,0
		ORG $224A30	; 張遼起身/死亡對話|向前動作
			dc.w	$080F
			dc.l	dword_22477E,$01003800,0,0

		ORG $2345BA	; 呂蒙起身/死亡對話|向後動作
			dc.w	$0805
			dc.l	dword_2343AC,$01003800,0,0
		ORG $23466E	; 呂蒙起身/死亡對話|向前動作
			dc.w	$080F
			dc.l	dword_2343AC,$01003800,0,0

		ORG $231444	; 黃蓋起身/死亡對話|向後動作
			dc.w	$0805
			dc.l	dword_231046,$01003800,0,0
		ORG $2314F8	; 黃蓋起身/死亡對話|向前動作
			dc.w	$080F
			dc.l	dword_231046,$01003800,0,0

		ORG $24E5EE	; 孫權起身/死亡對話|向後動作
			dc.w	$0805
			dc.l	dword_24E3A8,$01003800,0,0
		ORG $24E6A2	; 孫權起身/死亡對話|向前動作
			dc.w	$080F
			dc.l	dword_24E40C,$01003800,0,0
		ORG $31D476	; 敵孫權對話框頭像圖片|原水鏡先生
			dc.l	$000012EF,$0A400000
		ORG $1CF4E0	; 敵孫權對話框頭像色盤
			dc.l	word_31CC6E
		* ORG $2B0C2A	; 敵孫權對話框姓名
		* 	dc.l	word_2B039E

		ORG $240104	; 孟獲起身/死亡對話|向後動作
			dc.w	$0805
			dc.l	dword_23FEE6,$01003800,0,0
		ORG $2401B8	; 孟獲起身/死亡對話|向前動作
			dc.w	$080F
			dc.l	dword_23FEE6,$01003800,0,0
		* ORG $2B0BE2	; 孟獲、孟優對話框姓名
		* 	dc.l	word_2B0322
		ORG $2453C4	; 孟優起身/死亡對話|向後動作
			dc.w	$0805
			dc.l	dword_24523E,$01003800,0,0
		ORG $245478	; 孟優起身/死亡對話|向前動作
			dc.w	$080F
			dc.l	dword_24523E,$01003800,0,0

		ORG $1FE6C0	; 曹操起身/死亡對話|向後動作
			dc.w	$0804
			dc.l	dword_36F6CC,$02000001,0,0
		ORG $1FE774	; 曹操起身/死亡對話|向前動作
			dc.w	$080E
			dc.l	dword_36FC2C,$02000001,0,0


; =============== 敵將調整 ==================================================

	* 系統調整

		ORG $111330	; 優先攻擊對象[1]
			jsr		sub_111330
		ORG $111434	; 優先攻擊對象[2]
			jsr		sub_111330
		ORG $1112B0	; 優先攻擊對象[3]
			jsr		sub_111330

		ORG $12B652	; 敵方[火屬性]浮空時不無敵
			move.w  #0,$174(a2)
		ORG $12B6C4	; 敵方[爆屬性]浮空時不無敵
			move.w  #0,$174(a2)
		ORG $12B7B0	; 敵方[電屬性]浮空時不無敵
			move.w  #0,$174(a2)

		ORG $110556	; 敵將停定
			jsr		sub_110556

	* 敵將起身

		ORG $173F1A	; 孫權0109起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$173FD6		; 無動作
			beq.s	$173F1A+$14

		ORG $167236	; 曹操010B起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$1672F8		; 無動作
			beq.s	$167236+$14

		ORG $167712	; 司馬懿010C起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$1677E4		; 無動作
			beq.s	$167712+$14

		ORG $168108	; 程昱010D起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$1681BC		; 無動作
			beq.s	$168108+$14

		ORG $168C54	; 曹仁010F起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$168D3E		; 無動作
			beq.s	$168C54+$14

		ORG $16909C	; 夏侯淵0111起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16919E		; 無動作
			beq.s	$16909C+$14

		ORG $169390	; 夏侯惇0112起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16944C		; 無動作
			beq.s	$169390+$14

		ORG $169A18	; 牛金0113起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$169AD4		; 無動作
			beq.s	$169A18+$14

		ORG $169DF4	; 許褚0114起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$169EB0		; 無動作
			beq.s	$169DF4+$14

		ORG $16A316	; 張郃0115起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16A3D2		; 無動作
			beq.s	$16A316+$14

		ORG $16A82C	; 張遼0116起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16A8E0		; 無動作
			beq.s	$16A82C+$14

		ORG $16ABE4	; 甘寧0118起身後動作
			bclr	#7,$244(a2)	; 免疫暈屬性
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16ACA0		; 無動作
			NOP

		ORG $16BA30	; 周泰0119起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16BADE		; 無動作
			beq.s	$16BA30+$14

		ORG $16BD0C	; 黃蓋011A起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16BDBE		; 無動作
			beq.s	$16BD0C+$14

		ORG $16C070	; 呂蒙011B起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16C12C		; 無動作
			beq.s	$16C070+$14

		ORG $16C428	; 徐晃011C起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16C4E4		; 無動作
			beq.s	$16C428+$14

		ORG $16C9E0	; 呂布011D起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16CA9C		; 無動作
			beq.s	$16C9E0+$14

		ORG $16D074	; 孟獲011E起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16D146		; 無動作
			beq.s	$16D074+$14

		ORG $16DBEE	; 沙摩柯0120起身後動作
			jsr		sub_167236	; 是否屬性起身
			tst.l	d0
			bne.w	$16DCC0		; 無動作
			beq.s	$16DBEE+$14

	* 敵將出場
		ORG $10A476	; 敵將出場時記錄初始高度
			jsr		sub_10A476

		ORG $24D76E	; 孫權出場動作
			dc.l	off_24D3E8,$02005800

		ORG $3411BC	; 敵孫權長槊新色盤
			dc.w	$0020,$7FFF,$2820,$3CA3,$5967,$726D,$7F52,$0045
			dc.w	$10A8,$210C,$396F,$0444,$214B,$4253,$571B,$5123
			dc.w	$7622,$7F83,$0022,$0442,$1084,$1CC6,$2D49,$41EE
			dc.w	$3800,$5800,$762E,$7F36,$1824,$2846,$03E0,$0000
		ORG $3411FC	; 敵孫權盤龍三節棍新色盤
			dc.w	$0020,$7FFF,$2820,$3CA3,$5967,$726D,$7F52,$0045
			dc.w	$10A8,$210C,$396F,$0444,$214B,$4253,$571B,$5123
			dc.w	$7622,$7F83,$0022,$0442,$1084,$1CC6,$2D49,$41EE
			dc.w	$3572,$45F8,$66BF,$7F5F,$1824,$2846,$03E0,$0000

		ORG $1FDEDE	; 曹操出場動作
			dc.l	off_1FD6F8,$01000800
		ORG $1FE380	; 曹操跑步動作
			dc.w	$020D
			dc.l	dword_1FE0B6,$01000000,0,0

		ORG $2036D0	; 司馬懿跑步動作
			dc.w	$020D
			dc.l	dword_203426,$01000000,0,0

		ORG $20593C	; 程昱出場隨機坐標
			dc.l	$F0070000,sub_1681E2

		ORG $209A7A	; 曹仁跑步動作
			dc.w	$020D
			dc.l	dword_209728,$01000000,0,0

		ORG $21212E	; 夏侯惇出場調整
			dc.l	$F0070000,sub_1696F6

		ORG $20C0E2	; 夏侯淵
			dc.l	off_20BDD6,$01000800

		ORG $2169B8	; 牛金
			dc.l	off_2166A4,$01000800

		ORG $223046	; 張遼出場坐標后移
			dc.l	off_222CF2,$01000800

		ORG $21ABE0	; 許褚
			dc.l	off_21A6F0,$02000800

		ORG $22C960	; 周泰
			dc.l	off_22C720,$02001800

		ORG $22F280	; 黃蓋出場動作[0104]跑步踢出炸彈並釋放火團
			dc.l	off_23163C,$01000840

		ORG $23480E	; 呂蒙[出場水花下移]
			dc.l	$00250000,$00250000,$00250000,$00250000

		ORG $23BC7C	; 呂布跑步動作
			dc.w	$020D
			dc.l	dword_23B906,$01000000,0,0

		ORG $23696E	; 徐晃優化出場坐標
			dc.l	off_23678C,$02000800

		ORG $23F4E2	; 孟獲大象增加路程|同步雙方坐標
			dc.l	off_23F2A6,$01000800

		ORG $243EB6	; 孟優出場動作記錄南蠻（孟獲、孟優）出現次數
			dc.w	$0103
			dc.l	dword_243D34,$01000800,0,0

		ORG $2464DC	; 沙漠柯出場動作
			dc.w	$0101
			dc.l	lword_24626E,$01002800,0,0
		ORG $24698A	; 沙漠柯跑步動作
			dc.w	$020D
			dc.l	dword_246638,$01000000,0,0

		ORG $24D11C	; 左慈
			dc.l	off_24CBBC,$02000800
	
	* 敵將攻擊

		* 甘寧
			ORG $226634	; 甘寧上天下地(硬漢)
				dc.l	off_2287B6

		* 牛金
			ORG $215900	; 牛金怒濤洶湧(硬漢)
				dc.l	off_215618

		* 司馬懿
			ORG $201C1A	; 司馬懿AI|原觸發動作0300
				dc.l	$00000309	; 地板電波
			ORG $201DBA	; 司馬懿AI|原觸發動作0300
				dc.l	$00000300	; 召喚分身
			ORG $201D04	; 司馬懿AI|原觸發動作0300
				dc.l	$00000309	; 地板電波
			ORG $201B64	; 司馬懿AI|原觸發動作0300
				dc.l	$00000300	; 召喚分身

			ORG $2030D4	; 取消司馬懿出場四長兵
				dc.l	nullsub

			ORG $202522	; 司馬懿召喚分身
				dc.w	$0300
				dc.l	off_2020CE,$01002000,0,0

			ORG $2025C4	; 司馬懿地板電波|攻擊力$1C
				dc.w	$0309
				dc.l	off_23BF48,$01002000,0,0

			ORG $1BFF9C	; 司馬懿03類動作攻擊力表
				dc.b	0, 8, $10, 8, $C, $24, $24, 0, 0, $1C, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

		* 張遼
			ORG $11D4DC	; 0701前庭張遼衝兵陣調整縱坐標
				jsr		sub_11D4DC
				move.l	d0,-(sp)
				bra.s	$11D4EE

		* 程昱
			ORG $2072A4	; 程昱是否召喚木人
				dc.l	$F0070000,sub_1684CA
			ORG $1684F8	; 尚可召換的木人數目
				jsr		sub_1684F8
				move.l	d0,d3
				bra.s	$16850C

			ORG $207A7A ; 程昱紙人舞
				dc.w	$0309
				dc.l	off_23EF8E,$01003040,0,0

			ORG $1BFFB0	; 程昱03類動作攻擊力表
				dc.b	$C, $A, $10, 8, 0, $10, 0, 0, 0, $A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

			ORG $204FB8	; 敵將AI|動作0309|1
				dc.w	0, $0309, $32, $C8, 0, 8, 0, 0, 0, 0, 0, 0, 0
			ORG $2050A2	; 敵將AI|動作0309|2
				dc.w	0, $0309, $19, $87, 0, 6, 0, 0, 0, 0, 0, 0, 0
			ORG $2050F0	; 敵將AI|動作0309|3
				dc.w	0, $0309, $32, $C8, 0, 8, 0, 0, 0, 0, 0, 0, 0
			ORG $2051DA	; 敵將AI|動作0309|4
				dc.w	0, $0309, $50, $10E,0, 6, 0, 0, 0, 0, 0, 0, 0

			ORG $1CCFB0	; 敵將程昱毒屬性色盤
				dc.l	$00310BF4

		* 曹操
			ORG $1FFD80	; 曹操天斷劍[硬漢]
				dc.w	$F05E,$0100
			ORG $1FFB4C	; 曹操人如劍[硬漢]
				dc.w	$F05E,$0100

			ORG $1FF4CE	; 敵將曹操一指劍[雷電擊飛]劍光編號030D|值$22
				dc.w	$030D

			ORG $1BFF88	; 曹操03類動作攻擊力表
				dc.b	$12, $12, 0, $1E, $16, $C, $10, $14, $14, $10, $10, 0, $1E, $22, 0, 0, 0, 0, 0, 0

		* 孟獲孟優
			ORG $1E62A8	; 烟霧彈對南郡道孟優的無傷害加成
				dc.b	$40,$20

		* 黃蓋
			ORG $1C00B4	; 03類動作攻擊力表
				dc.b	$18,$12,$18,$14,$18,$24,$18,$24,$26,$18,$18,$18,$18,$00	; 原值
				*		$12,$0E,$12,$10,$12,$1A,$12,$1A,$16,$12,$12,$12,$10,$10	; 群雄$1DFE4C

			ORG $230E06	; 長無敵普攻[原0300]
				dc.w	$0300
				dc.l	$0023027A,$01001050,0,0
			ORG $230E2A	; 分身體轉
				dc.w	$0302
				dc.l	off_26BDB0,$01002050,0,0

			ORG $230E60	; 全程無敵原地爆炸[原0307]
				dc.w	$0305
				dc.l	$0023093A,$01002050,0,0
			ORG $230E84	; 分身體轉原地爆炸
				dc.w	$0307
				dc.l	off_26BF24,$01002050,0,0

			ORG $230ECC	; 黃蓋單體轉並暈
				dc.w	$030B
				dc.l	off_26B050,$01002050,0,0

			ORG $22E9BC	; 敵將AI|動作0302|1
				dc.w	$0000,$0302,$00C8,$0154,$0000,$0008,$0001,$0022,$E906,$0000,$0000,$0000,$0000
			ORG $22EB28	; 敵將AI|動作0302|1
				dc.w	$0000,$0302,$0000,$00AA,$0000,$0008,$0000,$0000,$0000,$0000,$0000,$0000,$0000

			ORG $22E954	; 敵將AI|動作0307|1
				dc.w	$0000,$0307,$0000,$00AA,$0000,$0008,$0000,$0000,$0000,$0000,$0000,$0000,$0000
			ORG $22EA8C	; 敵將AI|動作0307|2
				dc.w	$0000,$0307,$0000,$00AA,$0000,$0008,$0000,$0000,$0000,$0000,$0000,$0000,$0000
			ORG $22EB90	; 敵將AI|動作0307|3
				dc.w	$0000,$0307,$00C8,$0154,$0000,$0008,$0001,$0022,$E906,$0000,$0000,$0000,$0000
			ORG $22EC7A	; 敵將AI|動作0307|4
				dc.w	$0000,$0307,$00C8,$0154,$0000,$0008,$0001,$0022,$E93A,$0000,$0000,$0000,$0000

			ORG $22EB42	; 敵將AI|動作030B|1
				dc.w	$0000,$030B,$00C8,$0154,$0000,$0008,$0001,$0022,$E906,$0000,$0000,$0000,$0000
			ORG $22EC60	; 敵將AI|動作030B|2
				dc.w	$0000,$030B,$0000,$00AA,$0000,$0008,$0000,$0000,$0000,$0000,$0000,$0000,$0000

			ORG $22E706	; 群雄黃蓋色盤
				dc.l	off_38B96C	; (敵方指針+$32).l

		* 呂布
			ORG $23B7A2	; 召喚白虎或者原地踢腿
				dc.w	$0103	; 召喚白虎
				dc.l	dword_23B6B0,$01000800,0,0

			ORG $23AF44	; 敵將AI|動作0103|1
				dc.w	0, $0103, $0000,$0096, $0008,$0064, 1
				dc.l	$0023AF10,0,0
			ORG $23B014	; 敵將AI|動作0103|2
				dc.w	0, $0103, $000A,$00B4, $0000,$0007, 1
				dc.l	$0023AEC2,0,0
			ORG $23B0B0	; 敵將AI|動作0103|1
				dc.w	0, $0103, $0000,$0096, $0000,$0006, 0
				dc.l	0,0,0
			ORG $23B0CA	; 敵將AI|動作0103|2
				dc.w	0, $0103, $0000,$0096, $0008,$0064, 1
				dc.l	$0023AF10,0,0
			ORG $23B236	; 敵將AI|動作0103|2
				dc.w	0, $0103, $000A,$0096, $0000,$0006, 0
				dc.l	0,0,0

		* 左慈
			ORG $10AED4	; 107版本設定|左慈強制高度
				jsr		sub_110A08
				bra.s	$10AEEE

			ORG $24B362	; 左慈召喚通怪|正常高度範圍內|030C|升空判斷
				dc.l	$F0070001,sub_16E7CC
			ORG $24B3F6	; 左慈召喚通怪|正常高度範圍內|030D|降低判斷
				dc.l	$F0070000,sub_16E7CC

			ORG $247C40	; 敵將AI|動作030C|1
				dc.w	0, $030C, $003C, $00F5, 0, 8, 0, 0, 0, 0, 0, 0, 0	; $F7
			ORG $247C5A	; 敵將AI|動作030C|2
				dc.w	0, $030C, $0096, $019F, 0, 8, 0, 0, 0, 0, 0, 0, 0	; $104
			ORG $247D44	; 敵將AI|動作030C|3
				dc.w	0, $030C, $0050, $012C, 0, $A, 0, 0, 0, 0, 0, 0, 0	; $179

			ORG $247D78	; 敵將AI|動作030C|2
				dc.w	0, $030D, $003C, $00E6, 0, $A, 0, 0, 0, 0, 0, 0, 0	; $193

; =============== 敵兵調整 ==================================================

	* 隨機敵兵

		ORG $12F0CC	; 寫入敵兵數據[FF05]
			jsr		sub_109CC2		; 敵人數目是否達到上限
			tst.l	d0
			beq.w	$12F612			; 回到上一敵兵索引[INDEX][偏移四字節]
			clr.w	-$20(a6)		; 默認00號色盤
			jsr		sub_12F0CC		; 寫入敵兵數據[指定|隨機]
			bra.s	$12F106

		ORG $12F336	; 寫入敵兵數據[FF06]
			jsr		sub_109CC2		; 敵人數目是否達到上限
			tst.l	d0
			beq.w	$12F612			; 回到上一敵兵索引[INDEX][偏移四字節]
			move.w	#3,-$20(a6)		; 隊長03號色盤
			jsr		sub_12F0CC		; 寫入敵兵隊長數據[指定]
			bra.s	$12F370

		ORG $38BA00	; [0038AE68]短兵[0038B9CA]空降
			dc.w	$0103
			dc.l	off_38B5EE,$02000800,0,0

		ORG $389096	; [003878C8]長兵[00388F88]空降
			dc.w	$010F
			dc.l	off_388858,$02000800,0,0	; 02000[8]00無敵[$10EFFC]

		ORG $38E7F6	; [0038D30E]弓兵[0038E778]空降
			dc.w	$0107
			dc.l	off_38E61C,$02000800,0,0

		ORG $37E29E	; [0037D090]鐵甲步兵[0037E20E]空降
			dc.w	$0108
			dc.l	off_37E002,$02000800,0,0

		ORG $396E6C	; [0039631C]水兵[00396DA6]空降
			dc.w	$010B
			dc.l	off_39666A,$02000800,0,0

		ORG $382182	; [00381B98]馴獸師[0038213A]空降
			dc.w	$0104
			dc.l	off_381E06,$02000800,0,0

		ORG $170642	; 山賊兵[定位吊繩0102]出場高度
			jsr		sub_170642

		ORG $393142	; [00391D48]炸彈兵[0039306A]空降
			dc.w	$010C
			dc.l	off_392926,$01002800,0,0

		ORG $385DBE	; [00385AF0]機械兵[00385D9A]空降
			dc.w	$0102
			dc.l	off_385CFA,$02000800,0,0

		ORG $398FCC	; [00398D3C]木人[00398F96]空降
			dc.w	$0103
			dc.l	off_398F02,$02000800,0,0

		ORG $39B0E8	; [0039AC7C]桶怪[0039B046]空降
			dc.w	$0109
			dc.l	off_39AEE2,$02000800,0,0

		ORG $3776A8	; [00377194]男矛越兵[0037764E]空降
			dc.w	$0105
			dc.l	off_3774DE,$02000800,0,0

		ORG $3738F6	; [003732FA]男叉蠻兵[003738C0]空降
			dc.w	$0103
			dc.l	off_37379C,$02000800,0,0

		ORG $375602	; [00374DC2]女蠻兵[0037553C]空降
			dc.w	$010B
			dc.l	off_375218,$02000AB0,0,0

		ORG $3796AE	; [00378D98]女越兵[00379642]空降
			dc.w	$0106
			dc.l	off_379502,$02000800,0,0

		ORG $3A68C8	; [003A639E]蛇[003A6880]空降
			dc.w	$0104
			dc.l	off_3A6850,$02000800,0,0

		ORG $3A52E2	; [003A4E0E]蠍[003A5288]空降
			dc.w	$0105
			dc.l	off_3A521C,$02000800,0,0

		ORG $3A3944	; [003A36C6]鷹[003A3920]空降
			dc.w	$0102
			dc.l	off_3A3874,$02000800,0,0

		ORG $3A1E78	; [003A17B2]黑豹[003A1E0C]空降
			dc.w	$0106
			dc.l	off_3A1BD0,$02000800,0,0

		ORG $383E62	; [003837DE]工兵[00383DE4]閃電登場
			dc.w	$0107
			dc.l	off_3843D0,$01001800,0,0

		ORG $380136	; [0037FF10]輕騎兵[00380112]閃電登場
			dc.w	$0102
			dc.l	off_380412,$01003800,0,0

		ORG $37B892	; [0037B04C]鐵甲騎兵[0037B826]閃電登場
			dc.w	$0106
			dc.l	off_37BD98,$01002800,0,0

		ORG $371DA0	; [00370D1A]男弓蠻兵[00371CEC]閃電登場
			dc.w	$010A
			dc.l	off_3722EE,$01002800,0,0

		ORG $3A013C	; [0039FB66]虎[003A00F4]閃電登場
			dc.w	$0104
			dc.l	off_3A0716,$01003800,0,0

		ORG $39E6A2	; [0039E19E]熊[0039E648]閃電登場
			dc.w	$0105
			dc.l	off_39EBCA,$01003800,0,0

		ORG $39CCBE	; [0039C686]蠻牛[0039CC64]閃電登場
			dc.w	$0105
			dc.l	off_39D1F2,$01003800,0,0

	* 敵兵調整

		ORG $12F5E4	; [FF0A]敵兵刷新判斷
			jsr		sub_12F5E4
			jmp		(a0)

		ORG $12F648	; [FF0B]刷兵間隔判斷
			jsr		sub_12F648
			bra.w	$12F74E

		ORG $12F654	; [FF0C]敵兵AI設定
			moveq	#$0, D0
			move.b	$81A326.l, D0	; 随難度调整
			divu.w	#$2, D0
			move.b	D0, $817DFF.l	; 五阶1-0/2-1/4-2/6-3/8-4
			bra.w	$12F74E

		ORG $12F526	; [FF06]隊長生命值翻兩倍|107設定原生命值
			jsr		sub_12F526

		ORG $114740	; 不同版本不同關卡小兵的傷害追加[1]
			jsr		sub_146DD2
			jsr		sub_114746
		ORG $11518E	; 不同版本不同關卡小兵的傷害追加[2]
			jsr		sub_146DD2
			jsr		sub_114746

		ORG $38F0E0	; 弓兵0300橫射毒箭[1]
			dc.b	$80,$00	; $62(暈屬性)
		ORG $38E596	; 弓兵0302跳射毒箭[2]
			dc.b	$10,$00	; $62(毒屬性)
		ORG $38F2E0	; 弓兵0304跳射毒箭[3]
			dc.b	$00,$80	; $63(持續毒)

		ORG $38F3F2	; 弓兵0305跳射火箭[1]
			dc.b	$00,$00	; 取消火屬性
		ORG $38F424	; 弓兵0305跳射火箭[2]
			dc.b	$01,$00	; $62(爆屬性)

		ORG $3716CA	; 男弓蠻兵0300|0301直射箭矢
			dc.b	$00,$20	; $63(木化屬性)
		ORG $3713D4	; [三男弓蠻兵陣]發射木化箭矢
			dc.l	$00371668

		ORG $371750	; 男弓蠻兵0304|0305直射雪箭[1]
			dc.b	$00,$00	; 取消火屬性
		ORG $371782	; 男弓蠻兵0304|0305直射雪箭[2]
			dc.b	$20,$00	; $62(冰屬性)
		ORG $343E46	; 男弓蠻兵[00色盤]冰焰箭矢
			dc.w	$A9D4,$CA9D,$DB9E,$E3FF
		ORG $343E86	; 男弓蠻兵[01色盤]冰焰箭矢
			dc.w	$A9D4,$CA9D,$DB9E,$E3FF
		ORG $343EC6	; 男弓蠻兵[02色盤]冰焰箭矢
			dc.w	$A9D4,$CA9D,$DB9E,$E3FF

		ORG $3A5E3E	; 下水道場景毒蛇死亡動作|避免水花過多導致死機
			dc.l	off_3A7094

		ORG $1134AE	; 豹子投技判定完成後避免死亡無敵體
			jsr		sub_1134AE

	* 敵兵色盤

		; (魏軍棕色)0000 (蜀軍橙紅)0001 (吳軍藍色)0002 (金甲步兵)0003

		ORG $3706B4	; 男弓蠻兵$23[$32(指針)]
			dc.l	$00343EA4,$00343E24,$00343E64,$00343E24

		ORG $372CDE	; 男叉蠻兵$24
			dc.l	$00344548,$003444C8,$00344508,$003444C8

		ORG $3747A2	; 女蠻兵$25
			dc.l	$00344BEC,$00344B6C,$00344BAC,$00344B6C

		ORG $376B84	; 男矛越兵$26
			dc.l	$003453A0,$00345320,$00345360,$00345320

		ORG $37873A	; 女越兵$27
			dc.l	$003459D4,$00345A14,$00345994,$00345994

		ORG $37AA02	; 鐵甲騎兵$28
			dc.l	$003460F8,$00346138,$00346178,off_34677C	; 金甲鐵騎[3]

		ORG $37CA1C	; 鐵甲步兵[$29][0-3]
			dc.l	$003466BC,$003466FC,$0034673C,$0034677C		; 金甲步兵[3]

		ORG $37F8E0	; 輕騎兵$2A
			dc.l	$00346EB0,$00346EF0,$00346F30,$00346EF0

		ORG $38152E	; 馴獸師$2B
			dc.l	$003475E4,$00347624,$00347664,$00347624

		ORG $38314C	; 工兵$2C
			dc.l	$00347D88,$00347DC8,$00347E08,off_347E08	; 綠衣弓兵[3]

		ORG $3854E0	; 機械兵$2D
			dc.l	$0034844C,$0034848C,$003484CC,$0034848C

		ORG $38724E	; 長兵$2E
			dc.l	$00348B50,$00348B90,$00348BD0,off_348BD0	; 藍甲長兵[3]

		ORG $38A7FE	; 短兵$2F
			dc.l	$00349404,$00349444,$00349484,off_349484	; 群雄短兵[3]

		ORG $38CCF6	; 弓兵$30
			dc.l	$00349B88,$00349BC8,$00349C08,off_349C08	; 金盔弓兵[3]

		ORG $391738	; 炸彈兵$31
			dc.l	$0034A4BC,$0034A4FC,$0034A53C,$0034A4FC

		ORG $393E54	; 山賊兵$32
			dc.l	$0034ABB0,$0034ABF0,$0034AC30,$0034ABF0

		ORG $395CF4	; 水兵$33
			dc.l	$0034B3F4,$0034B434,$0034B474,off_34B474	; 群雄水兵[3]

		ORG $398720	; 木人$34
			dc.l	$0034BAD8,$0034BB18,$0034BB58,$0034BB18

		ORG $39A648	; 桶怪$35
			dc.l	$0034C0BC,$0034C0FC,$0034C13C,off_34C13C

		ORG $39C05E	; 蠻牛$36
			dc.l	$0034C6B0,$0034C6F0,$0034C730,$0034C6F0

		ORG $39DB76	; 熊$37
			dc.l	$0034CC14,$0034CC54,$0034CC94,$0034CC54

		ORG $39F532	; 虎[$38]
			dc.l	$0034D288,$0034D2C8,$0034D388,$0034D3C8

		ORG $3A118E	; 黑豹$39
			dc.l	$0034D8BC,$003623EA,$0034D8BC,$003623EA		; 豹雕色盤[2]

		ORG $3A30B6	; 鷹$3A
			dc.l	$0034DEF0,off_34DF70,$0034DEF0,off_34DF70	; 白頭獵鷹[3]

		ORG $3A47FE	; 蠍$3B
			dc.l	$0034E2C4,$0034E304,$0034E344,$0034E304

		ORG $3A5D8E	; 蛇$3C
			dc.l	$0034E6A8,$0034E6E8,$0034E728,$0034E6E8

	* 敵兵表格

		ORG $284A94	; 0200新野城左雙兵表增加1金珠
			dc.l	$027600B0,$00000004,$00104611

		ORG $2863FC	; 0202白河水壩末弓兵[1]出場橫坐標[0402]
			dc.l	$04020098,$00000001,$000A5F00

		ORG $28A784	; 0300襄江[短兵兵群]保留原版刷兵間隔
			dc.l	$FF0C0000,$FF0F0101,$FF0B035A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A724,$FF0B030A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A730,$FF0B030A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A73C,$FF0B030A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A748,$FF0A0100
			dc.l	$FF050100,$0038AE68,$00000100,$0028A754,$FF0B030A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A760,$FF0B030A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A76C,$FF0B030A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A778,$FF0A0000,$FF130000

		ORG $28A8DC	; 0300襄江[輕騎兵群][單兵]保留原版刷兵間隔
			dc.l	$FF0C0000,$FF0F0101,$FF0B0378
			dc.l	$FF050108,$003878C8,$00000108,$0028A834,$FF0B030A
			dc.l	$FF050108,$003878C8,$00000108,$0028A840,$FF0B030A
			dc.l	$FF050108,$003878C8,$00000108,$0028A84C,$FF0B030A
			dc.l	$FF050108,$003878C8,$00000108,$0028A858,$FF0A0100
			dc.l	$FF050100,$0037FF10,$00000302,$0028A87C,$FF0B030A
			dc.l	$FF050100,$0037FF10,$00000302,$0028A888,$FF0B030A
			dc.l	$FF050100,$0037FF10,$00000302,$0028A894,$FF0A0000,$FF130000
		ORG $28A978	; 0300襄江[輕騎兵群][雙兵]保留原版刷兵間隔
			dc.l	$FF0C0000,$FF0F0101,$FF0B0378
			dc.l	$FF050108,$003878C8,$00000108,$0028A834,$FF0B030A
			dc.l	$FF050108,$003878C8,$00000108,$0028A840,$FF0B030A
			dc.l	$FF050108,$003878C8,$00000108,$0028A84C,$FF0B030A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A864,$FF0B030A
			dc.l	$FF050100,$0038AE68,$00000100,$0028A870,$FF0A0000
			dc.l	$FF050100,$0037FF10,$00000302,$0028A87C,$FF0B030A
			dc.l	$FF050100,$0037FF10,$00000302,$0028A888,$FF0B030A
			dc.l	$FF050100,$0037FF10,$00000302,$0028A894,$FF0B030A
			dc.l	$FF050100,$0037FF10,$00000302,$0028A8A0,$FF0A0000
			dc.l	$FF050100,$0037FF10,$00000302,$0028A8AC,$FF0B030A
			dc.l	$FF050100,$0037FF10,$00000302,$0028A8B8,$FF0B030A
			dc.l	$FF050100,$0037FF10,$00000302,$0028A8C4,$FF0B030A
			dc.l	$FF050100,$0037FF10,$00000302,$0028A8D0,$FF0A0000,$FF130000
		ORG $28AB28	; 0300襄江鐵甲步兵隊長|明光鎧
			dc.l	$04CE00C8,$00000000,$000400045

		ORG $28B7E8	; 0301長坂坡[長兵]兵陣[單兵]
			dc.l	$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060305,$003878C8,$FFFF0305,$0028B6EC
			dc.l	$FF050305,$003878C8,$FFFF0305,$0028B6F8
			dc.l	$FF050305,$003878C8,$FFFF0305,$0028B704
			dc.l	$FF050305,$003878C8,$FFFF0305,$0028B710,$FF0A0300,$FF070000,$001841E0
			dc.l	$FF050305,$003878C8,$FFFF0305,$0028B710,$FF011300,$FF090000,$FF0A0000,$FF130000
		ORG $28B934	; 0301長坂坡[長兵/短兵]兵陣[雙兵]
			dc.l	$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060305,$003878C8,$FFFF0305,$0028B6EC
			dc.l	$FF050305,$003878C8,$FFFF0305,$0028B6F8
			dc.l	$FF050305,$003878C8,$FFFF0305,$0028B704
			dc.l	$FF050305,$003878C8,$FFFF0305,$0028B710,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050305,$003878C8,$FFFF0305,$0028B710,$FF011300,$FF090000,$FF0A0000,$FF0D0020
			dc.l	$FF060302,$0038AE68,$FFFF0302,$0028B71C
			dc.l	$FF050302,$0038AE68,$FFFF0302,$0028B728
			dc.l	$FF050302,$0038AE68,$FFFF0302,$0028B734
			dc.l	$FF050302,$0038AE68,$FFFF0302,$0028B740,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050302,$0038AE68,$FFFF0302,$0028B740,$FF012E00,$FF090000,$FF0A0000,$FF130000
		ORG $0028B71C	; 短兵隊長[包子]
			dc.l	$045600A5,$00000004,$00100082

		ORG $28BB4C	; 0301長坂坡[工兵]兵陣[雙兵]
			dc.l	$FF100304,$00000000
			dc.l	$FF060101,$003837DE,$FFFF0103,$0028BA48
			dc.l	$FF050101,$003837DE,$FFFF0103,$0028BA54
			dc.l	$FF050101,$003837DE,$FFFF0103,$0028BA60
			dc.l	$FF050101,$003837DE,$FFFF0103,$0028BA6C
			dc.l	$FF050101,$003837DE,$FFFF0103,$0028BA78
			dc.l	$FF050101,$003837DE,$FFFF0103,$0028BA84
			dc.l	$FF050101,$003837DE,$FFFF0103,$0028BA90,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050101,$003837DE,$FFFF0103,$0028BA90,$FF013500,$FF090000,$FF130000
		ORG $28BC48	; 0301長坂坡[工兵/弓兵]兵陣[雙兵]
			dc.l	$FF100304,$00000000
			dc.l	$FF060301,$003837DE,$FFFF0304,$0028BA48		; 工兵隊長[蓮花]
			dc.l	$FF050301,$003837DE,$FFFF0304,$0028BAA8
			dc.l	$FF050301,$003837DE,$FFFF0304,$0028BAB4
			dc.l	$FF050301,$003837DE,$FFFF0304,$0028BAC0
			dc.l	$FF050301,$003837DE,$FFFF0304,$0028BACC
			dc.l	$FF050301,$003837DE,$FFFF0304,$0028BAD8
			dc.l	$FF050301,$003837DE,$FFFF0304,$0028BAE4,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050301,$003837DE,$FFFF0304,$0028BAE4,$FF013500,$FF090000,$FF0A0000,$FF100304,$00000000
			dc.l	$FF060302,$0038D30E,$FFFF0302,$0028BA9C		; 弓兵隊長[超必殺補充品]
			dc.l	$FF050302,$0038D30E,$FFFF0302,$0028BA54
			dc.l	$FF050302,$0038D30E,$FFFF0302,$0028BA60
			dc.l	$FF050302,$0038D30E,$FFFF0302,$0028BA6C
			dc.l	$FF050302,$0038D30E,$FFFF0302,$0028BA78
			dc.l	$FF050302,$0038D30E,$FFFF0302,$0028BA84
			dc.l	$FF050302,$0038D30E,$FFFF0302,$0028BA90,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050302,$0038D30E,$FFFF0302,$0028BA90,$FF015D00,$FF090000,$FF0A0000,$FF130000

		ORG $28BFA4	; 0301長坂坡[鐵甲步兵]兵陣
			dc.l	$FF0F0100,$FF100204,$00000000
			dc.l	$FF060303,$0037D090,$FFFF0304,$0028C18C
			dc.l	$FF050304,$0037D090,$FFFF0304,$0028C198
			dc.l	$FF050304,$0037D090,$FFFF0304,$0028C1A4
			dc.l	$FF050304,$0037D090,$FFFF0304,$0028C1B0
			dc.l	$FF050100,$0037D090,$FFFF0100,$0028C1C8
			dc.l	$FF050304,$0037D090,$FFFF0304,$0028C1BC,$FF0A0500,$FF070000,$001841E0
			dc.l	$FF050304,$0037D090,$FFFF0304,$0028C1C8,$FF011B00,$FF090000,$FF0A0000,$FF130000
		ORG $0028C18C	; 鐵甲步兵隊長[策略補充品]
			dc.l	$046A00C8,$00000000,$00050004
		ORG $28C04C	; 0301長坂坡[輕騎]兵陣
			dc.l	$FF0F0100,$FF100204,$00000000
			dc.l	$FF060304,$0037FF10,$FFFF0303,$0028BF08
			dc.l	$FF050304,$0037FF10,$FFFF0303,$0028BEB4
			dc.l	$FF050304,$0037FF10,$FFFF0303,$0028BEC0
			dc.l	$FF050304,$0037FF10,$FFFF0303,$0028BECC
			dc.l	$FF050304,$0037FF10,$FFFF0303,$0028BED8
			dc.l	$FF050304,$0037FF10,$FFFF0303,$0028BEE4,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050304,$0037FF10,$FFFF0303,$0028BEB4,$FF011B00,$FF090000,$FF0A0000,$FF130000
		ORG $0028BF08	; 輕騎隊長[魔法補充品]
			dc.l	$04BA00C8,$00000000,$00200003
		ORG $28C0F4	; 0301長坂坡[鐵甲騎兵]兵陣
			dc.l	$FF0F0100,$FF100304,$00000000
			dc.l	$FF060301,$0037B04C,$FFFF0304,$0028BEFC
			dc.l	$FF050301,$0037B04C,$FFFF0304,$0028BEB4
			dc.l	$FF050301,$0037B04C,$FFFF0304,$0028BEC0
			dc.l	$FF050301,$0037B04C,$FFFF0304,$0028BECC
			dc.l	$FF050301,$0037B04C,$FFFF0304,$0028BED8
			dc.l	$FF050301,$0037B04C,$FFFF0304,$0028BEE4,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050301,$0037B04C,$FFFF0304,$0028BEF0,$FF011B00,$FF090000,$FF0A0000,$FF130000
		ORG $0028BEFC	; 鐵甲騎兵隊長[超必殺補充品]
			dc.l	$047E00C8,$00000000,$00200005

		ORG $28FA94	; 0400南坪山碼頭末[包子]替換為[粽子堆]
			dc.l	$04D00104,$00000000,$00100084

		ORG $28F7A8	; 0400南坪山碼頭牛金令之水兵[修正坐標][朱雀神器]
			dc.l	$027100FA,$00000000,$00100034

		ORG $291654	; 0405東吳船艙左兩鐵甲步兵坐標修正
			dc.l	$049800B4,$00000000,$00100A8B
			dc.l	$04A200DC,$00000000,$00100A00

		ORG $2917A8	; 0405東吳船艙左[水兵]兵陣[單兵]
			dc.l	$FF060301,$00381B98,$FFFF0302,$002916B4
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916C0
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916CC
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916D8
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916E4
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916F0,$FF0A0600,$FF070000,$0018CB08
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916F0,$FF014300,$FF090000,$FF0A0000,$FF130000
		ORG $29192C	; 0405東吳船艙左[水兵]兵陣[雙兵]
			dc.l	$FF060301,$00381B98,$FFFF0302,$002916B4
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916C0
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916CC
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916D8
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916E4
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916F0,$FF0A0600,$FF070000,$0018CB08
			dc.l	$FF050301,$00381B98,$FFFF0302,$002916F0,$FF015600,$FF090000,$FF0A0000,$FF130000
		ORG $002916B4	; 0405東吳船艙左水兵隊長[薤葉芸香]
			dc.l	$038400C8,$00000000,$00100A3E

		ORG $2950FC	; 040D曹魏船艙單兵[水兵/炸彈兵/機械兵]陣型
			dc.l	$294F20
		ORG $294F20	; 040D曹魏船艙雙兵[水兵/炸彈兵/機械兵]陣型
			dc.l	$FF120101,$FF100204,$059C00C8
			dc.l	$FF060302,$0039631C,$FFFF0301,$00294C80
			dc.l	$FF050302,$0039631C,$FFFF0301,$00294C8C
			dc.l	$FF050302,$0039631C,$FFFF0301,$00294C98
			dc.l	$FF050302,$0039631C,$FFFF0301,$00294CA4
			dc.l	$FF050302,$0039631C,$FFFF0301,$00294CB0
			dc.l	$FF050302,$0039631C,$FFFF0301,$00294CBC,$FF0A0600,$FF070000,$0018CB08
			dc.l	$FF050302,$0039631C,$FFFF0301,$00294CBC,$FF011B00,$FF090000,$FF0A0000,$FF100304,$03C000C8
			dc.l	$FF060301,$00391D48,$FFFF0103,$00294D10
			dc.l	$FF050301,$00391D48,$FFFF0103,$00294CD4
			dc.l	$FF050301,$00391D48,$FFFF0103,$00294CE0
			dc.l	$FF050301,$00391D48,$FFFF0103,$00294CEC
			dc.l	$FF050301,$00391D48,$FFFF0103,$00294CF8
			dc.l	$FF050301,$00391D48,$FFFF0103,$00294D04,$FF0A0600,$FF070000,$0018CB08
			dc.l	$FF050301,$00391D48,$FFFF0103,$00294D04,$FF013F00,$FF090000,$FF0A0000,$FF070000,$00192D40,$FF017100,$FF090000,$FF100204,$03C000C8
			dc.l	$FF060301,$00385AF0,$FFFF0300,$00294CC8
			dc.l	$FF050301,$00385AF0,$FFFF0300,$00294D1C
			dc.l	$FF050301,$00385AF0,$FFFF0300,$00294D28
			dc.l	$FF050301,$00385AF0,$FFFF0300,$00294D34
			dc.l	$FF050301,$00385AF0,$FFFF0300,$00294D40
			dc.l	$FF050301,$00385AF0,$FFFF0300,$00294D4C,$FF0A0600,$FF070000,$0018CB08
			dc.l	$FF050301,$00385AF0,$FFFF0300,$00294D4C,$FF016700,$FF090000,$FF0A0000,$FF130000
		ORG $00294CBC	; 水兵補充兵修正橫坐標
			dc.l	$060000DC,$00000000,$00100A00
		ORG $00294C80	; 水兵隊長[超必殺補充品]
			dc.l	$057400C8,$00000000,$00100A05
		ORG $00294CC8	; 炸彈兵隊長[燃燒彈]
			dc.l	$039800C8,$00000000,$00100A12
		ORG $00294D10	; 機械兵隊長[蓮花]
			dc.l	$039800C8,$00000000,$00100A14

		ORG $299FF4	; 0502南彝陵場景末[鉄騎兵群][單兵]保留原版刷兵間隔
			dc.l	$FF0C0000
			dc.l	$FF050104,$0037B04C,$00000105,$00299F40,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F4C,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F58,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F64,$FF0A0100
			dc.l	$FF050104,$0037B04C,$00000105,$00299F7C,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F88,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F94,$FF0A0000,$FF130000
		ORG $29A0E4	; 0502南彝陵場景末[鉄騎兵群][雙兵]保留原版刷兵間隔
			dc.l	$FF0C0000
			dc.l	$FF050104,$0037B04C,$00000105,$00299F40,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F4C,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F58,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F64,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F70,$FF0A0100
			dc.l	$FF050104,$0037B04C,$00000105,$00299F7C,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F88,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299F94,$FF0B031E
			dc.l	$FF050104,$0037B04C,$00000105,$00299FA0,$FF0A0000,$FF130000

		ORG $299D54	; 0502南彝陵場景中段弓兵取消掉落策略
			dc.l	$044C00A0,$00000000,$00105000
		ORG $16F19E	; 0502南彝陵場景中段深藍鉄騎[包子]更換為[燃燒彈]
			pea		($12).w
		ORG $16F1A8	; 0502南彝陵場景中段深藍鉄騎[包子堆]更換為[策略]
			pea		(2).w
		ORG $16F1BC	; 掉物程序
			jsr		$123B96
		ORG $16F166	; 0502南彝陵場景中段深藍鉄騎[包子串]更換為[援軍令]
			pea		(4).w
		ORG $16F17A	; 掉物程序
			jsr		$123B96

		ORG $299F7C	; 0502南彝陵場景末鉄騎[粽子堆]替換為[包子串]
			dc.l	$064000A0,$00000000,$00105083

		ORG $29C792	; 0504華容道后段單兵與雙兵同敵兵表
			dc.l	$29C578
		ORG $29C578	; 0504華容道后段雙兵種陣型
			dc.l	$FF0F0000,$FF100204,$025800B4	; [FF0F0000]自動方向
			dc.l	$FF060301,$0037D090,$FFFF0302,$0029C350
			dc.l	$FF050103,$0038D30E,$FFFF0302,$0029C35C
			dc.l	$FF050302,$0038D30E,$FFFF0303,$0029C368,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050100,$0038D30E,$FFFF0101,$0029C374
			dc.l	$FF050101,$003878C8,$FFFF0102,$0029C380,$FF010F00,$FF090000,$FF0A0000,$FF0D0020	; 烟霧彈
			dc.l	$FF060301,$0037D090,$FFFF0302,$0029C38C
			dc.l	$FF050301,$0037B04C,$FFFF0303,$0029C398
			dc.l	$FF050303,$0037B04C,$FFFF0301,$0029C3A4,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050101,$0038AE68,$FFFF0302,$0029C3B0
			dc.l	$FF050104,$0037B04C,$FFFF0105,$0029C3BC,$FF012A00,$FF090000,$FF0A0000,$FF130000	; 燃燒彈
		ORG $29C350	; 0504華容道后段陣型坐標
			dc.l	$07E40096,$00000000,$00046211	; 0029C350
			dc.l	$07E40096,$00000000,$00046213	; 0029C35C
			dc.l	$07E40096,$00000000,$00046212	; 0029C368
			dc.l	$08240096,$00000000,$00046200	; 0029C374
			dc.l	$08240096,$00000000,$00046200	; 0029C380
			dc.l	$05340096,$00000000,$00046200	; 0029C38C
			dc.l	$05340096,$00000000,$00046200	; 0029C398
			dc.l	$05340096,$00000000,$00046214	; 0029C3A4
			dc.l	$05340096,$00000000,$00046200	; 0029C3B0
			dc.l	$05340096,$00000000,$00046200	; 0029C3BC

		ORG $0029FE9E	; 0600山寨中段雙兵最後一個男矛越兵出場橫坐標
			dc.l	$047A00BE,$00000000,$00100600
		ORG $2A0352	; 0600山寨單兵[女越兵/木人/桶怪]陣型
				dc.l	off_2A01BE
		ORG $2A0384	; 0600山寨雙兵[女越兵/木人/桶怪]陣型
				dc.l	off_2A01BE

		ORG $2A3692	; 0603南郡道雙兵[男叉蠻兵/男弓蠻兵/女蠻兵]陣型
			dc.l	$2A2D3E
		ORG $2A2D3E	; 0603南郡道單兵[男叉蠻兵/男弓蠻兵/女蠻兵]陣型
			dc.l	$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060000,$003732FA,$FFFF0000,$002A2CC6
			dc.l	$FF050000,$003732FA,$FFFF0000,$002A2CD2
			dc.l	$FF050300,$00374DC2,$FFFF0304,$002A2CEA
			dc.l	$FF050300,$00370D1A,$FFFF0301,$002A2D02
			dc.l	$FF050300,$00374DC2,$FFFF0301,$002A2D1A
			dc.l	$FF050302,$00370D1A,$FFFF0303,$002A2D26,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050302,$00374DC2,$FFFF0303,$002A2D1A,$FF011B00,$FF090000,$FF0A0000,$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060304,$00374DC2,$FFFF0300,$002A2D1A
			dc.l	$FF050300,$003732FA,$FFFF0301,$002A2D32
			dc.l	$FF050304,$00370D1A,$FFFF0305,$002A2CF6
			dc.l	$FF050301,$00374DC2,$FFFF0302,$002A2CEA
			dc.l	$FF050302,$003732FA,$FFFF0303,$002A2D0E
			dc.l	$FF050300,$00370D1A,$FFFF0301,$002A2D26,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050304,$00370D1A,$FFFF0305,$002A2D0E,$FF014000,$FF090000,$FF0A0000,$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060302,$00370D1A,$FFFF0303,$002A2D02
			dc.l	$FF050302,$003732FA,$FFFF0303,$002A2D32
			dc.l	$FF050303,$00374DC2,$FFFF0304,$002A2D1A
			dc.l	$FF050300,$00374DC2,$FFFF0301,$002A2CEA
			dc.l	$FF050300,$003732FA,$FFFF0301,$002A2CDE
			dc.l	$FF050302,$00374DC2,$FFFF0303,$002A2CEA,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050300,$003732FA,$FFFF0301,$002A2CF6,$FF016500,$FF090000,$FF0A0000,$FF130000
		ORG $002A2D1A	; 女蠻兵補充兵不攜帶物品
			dc.l	$026700DC,$00000000,$00100600
		ORG $002A2D0E	; 男弓蠻兵補充兵不攜帶物品
			dc.l	$026700AA,$00000000,$00100600

		ORG $2A36A6	; 0603南郡道雙兵[黑豹/虎/熊]陣型
			dc.l	$2A32B2
		ORG $2A32B2	; 0603南郡道單兵[黑豹/虎/熊]陣型
			dc.l	$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060301,$003A17B2,$FFFF0300,$002A32A6
			dc.l	$FF050301,$003A17B2,$FFFF0300,$002A326A
			dc.l	$FF050301,$003A17B2,$FFFF0300,$002A3276
			dc.l	$FF050301,$003A17B2,$FFFF0300,$002A3282
			dc.l	$FF050301,$003A17B2,$FFFF0300,$002A328E
			dc.l	$FF050301,$003A17B2,$FFFF0300,$002A329A,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050301,$003A17B2,$FFFF0300,$002A326A,$FF011B00,$FF090000,$FF0A0000,$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060300,$0039FB66,$FFFF0301,$002A32A6
			dc.l	$FF050300,$0039FB66,$FFFF0301,$002A326A
			dc.l	$FF050300,$0039FB66,$FFFF0301,$002A3276
			dc.l	$FF050300,$0039FB66,$FFFF0301,$002A3282
			dc.l	$FF050300,$0039FB66,$FFFF0301,$002A328E
			dc.l	$FF050300,$0039FB66,$FFFF0301,$002A329A,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050300,$0039FB66,$FFFF0301,$002A326A,$FF014000,$FF090000,$FF0A0000,$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060302,$0039E19E,$FFFF0300,$002A325E
			dc.l	$FF050302,$0039E19E,$FFFF0300,$002A326A
			dc.l	$FF050302,$0039E19E,$FFFF0300,$002A3276
			dc.l	$FF050302,$0039E19E,$FFFF0300,$002A3282
			dc.l	$FF050302,$0039E19E,$FFFF0300,$002A328E
			dc.l	$FF050302,$0039E19E,$FFFF0300,$002A329A,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050302,$0039E19E,$FFFF0300,$002A326A,$FF016500,$FF090000,$FF0A0000,$FF130000
		ORG $002A325E	; 熊隊長攜帶[烤豬]
			dc.l	$06B700C3,$00000000,$00100087

		ORG $2A3E3A	; 0604油江口單兵與雙兵同敵兵表
			dc.l	$2A3812
		ORG $2A3812	; 0604油江口[雙兵][老鷹/山賊兵]陣型
			dc.l	$FF0F0101,$FF100204,$025800B4
			dc.l	$FF060300,$003A36C6,$FFFF0100,$002A36BA	; 老鷹
			dc.l	$FF050300,$003A36C6,$FFFF0100,$002A36C6
			dc.l	$FF050300,$003A36C6,$FFFF0100,$002A36D2
			dc.l	$FF050300,$003A36C6,$FFFF0100,$002A36DE,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050300,$003A36C6,$FFFF0100,$002A36EA,$FF011300,$FF090000,$FF0A0000,$FF0D0020
			dc.l	$FF060102,$00394464,$FFFF0101,$002A36F6	; 山賊兵
			dc.l	$FF050101,$00394464,$FFFF0102,$002A3702
			dc.l	$FF050106,$00394464,$FFFF0102,$002A370E
			dc.l	$FF050101,$00394464,$FFFF0106,$002A371A,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050102,$00394464,$FFFF0101,$002A3726,$FF012E00,$FF090000,$FF0A0000,$FF130000
		ORG $002A36BA	; 0604油江口[雙兵][老鷹/山賊兵]陣型坐標表
			dc.l	$024800A0,$FFA60000,$00100086	; 鷄腿
			dc.l	$020F009E,$FFA60000,$20000000
			dc.l	$022700B1,$FFA60000,$00100000
			dc.l	$021600D7,$FFA60000,$00100000
			dc.l	$022400B8,$FFA60000,$10200000
			dc.l	$01F40098,$FF100001,$00100004	; 策略
			dc.l	$00E800DC,$FF100001,$00100000
			dc.l	$00E200DC,$FF100001,$00100000
			dc.l	$011200C8,$FF100001,$00100013
			dc.l	$013200C8,$FF100001,$00100000

		ORG $1AFE56	; 0605四神獸密室木人掉落[流馬]替換為[包子]
			pea     $82.w
		ORG $1AFE6C	; 掉落補給程序
			jsr     $11c1ca

		ORG $2A430E	; 0605四神獸密室第二層取消重複刷兵[木人]
			dc.l	$FF0C0000
			dc.l	$FF050101,$00398D3C,$00020101,$002A4292
			dc.l	$FF050101,$00398D3C,$00020101,$002A429E
			dc.l	$FF050101,$00398D3C,$00020101,$002A42AA
			dc.l	$FF050101,$00398D3C,$00020101,$002A42B6,$FF0A0600	; 刪除[FF03-FF04]
			dc.l	$FF050101,$00398D3C,$00020101,$002A4292,$FF0A0600
			dc.l	$FF050101,$00398D3C,$00020101,$002A429E,$FF0A0600
			dc.l	$FF050101,$00398D3C,$00020101,$002A42AA,$FF0A0600
			dc.l	$FF050101,$00398D3C,$00020101,$002A42B6,$FF0A0600,$FF0A0000,$FF130000

		ORG $2A4522	; 0606火焰洞密室單兵[蠻牛]陣型
			dc.l	$FF0C0400,$FF0F0000,$FF100204,$025800B4	; [FF0F0000]自動方向
			dc.l	$FF050104,$0039C686,$FFFF0104,$002A44F2
			dc.l	$FF050104,$0039C686,$FFFF0104,$002A44FE
			dc.l	$FF020000,sub_1B1654	; 記錄藍牛隊長序號
			dc.l	$FF060104,$0039C686,$FFFF0104,unk_1B1654
			dc.l	$FF050104,$0039C686,$FFFF0104,$002A44F2
			dc.l	$FF050104,$0039C686,$FFFF0104,$002A44FE,$FF0A0600,$FF070000,$001841E0
			dc.l	$FF050104,$0039C686,$FFFF0104,$002A450A
			dc.l	$FF050104,$0039C686,$FFFF0104,$002A4516
			dc.l	$FF050104,$0039C686,$FFFF0104,$002A44F2,$FF011A00,$FF090000,$FF0A0000,$FF130000
		ORG $2A4630	; 0606火焰洞密室雙兵[蠻牛]陣型
			dc.l	$2A4522

		ORG $2A4FFE	; 0700南郡城門前藍色鉄騎|青龍神器
			dc.l	$076000C3,$00000000,$00101432

		ORG $2A66D2	; 0701前庭場景末增加[包子蒸籠]
			dc.l	$045D01A4,$00000000,$00100085

		ORG $2A69A2	; 0701前廳階梯老鷹[坐標修正]
			dc.l	$079A012C,$FFA60000,$00040000
			dc.l	$03FF0168,$FFA60000,$00040000
			dc.l	$079A012C,$FFA60000,$00040000
			dc.l	$03FF0168,$FFA60000,$00040088
		ORG $2A69C6	; 取消掉落金錢
			dc.l	$040F0168,$FFA60000,$00040000

		ORG $002A6FC2	; 0702長廊密道鐵甲步兵[包子串]替換為[薤葉芸香]
			dc.l	$01E200E6,$00000000,$0010003E

		ORG $2A7806	; 0703大廳[孫權座前黑豹群]
			dc.l	$FF120000,$FF0F0100,$FF0C0000,$FF030300	; 刷新三次敵兵表
			dc.l	$FF050105,$003A17B2,$00000105,$002A77CA,$FF0B000A
			dc.l	$FF050105,$003A17B2,$00000105,$002A77D6,$FF0B000A
			dc.l	$FF050105,$003A17B2,$00000105,$002A77CA,$FF0B000A
			dc.l	$FF050105,$003A17B2,$00000105,$002A77D6,$FF0A0000,$FF040000,$FF130000
		ORG $002A77CA	; 修正[孫權座前黑豹群]橫坐標
			dc.l	$048100B4,$00000002,$00040000
			dc.l	$051200F7,$00000002,$00040000

; =============== 我方調整 ==================================================

	* 107 版本設定
		; 連擊保護
		ORG $11513C	; 連擊保護
			jsr		sub_114D3C

		; 向前跌倒起身保護[080F]
		ORG $2527AA	; [關羽]向前跌倒起身動作
			dc.w	$080F
			dc.l	off_2525C8,$01003000,$0,$0
		ORG $257C34	; [張飛]向前跌倒起身動作
			dc.w	$080F
			dc.l	off_257A62,$01003000,$0,$0
		ORG $25D064	; [趙雲]向前跌倒起身動作
			dc.w	$080F
			dc.l	off_25CE92,$01003000,$0,$0
		ORG $26286E	; [黃忠]向前跌倒起身動作
			dc.w	$080F
			dc.l	off_26268C,$01003000,$0,$0
		ORG $2687A2	; [馬超]向前跌倒起身動作
			dc.w	$080F
			dc.l	off_2685D0,$01003000,$0,$0
		ORG $26E0CE	; [孔明]向前跌倒起身動作
			dc.w	$080F
			dc.l	off_26DEA4,$01003000,$0,$0
		ORG $272DAA	; [貂蟬]向前跌倒起身動作[無需]
		ORG $278276	; [龐統]向前跌倒起身動作
			dc.w	$080F
			dc.l	off_27809C,$01003000,$0,$0
		ORG $27DD92	; [孫權]向前跌倒起身動作
			dc.w	$080F
			dc.l	off_27DBB8,$01003000,$0,$0

	* 多玩家同角色
		; 選人可同角色
		ORG $102878	; 選人界面選定角色可重複上色
			bra.s	$1028C8

		ORG $14C142	; 投幣後第一可選角色不作檢查
			blt.s	$14C132
		ORG $14C926	; 反向選擇角色時判斷是否可選
			NOP
		ORG $14C9BA	; 正向選擇角色時判斷是否可選
			NOP

		ORG $14C1F2	; 死命重新時不檢查原角可選
			bra.s	$14C204
		ORG $14C238	; 死命重新時不檢查可選角色
			blt.s	$14C228

		; 同角色多武器
		ORG $123BAA	; 掉落道具時，記錄掉落的武器數目[1]
			jsr		sub_123BAA
			bra.s	$123BBA
		ORG $123ED4	; 掉落道具時，記錄[2]
			jsr		sub_123BAA
			bra.s	$123EE4
		ORG $123AA2	; 掉落多把武器
			jsr		sub_123AA2

		; 同角色不同色
		ORG $15C82C	; 四玩家同角色的色盤分配(進場時)
			jsr		sub_15C82C
		ORG $15F71C	; (更換武器時)
			jsr		sub_15C82C
		ORG $15C43C	; (場景内)
			jsr		sub_15C82C
		ORG $15F9E4	; (收回降將)
			jsr		sub_15C82C

		ORG $24F260	; 關羽默認色盤：大砍刀/青龍偃月刀/方天畫戟
			dc.l	$0032C902,$0032C942,word_32C982,$0	; 1P
			dc.l	word_24F290,word_24F294,word_24F298,$0	; 2P
			dc.l	word_24F270,word_24F274,word_24F278,$0	; 3P
			dc.l	word_24F280,word_24F284,word_24F288,$0	; 4P

		ORG $25460A	; 張飛：蛇矛/丈八蛇矛/方天畫戟
			dc.l	$0032FABA,$0032FB3A,word_32FAFA,$0	; 1P
			dc.l	word_25463A,word_25463E,word_254642,$0	; 2P
			dc.l	word_25461A,word_25461E,word_254622,$0	; 3P
			dc.l	word_25462A,word_25462E,word_254632,$0	; 4P

		ORG $259AF2	; 趙雲：長槍/紅纓梨花槍/方天畫戟
			dc.l	$00332862,$003328E2,word_3328A2,$0	; 1P
			dc.l	word_259B12,word_259B16,word_259B1A,$0	; 2P
			dc.l	word_259AF2,word_259AF6,word_259AFA,$0	; 3P
			dc.l	word_259B02,word_259B06,word_259B0A,$0	; 4P

		ORG $25F1CE	; 黃忠：長弓/毒龍鐵胎弓/祝融神火弓/天火雙煞弓
			dc.l	$0033514A,$0033518A,$003351CA,word_33520A	; 1P
			dc.l	word_25F1EE,word_25F1F2,word_25F1F6,word_25F1FA	; 2P
			dc.l	word_25F1CE,word_25F1D2,word_25F1D6,word_25F1DA	; 3P
			dc.l	word_25F1DE,word_25F1E2,word_25F1E6,word_25F1EA	; 4P

		ORG $264C28	; 馬超：長劍/倚天劍/青釭劍/玄鐵鴛鴦簡
			dc.l	$00337A32,$00337A72,$00337AF2,$00337AB2	; 1P
			dc.l	word_264C58,word_264C5A,word_264C5E,word_264C62	; 2P
			dc.l	word_264C38,word_264C3A,word_264C3E,word_264C42	; 3P
			dc.l	word_264C48,word_264C4A,word_264C4E,word_264C52	; 4P

		ORG $26A504	; 孔明：長劍/五火神焰扇/天罡劈水扇
			dc.l	$0033A444,$0033A4C4,$0033A484,$0	; 1P
			dc.l	word_26A534,word_26A538,word_26A534,$0	; 2P
			dc.l	word_26A514,word_26A518,word_26A51C,$0	; 3P
			dc.l	word_26A524,word_26A528,word_26A524,$0	; 4P

		ORG $26F394	; 貂蟬：匕首/血匕首/飛天虎爪
			dc.l	$0033C4AC,$0033C4EC,$0033C52C,$0	; 1P
			dc.l	word_26F3C4,word_26F3C8,word_26F3C4,$0	; 2P
			dc.l	word_26F3A4,word_26F3A8,word_26F3A4,$0	; 3P
			dc.l	word_26F3B4,word_26F3B8,word_26F3B4,$0	; 4P

		ORG $274AD0	; 龐統：彎刀/吳鈎/巫刀
			dc.l	$0033EE94,$0033EED4,$0033EF14,$0	; 1P
			dc.l	word_274B00,word_274B04,word_274B08,$0	; 2P
			dc.l	word_274AE0,word_274AE4,word_274AE8,$0	; 3P
			dc.l	word_274AF0,word_274AF4,word_274AF8,$0	; 4P

		ORG $279F56	; 孫權：長槊/盤龍三節棍
			dc.l	$0034113C,$0034117C,$0,$0	; 1P
			dc.l	word_3411BC,word_3411FC,$0,$0	; 2P
			dc.l	word_279F66,word_279F6A,$0,$0	; 3P
			dc.l	word_279F76,word_279F7A,$0,$0	; 4P

		; 色盤部分刷新(中毒刷新)
		ORG $12B1E0	; 角色各武器共用中蛇毒色盤
			bra.s	$12B1EA
		ORG $12B202	; 色盤部分刷新
			jsr		sub_100AF6
		ORG $12B140	; 角色各武器共用中蠍子毒2色盤
			bra.s	$12B14A
		ORG $12B162
			jsr		sub_100AF6

		ORG $2ABDAC	; 關羽中毒色盤(共用)
			dc.l	off_30FF34
		ORG $2ABE20	; 張飛(共用)
			dc.l	off_30FF34
		ORG $2ABE94	; 趙雲(共用)
			dc.l	off_30FF34
		ORG $2ABF08	; 黃忠
			dc.l	off_3102B4
		ORG $2ABF7C	; 馬超(共用)
			dc.l	off_30FF34
		ORG $2ABFF0	; 孔明
			dc.l	off_3105B4
		ORG $2AC064	; 貂蟬
			dc.l	off_3106F4
		ORG $2AC0D8	; 龐統
			dc.l	off_3107F4
		ORG $2AC14C	; 孫權(共用)
			dc.l	off_30FF34

	* 撿取動作無敵

		ORG $251818	; 關羽
			dc.w	$0223	; 站立撿取[15E3BE]
			dc.l	$002504A8,$01002800,$0,$0
			dc.w	$0224	; 下蹲撿取
			dc.l	$002504D0,$10003800,$0,$0

		ORG $256BE2	; 張飛
			dc.w	$0223
			dc.l	$002558A6,$01003800,$0,$0
			dc.w	$0224
			dc.l	$002558C6,$10003800,$0,$0

		ORG $25C0FE	; 趙雲
			dc.w	$0223
			dc.l	$0025ADAE,$01003800,$0,$0
			dc.w	$0224
			dc.l	$0025ADCE,$10003800,$0,$0

		ORG $2617EA	; 黃忠
			dc.w	$0223
			dc.l	$0026049A,$01003800,$0,$0
			dc.w	$0224
			dc.l	$002604BA,$10003800,$0,$0

		ORG $2675BC	; 馬超
			dc.w	$0223
			dc.l	$00266254,$01004800,$0,$0
			dc.w	$0224
			dc.l	$00266274,$10004800,$0,$0

		ORG $26CBA8	; 孔明
			dc.w	$0223
			dc.l	$0026B7BC,$01004800,$0,$0
			dc.w	$0224
			dc.l	$0026B7D8,$10004800,$0,$0

		ORG $271BB8	; 貂蟬
			dc.w	$0223
			dc.l	$00270900,$01004800,$0,$0
			dc.w	$0224
			dc.l	$00270920,$10004800,$0,$0

		ORG $27700C	; 龐統
			dc.w	$0223
			dc.l	$00275CA8,$01004800,$0,$0
			dc.w	$0224
			dc.l	$00275CC8,$10004800,$0,$0

		ORG $27CCAC	; 孫權
			dc.w	$0223
			dc.l	$0027B958,$01003800,$0,$0
			dc.w	$0224
			dc.l	$0027B980,$10004800,$0,$0

	* 跑步跳躍動作

		ORG $1581C4	; [二代/群雄]跑步系統
			jsr		sub_1581C4

		ORG $158014	; 全角色可三段跳躍
			bra.s	$15802E

		ORG $251A10	; 關羽
			dc.w	$023F	; 原地空中跳躍動作
			dc.l	off_2C42A0,$02000000,0,0
			dc.w	$0240	; 向前跳躍
			dc.l	off_2C4478,$02000000,0,0
			dc.w	$0241	; 向後跳躍
			dc.l	off_2C4560,$02000000,0,0
		ORG $251776
			dc.w	$021A	; 空中速降動作
			dc.l	dword_2508C4,$02000800,0,0

		ORG $256DDA	; 張飛
			dc.w	$023F	; 原地空中跳躍動作
			dc.l	off_2C9756,$02000000,0,0
			dc.w	$0240	; 向前跳躍
			dc.l	off_2C9916,$02000000,0,0
			dc.w	$0241	; 向後跳躍
			dc.l	off_2C99F2,$02000000,0,0
		ORG $256B40
			dc.w	$021A	; 空中速降動作
			dc.l	dword_255CBE,$02000800,0,0

		ORG $25C2F6	; 趙雲
			dc.w	$023F	; 原地空中跳躍動作
			dc.l	off_2CEE4C,$02000000,0,0
			dc.w	$0240	; 向前跳躍
			dc.l	off_2CF01C,$02000000,0,0
			dc.w	$0241	; 向後跳躍
			dc.l	off_2CF100,$02000000,0,0
		ORG $25C05C
			dc.w	$021A	; 空中速降動作
			dc.l	dword_25B1C6,$02000800,0,0

		ORG $2619E2	; 黃忠
			dc.w	$023F	; 原地空中跳躍動作
			dc.l	off_2D47B4,$02000000,0,0
			dc.w	$0240	; 向前跳躍
			dc.l	off_2D49A4,$02000000,0,0
			dc.w	$0241	; 向後跳躍
			dc.l	off_2D4A98,$02000000,0,0
		ORG $261748
			dc.w	$021A	; 空中速降動作
			dc.l	dword_2608AE,$02000800,0,0

		ORG $26751A	; 馬超
			dc.w	$021A	; 空中速降動作
			dc.l	dword_26666C,$02000800,0,0

		ORG $26CDA0	; 孔明
			dc.w	$023F	; 原地空中跳躍動作
			dc.l	off_2DF7F8,$02000000,0,0
			dc.w	$0240	; 向前跳躍
			dc.l	off_2DF9D0,$02000000,0,0
			dc.w	$0241	; 向後跳躍
			dc.l	off_2DFAB8,$02000000,0,0
		ORG $26CB06
			dc.w	$021A	; 空中速降動作
			dc.l	dword_25B1C6,$02000800,0,0

		ORG $271B16	; 貂蟬
			dc.w	$021A	; 空中速降動作
			dc.l	dword_25B1C6,$02000800,0,0

		ORG $277204	; 龐統
			dc.w	$023F	; 原地空中跳躍動作
			dc.l	off_2E9F5C,$02000000,0,0
			dc.w	$0240	; 向前跳躍
			dc.l	off_2EA134,$02000000,0,0
			dc.w	$0241	; 向後跳躍
			dc.l	off_2EA21C,$02000000,0,0
		ORG $276F6A
			dc.w	$021A	; 空中速降動作
			dc.l	dword_26666C,$02000800,0,0

		ORG $27CEA4	; 孫權
			dc.w	$023F	; 原地空中跳躍動作
			dc.l	off_2EF17C,$02000000,0,0
			dc.w	$0240	; 向前跳躍
			dc.l	off_2EF32C,$02000000,0,0
			dc.w	$0241	; 向後跳躍
			dc.l	off_2EF400,$02000000,0,0
		ORG $27CC0A
			dc.w	$021A	; 空中速降動作
			dc.l	dword_2608AE,$02000800,0,0

	* 普通攻擊設定

		ORG $11B256	; 普通四招一式|偽連四招一式
			jsr		sub_11B256	; 判斷四一
			subq.l	#8,sp		; 校正堆棧

		ORG $252148	; 關羽-普通攻擊第一下-1A-快
			dc.w	$F054,$0500
		ORG $2521A8	; 2A
			dc.w	$F054,$0400
		ORG $2521F8	; 3A
			dc.w	$F054,$0700
		ORG $252240	; 4A
			dc.w	$F054,$0900

		ORG $25752E	; 張飛-1A
			dc.w	$F054,$0500
		ORG $2575A2	; 2A
			dc.w	$F054,$0400
		ORG $2575F2	; 3A
			dc.w	$F054,$0700
		ORG $257636	; 4A
			dc.w	$F054,$0900

		ORG $26214E	; 黃忠-1A
			dc.w	$F054,$0600
		ORG $2621C6	; 2A
			dc.w	$F054,$0500
		ORG $262236	; 3A
			dc.w	$F054,$0500
		ORG $262276	; 4A
			dc.w	$F054,$0A00

		ORG $267EDC	; 馬超-1A
			dc.w	$F054,$0800
		ORG $267F8C	; 3A
			dc.w	$F054,$0800
		ORG $2684B6	; 馬超普攻四式|重砍
			dc.w	$0303
			dc.l	dword_268038,$01003080,0,0

		* ORG $26D6F0	; 孔明-1A-慢
		* 	dc.w	$F054,$0B00
		* ORG $26D748	; 2A
		* 	dc.w	$F054,$0300
		* ORG $26D798	; 3A-4A
		* 	dc.w	$F054,$0900
		* ORG $26F294	; 26A
		* 	dc.l	$F00E0000,$F0540E00,$F0450300,$F04F2E03,$F0580101,$F0070000,$001732D2
		* 	dc.l	$F0020300,$00A20E00,$F00BAF00,$02C2F63C,$F0410100,$F0280500,$20A30A00,$F0290000
		* 	dc.l	$F0540B00,$F0410100,$F0280300,$20A40600,$F0290000
		* 	dc.l	$F0540A00,$F0410100,$F0280300,$20A50400,$F0290000
		* 	dc.l	$F0020200,$00A60200,$F0020200,$00A70100,$F0020200,$00A80000
		* 	dc.l	$F0020300,$00A90000,$00AA0000,$80000000

		ORG $27795C	; 龐統-1A
			dc.w	$F054,$0600
		ORG $2779C4	; 2A
			dc.w	$F054,$0500
		ORG $277A2C	; 3A
			dc.w	$F054,$0800
		ORG $277A70	; 4A
			dc.w	$F054,$0900

		ORG $202948	; 司馬懿站立受擊動作取消無敵[原動作同角色受擊動作]
			dc.l	$0036F500

	* 動作指令系統

		ORG $157A4C	; 動作指令判斷|是否施放|是否消耗
			jsr		sub_157A4C
			jmp		(a0)

		ORG $253600	; 關羽
			dc.w	$0629	; 龍翔淺底-B6B
			dc.l	off_252CE2,$02000280,0,0
			dc.w	$062A	; 狂龍逆轉-82A
			dc.l	off_2C6BF2,$01003280,0,0
			dc.w	$062B	; 火獸陣-28B
			dc.l	off_25325E,$01000080,0,0
		ORG $25171C	; 0215突行技
			dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
			dc.l	$00252CE2,$01000000
		ORG $253594	; 狂龍旋舞|增加風眼判定
			dc.w	$623
			dc.l	dword_2544E6,$01002280,$10000000,0

		ORG $258562	; 張飛
			dc.w	$0629	; 龍擺尾-82A
			dc.l	off_2CCFEC,$01002280,0,0
			dc.w	$062A	; 猛虎捶-28A
			dc.l	off_2CE0BC,$01002280,0,0

		ORG $25E592	; 趙雲
			dc.w	$0629	; 梨花刺-223A
			dc.l	off_2D1A26,$01000280,0,0
			dc.w	$062A	; 長槍陣-28B
			dc.l	off_25E1F4,$01000080,0,0
		ORG $25C002	; 02類15號動作：突行技(0628)
			dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
			dc.l	$0025DCC8,$01000000

		ORG $2635EC	; 黃忠
			dc.w	$0629	; 鹰击长空-B6B
			dc.l	off_26307E,$02000280,0,0
			dc.w	$062A	; 追魂劈-82A
			dc.l	off_2D857A,$01000280,0,0
			dc.w	$062B	; 連弩陣-28B
			dc.l	off_26324E,$01000080,0,0
		ORG $2616EE	; 0215突行技
			dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
			dc.l	$0026307E,$01000000

		ORG $2696C4	; 馬超
			dc.w	$0629	; 躍馬蹬空騎射-B3A
			dc.l	off_2DCDAA,$02000280,0,0
			dc.w	$062A	; 火獸陣-28B
			dc.l	off_26932E,$01000080,0,0
			dc.w	$062B	; 落石陣-82B
			dc.l	off_121AC4,$01000080,0,0
			dc.w	$062C	; 滾石陣-223B
			dc.l	off_122992,$01000080,0,0

		ORG $26ED84	; 孔明
			dc.w	$0629	; 鹰击长空-B6B
			dc.l	off_26F320,$02000280,0,0
			dc.w	$062A	; 朝歌-28A
			dc.l	off_2E38C2,$02000080,$10000000,0
			dc.w	$062B	; 挑撥術-223B
			dc.l	off_11FE7A,$01000080,0,0
			dc.w	$062C	; 混亂術-623B
			dc.l	off_120074,$01000080,0,0
			dc.w	$062D	; 洪水術-28B
			dc.l	off_26E67A,$01000080,0,0
			dc.w	$062E	; 天燈陣-82B
			dc.l	off_26E9E6,$01000080,0,0
			dc.w	$062F	; 落雷術-28C
			dc.l	off_26E8AE,$01000080,0,0
			dc.w	$0630	; 八陣圖-623C
			dc.l	off_26E90A,$01000080,0,0
		ORG $26CAAC	; 0215突行技
			dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
			dc.l	$0026F320,$01000000

		ORG $27394C	; 貂蟬
			dc.w	$0629	; 魚潛鸳飞-26A
			dc.l	off_2E70D8,$02000240,0,0
			dc.w	$062A	; 恢覆術-28C
			dc.l	off_2733F2,$01000080,0,0
			dc.w	$062B	; 雪暴術-82C
			dc.l	off_273432,$01000080,0,0

		ORG $279068	; 龐統
			dc.w	$0629	; 縮地成寸-B6B
			dc.l	off_279EEA,$02000280,0,0
			dc.w	$062A	; 隔空仙法-82A
			dc.l	off_2EE080,$01000280,0,0
			dc.w	$062B	; 恐嚇計-623B
			dc.l	off_120002,$01000080,0,0
			dc.w	$062C	; 滾石陣-223B
			dc.l	off_2788EE,$01000080,0,0
			dc.w	$062D	; 落雷術-28C
			dc.l	off_27889A,$01000080,0,0
			dc.w	$062E	; 雪暴術-82C
			dc.l	off_278B66,$01000080,0,0
			dc.w	$062F	; 暴風術-223C
			dc.l	off_278942,$01000080,0,0
			dc.w	$0630	; 神將術-623C
			dc.l	off_123586,$01000080,0,0
		ORG $276F10	; 0215突行技
			dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
			dc.l	$00279EEA,$01000000

		ORG $27E7FC	; 孫權
			dc.w	$0629	; 金石墜地-B6B
			dc.l	off_27FD64,$02000280,0,0
			dc.w	$062A	; 虎臂雙勾-82A
			dc.l	off_2F29A4,$01000280,$10000000,0
			dc.w	$062B	; 所向披靡-6A
			dc.l	$0024EEB6,$01000002,0,0
			dc.w	$062C	; 長槍陣-28B
			dc.l	off_27E42A,$01000080,0,0
		ORG $27CBB0	; 0215突行技
			dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
			dc.l	$0027FD64,$01000000
		ORG $27F34C	; 孫權-江東怒吼-無需判定繼續下一動作
			dc.l	$F00E0000	; 替換F05F0300

	* 危險迴避技能

		* sub_157FCC	; 空中危險迴避技[0309]之後不可突行代之速降

		ORG $25252C	; 關羽危險迴避技|傷害值增加一半$24
			dc.l	off_252388

		ORG $2579C6	; 張飛危險迴避技|傷害值增加一半$2A
			dc.l	off_25777E

		* ORG $1E64A8	; 趙雲危險迴避技|傷害值增加一半$24
		* 	dc.b	$12,$24

		ORG $2625DE	; 黃忠危險迴避技|傷害值增加一半$24
			dc.l	off_2623F6

		ORG $268524	; 馬超危險迴避技|傷害值增加一半$24
			dc.l	off_26839C

		ORG $26DA54	; 孔明危險迴避技|傷害值增加一半$24
			dc.l	off_26D8C8

		ORG $272AF8	; 貂蟬危險迴避技|傷害值增加一半$30
			dc.l	off_272980

		ORG $27DB0C	; 孫權危險迴避技|傷害值增加一半$26
			dc.l	off_27D9BC

		; 08類動作
		ORG $16184A	; 中蝎子毒時可強制血殺
			jsr		sub_16184A
		ORG $1618E8	; 本角浮空狀態可強制血殺，包括換將
			jsr		sub_1618E8
			jmp		(a0)	; 換將同樣做格擋反擊判斷$161958
		
	* 角色攻擊力表

		ORG $13C7AE
			movea.l #byte_1E63D8,a0
		ORG $15F318 ; 03類動作傷害值表|普通攻擊
			movea.l #byte_1E63D8,a0
		ORG $15F57E
			movea.l #byte_1E63D8,a0

		ORG $13C6F4
			movea.l #byte_1E6824,a0
		ORG $15F2B6	; 06類動作傷害值表|必殺技、超必殺技、投擲道具
			movea.l #byte_1E6824,a0
		ORG $15F51C
			movea.l #byte_1E6824,a0

		ORG $114666
			movea.l #byte_1E4612,a0
		ORG $114A76
			movea.l #byte_1E4612,a0
		ORG $11699A
			movea.l #byte_1E4612,a0
		ORG $116E7E
			movea.l #byte_1E4612,a0
		ORG $13C730
			movea.l #byte_1E4612,a0
		ORG $13D4D6
			movea.l #byte_1E4612,a0
		ORG $15F2F8	; 06類攻擊對各敵人的加成|普通攻擊
			movea.l #byte_1E4612,a0
		ORG $15F564	; 06類攻擊對各敵人的加成|道具攻擊
			movea.l #byte_1E4612,a0

	* 角色傷害加成
		; 我對敵之傷害加成表
		ORG $1E2BE6	; 關羽
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A	; 0
			dc.b	$20,$2A,$2A,$24,  0,$2A,  0,$2A,$28,$24	; $A
			dc.b	$28,$2A,$28,  0,$2A,$28,$28,$2A,$28,$20	; $14
			dc.b	$24, $C,$2A,$2A,$20,$32,$30,$26,$30,$3A	; $1E
			dc.b	$20,$22,$28,$20,$3A,$3A,$2A,$2A,$2C,$34	; $28
			dc.b	$30,$32, $C,$10,$28,$28,$28,$28,$48,$48	; $32
			dc.b	$48,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A
		ORG $1E2C4A	; 張飛
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,$2C	; 0
			dc.b	$20,$2A,$2A,$24,  0,$2A,  0,$2A,$28,$24	; $A
			dc.b	$28,$2A,$28,  0,$2A,$28,$28,$2A,$28,$20	; $14
			dc.b	$24, $C,$2A,$2A,$20,$34,$34,$28,$30,$3C	; $1E
			dc.b	$24,$24,$2A,$22,$3C,$3C,$2E,$2E,$2E,$3A	; $28
			dc.b	$32,$36, $E,$12,$2C,$2C,$2C,$2C,$48,$48	; $32
			dc.b	$48,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A
		ORG $1E2CAE	; 趙雲
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A	; 0
			dc.b	$20,$2A,$2A,$24,  0,$2A,  0,$2A,$28,$24	; $A
			dc.b	$28,$2A,$28,  0,$2A,$28,$28,$2A,$28,$20	; $14
			dc.b	$24, $C,$2A,$2A,$20,$30,$2E,$26,$2C,$36	; $1E
			dc.b	$32,$20,$40,$20,$3A,$3A,$28,$28,$2A,$34	; $28
			dc.b	$30,$32, $C,$10,$26,$26,$26,$26,$48,$48	; $32
			dc.b	$48,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A
		ORG $1E2D12	; 黃忠
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A	; 0
			dc.b	$40,$2A,$2A,$24,  0,$2A,  0,$2A,$28,$24	; $A
			dc.b	$28,$2A,$28,  0,$2A,$28,$28,$2A,$28,$20	; $14
			dc.b	$24, $C,$2A,$2A,$20,$32,$32,$2C,$2E,$36	; $1E
			dc.b	$3C,$34,$2C,$20,$38,$34,$32,$32,$38,$34	; $28
			dc.b	$30,$32, $C,$10,$2A,$2A,$2A,$2A,$48,$48	; $32
			dc.b	$48,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A
		ORG $1E2D76	; 馬超
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A	; 0
			dc.b	$20,$2A,$2A,$24,  0,$2A,  0,$2A,$28,$24	; $A
			dc.b	$28,$2A,$28,  0,$2A,$28,$28,$2A,$28,$20	; $14
			dc.b	$24, $C,$2A,$2A,$20,$36,$34,$2E,$28,$3E	; $1E
			dc.b	$1C,$1C,$28,$24,$36,$36,$2C,$2E,$28,$32	; $28
			dc.b	$50,$32, $C,$16,$40,$40,$46,$4E,$54,$54	; $32
			dc.b	$54,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A
		ORG $1E2DDA	; 孔明
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A	; 0
			dc.b	$20,$2A,$2A,$24,  0,$2A,  0,$28,$24,$20	; $A
			dc.b	$24,$28,$24,  0,$28,$24,$24,$28,$24,$20	; $14
			dc.b	$20, $C,$28,$28,$20,$30,$2C,$28,$2C,$2C	; $1E
			dc.b	$1E,$20,$24,$1E,$34,$34,$20,$28,$28,$30	; $28
			dc.b	$2A,$32,$40,$20,$24,$24,$24,$26,$48,$48	; $32
			dc.b	$48,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A
		ORG $1E2E3E	; 貂蟬
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A	; 0
			dc.b	$20,$2A,$2A,$24,  0,$2A,  0,$2A,$28,$24	; $A
			dc.b	$28,$2A,$28,  0,$2A,$28,$28,$2A,$28,$30	; $14
			dc.b	$24, $C,$2A,$2A,$20,$2C,$2C,$2E,$28,$3E	; $1E
			dc.b	$20,$20,$28,$20,$32,$30,$26,$30,$2A,$34	; $28
			dc.b	$30,$32,$14,$18,$2A,$2A,$2A,$2A,$48,$48	; $32
			dc.b	$48,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A
		ORG $1E2F06	; 龐統
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A	; 0
			dc.b	$20,$2A,$2A,$24,  0,$2A,  0,$2A,$24,$24	; $A
			dc.b	$24,$2A,$24,  0,$2A,$24,$24,$2A,$24,$20	; $14
			dc.b	$20, $C,$2A,$2A,$20,$30,$2C,$28,$2C,$2C	; $1E
			dc.b	$1E,$20,$24,$1E,$34,$34,$1E,$26,$28,$30	; $28
			dc.b	$2A,$32,$22,$44,$24,$24,$24,$26,$48,$48	; $32
			dc.b	$48,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A
		ORG $1E2F6A	; 孫權09
			dc.b	$40,$40,$40,$40,$40,$44,$40,  0,$40,$30	; 0
			dc.b	$40,$2A,$2A,$2A,  0,$2A,  0,$2A,$2A,$24	; $A
			dc.b	$28,$2E,$2A,  0,$30,$28,$28,$28,$28,$28	; $14
			dc.b	$2C,$14,$30,$30,$20,$38,$40,$28,$2E,$2A	; $1E
			dc.b	$3A,$3C,$48,$26,$38,$2C,$32,$32,$36,$34	; $28
			dc.b	$2E,$3A,$12,$12,$60,$60,$60,$58,$60,$60	; $32
			dc.b	$60,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $3C
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $46
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $50
			dc.b	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; $5A

	* 其他調整內容

		; 各角色各等級統一生命值
		ORG $1EB2C6	; 參考蓋世英雄
			dcb.b	110,(128)

		; 各屬性攻擊對我方的加成
		ORG $1E61EE	; [3]火屬性追加[60-40]
			dc.b 	$54,$60,$40,$58,$48,$58	; 關羽0(原50%-60,取消追加)
			dc.b 	$44,$60,$40,$58,$48,$58	; 張飛1(原50%)
			dc.b 	$48,$60,$40,$58,$48,$58	; 趙雲2(原50%)
			dc.b 	$48,$60,$40,$58,$48,$58	; 黃忠3(原50%)
			dc.b 	$48,$60,$40,$58,$48,$58	; 馬超4(原50%)
			dc.b 	$50,$60,$40,$58,$48,$58	; 孔明5(原50%)
			dc.b 	$48,$60,$40,$58,$48,$58	; 貂蟬6(原50%)
			dcb.b 	6,0
			dc.b 	$50,$60,$40,$58,$48,$58	; 龐統8(原50%)
			dc.b 	$60,$48,$30,$60,$48,$50	; 孫權9(原12.5%,降低至-37.5%)

		; 必殺技與超必殺取消限制
		ORG $12922C	; 更換武器取消封禁武將技
			bra.s   $129264

		ORG $129140	; 當前武將技之道具格取消封禁
			clr.w	d0
			bra.s   $12917E

		; 黃忠策略|火弓陣
		ORG $38D730	; 黃忠火弓陣之火箭取消判定
			dc.l	$00640C08,$00640C08,$00640C08,$00650D0C,$00650D0C

		; 黃忠必殺技|猛黃忠一箭雙雕
		ORG $26355E	; 0621動作|平射
			dc.l	off_2D8914	; 按住A鍵射出雙箭
		ORG $26353A	; 061F動作|上射
			dc.l	off_2D8C10	; 按住A鍵射出雙箭
		ORG $26354C	; 0620動作|下射
			dc.l	off_2D8F44	; 按住A鍵射出雙箭
		ORG $1C623E	; 天火雙煞弓落於地面時的色表編號#5|123CDA
			dc.b	4,$5	; A0014A
		ORG $1C8428	; 天火雙煞弓於道具格上的色表編號#5|128966
			dc.b	$5,6	; A0014A

		; 馬超落石計優先判定敵將
		ORG $121B82
			jsr		sub_121B82
			jmp		(a0)

		; 孔明魔法|落雷術
		ORG $122380	; 一定時間的主循環內使用指令[落雷術]會導致佔用有效堆棧
			move.l	d0,-4(a6)	; $100EA4

		; 武器攻擊力表
		ORG $1E63BA
			dc.b	$40,$40,$58,$70	; 默認四十;大砍刀40;青龍偃月刀58;方天畫戟70/75%
			dc.b	$40,$60			; 蛇矛40;丈八蛇矛60
			dc.b	$40,$58			; 長槍40;紅纓梨花槍58/37%
			dc.b	$40,$40,$60,$80	; 長弓40;毒龍鐵胎弓40;猛虎劈山弓60/50%;天火雙煞弓80/100%
			dc.b	$40,$60,$80,$60	; 長劍40;倚天劍60/50%;青釭劍80/100%;玄鐵鴛鴦簡60
			dc.b	$80,$60			; 五火神焰扇80/100%;天罡劈水扇60
			dc.b	$40,$58,$60		; 匕首40;血匕首58;飛天虎爪60
			dc.b	$40,$50,$80		; 彎刀40;吳鈎50;巫刀80/100%/75%
			dc.b	$40,$34			; 長槊40;盤龍三節棍34/-18%

		; 武器屬性
		ORG $1E61D6	; 巫刀增加電屬性|取消攻擊阻力|非一般普攻
			dc.b	$10,0,$40,0
		ORG $1E613A	; 普通攻擊三式
			dc.b	0,0,0,1

		ORG $1E61AE	; 倚天劍取消攻擊阻力|非一般普攻
			dc.b	1,0,$60,0
		ORG $157D8A	; 倚天劍普攻三式[1]
			jsr		sub_157D8A
		ORG $15AA1E	; 倚天劍普攻三式[2]
			jsr		sub_15AA1E
		ORG $15AB88	; 倚天劍普攻三式[3]
			jsr		sub_15AA1E
		ORG $160E02	; 倚天劍普攻三式[4]
			jsr		sub_160E02

		; 對敵增加更多擊飛動作
		ORG $11B168	; 趙雲普攻四擊接梨花刺可使敵人反向浮空
			jsr		sub_122E82
			bra.s	$11B1B2
		ORG $25EDC2+$4	; 趙雲大鵬展翅對敵受擊動作|低浮空
			dc.l	$F0450200

		; 關羽、張飛部分動作缺失方天畫戟圖片|0015D32A
		ORG $32E842	; 關羽回風掃葉動作[C3-CD]方天畫戟與偃月刀同圖片
			dc.l	$0003F73B,$08220000,$0003F7C7,$06240000
			dc.l	$0003F837,$081E0000,$0003F8B3,$081C0000
			dc.l	$0003F927,$06270000,$0003F9A0,$0A1C0000
			dc.l	$0003FA30,$0A120000,$0003FA8E,$0A110000
			dc.l	$0003FAE7,$08170000,$0003FB47,$08220000
		ORG $32E97A	; 關羽狂龍逆轉動作[EA-106]方天畫戟與偃月刀同圖片
			dc.l	$0003FDD6,$0A170000,$0003FE4D,$06270000
			dc.l	$0003FE4D,$06270000,$0003FEC6,$08190000
			dc.l	$0003FEC6,$08190000,$0003FF2E,$06170000
			dc.l	$0003FF2E,$06170000,$0003FF77,$06240000
			dc.l	$0003FF77,$06240000,$0003FFE7,$08230000
			dc.l	$0003FFE7,$08230000,$00040077,$081B0000
			dc.l	$00040077,$081B0000,$000400E7,$0A1C0000
			dc.l	$000400E7,$0A1C0000,$00040177,$08170000
			dc.l	$00040177,$08170000,$000401D7,$0A100000
			dc.l	$000401D7,$0A100000,$0004022B,$081C0000
			dc.l	$0004022B,$081C0000,$0004029F,$08190000
			dc.l	$0004029F,$08190000,$00040307,$081A0000
			dc.l	$00040307,$081A0000,$00040373,$081B0000
			dc.l	$000403E3,$08190000,$0004044B,$061F0000
			dc.l	$000404AC,$08180000
		ORG $32E932	; 關羽狂龍旋舞動作[E1-E8]方天畫戟與偃月刀同圖片
			dc.l	$0003FC3B,$06260000,$0003FCB1,$0A140000
			dc.l	$0003FD19,$060B0000,$0003FD19,$060B0000
			dc.l	$0003FD3E,$08100000,$0003FD3E,$08100000
			dc.l	$0003FD82,$08140000,$0003FD82,$08140000

		ORG $33188A	; 張飛神龍擺尾動作[D6-E0]方天畫戟與蛇矛同圖片
			dc.l	$0002D15B,$060F0000,$0002D15B,$060F0000
			dc.l	$0002D18C,$080A0000,$0002D1B8,$060E0000
			dc.l	$0002D1E6,$08150000,$0002D23E,$06160000
			dc.l	$0002D284,$060F0000,$0002D2B5,$08090000
			dc.l	$0002D2DD,$080B0000,$0002D30D,$080E0000
			dc.l	$0002D349,$080D0000
		ORG $331962	; 張飛火牛撼地動作[F1-F7]方天畫戟與蛇矛同圖片
			dc.l	$0002D381,$04240000,$0002D3CD,$06170000
			dc.l	$0002D416,$06170000,$0002D45F,$06110000
			dc.l	$0002D496,$06140000,$0002D4D6,$06140000
			dc.l	$0002D516,$080B0000
		ORG $331A8A	; 張飛手接蛇矛動作[116]方天畫戟與蛇矛同圖片
		dc.l	$0002D546,$080E0000

		* sub_114228	; 各角色新增超必殺技[破招][1]
		* sub_11B520	; 各角色新增超必殺技[破招][2]

		ORG $157C66	; 反身格擋
			jsr		sub_16A792
			jsr		(a0)

; =============== 換將調整 ==================================================

	* 进场退场

		ORG $1C2BC4	; 援军进场退场动作对敌的受击动作
			dc.w	$0700	; 解除41限制|重置Hit累计
			dc.l	dword_1C2BC0,$01000000,0,0

		ORG $15F93E	; 強制召回援軍
			cmpi.w  #$2, ($50,A2)	; 是否02類動作[立地狀態?]
			bne.s	$15F954
			move.l  A2, -(A7)
			bsr.w   $15e6e8
			addq.l  #4, A7
			tst.l   D0				; 是否跳躍狀態?
			bne.s   $15f976
			bra.s	$15F96A			; 正常收將
			cmpi.w  #$8, ($50,A2)	; $15F954
			bne.s	$15f976			; 是否08類動作[浮空狀態?]
			cmpi.w  #$8, ($6c,A2)	; 判斷生命值是否大於8
			bls.s	$15f976
			jsr		sub_15F93E		; 强制收將減少8個生命值
			jsr		sub_15F952		; $15F96A 召回援軍
			bra.s	$15f976

		ORG $157FCC	; 突行不可取消援軍召回|空中不可突行代之速降
			btst	#5, $1C(A3)
			bne.w	$1581C2			; 是否方向下
			jsr		sub_157FCC		; 援軍換回動作中限制援軍突行
			bra.s	$157FE0

	* 援軍格擋

		ORG $112FB4	; 特殊情況暈眩屬性設定
			jsr		sub_112FB4

		ORG $14B996
			jsr		sub_14B996	; 換將狀態C鍵判斷
			bra.w	$14BA64

		ORG $157CCE
			jsr		sub_157CCE	; 判斷6C格擋指令
			tst.l 	d0
			beq.s   $157D0A		; 非AB非6C則繼續判斷
			bne.w	$1581CA

		* ORG $1618EC	; 換將格擋后做反擊判斷
		* 	bne.w   $161958

	* 援軍動作

		* 夏侯惇
			ORG $20FCB2	; 02類動作指針
				dc.l	off_2119C4

			ORG $20FCC2	; 06類動作指針
				dc.l	off_2137CA

			ORG $212FCA	; [0300]普攻一式
				dc.l	$F0540300
			ORG $21300A	; [0301]普攻二式
				dc.l	$F0540200
			ORG $21321A	; 030D格擋反擊
				dc.l	off_210632,$01002040,0,0

			ORG $169464	; 發射三顆金珠
				moveq	#3,d4
			ORG $169510	; 疾風金珠敵我判定
				move.w  #3,$6C(a3)
			ORG $2B5A44	; 疾風三珠相對坐標
				dc.l	$0000005B,$00000000,$FFFFFFE2
				dc.l	$00000044,$00000000,$FFFFFFEC
				dc.l	$00000044,$00000000,$FFFFFFD8

		* 張郃
			ORG $21C178	; 02類動作指針
				dc.l	off_21E70C

			ORG $2215A6
				dc.w	$0300	; 普攻一式
				dc.l	dword_2214F2,$01001240,0,0
				dc.w	$0301	; 普攻二式|鷹揚猛襲
				dc.l	$002216A2,$01001240,0,0
			ORG $221692	; 030D格擋反擊
				dc.l	dword_21F116,$02000240,0,0

			ORG $21C188	; 06類動作指針
				dc.l	off_222272

			ORG $221D5A	; 乾坤火輪|硬漢
				dc.l	$F05E0100

		* 甘寧
			ORG $2259E6	; 02類動作指針
				dc.l	off_22829C

			ORG $2259F6	; 06類動作指針
				dc.l	off_229EAA

			ORG $22968A	; 030D格擋反擊
				dc.l	off_228BF2,$02000040,0,0

			ORG $2295B2	; 0301[反向橫飛]普通攻擊可取消
				dc.l	off_26214E,$01001040,0,0

			ORG $16B4D2	; 後發制人
				pea		(off_22895A).l  ; 轉身用弓弩射出的箭矢
			ORG $16B4E8	; 敵我判定
				move.w  #3,$6C(a3)

		* 牛金
			ORG $2140E8	; 02類動作指針
				dc.l	off_215FDA

			ORG $2140F8	; 06類動作指針
				dc.l	off_21761C

			ORG $216CE4	; [0300]普攻一式
				dc.l	$F0540400
			ORG $216DCC	; [0301]普攻二式
				dc.l	$F0540200
			ORG $217028	; 030D格擋反擊
				dc.l	off_214E20,$02000240,0,0

		* 徐晃
			ORG $235846	; 02類動作指針
				dc.l	off_237442

			ORG $235856	; 06類動作指針
				dc.l	off_23AB7E

			ORG $23A842	; 030D格擋反擊[一斧劈树]
				dc.l	off_237E74,$01000000,0,0

			ORG $237E44	; [突撞]收尾無敵
				dc.l	$F0130100

		* 夏侯淵
			* 偽連四招一式|sub_11B256

			ORG $20B8A0	; 02類動作指針
				dc.l	off_20E262

			ORG $20E90E	; [0300]普攻一式
				dc.l	$F0540200
			ORG $20E946	; [0301]普攻二式
				dc.l	$F0540300
			ORG $20EC32	; 030D格擋反擊
				dc.l	off_20D4C6,$01001240,0,0

			ORG $20F3E2
				dc.w	$0600	; [橫掃千軍]爆屬性
				dc.l	off_20D332,$01002240,0,0
				dc.w	$0601	; [畫地爲牢]硬漢
				dc.l	off_20EA1A,$01001240,0,0

			ORG $20F3CA	; [翻天覆地]取消後搖
				dc.l	$80000000

		* 程昱
			ORG $2054C2	; 02類動作指針
				dc.l	off_206A52

			ORG $208082	; 0309挑釁動作
				dc.l	$002078D4,$01001040,0,0
			ORG $2080CA	; 030D格擋反擊
				dc.l	off_2081B2,$01001040,0,0

			ORG $2054D2	; 06類動作指針
				dc.l	off_2085A0

		* 曹操
			ORG $1FD53A	; 02類動作指針
				dc.l	off_1FEA26

			ORG $200DE6	; [0300]普攻一式
				dc.l	$F0540300
			ORG $200EF2	; [0301]普攻二式
				dc.l	$F0540300
			ORG $2010DE	; 030D格擋反擊
				dc.l	off_1FF800,$01002040,0,0
			ORG $1FCD8C	; [0817]格擋圖片編號|$15ADAE
				dc.w	$001E,$004A

			ORG $1FD54A	; 06類動作指針
				dc.l	off_2017D2

		* 周泰
			ORG $22A758	; 02類動作指針
				dc.l	off_22D636

			ORG $22DCEA	; [0300]普攻一式
				dc.l	$F0540400
			ORG $22E022	; 030D格擋反擊
				dc.l	off_22B982,$01001040,0,0

			ORG $22E2AE+$34	; [滿腔怒火]修正傷害
				dc.l	$F015FE00,off_22B04A

			ORG $0022DBF2	; 援軍周泰出場台詞「來人，毀橋！」
				dc.l	$F00BFF00,$01790000

		* 呂布
			ORG $23B44E	; 02類動作指針
				dc.l	off_23C1CE

			ORG $23B45E	; 06類動作指針
				dc.l	off_23E802

			ORG $23ACEE	; [0817]格擋圖片編號|$15ADAE
				dc.w	$0000,$004B
			ORG $23E1CE	; 030D格擋反擊
				dc.l	off_23C694,$01002240,0,0

		* 許褚
			ORG $217EB8	; 02類動作指針
				dc.l	off_21A1DA

			ORG $217EC8	; 06類動作指針
				dc.l	off_21B8D4

			ORG $21778C	; 0817格擋圖片編號
				dc.w	$001D,$0021
			ORG $21B18C	; 030D格擋反擊|無敵01002[8]40
				dc.l	off_219060,$01002840,0,0

			ORG $21B0A0
				dc.w	$0300	; 普攻一式
				dc.l	off_21AF34,$01002040,0,0
				dc.w	$0301	; 普攻二式|攻擊力$22
				dc.l	off_219060,$01002040,0,0

			ORG $21B608	; 0603泰山壓頂[全程霸體]
				dc.l	$F05E0100
			ORG $21B7A0
				dc.l	$F05E0100

	* 招式傷害

		ORG $15F224	; 援軍普攻攻擊力表|03類動作
			moveq	#0,d0
			move.b	1(a3),d0	; 援軍編號
			subi.l	#$B,d0		; 曹操0B始<
			mulu.w	#$E,d0		; 每$E一援
			moveq	#0,d1
			move.w	$52(a2),d1
			add.l	d1,d0
			movea.l	#byte_1E84AA,a0
			bra.w	$15F31E

		ORG $15F46E	; 援軍道具攻擊力表|03類
			moveq	#0,d0
			move.b	1(a3),d0	; 援軍編號
			subi.l	#$B,d0		; 曹操0B始<
			mulu.w	#$E,d0		; 每$E一援
			add.l	d3,d0
			movea.l	#byte_1E84AA,a0
			bra.w	$15F584

		ORG $15F202	; 援軍必殺攻擊力表|06類動作
			moveq	#0,d0
			move.b	1(a3),d0	; 援軍編號
			subi.l	#$B,d0		; 曹操0B始<
			mulu.w	#8,d0		; 每$8一援
			moveq	#0,d1
			move.w	$52(a2),d1
			add.l	d1,d0
			movea.l	#byte_1E8672,a0
			bra.w	$15F31E

		ORG $15F452	; 援軍道具攻擊力表|06類
			moveq	#0,d0
			move.b	1(a3),d0	; 援軍編號
			subi.l	#$B,d0		; 曹操0B始<
			mulu.w	#8,d0		; 每$8一援
			add.l	d3,d0
			movea.l	#byte_1E8672,a0
			bra.w	$15F584

		; 援軍對各敵人的攻擊力追加 $40=100%|$15F328
		ORG $1E3032	; 曹操0B
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   0,   $2F, $40, 0,   $38, 0,   $40, $50, $32	; $A
			dc.b	$30, $40, $30, 0,   $40, $34, $34, $34, $30, $32	; $14
			dc.b	$2F, $2A, $2C, $50, $2A, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0
		
		ORG $1E30FA	; 程昱0D
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $3A, $2F, 0,   0,   $2F, 0,   $40, $40, $38	; $A
			dc.b	$38, $40, $40, 0,   $40, $40, $40, $40, $3A, $48	; $14
			dc.b	$40, $40, $50, $40, $40, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E328A	; 夏侯淵11
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $2A, $2F, $30, 0,   $2F, 0,   0,   $34, $28	; $A
			dc.b	$38, $2C, $2C, 0,   $40, $30, $30, $30, $2F, $30	; $14
			dc.b	$30, $1C, $24, $30, $28, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E32EE	; 夏侯惇12
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $2F, $2A, $2A, 0,   $30, 0,   $2A, 0,   $18	; $A
			dc.b	$2F, $2F, $2A, 0,   $2F, $2F, $2F, $2F, $2F, $18	; $14
			dc.b	$2A, $18, $2A, $2A, $30, $60, $60, $60, $60, $60	; $1E
			dc.b	$40, $40, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E3352	; 牛金13
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $26, $2A, $2A, 0,   $2F, 0,   $2A, $40, 0		; $A
			dc.b	$30, $40, $30, 0,   $2F, $30, $30, $30, $40, $28	; $14
			dc.b	$28, $18, $2A, $32, $30, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E33B6	; 許褚14
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $30, $2F, $50, 0,   $2F, 0,   $40, $50, $38	; $A
			dc.b	0,   $40, $30, 0,   $40, $34, $30, $38, $30, $C		; $14
			dc.b	$30, $30, $30, $28, $2F, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E341A	; 張郃15
			dc.b	$40, $3A, $40, $40, $40, $48, $48, 0,   $48, $34	; 0
			dc.b	0,   $30, $34, $40, 0,   $2F, 0,   $30, $40, $2A	; $A
			dc.b	$2A, 0,   $34, 0,   $30, $30, $28, $30, $50, $20	; $14
			dc.b	$30, $1C, $30, $40, $34, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E3546	; 甘寧18
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $30, $2F, $34, 0,   $2F, 0,   $40, $40, $20	; $A
			dc.b	$38, $40, $34, 0,   0,   $34, $34, $34, $40, $30	; $14
			dc.b	$34, $2F, $34, $40, $38, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E35AA	; 周泰19
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $30, $2F, $40, 0,   $2F, 0,   $40, $40, $38	; $A
			dc.b	$38, $40, $40, 0,   $40, 0,   $40, $40, $34, $30	; $14
			dc.b	$40, $2F, $40, $40, $40, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E36D6	; 徐晃1C
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $36, $2F, $40, 0,   $2F, 0,   $40, $30, $30	; $A
			dc.b	$34, $40, $40, 0,   $40, $34, $34, $40, 0,   $32	; $14
			dc.b	$38, $2A, $40, $50, $40, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

		ORG $1E373A	; 呂布1D
			dc.b	$40, $3A, $40, $40, $40, $48, $40, 0,   $48, $34	; 0
			dc.b	0,   $30, $2F, $40, 0,   $2F, 0,   $30, $2F, $30	; $A
			dc.b	$48, $2F, $30, 0,   $30, $2A, $40, $40, $30, 0  	; $14
			dc.b	$40, $2A, $40, $58, $40, $60, $60, $60, $60, $60	; $1E
			dc.b	$60, $60, $60, $60, $60, $60, $60, $60, $60, $60	; $28
			dc.b	$60, $60, $FF, $FF, $60, $60, $60, $60, $60, $60	; $32
			dc.b	$60
			dcb.b	$27,0

; =============== 道具調整 ==================================================
	
	* 角色道具上限

		ORG $2ABCB8	; 各角色各道具限數指針總表[等級 0~4|$6B 5-9|$D6 10-14|$141 15-19|$1AC 20-24|$217]
			dc.l	byte_1C6470,byte_1C66F2,byte_1C6974,byte_1C6BF6,byte_1C6E78
			dc.l	byte_1C70FA,byte_1C737C,0,          byte_1C75FE,byte_1C7880

		ORG $125DFE	; 全角色[勛章]換[薤葉芸香]
			move.b  #$4F,$2B(a2)
		ORG $125E20	; [孔明]出場自帶[木牛*1]
			move.b  #$52,$2F(a2)
			move.b  #1,$30(a2)

		ORG $1C7B38	; [關羽]出場道具
			dc.l	$02220400,$02240400,$02010400,$02020100,$02030100,$02120100,$00000000,$00000000
		ORG $1C7B58	; [張飛]出場道具
			dc.l	$02220600,$02240100,$02010400,$02020400,$02030100,$02040100,$02050100,$00000000
		ORG $1C7B78	; [趙雲]出場道具
			dc.l	$02220400,$02230100,$02010400,$02020100,$02030100,$02100400,$00000000,$00000000
		ORG $1C7B98	; [黃忠]出場道具
			dc.l	$02250400,$02240400,$02230100,$02010400,$02020100,$02030100,$02110400,$00000000
		ORG $1C7BB8	; [馬超]出場道具
			dc.l	$02230100,$02240400,$02010400,$02020100,$020D0100,$020E0100,$02120400,$00000000
		ORG $1C7BD8	; [孔明]出場道具
			dc.l	$03060000,$020A0400,$020F0400,$02130100,$02140200,$02160100,$00000000,$00000000
		ORG $1C7BF8	; [貂蟬]出場道具
			dc.l	$02230400,$02240100,$02010300,$02020100,$02030100,$02040100,$03080000,$020B0300
		ORG $1C7C18	; [龐統]出場道具
			dc.l	$02240400,$02090400,$020A0100,$020B0100,$030C0000,$020E0100,$02150100,$00000000
		ORG $1C7C38	; [孫權]出場道具
			dc.l	$02230400,$02010400,$02020100,$02030100,$02100400,$00000000,$00000000,$00000000

	* 物品地面動作

		; 敵人掉落的道具|掉物$123B96|丟出道具、道具落回$123D26
		ORG $1C5FF0	; 一般道具|02~4F,-03,-05
			dc.w	$F028,$1200
		ORG $1C6154	; 魔法補充品|03
			dc.w	$F028,$FF00
		ORG $1C60A4	; 超殺補充品|05
			dc.w	$F028,$FF00

		; 敵人掉落的補給|掉物$11C1CA|爆物$11C2DC
		ORG $1C12BE	; 一般補給|81,85~87|冒熱氣的即食補給
			dc.w	$F028,$FF00
		ORG $1C1766	; 包子堆|81
			dc.l	dword_1C135E
		ORG $1C16F2	; 包子|82
			dc.l	dword_1C135E
		ORG $1C17DA	; 粽子堆|84
			dc.l	dword_1C135E
		ORG $1C1EA6	; 即食靈芝|93
			dc.l	dword_1C135E

		; 其他掉落的道具|爆物$123EBC|障礙$124192
		ORG $1C63D0	; 敵人丟出的道具
			dc.w	$F028,$1200
		ORG $1C6400	; 障碍物上的道具
			dc.w	$F028,$1200
		* ORG $1C1536	; 長坂坡阿斗|92
		* 	dc.w	$F028,$FF00
		* ORG $1C6368	; 角色丟出的道具
		* 	dc.w	$F028,$FF00

	* 道具存放規則

		ORG $1245F6	; 特殊技補充品增目
			jsr		sub_1245F6
			jmp		(a0)

		ORG $1260D8	; 投擲道具、援軍令、B面道具 划為一類
			bra.s	$1260E0

		ORG $12615A	; 道具存放規則|除防具外
			cmpi.b  #$2, D4
			beq.w	$126540		; 是否防具
			jsr		sub_12615A	; 存放規則|包含七星燈
			bra.w	$12666a

	* 道具丟出規則

		ORG $126E46	; A面之援軍令、B面道具 可寫丟出動作
			cmpi.b  #$17, ($1,A5)
			bcs     $126ee4
			cmpi.b  #$53, ($1,A5)

		ORG $12668C	; 判斷丟出道具所在面
			jsr		sub_12668C
			bra.s	$12669E

		ORG $12671A
			cmpi.b  #$16, D6
			bhi.s   $126726
			move.b  #$1, (A2)
			bra.s   $12676C	; (特殊技丟出后)保留道具信息,標記禁止符號
			clr.l   (a2)	; A面丟出時清空 當前道具格信息
			bra.s   $12676C

		ORG $126742	; B面丟出/替換時，第八格清空值不搬運
			jsr		sub_126742

		ORG $126DEE	; B面丟出道具數目 可為0
			bra.s	$126DF4
		ORG $126E3E	; A面丟出道具數目 可為0
			bra.s	$126E46
		ORG $1266E4	; 當前道具格目為0時可丟出(非特殊技)
			jsr		sub_1266E4
			cmp.l   D6, D0
			bne     $126778
			cmpi.b	#$16, D6
			bgt.w	$126700

		ORG $126D4C	; AC組合鍵 寫入丟出道具動作
			jsr		sub_126D4C

		ORG $126E72	; AC組合鍵 丟出A面道具*1/0
			jsr		sub_126E72

		ORG $126E0C	; AC組合鍵 丟出B面道具*1/0
			jsr		sub_126E72

	* 道具使用規則

		* 通用規則
			; 各場景策略魔法可否使用表|$2ABD30
			ORG $129296	; 策略取消场景限制
				move.w	#0,d0
			ORG $129270	; 魔法取消场景限制
				move.w	#0,d0
			ORG $12933A	; 道具欄道具皆標記可用
				bra.s	$129344
			ORG $129314	; 0701前庭限制使用水攻計|敵將不在場限制使用恐嚇計
				jsr		sub_129314
				jmp		(a0)

			ORG $126898
				cmpi.b  #$25, D2
				bhi.s   $1268A4
				move.b  #$1, (A2)
				bra.s   $1268A6	; (特殊技/援軍令/投擲道具用完后)保留道具信息,標記禁止符號
				clr.l   (a2)	; (道具用完后)置零
				tst.b   D3		; $1268aa:原代碼,是否B面道具則減格目
				beq.s   $126908
				tst.b   ($1,A2)
				bne.w	$126908	; B面非空格則只標記不減格目(.w占位)

			ORG $1268E6	; (B面當前道具用完后)搬運時外格置零
				bge.s   $1268CE

			ORG $1268CE	; (B面當前道具用完后搬運時)下格為防具則置零
				jsr		sub_1268CE

			ORG $11D2BA	; 策略與魔法無冷卻時間(除 八陣圖/神將術)
				jsr		sub_11D2BA
				NOP

			ORG $120E14	; 孔明八陣圖無法耗氣
				beq.s	$120E54
			ORG $15FB46	; 貂蟬LV1蝶舞時間2/3
				move.w	#$2D0,$16E(a2)
			ORG $12004C	; 龐統恐嚇計無法耗氣
				bra.s	$120062		

		* 木牛流馬
			ORG $121994	; 補充生命值60點
				move.b	#60, $80C3ED.l

			ORG $121150	; 木牛生命值補充剩餘值$80C3ED為負則結束
				bmi.w	$1214DA

			ORG $121452	; 木牛每次補充三個生命值
				move.l	d1,-(sp)	; 角色的生命值上限
				jsr		sub_121452
				addq.l	#4,sp
				bra.s	$12146A

			ORG $1212EC	; 增加道具兩個數目
				jsr		sub_1212EC	; 增一目
				jsr		sub_1212EC	; 增二目
				bra.s	$12134A
			ORG $121360	; 取消原版投擲道具的補充
				bra.w	$121408


		* 威靈仙
			ORG $12043C	; 增加100個生命值
				pea		(100).w

			ORG $120500	; "BLOOD UP 100"
				pea		(aBloodUp).l


		* 薤葉芸香
			ORG $1C2ABE	; 薤葉芸香使用效果
				dc.l	sub_1205D0

			ORG $194BFA	; 040F連環船2 勛章換薤葉芸香
				move.w  #$3E,$DE(a2)
			ORG $195ED2	; 0410東吳船艙左密室
				move.w  #$3E,$DE(a2)
			ORG $2AAE08	; 0707下水道密室
				dc.w 	$3E
			ORG $1A3FF8	; 0506葫蘆口山洞2
				move.w  #$3E,$DE(a2)
			ORG $1A6068	; 0507北彝陵密道右
				move.w  #$3E,$DE(a2)
			ORG $18D028	; 0411東吳船艙右密室
				pea     $3E.w

		* 援軍令
			ORG $124488	; AB兩面皆可增目
				jsr		sub_124488
				tst.b	D2
				beq		$12455C		; 無法撿起
				bra		$12462C		; 撿取或者加分

		* 投擲道具

			* 傷害表byte_1E6824[0601~0604]

			; 金珠
			ORG $11C946
				moveq   #0,d2	; 后先順序
				tst.w   d0
				bne.s   $11C9C6	; (金珠)無氣為 原滿氣效果
			ORG $11CA84
				moveq   #6,d0	; 滿氣為 原無氣+滿氣效果
			ORG $11CA18
				jsr		sub_11CA18	; 增加新滿氣判定範圍
				addq.l  #1,d2
				moveq   #5,d0
				cmp.l   d2,d0	; 循環5次傷害
				bgt.s   $11C9C6
				bra.s	$11CA2C

			; 燃燒彈
			ORG $1C2266	; 滿士氣五顆燃燒彈
				dc.l	off_1C20E2
			ORG $11CAE6	; 不滿士氣三顆燃燒彈
				move.l	#$1C20E2,$2C(a2)
			ORG $11EB10	; 燃燒彈落地火球
				pea		(off_1E22B4).l

			ORG $1392BA	; 燃燒彈可以炸開鐵盒
				jsr		sub_1392BA
				jmp		(a0)

			; 煙霧彈
			ORG $1C2502	; (烟霧彈)不滿士氣3顆
				dc.l	$1C2466
			ORG $11CB7E	; 5顆烟霧彈
				move.l  #off_1C240A,$2C(a2)

			; 鐵蓮花
			ORG $11CBC2	; (鉄蓮花)不滿士氣同樣彈起
				bne.w	$11CC5C

		* 四大神器

			ORG $1C2A8E	; 道具欄中四神器指針
				dc.l	sub_129CA4,sub_129D82,sub_129CCA,sub_129CB6

			ORG $11D24E	; 同一神器不可重複使用
				jsr		sub_11D24E
				jmp		(a0)

			; 青龍神器
			ORG $11D2FC	; 道具欄裡使用策略魔法不減目
				jsr		sub_11D2FC
			ORG $126B42	; 道具欄裡使用超必殺技不減目
				jsr		sub_126B42
				lea		$C(sp),sp
			* loc_157A88	; 指令使用超必殺技不減目
			* ORG $11EA3A	; 滿士氣效果且不消耗士氣

			; 白虎神器
			* loc_11B2F9	; 普攻必殺攻擊力追加且暴擊
			* sub_11B256	; 偽連

			; 朱雀神器
			ORG $12F82C	; 擊殺敵兵掉落隨機物品
				jsr		sub_12F82C
				jmp		(a0)
			ORG $12EDE8	; 撞擊敵人掉落隨機物品
				jsr		sub_12EDE8
				jmp		(a0)

			; 玄武神器
			ORG $10EFDA	; 敵人延時刷新動作
				jsr		sub_10EFDA
				bra.s	$10EFE6

			ORG $15ED28	; 最強防御|抑傷為一
				jsr		sub_15ED28
			* loc_1135D7	; 免疫屬性攻擊|效果

			ORG $114228	; 取消四招一式限制|策略
				jsr		sub_114228
			ORG $118DD0	; 取消四招一式限制|魔法
				jsr		sub_114228
			ORG $11B520	; 取消四招一式限制|本攻
				jsr		sub_11B520

			ORG $15F1E2	; 高 Hits 降低減傷[1]
				jsr		sub_15F1E2
			ORG $15F27E	; 高 Hits 降低減傷[2]
				jsr		sub_15F1E2
			ORG $15F434	; 高 Hits 降低減傷[3]
				jsr		sub_15F1E2
			ORG $15F4EC	; 高 Hits 降低減傷[4]
				jsr		sub_15F1E2

			; 施放動作
			ORG $26E8C2	; 孔明施放技能時先調用道具再出現必殺閃光
				dc.l	$F00B8F00,$02870000
				dc.l	$F01A0000,$003C00D0,$00B20000
				dc.l	$F0140334,$001600AD

			ORG $2733BA	; 貂蟬施放技能時先調用道具再出現必殺閃光
				dc.l	$F00B8F00,$028A0000
				dc.l	$F01A0000,$003000D0,$010B0000
				dc.l	$F0140338,$000400A3

			ORG $2788AE	; 龐統施放技能時先調用道具再出現必殺閃光
				dc.l	$F00B8F00,$02890000
				dc.l	$F01A0000,$003500D4,$00700000
				dc.l	$F0140335,$000800B9

			ORG $27E38A	; 孫權施放技能時先調用道具再出現必殺閃光
				dc.l	$F00B8F00,$02890000
				dc.l	$F0130100
				dc.l	$F01A0000,$004500D4,$00EE0000
				dc.l	$F0130000
				dc.l	$F0140335,$000800B9

	* 防具系統調整

		ORG $1E6146	; 防具屬性表：不防禦值、火|毒|混亂|木|電|暈|爆|冰、防盜否[80]、結束符[00]

		* ORG $1C85B4 ; 道具欄雙道具時圖片橫縱坐標
		* 	dc.w	$FFE8,$FFA4,$0010,$FFA4

		ORG $12654C	; 分位裝備寶甲寶衣
			jsr		sub_12654C
			jmp		(a0)

		ORG $126D8A	; 分位清除寶甲寶衣
			jsr		sub_126D8A
			dcb.w	2,$4E71	; NOP佔位

		ORG $127062	; 打開防具頁時打印疊甲防禦值
			jsr		sub_127062

		* 計算裝備防具屬性
			ORG $1135CC	; 計算裝備防具屬性[1]|降將狀態防禦有效
				move.l	a2,-(sp)
				jsr		sub_1135D6	; 計算隨機值
				addq.l	#4,sp
				movea.l	a0,a4
				move.l	d0,d4
				bra.s	$1135CC+$26
			ORG $113898	; 計算裝備防具屬性[2]|降將狀態防禦有效
				move.l	a3,-(sp)
				jsr		sub_1135D6	; 計算隨機值
				addq.l	#4,sp
				movea.l	a0,a4
				move.l	d0,d5
				bra.s	$113898+$22
			ORG $1146B2	; 計算裝備防具屬性[3]|降將狀態防禦有效
				move.l	a2,-(sp)
				jsr		sub_1135D6	; 計算隨機值
				addq.l	#4,sp
				movea.l	a0,a4
				move.l	d0,d7
				bra.s	$1146B2+$26
			ORG $114AC6	; 計算裝備防具屬性[4]|降將狀態防禦有效
				move.l	a2,-(sp)
				jsr		sub_1135D6	; 計算隨機值
				addq.l	#4,sp
				movea.l	a0,a4
				move.l	d0,d7
				bra.s	$114AC6+$22
			ORG $116A10	; 計算裝備防具屬性[5]|降將狀態防禦有效
				move.l	a3,-(sp)
				jsr		sub_1135D6	; 計算隨機值
				addq.l	#4,sp
				movea.l	a0,a5
				move.l	d0,d6
				bra.s	$116A10+$22
			ORG $116DA2	; 計算裝備防具屬性[6]|降將狀態防禦有效
				move.l	a3,-(sp)
				jsr		sub_1135D6	; 計算隨機值
				addq.l	#4,sp
				movea.l	a0,a5
				move.l	d0,d6
				bra.s	$116DA2+$22


		* 疊甲合成特殊效果
			ORG $15BDB4		; 青銅太平養生甲
				jsr		sub_15BDB4
				NOP

			ORG $10FC68		; 青銅於吉浴血甲
				jsr		sub_10FC68
				NOP
			* loc_10FAE2	; 青銅於吉浴血甲|傷將回血

			ORG $114618		; 青銅魚鱗強襲甲|本體霸體
				jsr		sub_114618
				jmp		(a0)
			ORG $11A604		; 青銅魚鱗強襲甲|破敵硬漢
				jsr		sub_11A604
				jmp		(a0)
			ORG $11A888		; 青銅魚鱗強襲甲|破敵格擋
				jsr		sub_11A888	; 最大隨機值>格擋閾值

			ORG $1151E6		; 鎖子魚鱗逆鱗甲
				jsr		sub_1151E6
			* loc_114618	; 鎖子魚鱗反刃甲

			ORG $11B2F8		; 鎖子於吉巨靈甲
				jsr		sub_11B2F8	; 03|06類本體判定

			ORG $10FAE2		; 明光天師獻祭甲
				jsr		sub_10FAE2

			ORG $11C716		; 明光魚鱗吞食甲[1|即食補給]
				jsr		sub_14DA4A
			ORG $120440		; 明光魚鱗吞食甲[2|攜帶補給]
				jsr		sub_14DA4A
			* loc_121453	; 明光魚鱗吞食甲[3|被動補給]
			ORG $11C572		; 明光魚鱗吞食甲[4|金銀財寶]
				jsr		sub_11C572
			ORG $11C706		; 明光魚鱗吞食甲[4|金銀財寶]
				jsr		sub_11C572
			* sub_1205D0	; 明光魚鱗吞食甲[5|薤葉芸香]

			ORG $1464CA		; 鎖子天師磨礪甲|重置
				jsr		sub_1464CA
			* loc_114619	; 鎖子天師磨礪甲|記錄|本體判定
			ORG $11679C		; 鎖子天師磨礪甲|記錄|機關判定
				jsr		sub_11679C
			* loc_1135DA	; 鎖子天師磨礪甲|計算

			ORG $15ED44		; 鎖子太平靈識甲|回光
				jsr		sub_15ED44
				bra.s	$15ED52
			ORG $15D7E8		; 鎖子太平靈識甲|返照
				jsr		sub_1096A8
			* sub_114D3C	; 鎖子太平靈識甲|護主
			* loc_15ED28	; 鎖子太平靈識甲|免疫

			ORG $15AE48		; 青銅天師飛將甲|左跑加速
				jsr		sub_15AE48
				bra.w	$15AF06
			ORG $15AEB8		; 青銅天師飛將甲|左走加速
				jsr		sub_15AE48
				bra.s	$15AEC8
			ORG $15AF80		; 青銅天師飛將甲|右跑加速
				jsr		sub_15AE48
				bra.w	$15B038
			ORG $15AFEC		; 青銅天師飛將甲|右走加速
				jsr		sub_15AE48
				bra.s	$15AFFA
			* loc_1135DC	; 青銅天師星旋甲
			ORG $1A07B6		; 飛將甲於特殊地形的調整|0505江陵道馬車
				jsr		sub_1BA7A4
			ORG $15EAF8		; 設定時間內結束出場動作
				move.l	4(sp),-(sp)	; 時間
				jsr		sub_171BB4	; 重写程序|暂停防具效果
				addq.l	#4,sp
				rts

		* 重寫山賊偷盜程序
			ORG $39474A	; 山賊兵偷盜[1]
				dc.l	$F0070000,sub_1703F4
			ORG $3947C2	; 山賊兵偷盜[2]
				dc.l	$F0070000,sub_1703F4
			ORG $395608	; 山賊兵偷盜[3]
				dc.l	$F0070000,sub_1703F4
			ORG $395788	; 山賊兵偷盜[4]
				dc.l	$F0070000,sub_1703F4
			ORG $395820	; 山賊兵偷盜[5]
				dc.l	$F0070000,sub_1703F4

	* 等級升階增目

		ORG $128ED6
			jsr		sub_128ED6				; 等級升階 特殊技/投擲道具 增目
			beq.s	$128f12					; 空格則操作下一格
			tst.b   (A4)
			beq.s	$128f12					; 無撿取權限則下一格
			cmpi.b  #$17, D2
			bcs.s   $128ef4					; 特殊技增目
			cmpi.b  #$21, D2
			bls.s   $128f12					; 援軍令不增目
			cmpi.b  #$25, D2
			bhi.s   $128f12					; 投擲道具增目
		ORG $128F14
			moveq   #$10,d0					; AB面最大16格

	* 道具欄顯示圖

		ORG $12763E	; 投擲道具01XX顯示圖(選中22~25)
			jsr		sub_12763E			

		ORG $314D6C	; 空道具格0000顯示圖(選中)
			dc.w	$0,$29E5
		ORG $3148F4	; 空道具格0000顯示圖(未選中)
			dc.w	$0,$29C1

; =============== ROM 擴容 ==================================================
	
	ORG ROMBase

nullsub:	; 空程序
	RTS

; --------------- 基礎調整 --------------------------------------------------

sub_16524C:	; 菜單選項
	link	a6,#-$10
	movem.l	d2-d5,-(sp)
; 默認設定
	bclr	#0,(byte_803765).l			; 註銷[F2]鍵
	clr.b	($80345E).l					; 不進入主菜單
	movea.l	#unk_1CE35E,a0				; 默認設定表
	btst	#1,(ram_0000).l				; 是否遊聚存檔[02]
	bne.s	loc_16524D
	btst	#0,(ram_0000).l				; 是否未設定菜單[00]
	bne.s	loc_16524C
	move.b	(a0),($803B82).l			; 普通難度
	move.b	($803B82).l,($81A326).l		; 更新難度
loc_16524D:
	move.b	1(a0),(ram_0002).l			; 單兵
	move.b	(ram_0002).l,(ram_0003).l	; 更新難度+
	move.b	2(a0),(ram_0005).l			; 107版
	move.b	3(a0),(ram_0004).l			; 新野城
	move.b	4(a0),(ram_0006).l			; 二代
	move.b	5(a0),(ram_0007).l			; 指令D
	move.b	6(a0),($803B85).l			; 四玩家位
	bset	#0,(ram_0000).l				; 記錄
	bclr	#1,(ram_0000).l				; 重置
loc_16524C:
; 設定色盤
	pea		($1F2392).l
	pea		($F).w
	clr.l	-(sp)
	jsr		$102D28
; 選項取值
	moveq	#7+1,d4			; 7選項+1大項[按鍵ABCD]
	moveq	#0,d0
	move.b	($81A326).l,($803B82).l
	move.b	($803B82).l,d0	; 遊戲難度[00-08]
	addi.w	#-1,d0
	move.w	d0,-$10(a6)
	moveq	#0,d0
	move.b	(ram_0002).l,d0	; 敵人模式[0/+1/+2/+3/+4]
	move.w	d0,-$E(a6)
	moveq	#0,d0
	move.b	(ram_0005).l,d0	; 遊戲版本[100/107]
	move.w	d0,-$C(a6)
	moveq	#0,d0
	move.b	(ram_0004).l,d0	; 開局場景[隨機/選定]
	move.w	d0,-$A(a6)
	moveq	#0,d0
	move.b	(ram_0006).l,d0	; 動作移動[V10X/V20X]
	move.w	d0,-8(a6)
	moveq	#0,d0
	move.b	(ram_0007).l,d0	; 出招指令[A/B/C/D]
	move.w	d0,-6(a6)
	moveq	#0,d0
	move.b	($803B85).l,d0	; 玩家模式[2/4 PLAYERS]
	eori.b	#1,d0
	move.w	d0,-4(a6)
; 打印選項
	moveq	#1,d3			; 第二項開始
loc_16538E:
	clr.l	-(sp)			; 未選中|白色
	move.w	d3,d0
	add.w	d0,d0
	move.w	-$10(a6,d0.w),d1
	move.l	d1,-(sp)
	move.w	d3,d0
	move.l	d0,-(sp)
	bsr.w	sub_164EAC
	lea		$C(sp),sp
	addq.w	#1,d3
	moveq	#0,d0
	move.w	d3,d0			; 已打印的選項數目
	cmp.l	d4,d0
	blt.s	loc_16538E
; 打印首項
	pea		(3).w			; 已選中|金色
	moveq	#0,d0
	move.w	-$10(a6),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	bsr.w	sub_164EAC
	lea		$18(sp),sp
; 打印標題
	pea		($301950).l		; "OPERATOR SETTING"
	pea		(3).w
	pea		(3).w
	pea		($2).w			; 縱坐標
	pea		($A).w			; 橫坐標
	clr.l	-(sp)
	jsr		$107728			; 打印英文
	lea		$18(sp),sp
; 打印紅線
	pea		($38).w			; 線長度
	pea		(6).w			; 縱坐標
	clr.l	-(sp)			; 橫坐標
	jsr		(sub_380A).l	; 分割線
	pea		($38).w
	pea		($18).w
	clr.l	-(sp)
	jsr		(sub_380A).l
	lea		$18(sp),sp
; 選項選擇
	clr.w	d2					; 當前選中第幾項
loc_1653E6:
; 判斷按鍵
	bsr.w	sub_1653E6			; 檢測按鍵
	move.l	d0,d5				; 記錄按鍵
	moveq	#(4-1),d1			; 四類情況
	cmp.l	d1,d0
	bhi.w	loc_1655A6
	add.l	d0,d0
	move.w	jpt_1653E6(pc,d0.l),d0
	jmp		jpt_1653E6(pc,d0.w)
jpt_1653E6:
	dc.w	loc_1653E6-jpt_1653E6	; [0]未按鍵
	dc.w	loc_1653E8-jpt_1653E6	; [1]方向上
	dc.w	loc_16546C-jpt_1653E6	; [2]方向下
	dc.w	loc_1655A6-jpt_1653E6	; [3|4|5|6]確認鍵
loc_1653E8:
; 上一選項
	clr.l	-(sp)				; 未選中|白色
	move.w	d2,d0
	add.w	d0,d0
	move.w	-$10(a6,d0.w),d1
	move.l	d1,-(sp)
	move.w	d2,d0
	move.l	d0,-(sp)
	bsr.w	sub_164EAC
	tst.w	d2
	beq.s	loc_165420
	subq.w	#1,d2				; 上一選項
	bra.s	loc_165426
loc_165420:
	move.w	d4,d2
	addi.w	#-1,d2				; 跳到最後一項
loc_165426:
	pea		(3).w				; 已選中|金色
	move.w	d2,d0
	add.w	d0,d0
	move.w	-$10(a6,d0.w),d1
	move.l	d1,-(sp)
	move.w	d2,d0
	move.l	d0,-(sp)
	bsr.w	sub_164EAC
	lea		$18(sp),sp
	bra.w	loc_165456			; 繼續循環
loc_16546C:
; 下一選項
	clr.l	-(sp)				; 未選中|白色
	move.w	d2,d0
	add.w	d0,d0
	move.w	-$10(a6,d0.w),d1
	move.l	d1,-(sp)
	move.w	d2,d0
	move.l	d0,-(sp)
	bsr.w	sub_164EAC
	addq.w	#1,d2				; 下一選項
	moveq	#0,d0
	move.w	d2,d0
	cmp.l	d4,d0
	blt.s	loc_1654A8
	clr.w	d2					; 跳到第一項
loc_1654A8:
	pea		(3).w				; 已選中|金色
	move.w	d2,d0
	add.w	d0,d0
	move.w	-$10(a6,d0.w),d1
	move.l	d1,-(sp)
	move.w	d2,d0
	move.l	d0,-(sp)
	bsr.w	sub_164EAC
	lea		$18(sp),sp
	bra.w	loc_165456			; 繼續循環
loc_1655A6:
; 確認按鍵
	move.w	d2,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	lsl.w	#3,d0
	movea.l	#(aOperatorSetting+$10),a0
	cmpi.b	#8,(a0,d0.w)		; 是否退出選項[EXIT]
	bne.w	loc_1656EA
; EXIT | 更新選值
	move.b	-3(a6),d0
	eori.b	#1,d0
	move.b	d0,($803B85).l				; 玩家模式[2/4 PLAYERS]
	move.b	-5(a6),(ram_0007).l			; 出招指令[A/B/C/D]
	move.b	-7(a6),(ram_0006).l			; 動作移動[V10X/V20X]
	move.b	-9(a6),(ram_0004).l			; 開局場景[隨機/選定]
	move.b	-$B(a6),(ram_0005).l		; 遊戲版本[100/107]
	move.b	-$D(a6),(ram_0002).l		; 敵人模式[0/+1/+2/+3/+4]
	move.b	(ram_0002).l,(ram_0003).l	; 更新難度+
	move.b	-$F(a6),d0
	addq.b	#1,d0
	move.b	d0,($803B82).l				; 遊戲難度[00-08]
	move.b	($803B82).l,($81A326).l		; 更新難度
; 按鍵音頻 | 更新退出
	pea		($FF).w
	pea		(6).w
	pea		(1).w
	movea.l	$240.w,a0
	jsr		(a0)
	lea		$C(sp),sp
	bra.w	loc_1657D2
loc_1656EA:
	cmpi.b	#6,(a0,d0.w)		; 是否指令選項[DESPERATION]
	bne.w	loc_1656EB
; DESPERATION MOVES | 按鍵[A|B|C|D]
	subq.l	#3,d5				; ABCD=0123
	move.w	d2,d0
	add.w	d0,d0
	bchg	d5,-$F(a6,d0.w)		; 更新開關值[not.b]
	bra.s	loc_16579A			; 更新開關文字
loc_1656EB:
	cmpi.l	#3,d5				; 是否按鍵[A]
	bne.w	loc_1653E6			; 重新循環
; 更新開關值[+1]
	move.w	d2,d0
	add.w	d0,d0
	addq.w	#1,-$10(a6,d0.w)	; 開關+1
; 開關上限值[d1]
	move.w	d2,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	lsl.w	#3,d0				; 每個選項佔位|d2*$18
	movea.l	#(aOperatorSetting+$11),a0
	move.b	(a0,d0.w),d0
	andi.l	#$FF,d0
	move.l	d0,-(sp)
; 當前開關值[d0]
	move.w	d2,d0
	add.w	d0,d0
	move.w	-$10(a6,d0.w),d0
	andi.l	#$FFFF,d0
; 是否回開關[01]
	move.l	(sp)+,d1
	cmp.l	d1,d0				; 對比
	blt.s	loc_16579A
	move.w	d2,d0
	add.w	d0,d0
	clr.w	-$10(a6,d0.w)		; 回到第一開關
loc_16579A:
	pea		(1).w				; 保持選中|藍色
	move.w	d2,d0
	add.w	d0,d0
	move.w	-$10(a6,d0.w),d1
	move.l	d1,-(sp)
	move.w	d2,d0
	move.l	d0,-(sp)
	bsr.w	sub_164EAC
	lea		$C(sp),sp
loc_165456:
; 按鍵音頻
	pea		($FF).w
	pea		(5).w
	pea		(1).w
	movea.l	$240.w,a0
	jsr		(a0)
	lea		$C(sp),sp
	bra.w	loc_1653E6			; 循環
loc_1657D2:
	movem.l	-$20(a6),d2-d5
	unlk	a6
	rts

sub_1653E6:
	moveq	#0,d0		; 未按鍵
; 判斷按鍵[↑]
	pea		(2).w
	pea		(1).w
	movea.l	$23C.w,a0
	jsr		(a0)
	addq.l	#8,sp
	tst.l	d0
	beq.s	loc_1653E7
	moveq	#1,d0
	bra.s	locret_1653E6
loc_1653E7:
; 判斷按鍵[↓]
	pea		(3).w
	pea		(1).w
	movea.l	$23C.w,a0
	jsr		(a0)
	addq.l	#8,sp
	tst.l	d0
	beq.s	loc_1653EA
	moveq	#2,d0
	bra.s	locret_1653E6
loc_1653EA:
; 判斷按鍵[A]
	pea		(6).w
	pea		(1).w
	movea.l	$23C.w,a0
	jsr		(a0)
	addq.l	#8,sp
	tst.l	d0
	beq.w	loc_1653EB
	moveq	#3,d0
	bra.s	locret_1653E6
loc_1653EB:
; 判斷按鍵[B]
	pea		(7).w
	pea		(1).w
	movea.l	$23C.w,a0
	jsr		(a0)
	addq.l	#8,sp
	tst.l	d0
	beq.w	loc_1653EC
	moveq	#4,d0
	bra.s	locret_1653E6
loc_1653EC:
; 判斷按鍵[C]
	pea		(8).w
	pea		(1).w
	movea.l	$23C.w,a0
	jsr		(a0)
	addq.l	#8,sp
	tst.l	d0
	beq.w	loc_1653ED
	moveq	#5,d0
	bra.s	locret_1653E6
loc_1653ED:
; 判斷按鍵[D]]
	pea		($29).w
	pea		(1).w
	movea.l	$23C.w,a0
	jsr		(a0)
	addq.l	#8,sp
	tst.l	d0
	beq.w	locret_1653E6
	moveq	#6,d0
locret_1653E6:
	rts

sub_164EAC:	; 選項開關
	link	a6,#0
	movem.l	d2-d6/a2-a4,-(sp)
	move.l	$C(a6),d4		; 開關編號
	move.l	8(a6),d5		; 選項編號
	move.l	$10(a6),d6		; 是否選中
; 選項基址
	move.l	d5,d0
	move.l	d0,d1
	add.l	d0,d0
	add.l	d1,d0
	lsl.l	#3,d0
	movea.l	#aOperatorSetting,a0
	adda.l	d0,a0
	movea.l	a0,a2			; 選項基址
; 打印星號
	tst.l	d6
	bne.s	loc_164F20
	clr.l	d2				; 00|白
	moveq	#7,d3			; 漢字|無
	pea		($3018EC).l		; 未選中[ ]
	bra.s	loc_164F28
loc_164F20:
	moveq	#2,d2			; 02|藍
	moveq	#$F,d3			; 漢字|藍
	pea		($3018EE).l		; 已選中[*]
loc_164F28:
	pea		(1).w
	pea		(1).w
	moveq	#0,d0
	move.b	$13(a2),d0		; 選項縱坐標
	move.l	d0,-(sp)
	moveq	#0,d0
	move.b	$12(a2),d0
	subq.l	#2,d0			; 選項橫坐標-2
	move.l	d0,-(sp)
	clr.l	-(sp)
	jsr		$107728			; 打印英文
; 打印選項
	move.l	a2,-(sp)
	pea		(1).w
	move.l	d6,-(sp)
	moveq	#0,d0
	move.b	$13(a2),d0		; 選項縱坐標
	move.l	d0,-(sp)
	moveq	#0,d0
	move.b	$12(a2),d0		; 選項橫坐標
	move.l	d0,-(sp)
	clr.l	-(sp)
	jsr		$107728			; 打印英文
	lea		$30(sp),sp
; 選項內容
	moveq	#0,d0
	move.b	$10(a2),d0
	moveq	#(8-1),d1		; 最多8個選項
	cmp.l	d1,d0
	bhi.w	loc_165204
	add.l	d0,d0
	move.w	jpt_164F8A(pc,d0.l),d0
	jmp		jpt_164F8A(pc,d0.w)
jpt_164F8A:
	dc.w	loc_164F98-jpt_164F8A
	dc.w	loc_1650FA-jpt_164F8A
	dc.w	loc_164FD6-jpt_164F8A
	dc.w	loc_165076-jpt_164F8A
	dc.w	loc_16508E-jpt_164F8A
	dc.w	loc_1650B6-jpt_164F8A
	dc.w	loc_1650B7-jpt_164F8A
	dc.w	loc_1651C6-jpt_164F8A
; [00]數字開關|待定
loc_164F98:
	move.l	d4,d0			; 數值
	addq.l	#1,d0
	move.l	d0,-(sp)
	pea		($3018F0).l		; "%1d"
	pea		(1).w
	move.l	d2,-(sp)
	moveq	#0,d0
	move.b	$17(a2),d0		; 開關橫坐標
	move.l	d0,-(sp)
	moveq	#0,d0
	move.b	$16(a2),d0		; 開關縱坐標
	move.l	d0,-(sp)
	clr.l	-(sp)
	jsr		$107FAA
	lea		$1C(sp),sp
	bra.w	loc_165204
; [01]DIFFICULTY
loc_1650FA:
	move.l	d4,d0
	lsl.w	#2,d0
	movea.l	#$2B51C4,a3
	movea.l	(a3,d0.l),a3		; 難度|英文
	move.l	d4,d0				; 開關值
	mulu.w	#6,d0
	movea.l	#unk_1F2698,a4
	adda.l	d0,a4				; 難度|漢字
	bra.w	loc_1651D2
; [02]ENEMY MODES
loc_164FD6:
	move.l	d4,d0				; 開關值
	mulu.w	#$C,d0
	movea.l	#aEnemyMode,a3
	adda.l	d0,a3				; 敵人模式|英文
	move.l	d4,d0
	mulu.w	#6,d0
	movea.l	#aEnemyModeZH,a4
	adda.l	d0,a4				; 敵人模式|漢字
	bra.w	loc_1651D2
; [03]VERSION
loc_165076:
	move.l	d4,d0
	lsl.l	#2,d0
	movea.l	#aVersion,a3
	adda.l	d0,a3				; 版本|英文
	movea.l	#aVersionZH,a4		; 版本|漢字
	bra.w	loc_1651D2
; [04]STAGE ONE
loc_16508E:
	move.l	d4,d0
	lsl.l	#3,d0
	movea.l	#aStage,a3
	adda.l	d0,a3				; 開局|英文
	movea.l	#aStageZH,a4
	adda.l	d0,a4				; 開局|漢字
	bra.w	loc_1651D2
; [05]MOVES
loc_1650B6:
	move.l	d4,d0
	mulu.w	#$A,d0
	movea.l	#aMoves,a3
	adda.l	d0,a3				; 跑步出招|英文
	move.l	d4,d0
	mulu.w	#6,d0
	movea.l	#aMovesZH,a4
	adda.l	d0,a4				; 跑步出招|漢字
	bra.w	loc_1651D2
; [06]DESPERATION
loc_1650B7:
	movea.l	#aOnOff,a3			; 開關[+|-]
	btst	#3,d4				; 按鍵[D]
	sne.b	d0
	andi.w	#1,d0
	add.w	d0,d0
	pea		(a3,d0.w)
	btst	#2,d4				; 按鍵[C]
	sne.b	d0
	andi.w	#1,d0
	add.w	d0,d0
	pea		(a3,d0.w)
	btst	#1,d4				; 按鍵[B]
	sne.b	d0
	andi.w	#1,d0
	add.w	d0,d0
	pea		(a3,d0.w)
	btst	#0,d4				; 按鍵[A]
	sne.b	d0
	andi.w	#1,d0
	add.w	d0,d0
	pea		(a3,d0.w)
	pea     (aDesperation).l	; 按鍵指令|英文
	pea		($1).w				; 字體
	move.l	d2,-(sp)			; 顏色
	moveq	#0,d0
	move.b	$17(a2),d0			; 縱坐標
	move.l	d0,-(sp)
	moveq	#0,d0
	move.b	$16(a2),d0			; 橫坐標
	move.l	d0,-(sp)
	clr.l	-(sp)
	jsr		$107FAA				; 打印英文
	lea		$28(sp),sp
	movea.l	#aDesperationZH,a4	; 按鍵指令|漢字
	bra.s	loc_16514E
; [07]PLAYER MODE
loc_1651C6:
	move.l	d4,d0
	mulu.w	#$A,d0
	movea.l	#aPlayerMode,a3
	adda.l	d0,a3				; 玩家模式|英文
	movea.l	#aPlayerModeZH,a4	; 玩家模式|漢字
loc_1651D2:	; 共用打印
; 打印英文開關
	move.l	a3,-(sp)
	pea		($1).w			; 字體
	move.l	d2,-(sp)		; 顏色
	moveq	#0,d0
	move.b	$17(a2),d0		; 開關縱坐標
	move.l	d0,-(sp)
	moveq	#0,d0
	move.b	$16(a2),d0		; 開關橫坐標
	move.l	d0,-(sp)
	clr.l	-(sp)
	jsr		$107FAA			; 打印英文
	lea		$18(sp),sp
; 打印漢字開關
loc_16514E:
	move.l	a4,-(sp)
	move.l	d3,-(sp)		; 顏色
	moveq	#0,d0
	move.b	$15(a2),d0		; 漢字縱坐標
	move.l	d0,-(sp)
	moveq	#0,d0
	move.b	$14(a2),d0		; 漢字橫坐標
	move.l	d0,-(sp)
	jsr		$164DDE			; 打印漢字
	lea		$10(sp),sp
loc_165204:
	movem.l	(sp)+,d2-d6/a2-a4
	unlk	a6
	rts

aOperatorSetting:
; 選項[01]開關[08] | 橫坐標[03]縱坐標[08] | 漢字橫坐標[1A]縱坐標[07] | 開關橫坐標[21]縱坐標[08]
	dc.l	'Difficulty',0	; 遊戲難度[00-08]
	dc.b	$01,$08, $03,$08, $1A,$07, $21,$08
	dc.l	'Enemy Units',0	; 敵人模式[0/+1/+2/+3/+4]
	dc.b	$02,$04, $03,$0A, $1A,$09, $21,$0A
	dc.l	'Version',0,0	; 遊戲版本[100/107]
	dc.b	$03,$02, $03,$0C, $1A,$0B, $21,$0C
	dc.l	'Stage One',0	; 開局場景[隨機/選定場景]
	dc.b	$04,$19, $03,$0E, $17,$0D, $21,$0E
	dc.l	'Moves',0,0		; 跑步出招[二代/群雄]
	dc.b	$05,$02, $03,$10, $1A,$0F, $21,$10
	dc.l	'Desperation',0	; 按鍵指令[按鈕A|B|C|D]
	dc.b	$06,$02, $03,$12, $1A,$11, $21,$12
	dc.l	'Player',0,0	; 玩家模式[2/4 Players]
	dc.b	$07,$02, $03,$14, $1A,$13, $21,$14
	dc.l	'Exit',0,0,0	; 退出
	dc.b	$08,$01, $03,$16, 0,0,0,0

unk_1F2698:	; 難度漢字表
	dc.w	$031F,$014A,$FFFF	; 簡單
	dc.w	$009B,$01C9,$FFFF	; 普通
	dc.w	$06DA,$01DB,$FFFF	; 困難
	dc.w	$018C,$01DB,$FFFF	; 特難
	dc.w	$0448,$01DB,$FFFF	; 超難
	dc.w	$0302,$01DB,$FFFF	; 極難
	dc.w	$0428,$030D,$FFFF	; 專家
	dc.w	$036B,$0624,$FFFF	; 權威

aEnemyMode:
	dc.b	'SINGLE RORO',0	; 單兵
	dc.b	'DOUBLE RORO',0	; 雙兵
	dc.b	'TRIPLE RORO',0	; 三兵
	dc.b	'TWO CHIEFS ',0	; 雙王

aEnemyModeZH:
	dc.w	$014A,$0046,$FFFF	; 單兵
	dc.w	$04E0,$0046,$FFFF	; 雙兵
	dc.w	$057B,$0046,$FFFF	; 三兵
	dc.w	$04E0,$0642,$FFFF	; 雙王

aVersion:
	dc.b	'100',0	; 100版
	dc.b	'107',0	; 107版
aVersionZH:
	dc.w	$FFFF	; 版本

aStage:
	dc.b	'RANDOM',0,0	; 隨機
	dc.b	'0100  ',0,0	; 博望坡
	dc.b	'0200  ',0,0	; 新野城
	dc.b	'0202  ',0,0	; 白河川
	dc.b	'0203  ',0,0	; 白河上游
	dc.b	'0204  ',0,0	; 新野城屋頂
	dc.b	'0300  ',0,0	; 襄江
	dc.b	'0301  ',0,0	; 長坂坡
	dc.b	'0302  ',0,0	; 江夏
	dc.b	'0400  ',0,0	; 南坪山碼頭
	dc.b	'0403  ',0,0	; 東吳戰船
	dc.b	'040B  ',0,0	; 曹魏戰船
	dc.b	'0500  ',0,0	; 烏林
	dc.b	'0501  ',0,0	; 北彝陵
	dc.b	'0502  ',0,0	; 南彝陵|江陵道
	dc.b	'0503  ',0,0	; 葫蘆口
	dc.b	'0504  ',0,0	; 華容道
	dc.b	'0600  ',0,0	; 山寨
	dc.b	'0601  ',0,0	; 火焰洞
	dc.b	'0602  ',0,0	; 古墓
	dc.b	'0603  ',0,0	; 南郡道
	dc.b	'0701  ',0,0	; 前庭
	dc.b	'0703  ',0,0	; 大廳
	dc.b	'0704  ',0,0	; 南郡城
	dc.b	'0705  ',0,0	; 下水道
aStageZH:
	dc.w	$06E8,$06DB,$02FD,$FFFF	; 隨機
	dc.w	$0013,$0647,$0056,$FFFF	; 博望坡
	dc.w	$0398,$05BB,$046B,$FFFF	; 新野城
	dc.w	$0009,$06DC,$047C,$FFFF	; 白河川
	dc.w	$0009,$06DC,$021A,$FFFF	; 白河林
	dc.w	$0398,$05BB,$060D,$FFFF	; 新野屋
	dc.w	$06E8,$039E,$0325,$FFFF	; 襄江
	dc.w	$040A,$0020,$0056,$FFFF	; 長坂坡
	dc.w	$06E8,$0325,$037D,$FFFF	; 江夏
	dc.w	$01DA,$008E,$04AE,$FFFF	; 南屏山
	dc.w	$06E8,$0610,$047E,$FFFF	; 吳船
	dc.w	$06E8,$0634,$047E,$FFFF	; 魏船
	dc.w	$06E8,$06DD,$021A,$FFFF	; 烏林
	dc.w	$06DE,$06DF,$022F,$FFFF	; 北彝陵
	dc.w	$0325,$022F,$0144,$FFFF	; 江陵道
	dc.w	$06E0,$0235,$06E1,$FFFF	; 葫蘆口
	dc.w	$02D8,$04FF,$0144,$FFFF	; 華容道
	dc.w	$06E8,$04AE,$03E2,$FFFF	; 山寨
	dc.w	$02DA,$06E2,$0188,$FFFF	; 火焰洞
	dc.w	$06E8,$026F,$06E3,$FFFF	; 古墓
	dc.w	$01DA,$06E4,$0144,$FFFF	; 南郡道
	dc.w	$06E8,$0355,$01B4,$FFFF	; 前庭
	dc.w	$06E8,$0138,$06E5,$FFFF	; 大廳
	dc.w	$01DA,$06E4,$046B,$FFFF	; 南郡城
	dc.w	$06E6,$04DC,$0144,$FFFF	; 下水道

aMoves:
	dc.b	'V10X     ',0	; 二代
	dc.b	'V20X     ',0	; 群雄
aMovesZH:
	dc.w	$06C3,$013C,$FFFF	; 二代
	dc.w	$0370,$03C2,$FFFF	; 群雄

aOnOff:
	dc.b	'-',0	; 關閉
	dc.b	'+',0	; 開啟
aDesperation:
	dc.b	'A%s B%s C%s D%s',0	; 按鈕
aDesperationZH:
	dc.w	$06E7,$0233,$FFFF	; 指令

aPlayerMode:
	dc.b	'2 PLAYERS',0	; 雙玩家位
	dc.b	'4 PLAYERS',0	; 四玩家位
aPlayerModeZH:
	dc.w	$FFFF	; 模式

sub_380A:	; 黃金分割線
	link	a6,#0
	movem.l	d2-d3,-(sp)
	move.l	8(a6),d3
	moveq	#0,d2
	bra.s	loc_385C
loc_381A:
	pea		(1).w
	pea		(1).w
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($500).w
	clr.l	-(sp)
	jsr		(sub_7F9E).l
	addq.l	#8,sp
	move.l	d0,-(sp)
	pea		(3).w		; 金色
	clr.l	-(sp)
	pea		(1).w
	pea		(off_18790).l
	move.l	$C(a6),-(sp)
	move.l	d3,-(sp)
	clr.l	-(sp)
	jsr		(sub_7966).l
	lea		$30(sp),sp
	addq.l	#1,d2
	addq.l	#1,d3
loc_385C:
	moveq	#0,d0
	move.w	$12(a6),d0
	cmp.l	d2,d0
	bgt.s	loc_381A
	movem.l	-8(a6),d2-d3
	unlk	a6
	rts

unk_1CE35E:	; 默認設定表
	dc.b	$02,$00,$01,$02,$00,$08,$00, 0


sub_139BC8:	; 投幣後進行遊戲設定
	movem.l	d2-d3/a2,-(sp)
; 菜單設定
	btst	#1,(ram_0000).l		; 是否遊聚存檔[02]
	bne.s	loc_139BC8
	pea		(7).w				; 1P是否按住「B键」
	jsr		$1010B2.l
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_139BC9
loc_139BC8:
	move.b	#1,($80345E).l		; 激活菜單入口
	jmp		F3Key				; 進入[F3]新菜單|跳出程序
loc_139BC9:
; 重置新增寄存
	movea.l	#ram_000A,a2		; 新增寄存起
	moveq	#0,d2
	moveq	#$7F,d3				; 循環次數[$200]
loc_E44:
	move.l	d2,(a2)+			; 清零
	dbf		d3,loc_E44			; 重複
	move.b  #1, $81A2DE.l		; InternetRank畫面
	clr.b	($818058).l			; 原代碼
	movem.l	(sp)+,d2-d3/a2
	rts


sub_1573CE:	; 場景開頭設定遊戲名稱|v100-$145FDE|v205-$1576E2
	move.l	d2,-(sp)
	clr.w	($8186B8).l		; 原代碼
	jsr		sub_145F3A		; 是否序章[0000|0003]
	tst.w	d0
	bne.w	locret_1573CE
; 重置遊戲名稱寄存
	moveq	#0,d2
loc_1573D4:
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#ram_0023+2,a0	; 遊戲名稱OBJ寄存*4
	tst.l	(a0,d0.w)
	beq.s	loc_1573CE
	move.l	(a0,d0.w),-(sp)
	clr.l	(a0,d0.w)		; 清除遊戲名稱寄存
	jsr		$151A3A			; 清除遊戲名稱圖片
	addq.l	#4,sp
loc_1573CE:
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_1573D4
; 打印遊戲名稱圖片
	pea		($19).w			; 縱坐標
	pea		($AE).w			; 橫坐標
	jsr		sub_157274		; 斗轉星旋
	addq.l	#8,sp
locret_1573CE:
	move.l	(sp)+,d2
	rts

sub_157274:	; 打印遊戲名稱
	link	a6,#0
	movem.l	d2-d5/a2,-(sp)
; 分配色表序號
	* pea		($322F9E).l		; 基礎色盤
	* jsr		$14DE32			; 分配色盤編號|預寫
	* addq.l	#4,sp			; 區域$A00000-$A007FF|20字大小
	* move.w	d0,(ram_0023+0).l	; 寄存遊戲名稱圖層
	* move.l	d0,d5
; 指定色表序號
	pea		word_322F9E.l		; 基礎色盤
	pea		($C).w				; A00300|佔用第三重藍影
	pea		(2).w				; 區域$A00000-$A007FF|20字大小
	; 常駐色盤指針表$809248|以便調整亮度等|比如死命時背景暗色
	jsr		$10388E				; 預備寫入色表
	lea		$C(sp),sp
	move.w	#$C,(ram_0023+0).l	; 寄存遊戲名稱圖層
	move.l	#$C,d5				; 色盤編號
; 設定動態色盤
	jsr		$105562				; 分配OBJ[d0]
	pea		(word_322F9E+2).l	; 循環色盤
	pea		(8).w				; 循環頻率
	pea		(8).w				; 八色循環
	pea		(1).w				; 色表偏移
	move.l	d5,-(sp)			; 圖層編號
	pea		(2).w				; 第二色表區域[A00000-A00800]
	move.l	d0,-(sp)
	jsr		$10575E
	lea		$1C(sp),sp
; 初始化
	move.l	8(a6),d4		; 初始橫坐標
	moveq	#0,d2			; 第幾個漢字
loc_157294:
	movea.l	#unk_21EF4E,a0	; 「斗轉星旋」
	move.l	d2,d0
	add.l	d0,d0
	adda.l	d0,a0
	move.w	(a0),d3			; 當前漢字編號
	cmpi.w	#$FFFF,d3		; 結束符
	beq.w	loc_157380
; 開始打印
loc_1572AC:
	clr.l	-(sp)
	clr.l	-(sp)
	move.l	$C(a6),-(sp)	; 縱坐標
	move.l	d4,-(sp)		; 橫坐標
	pea		(off_21EEDA).l	; 繁體字體
	jsr		$1517D4			; 佈置
	lea		$14(sp),sp
; 設定圖片
	movea.l	d0,a2
	move.w	d3,$3E(a2)		; 漢字編號
	move.w	d5,$50(a2)
	move.w	d5,$8A(a2)
	move.w	#1,$CE(a2)
	move.w	#$7FBC,$CC(a2)
	move.l	$4C(a2),d0
	cmpi.l	#$80B2A6,d0
	bcs.s	loc_157314
	move.l	$4C(a2),d0
	cmpi.l	#$80C296,d0
	bls.s	loc_15732E
loc_157314:
	pea		($40).w
	pea		($2F84D8).l		; "cstory.c"
	pea		($2F8478).l		; "(DISPLAY*)((h)->displayh) >= &display[0"...
	jsr		$13A50C
	lea		$C(sp),sp
; 設定結構
loc_15732E:
	movea.l	$4C(a2),a0		; 結構頭？
	move.w	2(a0),d0
	cmp.w	$CC(a2),d0
	beq.s	loc_157362
	move.l	$4C(a2),-(sp)
	jsr		$108CE4
	move.w	$CC(a2),d0
	move.l	d0,-(sp)
	movea.l	$4C(a2),a0
	move.l	4(a0),-(sp)
	move.l	$4C(a2),-(sp)
	jsr		$108C14
	lea		$10(sp),sp
; 下一漢字
loc_157362:
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#ram_0023+2,a0	; 遊戲名稱OBJ寄存
	move.l	a2,(a0,d0.w)
	addq.l	#1,d2			; 下一漢字
	addi.l	#$1A,d4			; 字間距
	bra.w	loc_157294
loc_157380:
	movem.l	(sp)+,d2-d5/a2
	unlk	 a6
	rts

word_322F9E:
	dc.w	$7FF1,$7F0D,$7ECC,$720A,$6948,$5CA7,$6948,$720A
	dc.w	$7ECC,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$0000

unk_21EF4E:	; 斗轉星旋
	dc.w	$0145,$0429,$03A7,$03BA,$FFFF

off_21EEDA:
	dc.l	$001CEFC8,$001EC420,$00000000,$00000000	; 001EC420|字體坐標偏移量|152D30|00152F5A
	dc.l	unk_3A4734,$00699ECF,$00020060,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$80000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000,$00000000

unk_3A4734:	; 繁體
	dc.l	$00323678,$324B28,$07020000
	dc.l	$00000000,$00000000,$00000000,$0000


sub_15747E:	; 清除遊戲名稱
	move.l	d2,-(sp)
	clr.b	($818390).l			; 原代碼
	moveq	#0,d2
loc_157482:
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#ram_0023+2,a0		; 遊戲名稱OBJ寄存*4
	tst.l	(a0,d0.w)
	beq.s	loc_1574A8
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#ram_0023+2,a0
	move.l	(a0,d0.w),-(sp)
	jsr		$151A3A				; 清除場景障礙等
	addq.l	#4,sp
loc_1574A8:
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_157482
	move.w	(ram_0023+0).l,d0	; 遊戲名稱所在圖層
	ext.l	d0
	move.l	d0,-(sp)
	jsr		$14DEC2
	addq.l	#4,sp
	clr.w	(ram_0023+0).l
	move.l	(sp)+,d2
	rts


sub_133566:	; 修復敵方上圓弧(⌒)異常走位
	pea     ($4A).w		; ARM:sub_C9C
	jsr     ($13A27E).l	; 兵陣相關:$11286E
	addq.l	#4,sp
	rts


sub_123F0E:
	move.l	A2, -(A7)
	moveq	#$0, D0
	moveq	#$1, D1
	move.l	#$d09000, A0
loc_123F0F:
	cmpi.w	#2, $C(A0)			; 判斷OBJ是否占用
	bne.s	loc_123F0E
	movea.l	$58(A0), A1			; 當前角色
	movea.l	#unk_123F0E, A2 	; 補充品掉落表
	move.b	1(A1), D0
	lsl.l   #2, D0
	lea		(A2, D0.w), A2 		; 計算角色偏移
	move.l	D2, D1
	subi.l	#$2, D1
	lea		(A2, D1.w), A2 		; 計算補充品偏移
	move.b	(A2), D1
	beq.s	locret_123F0E		; 0掉落1不掉
loc_123F0E:
	cmpa.l	#$d09c00, A0
	beq.s	locret_123F0E
	lea		($400,A0), A0
	bra.s	loc_123F0F
locret_123F0E:
	movea.l	(A7)+, A2
	tst.b	D1
	rts

unk_123F0E:
	dc.b	$0,$1,$0,$0			; 關羽
	dc.b	$1,$1,$0,$0			; 張飛
	dc.b	$0,$1,$0,$0			; 趙雲
	dc.b	$0,$1,$0,$0			; 黃忠
	dc.b	$0,$1,$0,$0			; 馬超
	dc.b	$0,$0,$0,$1			; 孔明
	dc.b	$1,$0,$0,$0			; 貂蟬
	dcb.b	4,$0
	dc.b	$0,$0,$0,$1			; 龐統
	dc.b	$0,$1,$0,$0			; 孫權


sub_1B3246:
	cmpi.w	#$20,($D0A002).l
	bge.s	loc_1B3296
	cmpi.w	#$3C1,($D0A000).l
	bge.s	loc_1B326A
	pea		(1).w
	pea		(1).w
	jsr		$14DC48
	addq.l	#8,sp
loc_1B326A:
	cmpi.w	#$3C1,($D0A000).l
	ble.s	loc_1B3284
	pea		(1).w
	pea		($FFFFFF).w
	jsr		$14DC48
	addq.l	#8,sp
loc_1B3284:	; 向下調整屏幕縱視野
	cmpi.w	#$3C1,($D0A000).l
	bne.s	loc_1B32C6
	pea		(1).w
	clr.l	-(sp)
	bra.s	loc_1B32BE
loc_1B3296:
	cmpi.w	#$3C1,($D0A000).l
	bge.s	loc_1B32AE
	clr.l	-(sp)
	pea		(1).w
	jsr		$14DC48
	addq.l	#8,sp
loc_1B32AE:
	cmpi.w	#$3C1,($D0A000).l
	ble.s	loc_1B32C6
	clr.l	-(sp)
	pea		($FFFFFF).w
loc_1B32BE:
	jsr		$14DC48
	addq.l	#8,sp
loc_1B32C6:
	jsr		sub_15E72C.l
	cmp.l	d2,d0
	bne.s	loc_1B32DE
	cmpi.w	#$3C1,($D0A000).l
	bne.s	loc_1B32DE
	moveq	#1,d0
	bra.s	loc_1B32E0
loc_1B32DE:
	moveq	#0,d0
loc_1B32E0:
	rts


sub_124BA0:
	tst.l	($80C75C).l		; 是否白屏中
	bne.s	locret_124BA0
	jsr		$108BD4			; 分配OBJ
	move.l	d0,($80C76C).l	; 白屏寄存
	movea.l	#$124BAC,a0		; 進行刷屏
	rts
locret_124BA0:
	movea.l	#$124C18,a0		; 取消刷屏
	rts


sub_11D220:	; 援軍退場機關
	clr.w	$6C(a3)			; 判定敵方
	move.w	$60(a2),$8A(a3)	; 原代碼
	rts


sub_109D20:
	move.l	($81B9BC).l,d0
	movea.l	d0,a0			; 場上最後敵人OBJ
	moveq	#0,d0
	move.w	$E(a0),d0		; 敵人OBJ序號
	move.l	d0,-(sp)
	jsr		$109D38.l		; 清除敵人
	addq.l	#4,sp
	rts


sub_12482A:	; 清除地面[1]可攜帶物品
	move.l	a2,-(sp)
	movea.l	$80C748.l,a2
	bra.s	loc_124854
loc_124834:
	cmpi.b	#1,$C(a2)
	bne.s	loc_124850
	move.l	8(a2),-(sp)
	jsr		$151A3A		; 清除
	move.l	8(a2),-(sp)
	jsr		$123AFE		; 重置
	addq.l	#8,sp
	bra.s	locret_124858
loc_124850:
	movea.l	4(a2),a2
loc_124854:
	move.l	a2,d0
	bne.s	loc_124834
locret_124858:
	movea.l	(sp)+,a2
	rts


sub_11C82C:	; 清除地面[1]不可攜物品
	move.l	a2,-(sp)
	movea.l	$80C3A6.l,a2
	bra.s	loc_11C856
loc_11C836:
	cmpi.b	#1,$C(a2)
	bne.s	loc_11C852
	move.l	8(a2),-(sp)
	jsr		$151A3A		; 清除
	move.l	8(a2),-(sp)
	jsr		$11C12C		; 重置
	addq.l	#8,sp
	bra.s	locret_11C85A
loc_11C852:
	movea.l	4(a2),a2
loc_11C856:
	move.l	a2,d0
	bne.s	loc_11C836
locret_11C85A:
	movea.l	(sp)+,a2
	rts


sub_15C61E:
	addq.b	#1,($81A1BB).l		; 原代碼
	bra.s	loc_15C61E
sub_15C2E0:
	clr.b	($81A1BB).l			; 原代碼
	bra.s	loc_15C61E
sub_15CE4E:
	subq.b	#1,($81A1BB).l		; 原代碼
loc_15C61E:	; 計算玩家數目難度
	moveq	#0,d0
	move.b	($81A1BB).l,d0		; 玩家數目
	move.b  (ram_0003).l,d1		; 難度+
	add.b	d1,d0
	clr.b	(ram_0001).l		; 玩家數目難度寄存
	moveq	#4,d1				; 玩家數目難度上限[04]
loc_15C61F:	
	addq.b	#1,(ram_0001).l
	subi.l	#1,d1
	beq.s	locret_15C61E
	dbf		d0,loc_15C61F		; d0+1
locret_15C61E:
	rts


* sub_11B2E2:
* 	tst.l	$BE(a3)			; 換將狀態不追加
* 	bne.s	locret_11B2E2
* 	moveq	#0,d0
* 	move.b	($81A326).l,d0	; 難度
* 	movea.l	#unk_11B2E2,a0
* 	move.b	-1(a0,d0.l),d0
* 	move.l	d2,d1			; 原始傷害值
* 	jsr		$1BEBE0.l		; d0*d1,d0
* 	asr.l	#4,d0			; 最终傷害值
* 	move.l	d0,d2
* locret_11B2E2:
* 	cmpi.w	#$63,$1A0(a3)	; 原代碼
* 	rts

* unk_11B2E2:	; 各難度最終攻擊力追加|0x10=0%|0x20=100%
* 	dc.b	$17,$16,$15,$14,$13,$12,$11,$10


sub_145574:
	link	a6,#0
	movem.l	d2-d5,-(sp)
	move.l	$C(a6),d2
	jsr		sub_145F3A		; 是否序章[0000|0003]
	tst.w	d0
	bne.w	loc_14565A
	tst.l	8(a6)
	bne.s	loc_1455A6
	tst.b	($818390).l
	bne.s	loc_1455D6
; 下移[TIME]
loc_1455A6:
	clr.l	-(sp)
	jsr		$108A64
	addq.l	#4,sp
	move.l	d0,-(sp)
	pea		($B).w
	clr.l	-(sp)
	pea		(5).w
	pea		($30FB7A).l
	pea		(6).w			; 縱坐標下移
	pea		($19).w
	clr.l	-(sp)
	jsr		$1494C2
	lea		$20(sp),sp
loc_1455D6:
	tst.l	d2				; 當前時間秒-1
	blt.w	loc_145652
; 重置顯存
	pea		($2fd66a).l		; 空白字符
	pea		($3).w			; 大字體
	pea		($2).w			; 顔色
	pea		($7).w			; 縱坐標
	pea		($9).w			; 橫坐標
	clr.l	-(sp)
	jsr		$107728.l
	lea		$18(sp),sp
; 時間秒十進制
	move.l	d2,d0
	divu.w	#100,d0
	move.w	d0,d2			; 百位數
	swap	d0
	ext.l	d0
	divu.w	#10,d0
	move.w	d0,d3			; 十位數
	ext.l	d3
	swap	d0
	move.w	d0,d4			; 個位數
	ext.l	d4
; 打印百位數[d2]
	move.l	#$1A,d5			; 初始橫坐標
	tst.l	d2
	beq.s	loc_1455F2
	clr.l	-(sp)
	jsr		$108A64
	addq.l	#4,sp
	move.l	d0,-(sp)
	pea		($B).w
	clr.l	-(sp)
	move.l	d2,d0
	addq.l	#6,d0
	move.l	d0,-(sp)
	pea		($30FB7A).l
	pea		(7).w			; 縱坐標
	pea		($19).w			; 橫坐標
	clr.l	-(sp)
	jsr		$1494C2			; 畫圖
	lea		$20(sp),sp
	addq.l	#1,d5			; 右移一
; 打印十位數[d3]
loc_1455F2:
	clr.l	-(sp)
	jsr		$108A64
	addq.l	#4,sp
	move.l	d0,-(sp)
	pea		($B).w
	clr.l	-(sp)
	move.l	d3,d0
	addq.l	#6,d0
	move.l	d0,-(sp)
	pea		($30FB7A).l
	pea		(7).w
	move.l	d5,-(sp)		; 橫坐標|$1A
	clr.l	-(sp)
	jsr		$1494C2
	lea		$20(sp),sp
	addq.l	#2,d5			; 右移二
; 打印個位數[d4]
	clr.l	-(sp)
	jsr		$108A64
	addq.l	#4,sp
	move.l	d0,-(sp)
	pea		($B).w
	clr.l	-(sp)
	move.l	d4,d0
	addq.l	#6,d0
	move.l	d0,-(sp)
	pea		($30FB7A).l
	pea		(7).w
	move.l	d5,-(sp)		; 橫坐標|$1C
	clr.l	-(sp)
	jsr		$1494C2
	lea		$20(sp),sp
loc_145652:
	move.b	#1,($818390).l	; 完成打印
loc_14565A:
	movem.l	-$10(a6),d2-d5
	unlk	a6
	rts


sub_143D2E:
; 版本編號
	pea     (aVer1102021).l
	pea     $3.w	; PROM自帶字體[2x2]
	pea     $3.w	; 金色
	pea     $1.w	; 縱坐標
	pea     $3.w	; 橫坐標
	clr.l   -(sp)
	jsr     $107728.l
	lea		$18(sp),sp
; 遊戲攻略
	* pea     (aGameGuide).l
	* pea     $1.w	; 字體
	* pea		$2.w	; 藍色
	* pea     $2.w	; 縱坐標
	* pea     $A.w	; 橫坐標
	* clr.l   -(sp)
	* jsr     $107728.l
	* lea		$18(sp),sp
	rts
; 文本內容
aVer1102021:
	dc.b	'VER.110,2021,MOD BY BOLAO',0
aGameGuide:
	dc.b	'QQ Group:197216616',0,0
asc_2FD66A:
	dc.b	'                         ',0

sub_1439AC:	; 打印隱藏人物
	movem.l	d2/a2-a3,-(sp)
	moveq	#0,d2
loc_1439B2:
	move.l	d2,d0
	lsl.l	#2,d0
	add.l	d2,d0
	lsl.l	#2,d0
	movea.l	#$2B4278,a0
	adda.l	d0,a0
	movea.l	a0,a2
	clr.l	-(sp)
	pea		($77).w
	moveq	#0,d0
	move.b	(a2),d0
	addi.l	#$C,d0
	move.l	d0,-(sp)
	moveq	#0,d0
	move.b	(a2),d0
	addi.l	#$13,d0
	move.l	d0,-(sp)
	pea		($88).w
	move.w	$10(a2),d0
	ext.l	d0
	addq.l	#3,d0
	move.l	d0,-(sp)
	jsr		$143300
	move.w	d2,d1
	lsl.w	#2,d1
	movea.l	#$8182DC,a0
	move.l	d0,(a0,d1.w)
	move.l	2(a2),-(sp)
	moveq	#0,d0
	move.b	(a2),d0
	addi.l	#$C,d0
	move.l	d0,-(sp)
	pea		(2).w
	jsr		$102C62
	lea		$24(sp),sp
	clr.l	-(sp)
	pea		($6D).w
	pea		($1B).w
	pea		($E).w
	pea		($86).w
	move.w	$10(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	jsr		$143300
	movea.l	d0,a3
	move.l	a3,-(sp)
	clr.l	-(sp)
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#$8182DC,a0
	move.l	(a0,d0.w),-(sp)
	jsr		$15101E
	jsr		$103F30
	move.l	2(a2),-(sp)
	moveq	#0,d0
	move.b	(a2),d0
	addi.l	#$C,d0
	move.l	d0,-(sp)
	pea		(2).w
	jsr		$10388E
	lea		$30(sp),sp
	move.l	d2,-(sp)
	jsr		$15C032
	addq.l	#4,sp
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.w	loc_1439B2
	movem.l	(sp)+,d2/a2-a3
	rts

sub_144284:	; 開啟隱藏人物選擇權限
	moveq	#0,d2
loc_144286:
	move.w	d2,d0
	addq.w	#5,d0
	move.w	d0,($D00002).l
	clr.w	($D00004).l
	pea		($76).w
	jsr		$13A27E
	move.w	d2,d0
	addq.w	#5,d0
	move.w	d0,($D00002).l
	move.w	-$2A(a6),($D00004).l
	pea		($78).w
	jsr		$13A27E
	addq.l	#8,sp
	addq.l	#1,-$2C(a6)
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_144286
	jsr		$100D74		; 原代碼
	rts


sub_14B004:	; 預寫色盤|16色
; 我方色盤
	pea		(word_30ECD8).l	; 士氣條閃爍[08]
	pea		(4).w	; A01080
	clr.l	-(sp)	; 騰出佔用[$107604]
	jsr		($10388E).l
	lea		$C(sp),sp
	pea		(word_30EC98).l	; 我方生命槽[0A]
	pea		(5).w	; A010A0
	clr.l	-(sp)
	jsr		($10388E).l
	lea		$C(sp),sp
; 敵方色盤
	pea		(word_30ECB8).l	; 敵將前三層血槽色盤
	pea		(6).w			; 第六組16色
	clr.l	-(sp)			; A010C0
	jsr		($10388E).l
	lea		$C(sp),sp
	pea		(word_30ECB9).l	; 敵將中三層血槽色盤
	pea		($D).w			; 第十三組16色
	clr.l	-(sp)			; A011A0
	jsr		($10388E).l
	lea		$C(sp),sp
	pea		(word_30ECBA).l	; 敵將後三層血槽色盤
	pea		($E).w			; 第十四組16色
	clr.l	-(sp)			; A011C0
	jsr		($10388E).l
	lea		$C(sp),sp
; 頭像色盤
	pea		(word_30EC38).l	; 頭像色盤一[0E]
	pea		(7).w	; A010E0
	clr.l	-(sp)
	jsr		($10388E).l
	lea		$C(sp),sp
	pea		(word_30EC58).l	; 頭像色盤二[11]
	pea		(8).w	; A01100
	clr.l	-(sp)
	jsr		($10388E).l
	lea		$C(sp),sp
	pea		(word_30EC78).l	; 頭像色盤三[13]
	pea		(9).w	; A01120
	clr.l	-(sp)
	jsr		($10388E).l
	lea		$C(sp),sp
; 其他色盤
	pea		($30ECF8).l		; 換將計時條[14]
	pea		($A).w	; A01140
	clr.l	-(sp)
	jsr		($10388E).l
	lea		$C(sp),sp
	pea		($30EDD8).l
	pea		($B).w
	clr.l	-(sp)
	jsr		($10388E).l
	lea		$C(sp),sp
	pea		(word_30ED98).l		; 生命數、等級[1E]
	pea		($F).w
	clr.l	-(sp)
	jsr		($10388E).l
	lea		$C(sp),sp
	rts

word_30ECD8:	; 我方士氣條閃爍色盤[08]
	dc.w	$EAAF,$FFD5,$FFC0,$FEC0,$C3F6,$8BAE,$826D,$C3F6
	dc.w	$8BAE,$826D,$9CE7,$A94A,$8421,$BD48,$D1EA,$0000

word_30EC98:	; 我方生命槽、士氣條色盤[0A]
	dc.w	$EAAF,$FFD5,$FFC0,$FEC0,$C3F6,$8BAE,$826D,$826D
	dc.w	$8BAE,$C3F6,$9CE7,$A94A,$8421,$BD48,$D1EA,$0000

word_30ECB8:	; 血槽瓦片色盤[赤|橙|黃]
	dc.w	$F64F,$F083,$FAC6,$FD40,$FBAC,$EEA0,$B9CF,$9084
	dc.w	$FFFF,$DAD6,$8000,$FFD5,$A94A,$9CE7,$BD48,$0000

word_30ECB9:	; 血槽瓦片色盤[綠|藍|靛]
	dc.w	$8B04,$9DE3,$86FF,$817F,$8E1F,$A41B,$FBAC,$EEA0
	dc.w	$FFFF,$DAD6,$8000,$FFD5,$A94A,$9CE7,$BD48,$0000

word_30ECBA:	; 血槽瓦片色盤[白|灰|黑]
	dc.w	$FFFF,$DAD6,$DAD6,$B9CE,$B9CF,$9084,$8E1F,$A41B
	dc.w	$FFFF,$DAD6,$8000,$FFD5,$A94A,$9CE7,$BD48,$0000

word_30EC38:	; 頭像色盤1-7[0E]
	dc.w	$FDEA,$8000,$B8C7,$E5EB,$FECF,$FF99,$FFD6,$B129
	dc.w	$C9ED,$E715,$EDE1,$FF08,$FFAE,$C821,$E0E3,$0000

word_30EC58:	; 頭像色盤2-8[10]
	dc.w	$FFFF,$8421,$B8E1,$F64B,$FF11,$FFD6,$D35F,$B5B8
	dc.w	$AD32,$A8AC,$82DF,$AD48,$C9ED,$E1C5,$FF20,$0000

word_30EC78:	; 頭像色盤3-9[13]
	dc.w	$B569,$8421,$ACA1,$DDA7,$F68D,$FFD6,$FFFF,$956D
	dc.w	$A230,$AEF2,$D3DD,$9CC5,$BED9,$EB37,$D64E,$0000

word_30ED98:	; 我方生命、等級數目色盤[1E]
	dc.w	$0421,$7FFF,$7E40,$7F00,$7FE0,$02DF,$239F,$43FF
	dc.w	$7CE7,$7DEF,$7F18,$6E9E,$7F5F,$9CE7,$A94A,$0000

byte_1EB296:; 頭像色表號
	dc.b	7,9,7,7,8,7,7,0,8,7	; 我方角色[0-9]
	dc.b	9,8,8,7,0,7,0,7,7,7	; $A
	dc.b	8,7,7,0,7,7,7,8,7,8	; $14
	dc.b	7,7,9,9,9,$0	; $1E


sub_14CC02:
	cmpi.w	#1,d0		; 等級是否[0-9]
	bne.s	locret_14CC02
	clr.l	(a2)		; 重置顯存
	move.w	#$CAFE,(a2)	; 寫入數字[0]
	moveq	#$1F,d0
	and.l	d3,d0		; 色表號
	add.l	d0,d0
	andi.b	#$C1,3(a2)
	or.b	d0,3(a2)
	addq.l	#4,a2
locret_14CC02:	; 原代碼
	lea		-4(a6),a0
	move.l	a0,-8(a6)
	rts


sub_14CF4C:
	addi.w	#-$30,d0	; 原代碼
	move.w	d0,(a3)		; 寫入顯存
	moveq	#$1F,d0
	andi.l	#$B,d0		; 色表號
	add.l	d0,d0
	andi.b	#$C1,3(a3)
	or.b	d0,3(a3)
	rts


sub_14ABCC:
	moveq	#2-1,d4			; 兩次分配
	move.b	1(a3),d5		; 角色P號
loc_14ABCE:
	andi.l	#1,d5
	bne.s	loc_14ABCC		; 2/4P先數目後乘號
; 等級乘號瓦片
	clr.l	-(sp)
	jsr		$108A64			; 貼圖區C000
	movea.l	$30FB6A.l,a0	; 貼圖組
	movea.l	4(a0),a0
	move.w	(a0),d1
	andi.l	#$FFFF,d1
	add.l	d1,d0
    addq.l	#2,d0           ; CAEA
	clr.l	(a2)
	move.w	d0,(a2)
	moveq	#$1F,d0
	and.l	d2,d0
	add.l	d0,d0
	andi.b	#$C1,3(a2)
	or.b	d0,3(a2)		; [x]
	bra.s	loc_14ABCD
; 等級數目瓦片
loc_14ABCC:
	clr.l	-(sp)
	jsr		$108A64			; 貼圖區C000
	movea.l	$30FB6A.l,a0	; 貼圖組
	movea.l	$44(a0),a0
	move.w	(a0),d1
	andi.l	#$FFFF,d1
	add.l	d1,d0
	move.l	d0,d3
	moveq	#0,d0
	move.b	5(a3),d0
	subq.l	#1,d0
	add.l	d0,d3
	clr.l	(a2)
	move.l	d3,d0
	addq.l	#1,d3
	move.w	d0,(a2)
	moveq	#$1F,d0
	and.l	d2,d0
	add.l	d0,d0
	andi.b	#$C1,3(a2)
	or.b	d0,3(a2)		; [0]
; 切換分配瓦片
loc_14ABCD:
	addq.l	#1,d5
	addq.l	#4,a2
	dbra	d4,loc_14ABCE
	addq.l	#8,sp
	rts


sub_14CF8E:
	movem.l	a1-a3,-(sp)
	cmpi.b	#2, (a1)
	bne.s	loc_14CF8E
; 打印數值
	moveq	#0,d0
	movea.l	$10(a1),a2	; 當前角色OBJ
	move.w	$6C(a2),d0	; 當前生命值
	move.l	d0,-(sp)
	pea		aHitPoint	; 十進制二位整型数右對齊
	pea		(7).w		; TROM原生字體
	pea		(5).w		; 漸變金色
	moveq	#0, D0
	move.b	1(a1),d0
	lsl.l	#2,d0
	movea.l	#unk_14CF8E,a3
	adda.l	d0,a3
	move.w	2(a3),d0	; 縱坐標
	move.l	d0,-(sp)
	move.w	(a3),d0		; 橫坐標
	move.l	d0,-(sp)
	clr.l	-(sp)
	jsr		($107FAA).l
	lea		$1C(sp),sp	; 出棧*7
; 原代碼
loc_14CF8E:
	movea.l	(sp),a1		; 恢復角色基址
	tst.w   8(a1)
	beq.s	loc_14CFFC
	tst.w	8(a1)
	bge.s	loc_14CFCC
	tst.b	$240(a1)
	bne.s	loc_14CFAA
	move.b	#8,$240(a1)
	subq.l	#4,$242(a1)
loc_14CFAA:
	movea.l	#$14CFAA,a0
	bra.s	locret_14CF8E
loc_14CFCC:
	movea.l	#$14CFCC,a0
	bra.s	locret_14CF8E
loc_14CFFC:
	movea.l	#$14CFFC,a0
locret_14CF8E:
	movem.l	(sp)+,a1-a3
	rts

aHitPoint:	; 三位十進制整數
	dc.b	'%03d',0,0
unk_14CF8E:	; 生命值數顯坐標
	dc.w	$0000,$0002		; (1P)
	dc.w	$0035,$0002		; (2P)
	dc.w	$0000,$0019		; (3P)
	dc.w	$0035,$0019		; (4P)


sub_124F78:
; 畫生命槽
	moveq	#0,d0
	move.w	$6C(a4),d0
	move.l	d0,-8(a6)
	clr.w	$1CC(a2)
	move.l	-8(a6),d0
	addi.l	#$13F,d0
	move.l	#$140,d1		; 一管320滴血
	jsr		$1BEC0E			; [d0/d1]有符號相除
	move.l	d0,-$C(a6)		; 血槽數目
	move.b	-9(a6),$1CA(a2)	; 寄存數目[$80C99A]
	move.b	-9(a6),$1CB(a2)	; 寄存數目[$80C99B]
	moveq	#0,d3
	bra.w	loc_12511C
loc_124FB2:
; 計算顯存地址
	moveq	#0,d0
	move.w	($80CBB4).l,d0	; 縱坐標
	move.l	d7,d1			; 一王[0]或二王[1]
	add.l	d1,d1
	sub.l	d1,d0			; 不使用第二位置的顯存|$12508A
	lsl.l	#8,d0
	addi.l	#$90402C,d0		; 敵將血槽右移
	move.l	d0,6(a2)
; 打印完整血槽
	move.l	d0,-(sp)		; 顯存地址
	move.l	-8(a6),-(sp)	; 待畫血量
	move.l	d3,-(sp)		; 第幾血槽
	move.l	a2,-(sp)		; 血槽OBJ
	jsr		sub_124FD2
	lea		$10(sp),sp
; 更新血槽數值
	move.l	d0,d2			; 已畫瓦片數
	move.b	d0,1(a2)
	lsl.w	#3,d0
	add.w	d0,$1CC(a2)		; 更新血槽值
	move.l	d1,-8(a6)		; 更新待畫值
	move.b	#8,2(a2)
	move.l	d2,d0
	lsl.l	#2,d0
	add.l	d0,6(a2)		; 下一顯存地址
	clr.w	4(a2)
	addq.l	#1,d3
loc_12511C:
	cmp.l	-$C(a6),d3		; 需畫的血槽數
	blt.w	loc_124FB2
	move.b	#2,(a2)
	rts

sub_1256E8:
; 原代碼
	cmpi.b	#2,($80C7D0).l
	bne.s	loc_1256FE
	pea		($80C7D0).l		; 生命槽一OBJ
	bsr.s	sub_1255CE		; 敵將生命槽變動
	addq.l	#4,sp
; 敵將生命值數顯[1]
	moveq	#0,d0
	move.w	($80CBB4).l,d0	; 生命槽縱坐標
	addq.l	#1,d0
	move.l	d0,-(sp)		; 數顯縱坐標
	pea		$80C7D0.l		; 生命槽一OBJ
	pea		(ram_000E+0).l	; 敵將一序號寄存
	bsr.w	sub_1255CF
	lea		$C(sp),sp
loc_1256FE:
; 原代碼
	cmpi.b	#2,($80C99E).l
	bne.s	locret_125714
	pea		($80C99E).l		; 生命槽二OBJ
	bsr.s	sub_1255CE		; 敵將生命槽變動
	addq.l	#4,sp
; 敵將生命值數顯[2]
	moveq	#0,d0
	move.w	($80CBB4).l,d0	; 生命槽縱坐標
	subq.l	#1,d0
	move.l	d0,-(sp)		; 數顯縱坐標
	pea		$80C99E.l		; 生命槽二OBJ
	pea		(ram_0010+0).l	; 敵將二序號寄存
	bsr.w	sub_1255CF
	lea		$C(sp),sp
locret_125714:
	rts

sub_1255CE:	; 調整生命槽
	link	a6,#0
	movem.l	d2-d3/a2,-(sp)
	movea.l	8(a6),a2
	tst.w	4(a2)			; 是否變動
	beq.w	loc_1256E2
	tst.w	4(a2)			; 是增是減
	bge.w	loc_12567A
; 減少生命值|分配瓦片
	subq.w	#1,$1CC(a2)		; 生命槽血量-1
	moveq	#0,d0
	move.w	$1CC(a2),d0
	move.l	#$140,d1
	jsr		$1BEC0E.l		; d0/d1,d0
	lsl.l	#3,d0
	movea.l	#unk_124FB2,a0
	move.l	(a0,d0.l),d2	; 瓦片編號
	move.l	4(a0,d0.l),d3	; 色盤組號
; 減少生命值|重置瓦片
	tst.b	2(a2)
	bne.s	loc_125658
	move.b	#8,2(a2)		; 一瓦片8血
	subq.l	#4,6(a2)
	subq.b	#1,1(a2)
	tst.b	1(a2)			; 當前層空血否
	bne.s	loc_125658
	move.b	#$28,1(a2)		; 槽血40個像素
	addi.l  #$A0,6(a2)		; 回到顯存結尾
	subq.b	#1,$1CB(a2)		; 生命槽數目-1
	move.w	d2,d1			; 瓦片編號
	addi.w	#$C,d1
	movea.l	6(a2),a0
	adda.l	#$C,a0
	move.w	d1,(a0)			; 刷新槽目瓦片
	moveq	#$1F,d0
	and.l	d3,d0
	add.l	d0,d0
	andi.b	#$C1,3(a0)
	or.b	d0,3(a0)		; 刷新槽血色盤
; 減少生命值|刷新瓦片
loc_125658:
	subq.b	#1,2(a2)
	moveq	#0,d0
	move.b	2(a2),d0
	move.w	d2,d1			; 瓦片編號
	sub.w	d0,d1
	addi.w	#9,d1
	movea.l	6(a2),a0		; 當前顯存地址
	move.w	d1,(a0)			; 刷新槽血瓦片
	moveq	#$1F,d0
	and.l	d3,d0
	add.l	d0,d0
	andi.b	#$C1,3(a0)
	or.b	d0,3(a0)		; 刷新槽血色盤
	addq.w	#1,4(a2)
	bra.w	loc_1256E2
loc_12567A:
; 增加生命值|分配瓦片
	moveq	#0,d0
	move.w	$1CC(a2),d0
	move.l	#$140,d1
	jsr		$1BEC0E.l		; d0/d1,d0
	lsl.l	#3,d0
	movea.l	#unk_124FB2,a0
	move.l	(a0,d0.l),d2	; 瓦片編號
	move.l	4(a0,d0.l),d3	; 色盤組號
; 增加生命值|重置瓦片
	cmpi.b	#8,2(a2)		; 一瓦片8血
	bne.s	loc_1256C2
	clr.b	2(a2)
	addq.l	#4,6(a2)
	addq.b	#1,1(a2)
	cmpi.b	#$29,1(a2)		; 是否槽尾41
	bne.s	loc_1256C2
	move.b	#1,1(a2)		; 瓦片第一血
	move.w	d2,d1			; 瓦片編號
	addi.w	#$C,d1
	move.l	6(a2),a0
	addq.l	#8,a0
	move.w	d1,(a0)			; 刷新槽目瓦片
	moveq	#$1F,d0
	and.l	d3,d0
	add.l	d0,d0
	andi.b	#$C1,3(a0)
	or.b	d0,3(a0)		; 刷新槽血色盤
	subi.l	#$A0,6(a2)		; 回到顯存開頭
	addq.b	#1,$1CB(a2)		; 生命槽數目+1
loc_1256C2:
; 增加生命值|刷新瓦片
	addq.b	#1,2(a2)
	moveq	#0,d0
	move.b	2(a2),d0
	move.w	d2,d1			; 瓦片編號
	sub.w	d0,d1
	addi.w	#9,d1
	movea.l	6(a2),a0
	move.w	d1,(a0)			; 刷新槽血瓦片
	moveq	#$1F,d0
	and.l	d3,d0
	add.l	d0,d0
	andi.b	#$C1,3(a0)
	or.b	d0,3(a0)		; 刷新槽血色盤
	subq.w	#1,4(a2)
	addq.w	#1,$1CC(a2)		; 生命槽血量+1
loc_1256E2:
	movem.l	(sp)+,d2-d3/a2
	unlk	a6
	rts

unk_124FB2:	; 血槽瓦片編號+色盤組號
	dc.l	$C950,6,$C95D,6,$C96A,6
	dc.l	$C977,13,$C984,13,$C991,13
	dc.l	$C99E,14,$C9AB,14,$C9B8,14

sub_124FD2:	; 打印完整血槽
	link	a6,#0
	movem.l	d2-d7/a2-a3,-(sp)
	move.l	$10(a6),d7		; 待畫血量
	move.l	$C(a6),d3		; 第幾血槽
	movea.l	8(a6),a2		; 血槽OBJ
	moveq	#0,d2			; 槽血瓦片
; 分配瓦片編號
	move.l	d3,d0
	lsl.l	#3,d0
	movea.l	#unk_124FB2,a0
	move.l	(a0,d0.l),d4	; 瓦片編號
	move.l	4(a0,d0.l),d5	; 色盤組號
; 寫入完整血槽|計算瓦片寄存
	moveq	#1,d0
	and.l	d3,d0
	move.l	d0,d1
	lsl.l	#3,d0
	sub.l	d1,d0
	lsl.l	#5,d0
	add.l	a2,d0
	addi.l	#$A,d0
	movea.l	d0,a3
; 寫入槽頭瓦片
	clr.l	(a3)
	move.w	d4,(a3)
	moveq	#$1F,d0			; 16組16色
	and.l	d5,d0
	add.l	d0,d0
	andi.b	#$C1,3(a3)
	or.b	d0,3(a3)
	addq.l	#4,a3
	cmpi.l	#$140,d7
	ble.s	loc_12505E
; 下層生命槽血
loc_125012:
	clr.l	(a3)
	move.w	d4,d0
	addq.w	#1,d0			; 第二個瓦片|滿血槽塊
	move.w	d0,(a3)
	moveq	#$1F,d0
	and.l	d5,d0
	add.l	d0,d0
	andi.b	#$C1,3(a3)
	or.b	d0,3(a3)
	addq.l	#4,a3
	addq.l	#1,d2
	moveq	#$28,d0			; 重複44個
	cmp.l	d2,d0
	bgt.s	loc_125012
	subi.l	#$140,d7
	bra.s	loc_125070
; 上層生命槽血
loc_125042:
	clr.l	(a3)
	move.w	d4,d0
	addq.w	#1,d0			; 第二個瓦片|滿血空槽
	cmpi.b	#$29,1(a2)		; 是否滿血槽|加血狀態
	bne.s	loc_125043
	addq.w	#8,d0			; 下面一層血槽
loc_125043:
	move.w	d0,(a3)
	moveq	#$1F,d0
	and.l	d5,d0
	add.l	d0,d0
	andi.b	#$C1,3(a3)
	or.b	d0,3(a3)
	addq.l	#4,a3
	addq.l	#1,d2
loc_12505E:
	move.l	d7,d0
	bge.s	loc_125066
	addq.l	#7,d0			; 每血槽塊8個生命值
loc_125066:
	asr.l	#3,d0
	cmp.l	d2,d0
	bgt.s	loc_125042
	clr.l	d7				; 完成待画血槽值
; 寫入槽尾瓦片
loc_125070:
	moveq	#$A,d6			; 槽尾瓦片序號
loc_1250B2:
	clr.l	(a3)
	move.w	d4,d0
	add.w	d6,d0
	move.w	d0,(a3)
	moveq	#$1F,d0
	and.l	d5,d0
	add.l	d0,d0
	andi.b	#$C1,3(a3)
	or.b	d0,3(a3)
	addq.l	#4,a3
	addq.w	#1,d6
	cmpi.l	#$D,d6			; 三瓦片A|B|C
	bcs.s	loc_1250B2
; 寫入待畫數據
	clr.l	-(sp)
	move.l	$14(a6),-(sp)	; 顯存地址
	pea		(1).w
	move.l	d2,d0			; 中間瓦片數
	addq.l	#4,d0			; 首尾四瓦片
loc_1250DA:
	move.l	d0,-(sp)
	clr.l	-(sp)
	moveq	#1,d0
	and.l	d3,d0
	move.l	d0,d1
	lsl.l	#3,d0
	sub.l	d1,d0
	lsl.l	#5,d0
	add.l	a2,d0
	addi.l	#$A,d0
	move.l	d0,-(sp)
	jsr		$149196			; 分配打印任務
	addq.l	#4,sp
	move.l	d0,-(sp)
	jsr		$1491F8			; 寫入待畫數據
	lea		$18(sp),sp
	move.l	d2,d0			; 傳出中間瓦片數
	move.l	d7,d1			; 傳出待畫血槽值
	movem.l	-$20(a6),d2-d7/a2-a3
	unlk	a6
	rts

sub_1255CF:	; 打印數值
	link	a6,#0
	move.l	a2,-(sp)
; 打印速殺計時器
	movea.l	8(a6),a2		; 敵將序號寄存
	tst.l	8(a2)			; 計時器是否開啟
	beq.s	loc_1255D0
	move.l	8(a2),-(sp)
	jsr		$100E62			; 獲取時間
	addq.l	#4,sp
	addi.l	#59,d0			; 01~60=1秒
	divu.w	#60,d0			; 換算成秒
	ext.l	d0
	move.l	d0,-(sp)
	beq.s	loc_1255CE		; 是否為零
	pea		aTime			; 十進制4位整型数右對齊
	bra.s	loc_1255CF
loc_1255CE:
	pea		(aTime+$A).l	; "TIME'S UP"
loc_1255CF:
	clr.l	-(sp)			; PGM原生字體
	pea		$2.w			; 藍色色
	move.l	$10(a6),-(sp)	; 縱坐標
	pea		($21).w			; 橫坐標
	clr.l	-(sp)
	jsr		$107FAA.l
	lea		$1C(sp),sp
; 打印敵將位目
loc_1255D0:
	move.b	1(a2),d0		; 當前敵將位目
	andi.l	#$FF,d0
	move.l	d0,-(sp)
	pea		aNumber			; 十進制2位整型数右對齊
	clr.l	-(sp)			; PGM原生字體
	pea		$1.w			; 黃色
	move.l	$10(a6),-(sp)	; 縱坐標
	pea		($C).w			; 橫坐標
	clr.l	-(sp)
	jsr		$107FAA.l
	lea		$1C(sp),sp
; 打印敵將生命值
	movea.l	$C(a6),a2		; 生命槽OBJ
	move.w	$1CC(a2),d0		; 當前生命槽數值
	move.l	d0,-(sp)
	pea		aHealth			; "HEALTH:2880"
	clr.l	-(sp)			; PGM原生字體
	pea		$1.w			; 黃色
	move.l	$10(a6),-(sp)	; 縱坐標
	pea		($13).w			; 橫坐標
	clr.l	-(sp)
	jsr		$107FAA.l
	lea		$1C(sp),sp
	movea.l	(sp)+,a2
	unlk	a6
	rts

aTime:
	dc.b	'TIME:%03d',0
	dc.b	'TIME',$27,'S UP',0
aNumber:
	dc.b	'NO.%0d',0,0
aHealth:
	dc.b	'HEALTH:%04d',0


sub_166440:	; 三段式士氣條
; 士氣是否已滿
	cmpi.w	#$48,$208(a4)
	bcc.s	locret_166440
; 士氣三分之二
	cmpi.w	#$30,$208(a4)
	bcs.s	loc_166441
	pea		(6).w
	bsr.s	sub_90412C
	addq.l	#4,sp
	bra.s	locret_166440
loc_166441:
; 士氣三分之一
	cmpi.w	#$18,$208(a4)
	bcs.s	loc_166442
	pea		(3).w
	bsr.s	sub_90412C
	addq.l	#4,sp
	bra.s	locret_166440
loc_166442:
; 不到三分之一
	pea		(3).w
	bsr.s	sub_90412C
	addq.l	#4,sp
locret_166440:
; 原代碼
	moveq	#0,d0
	move.b  1(a3),d0
	rts

sub_90412C:	; 士氣條顯存調整
	move.l	d2,-(sp)
	moveq	#0,d0
	move.b	1(a3),d0
	add.w	d0,d0
	movea.l	#($2B51F4),a0		; 士氣條橫坐標
	move.w	(a0,d0.w),d1
	andi.l	#$FFFF,d1
	moveq	#0,d0
	move.b	1(a3),d0
	add.w	d0,d0
	movea.l	#($2B51F4+8),a0		; 士氣條縱坐標
	move.w	(a0,d0.w),d2
	andi.l	#$FFFF,d2
	move.l	D2,d0
	lsl.l	#8,d0
	lsl.l	#2,d1
	add.l	D1,d0
	addi.l	#$904000,d0
	movea.l	d0,a1			; 第一士氣段顯存地址
	addq.l	#4,a1
	move.l	8(sp),d2		; 循環總次數
	moveq	#0,d0			; 當前循環次數
loc_90412C:
	andi.b	#$C1,3(a1)
	cmpi.w	#$18,$208(a4)	; 士氣是否少於三分之一
	bcs.s	loc_90412D
	ori.b	#8,3(a1)		; 變白
	bra.s	loc_90412E
loc_90412D:
	ori.b	#$A,3(a1)		; 變青
loc_90412E:
	addq.l	#4,a1			; 遞增到下一士氣段
	addq.l	#1,d0
	cmp.l	d0,d2
	bhi.s	loc_90412C
	move.l	(sp)+,d2
	rts


sub_1660C6:	; 切換場景後修正士氣條顯存
	cmpi.w	#$18,$208(a3)	; 是否超過三分之一
	bcs.s	loc_1660C7
	cmpi.l	#3,d2
	bcc.s	loc_1660C6
	moveq	#4,d0			; 白閃|色表號
loc_1660C6:
	cmpi.w	#$30,$208(a3)	; 是否超過三分之二
	bcs.s	locret_1660C6
	cmpi.l	#6,d2
	bcc.s	loc_1660C7
	moveq	#4,d0			; 白閃|色表號
	bra.s	locret_1660C6
loc_1660C7:
	moveq	#5,d0			; 青色|色表號
locret_1660C6:
	rts


sub_1461FA:
	jsr		sub_145F3A		; 是否序章[0000|0003]
	tst.w	d0
	bne.w	locret_1461FA
	tst.b	(ram_0024+1).l	; 右下角信息輪換計數
	bne.w	loc_1461FE
	move.b	#$B4,(ram_0024+1).l	; 三秒一換
; 輪換信息
	moveq	#0,d0
	move.b	(ram_0024).l,d0
	cmpi.b	#3,d0
	bhi.w	loc_1461FE
	add.l	d0,d0
	move.w	jpt_1461FA(pc,d0.l),d0
	jmp		jpt_1461FA(pc,d0.w)
jpt_1461FA:
	dc.w	loc_1461FA-jpt_1461FA
	dc.w	loc_1461FB-jpt_1461FA
	dc.w	loc_1461FC-jpt_1461FA
	dc.w	loc_1461FD-jpt_1461FA
; 加強難度
loc_1461FA:
	addq.b	#1,(ram_0024).l		; 下一信息
	moveq	#0,d0
	move.b	(ram_0002).l,d0		; 難度+
	move.l	d0,-(sp)
	sne		d0
	andi.b	#1,d0				; 難度文本[0|1]
	lsl.l	#4,d0				; 偏移量
	movea.l	#aGameDifficulty,a0
	adda.l	d0,a0
	move.b	($81A326).l,d0		; 基本難度
	move.l	d0,-(sp)
	move.l	a0,-(sp)			; GAME DIFFICULTY
	bra.s	loc_107FAA
; 版本難度
loc_1461FB:
	addq.b	#1,(ram_0024).l		; 下一信息
	subq.l	#8,sp				; 堆棧-2
	move.b	(ram_0005).l,d0		; 版本100|107
	lsl.l	#4,d0				; 偏移量
	movea.l	#aGameDifficulty+$20,a0
	adda.l	d0,a0
	move.l	a0,-(sp)			; VERSION
	bra.s	loc_107FAA
; 12P投幣數
loc_1461FC:
	addq.b	#1,(ram_0024).l		; 下一信息
	subq.l	#4,sp				; 堆棧-1
	moveq	#0,d0	
	move.b	($8186C4).l,d0		; 12P投幣數
	move.l	d0,-(sp)
	pea		(aGameDifficulty+$40).l	; CREDIT 12
	bra.s	loc_107FAA
; 34P投幣數
loc_1461FD:
	clr.b	(ram_0024).l		; 重新輪換
	subq.l	#4,sp				; 堆棧-1
	moveq	#0,d0	
	move.b	($818ED0).l,d0		; 34P投幣數
	move.l	d0,-(sp)
	pea		(aGameDifficulty+$50).l	; CREDIT 34
; 打印設定
loc_107FAA:
	clr.l	-(sp)				; 黑體
	clr.l	-(sp)				; 白色
	pea		(6).w				; 縱坐標
	pea		($2A).w				; 橫坐標
	clr.l	-(sp)
	jsr		$107FAA.l
	lea		$20(sp),sp
loc_1461FE:
	subq.b	#1,(ram_0024+1).l
locret_1461FA:
	moveq	#0,d0				; 原代碼
	move.b	($8182FA).l,d0
	rts

aGameDifficulty:
	dc.b	'GAMEDIFF %d   ',0,0
	dc.b	'GAMEDIFF %d+%d',0,0
	dc.b	'VERSION  100  ',0,0
	dc.b	'VERSION  107  ',0,0
	dc.b	'CREDIT1,2 %2d ',0,0
	dc.b	'CREDIT3,4 %2d ',0,0


sub_12222A:
; 原代碼
	tst.l	$D4(a2)
	beq.s	loc_12222A
	clr.l	-(sp)
	move.l	$D4(a2),-(sp)
	jsr		$150838
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$15D912
	lea		$10(sp),sp
loc_12222A:
; 清除混亂符
	movea.l	$DC(a2),a0
	move.l	a0,d0
	beq.s	loc_12224A
	clr.w	$6A(a0)
	move.l	a0,-(sp)
	jsr		$14E464
	addq.l	#4,sp
	clr.l	$DC(a2)
	clr.w	$234(a2)	; 清除符篆計時
	clr.w	$238(a2)
loc_12224A:
	rts


sub_15828A:	; 執行動作腳本時修正角色高度
	move.b	$9B(a4),-$73(a6)	; 原代碼
	tst.w	$24(a4)				; 是否正常高度≤0
	ble.s	locret_15828A
	move.w	$1C8(a4),$24(a4)	; 恢復默認高度
locret_15828A:
	rts


sub_13DB50:
; 創建角色
	move.l	d6,-(sp)
	move.l	d6,d0
	lsl.l	#8,d0
	add.l	d6,d0
	add.l	d0,d0
	add.l	d6,d0
	add.l	d0,d0
	movea.l	#$8186C0,a0
	pea		(a0,d0.l)
	jsr		$14D750			
; 角色下場
	move.l	d6,d0
	lsl.l	#8,d0
	add.l	d6,d0
	add.l	d0,d0
	add.l	d6,d0
	add.l	d0,d0
	movea.l	#$8186C0,a0
	pea		(a0,d0.l)
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($B4).w
	move.l	d6,d0
	lsl.l	#4,d0
	sub.l	d6,d0
	add.l	d0,d0
	move.l	d0,-(sp)
	move.l	d6,-(sp)
	move.l	d6,-(sp)
	jsr		$15C390
	lea		$24(sp),sp
	rts


; --------------- 斗轉星移 --------------------------------------------------

sub_146DD2:	; 當前章節目
	moveq	#0,d0
	move.b	(ram_000D).l,d0
	rts


seg_1E7BA0:
	dc.b	$00,$1E,$12,$15,$0F,$16,$13,$0C
	dc.b	$1C,$18,$11,$0D,$20,$1A,$1F,$14
	dc.b	$1B,$19,$21,$0B,$09,$1D

sub_10FBCC:
	moveq	#0,d3
	move.w  $F6(a2),d3		; 敵人編號d3
	movea.l	$58(a2),a0
	cmpi.b	#2,(a0)			; 是否敵兵
	beq.s	locret_10FBCC
	movea.l	#seg_1E7BA0,a0	; 敵將分數編號表
	move.b	(ram_000C).l,d0	; 當前敵將位目
	andi.l	#$FF,d0
	adda.l	d0,a0			; 確定編號
	move.b	(a0),d3
locret_10FBCC:
	rts

sub_14705E:
	movea.l	#seg_1E7BA0,a0	; 敵將分數編號表
	move.b	(ram_000C).l,d0	; 當前敵將位目
	andi.l	#$FF,d0
	adda.l	d0,a0			; 確定編號
	move.b	(a0),d0
	lsl.l	#4,d0
	rts


sub_1130E0:	; 關卡AI設定，敵人出招頻率
	move.l	d2,-(sp)
	tst.b	(ram_0005).l	; 107版本否
	beq.s	loc_1130E0
	movea.l	#(word_1C188A-$12),a0	; 當前關卡出招頻率下限表
	movea.l	#(word_1C188A+$7E),a1	; 當前關卡出招頻率上限表
	bra.s	loc_1130E2
loc_1130E0:	; 100版本
	movea.l	#($1C0FB0-$12),a0	; 當前關卡出招頻率下限表
	movea.l	#($1C0FB0+$7E),a1	; 當前關卡出招頻率上限表
loc_1130E2:
	move.l	8(sp),d2		; 當前關卡
	moveq	#0,d0
	move.b	($803B82).l,d0	; 難度等級
	move.w	d0,d1
	lsl.w	#3,d0
	add.w	d1,d0
	add.w	d0,d0
	move.w	d2,d1
	add.w	d1,d1
	add.w	d1,d0
	move.w	(a0,d0.w),($80C2A8).l
	moveq	#0,d0
	move.b	($803B82).l,d0	; 難度等級
	move.w	d0,d1
	lsl.w	#3,d0
	add.w	d1,d0
	add.w	d0,d0
	move.w	d2,d1
	add.w	d1,d1
	add.w	d1,d0
	move.w	(a1,d0.w),($80C2AA).l
	move.l	(sp)+,d2
	rts

word_1C188A:
	dc.w	 $46, $5A, $5A, $5A, $6E, $82, $96, $AA,$1D6	; 出招頻率表[1]
	dc.w	 $46, $5A, $5A, $5A, $6E, $82, $96, $AA,$1D6	; 9
	dc.w	 $64, $78, $78, $8C, $A0, $B4, $C8, $DC,$1F4	; $12
	dc.w	 $96, $AA, $BE, $D2, $E6, $FA,$10E,$122,$212	; $1B
	dc.w	 $B4, $C8, $DC, $F0,$118,$12C,$140,$140,$230	; $24
	dc.w	 $E6,$10E,$122,$15E,$186,$1AE,$1D6,$1FE,$24E	; $2D
	dc.w	$104,$12C,$140,$17C,$1A4,$1CC,$1F4,$21C,$26C	; $36
	dc.w	$136,$15E,$172,$1AE,$1D6,$1FE,$226,$24E,$28A	; $3F
	dc.w	 $AA, $FA,$10E,$122,$136,$14A,$15E,$172,$1D6	; 出招頻率表[2]
	dc.w	 $AA, $FA,$10E,$122,$136,$14A,$15E,$172,$1D6	; 9
	dc.w	 $C8,$12C,$140,$154,$168,$17C,$190,$190,$1F4	; $12
	dc.w	 $FA,$172,$172,$186,$19A,$19A,$1AE,$1C2,$212	; $1B
	dc.w	$118,$1CC,$1CC,$1E0,$1F4,$208,$21C,$21C,$230	; $24
	dc.w	$14A,$1FE,$212,$262,$28A,$2B2,$2DA,$302,$24E	; $2D
	dc.w	$168,$230,$244,$294,$2BC,$2E4,$30C,$334,$26C	; $36
	dc.w	$19A,$262,$276,$2C6,$2EE,$316,$33E,$366,$28A	; $3F


sub_162410:
	tst.b	($8182F9).l		; 是否終章[0004]
	beq.s	loc_162410
	bsr.s	sub_2B3D36		; 隨機敵將
	bsr.w	sub_1465E6		; 隨機場景
	clr.l	($81A2DA).l		; 下一章節
	bra.s	locret_162410
loc_162410:
	move.l	#2,($81A2DA).l	; 結束當前周目
locret_162410:
	move.l	($81A2DA).l,d0
	rts


sub_2B3D36:	; 隨機一二敵將
	movem.l	d2/a2,-(sp)
; 是否雙王
	moveq	#0,d2
loc_2B3D3C:
; 隨機編號
	pea		(21).w				; [00-20]敵將
	jsr		$102480				; 大隨機
	addq.l	#4,sp
	moveq	#$1,d1				; 大循環1次
loc_2B3D36:
	movea.l	#ram_0012,a2		; 敵將標記寄存
	adda.l	d0,a2				; 從隨機號開始
loc_2B3D37:
	tst.b	(a2)
	beq.s	loc_2B3D38
; 循環判斷
	addq.l	#1,d0
	addq.l	#1,a2				; 循環判斷隨機值的最近場景
	cmpi.l	#21,d0				; 敵將目不超過#21
	blt.s	loc_2B3D37
	moveq	#$0,d0				; 輪回到敵將號一
	dbf		d1,loc_2B3D36
; 標記敵將
loc_2B3D38:
	move.b	#1,(a2)				; 標記已出敵將
	movea.l	#ram_000E+0,a2		; 敵將序號寄存
	move.l	d2,d1
	mulu.w	#$C,d1				; 敵將一寄存與敵將二12個字節偏移
	adda.l	d1,a2
	move.b	d0,(a2)				; [00-20]下一敵將序號
	addq.b	#1,(ram_000C).l		; [01-21]第幾位敵將
	move.b	(ram_000C).l,1(a2)	; 敵將位目
	addq.l	#1,d2
; 調整難度+|前三敵將關卡[00-03]
	move.b	(ram_0002).l,(ram_0003).l	; 恢復默認敵人模式
	cmpi.b	#3,(ram_000C).l
	bhi.s	loc_2B3D39
	tst.b	(ram_0002).l		; 是否最低難度+0
	beq.s	loc_2B3D3B
	subq.b	#1,(ram_0003).l		; 降低難度
	bra.s	loc_2B3D3B
; 調整難度+|中間敵將關卡[04-19]
loc_2B3D39:
	cmpi.b	#19,(ram_000C).l
	bhi.s	loc_2B3D3A
	move.b	(ram_0002).l,(ram_0003).l	; 還原難度+
	bra.s	loc_2B3D3B
; 調整難度+|終二敵將關卡[20|21]
loc_2B3D3A:
	cmpi.b	#3,(ram_0003).l		; 是否最高難度+3
	beq.s	loc_2B3D3B
	addq.b	#1,(ram_0003).l		; 增加難度
loc_2B3D3B:
	moveq	#0,d0
	move.b	(ram_0003).l,d0		; 雙王[+3]
	divu.w	#3,d0				; 雙王[01]
	cmp.w	d0,d2
	bls.w	loc_2B3D3C
; 等階關卡
	moveq	#0,d0
	move.b	(ram_000C).l,d0
	lsr.b	#1,d0				; [00-0A]
	btst	#3,d0				; 是否大於07[0111]
	beq.s	loc_2B3D3D
	moveq	#7,d0
loc_2B3D3D:
	move.b	d0,(ram_000D).l		; 計算結果
	movem.l	(sp)+,d2/a2
	rts


sub_1465E6:	; 隨機場景
	movem.l	a2,-(sp)
	pea		(24).w				; [00-23]場景
	jsr		$102480				; 大隨機
	addq.l	#4,sp
	moveq	#$1,d1				; 大循環1次
loc_1465E6_1:
	movea.l	#ram_0013+2,a2		; 場景標記寄存
	adda.l	d0,a2				; 從隨機號開始
loc_1465E6_2:
	tst.b	(a2)
	bne.s	loc_1465E6_3
	move.w	d0,(ram_0013).l		; [00-23]下一場景序號
	move.b	#1,(a2)				; 標記已出場景
	movea.l	#unk_1465E6,a2		; 關卡表
	lsl.l	#$1,d0
	adda.l	d0,a2				; 下一場景值
	move.b	(a2),$8182F9		; 寫入章節序號
	move.b	1(a2),$8182FA		; 寫入場景序號
	bra.s	locret_1465E6
loc_1465E6_3:
	addq.l	#1,d0
	addq.l	#1,a2				; 循環判斷隨機值的最近場景
	cmpi.l	#24,d0				; 場景目不超過#24
	blt.s	loc_1465E6_2
	moveq	#$0,d0				; 輪回到場景號一
	dbf		d1,loc_1465E6_1
locret_1465E6:
	movem.l	(sp)+,a2
	rts
unk_1465E6:
	dc.w	$0100
	dc.w	$0200,$0202,$0203,$0204
	dc.w	$0300,$0301,$0302
	dc.w	$0400,$0403,$040B
	dc.w	$0500,$0501,$0502,$0503,$0504
	dc.w	$0600,$0601,$0602,$0603
	dc.w	$0701,$0703,$0704,$0705
	dc.w	0


sub_17592E:	; 敵將出場
	link	a6,#0
	movem.l	d2-d4/a2-a4,-(sp)
	clr.b	($81B93C).l			; 敵方不攻擊
	clr.b	($80C2B5).l			; 全局無判定
; 設定敵將出場坐標[坐標基址]
	movea.l	#off_17592E,a3		; 敵將表
	move.l	8(a6),d3			; 敵將編號
	mulu.w	#$C,d3				; 運算結果覆蓋高位
	adda.l	d3,a3				; 敵將信息
	movea.l	#seg_17592E,a4		; 坐標表
	move.w	(ram_0013).l,d4		; 場景序號
	mulu.w	#$C,d4				; 運算結果覆蓋高位
	adda.l	d4,a4				; 坐標信息
; 設定敵將出場坐標[固定坐標]
	moveq	#0,d0
	clr.l	-(sp)
	move.w	2(a4),d0			; 面向
	move.l	d0,-(sp)
	move.w	$8(a3),d0			; Z坐標
	move.l	d0,-(sp)
	tst.w	$A(a3)				; 是否根據角色定位
	bne.s	loc_175930
	move.w	6(a4),d0			; Y坐標
	move.l	d0,-(sp)
	move.w	($D0A000).l,d0
	move.w	4(a4),d1			; X偏移值
	tst.w	2(a4)				; 是否面右
	beq.s	loc_17592E
	addi.w	#$1C0,d0			; 最右坐標
	add.w	d1,d0				; X坐標
	bra.s	loc_17592F
loc_17592E:
	sub.w	d1,d0				; X坐標偏左
loc_17592F:
	move.l	d0,-(sp)
	bra.s	loc_175931
; 設定敵將出場坐標[定位坐標]
loc_175930:
	jsr		$15EC62				; 判斷第一角色OBJ
	movea.l	d0,a2
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	move.l	d0,-(sp)			; 鎖定角色坐標
; 設定敵將出場動作
loc_175931:
	move.l	(a3),d0				; 敵將指針
	move.l	d0,-(sp)
	jsr		$109CC2				; 分配OBJ
	move.l	d0,d2
	move.l	d2,-(sp)
	jsr		$10A1BA				; 敵方出場
	move.l	d2,-(sp)
	jsr		$10F2C2
	movea.l	d0,a2
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10FC92
	moveq	#$0,d0
	move.w	$6(a3),d0			; 動作編號
	move.l	d0,-(sp)
	move.W	$4(a3),d0			; 動作類目
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EBDE				; 計算指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18				; 寫入動作
	lea		$30(sp),sp
; 初始化敵將信息
	clr.w	$1DE(a2)
	clr.w	$216(a2)
	move.w	#8,$218(a2)			; 未知信息
	jsr		sub_109CC3			; 在場敵將數目
	subq.l	#1,d0
	move.w	d0,$11E(a2)			; 記錄
	move.l	a2,-(sp)
	jsr		sub_1A87EC			; 計算生命值
	addq.l	#4,sp
	move.w	d0,$6C(a2)
	move.l	a2,-(sp)
	jsr		sub_10A126			; 游戲時間以及血條等
	addq.l	#4,sp
; 敵將出場對話等
loc_175932:
	move.w	#1,$174(a2)			; 無敵容錯
	jsr		($13A646).l			; 主循環
	cmpi.w	#2,$50(a2)			; 是否完成動作
	bne.w	loc_175932			; 繼續循環
	move.w	$24(a2),$286(a2)	; 記錄敵將高度
	clr.l	-(sp)				; 出場對話
	move.l	8(a6),-(sp)			; 敵將編號
	move.l	a2,-(sp)			; 敵將OBJ
	bsr.w	sub_1343D6			; 處理對話
	lea		$C(sp),sp
	move.b	#1,($81B93C).l		; 敵方開始攻擊
	move.b	#1,($80C2B5).l		; 全局恢復判定
	move.l	a2,d0				; 傳出敵將OBJ
	movem.l	(sp)+,d2-d4/a2-a4
	unlk	a6
	rts

seg_17592E:	; [速殺|面向][出場坐標][終點坐標]
	dc.w	$0000,$0001, $0050,$00BB, $0000,$00BB	; [00]0100博望坡
	dc.w	$0000,$0001, $004F,$00B8, $0000,$00D3	; [01]0200新野城左
	dc.w	$0000,$0000, $00E0,$00C7, $0000,$00C7	; [02]0202白河水壩
	dc.w	$0001,$0001, $0050,$00CB, $0000,$00CB	; [03]0203白河上游
	dc.w	$0000,$0001, $0044,$00F7, $0100,$00CB	; [04]0204屋頂
	dc.w	$0000,$0001, $0056,$00CF, $0000,$00CF	; [05]0300襄江
	dc.w	$0000,$0001, $0060,$00BB, $0000,$00BB	; [06]0301長坂坡
	dc.w	$0000,$0001, $0050,$00CB, $0000,$00CB	; [07]0302江夏
	dc.w	$0000,$0000, $0060,$00AF, $0000,$00AF	; [08]0400南坪山碼頭
	dc.w	$0000,$0001, $0070,$00DB, $0000,$00C7	; [09]0403東吳戰船
	dc.w	$0000,$0000, $0020,$00EB, $0000,$00C7	; [0A]040B曹魏戰船
	dc.w	$0000,$0001, $0070,$00DB, $0000,$00C7	; [0B]0500烏林
	dc.w	$0000,$0001, $0054,$00BB, $0000,$00BB	; [0C]0501北彝陵
	dc.w	$0000,$0000, $0050,$00CB, $0000,$00CB	; [0D]0502南彝陵|0505江陵道
	dc.w	$0000,$0001, $0054,$00BB, $0000,$00BB	; [0E]0503葫蘆口
	dc.w	$0001,$0001, $0056,$00C3, $0000,$00C3	; [0F]0504華容道
	dc.w	$0000,$0001, $0056,$00CF, $0000,$00CF	; [10]0600山寨
	dc.w	$0000,$0001, $0056,$00C3, $0000,$00C3	; [11]0601火焰洞
	dc.w	$0000,$0000, $0056,$00CB, $0000,$00CB	; [12]0605白虎密室
	dc.w	$0001,$0001, $003E,$00CF, $0000,$00CF	; [13]0603南郡道
	dc.w	$0000,$0001, $0044,$0103, $0000,$0103	; [14]0701前庭
	dc.w	$0001,$0000, $0120,$00CF, $0653,$00CF	; [15]0703大廳
	dc.w	$0000,$0001, $003C,$00CF, $0000,$00CF	; [16]0704南郡城後方|0700南郡城門
	dc.w	$0000,$0001, $007E,$00F7, $0000,$00CF	; [17]0705下水道
	dc.w	$0000,$0001, $0056,$00BB, $0000,$00BB	; [18]0604油江
	dc.w	$0000,$0001, $0035,$00B0, $0000,$00B0	; [19]0602古墓
	dc.w	$0000,$0001, $0054,$00D3, $0000,$00D3	; [1A]0706長廊

off_17592E:	; [敵將指針][出場動作][高度|定位]
	dc.l	$0027AB72,$00010002,$00000000	; 00[孫權09]
	dc.l	$001FD476,$00010000,$00000000	; 01[曹操0B]
	dc.l	$00201F76,$00010000,$00000001	; 02[司馬懿0C]
	dc.l	$002053FE,$00010004,$00000000	; 03[程昱0D]
	dc.l	$00208DE0,$00030005,$00000000	; 04[曹仁0F]
	dc.l	$0020B7DC,$00010005,$00000000	; 05[夏侯淵11]
	dc.l	$0020FBEE,$00010001,$00000000	; 06[夏侯惇12]
	dc.l	$00214024,$00010001,$00000000	; 07[牛金13]
	dc.l	$00217DF4,$00010001,$FF4C0001	; 08[許褚14]
	dc.l	$0021C0B4,$00010007,$FF380001	; 09[張郃15]
	dc.l	$00222A98,$00010001,$00000000	; 0A[張遼16]
	dc.l	$00225922,$00030006,$FF100001	; 0B[甘寧18]
	dc.l	$0022A694,$00010003,$00000000	; 0C[周泰19]
	dc.l	$0022EDB4,$00010004,$00000000	; 0D[黃蓋1A]
	dc.l	$00232702,$00010004,$00000001	; 0E[呂蒙1B]
	dc.l	$00235782,$0001000A,$FF000001	; 0F[徐晃1C]
	dc.l	$0023B38A,$00030004,$00000000	; 10[呂布1D]
	dc.l	$0023F080,$00010002,$00000000	; 11[孟獲1E]
	dc.l	$002438B2,$00010003,$00000000	; 12[孟優1F]
	dc.l	$00245DA0,$00010001,$00000000	; 13[沙摩柯20]
	dc.l	$00247EB2,$00010005,$FFAB0000	; 14[左慈21]

sub_109CC3:	; 場上敵將數目[d0]與生命條數[d1]
	movem.l	d2/a2,-(sp)
	movea.l	#$D07000,a2
	moveq	#6,d2		; 循環檢查7次
	moveq	#0,d1
	moveq	#0,d0
loc_109CC3:
	tst.w	$C(a2)		; 是否在場
	beq.s	loc_109CC4
	movea.l	$58(a2),a0
	cmpi.b	#1,(a0)		; 是否敵將
	bne.s	loc_109CC4
	addq.l	#1,d0		; 敵將數目+1
	add.w	$6C(a2),d1	; 敵將生命值
loc_109CC4:
	lea		$400(a2),a2
	dbf		d2,loc_109CC3
; 計算敵將生命條總數
	addi.l	#$13F,d1
	divu.w	#$140,d1
	ext.l	d1			; 敵將總血數
	bne.s	locret_109CC3
	st.b	d1			; 結果不為零
locret_109CC3:
	movem.l	(sp)+,d2/a2
	rts

sub_1A87EC:
; 生命值表格地址
	movem.l	a2-a3,-(sp)
	movea.l	#seg_1A87EC,a2
	moveq	#0,d0
	move.b	(ram_0002).l,d0	; 原難度+
	lsl.l	#2,d0
	movea.l	(a2,d0.l),a2
; 計算敵將之位目
	moveq	#0,d0
	movea.l	$C(sp),a3		; 敵將OBJ
	tst.w	$11E(a3)
	bne.s	loc_1A87EC
	move.b	(ram_000E+1).l,d0	; 敵將一位目
	bra.s	loc_1A87ED
loc_1A87EC:
	move.b	(ram_0010+1).l,d0	; 敵將二位目
loc_1A87ED:
	lsl.l	#1,d0
	move.w	-2(a2,d0.l),d0	; 查表
	andi.l	#$FFFF,d0
; 江陵道減生命值
	cmpi.b	#5,($8182F9).l	; 江陵道0505
	bne.s	loc_1A87EE
	cmpi.b	#5,($8182FA).l
	bne.s	loc_1A87EE
	subi.l	#$0140,d0		; 減去一血
; 雙王模式減一血
	cmpi.b	#3,(ram_0003).l
	bne.s	loc_1A87EE
	subi.l	#$0140,d0		; 再減一血
; 容錯
loc_1A87EE:
	tst.l	d0
	bgt.s	loc_1A87EF
	move.l	#$0140,d0		; 最少一血
	bra.s	locret_1A87EC
loc_1A87EF:
	cmpi.l	#$0B40,d0
	bls.s	locret_1A87EC
	move.l	#$0B40,d0		; 最多九血
locret_1A87EC:
	movem.l (sp)+,a2-a3
	rts

seg_1A87EC:	; 敵將生命值表格指針
	dc.l	off_1A87ED,off_1A87EE,off_1A87EF,off_1A87F0

off_1A87ED:	; 正常難度
	dcb.w	2,$0140
	dcb.w	4,$0280
	dcb.w	6,$03C0
	dcb.w	4,$0500
	dcb.w	3,$0640
	dcb.w	2,$0780

off_1A87EE:	; 難度+1
	dcb.w	1,$0140
	dcb.w	2,$0280
	dcb.w	3,$03C0
	dcb.w	6,$0500
	dcb.w	4,$0640
	dcb.w	3,$0780
	dcb.w	2,$08C0

off_1A87EF:	; 難度+2
	dcb.w	2,$0280
	dcb.w	3,$03C0
	dcb.w	4,$0500
	dcb.w	4,$0640
	dcb.w	3,$0780
	dcb.w	2,$08C0
	dc.w	$0A00,$03C0,$0500	; 雙王[20|21]

off_1A87F0:	; 難度+3
	dc.w	$0280,$03C0,$0500	; 01-03
	dc.w	$0140,$0280, $0280,$0280, $0280,$03C0, $0280,$03C0	; 04-0B
	dc.w	$03C0,$0500, $03C0,$0500, $0500,$0640, $0500,$0640, $0640,$0780	; 0C-15

sub_10A126:	; 設定游戲時間以及血條等
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	tst.w	$D0(a2)			; 是否已畫血槽
	bne.s	loc_10A170
; 對戰遊戲時間
	move.w	$6C(a2),d0
	divu.w	#$140,d0
	mulu.w	#10,d0			; 每血10秒
	tst.w	$11E(a2)		; 是否敵將[1]
	bne.s	loc_10A13C
	addi.l	#50,d0			; 基礎50秒
	move.b	d0,($81833E).l	; 刷新時間
	bra.s	loc_10A150
loc_10A13C:
	addi.l	#25,d0			; 基礎25秒
	add.b	d0,($81833E).l	; 增加時間
; 畫敵將之血槽
loc_10A150:
	move.l	a2,-(sp)
	moveq	#0,d0
	move.w	$11E(a2),d0		; 一王或二王 0|1
	move.l	d0,-(sp)
	jsr		$124DBE			; 設定血槽
	addq.l	#8,sp
	move.w	#1,$D0(a2)
	jsr		$1293A2			; 特殊技解禁
loc_10A170:
	movea.l	(sp)+,a2
	rts


sub_1343D6:	; 劇情對話
	link	a6,#0
	move.l	a2,-(sp)
; 重置對話信息
	movea.l	#(ram_0025).l,a0
	moveq	#8-1,d1			; 對話上限7+1則
loc_1343D7:
	move.l	#-$1,(a0)+		; 重置對話信息
	dbra	d1,loc_1343D7
; 計算對話信息
	movea.l	#(off_1343D6),a0
	move.l	$C(a6),d0		; 敵將編號
	lsl.l	#2,d0
	movea.l	(a0,d0.l),a0
	move.l	8(a6),-(sp)		; 敵將OBJ
	move.l	$10(a6),-(sp)	; 對話類型
	jsr		(a0)			; 對話判斷
	addq.l	#8,sp
; 對話前的設定
	clr.l	-(sp)
	jsr		($14B73E).l		; 投幣選人無效
	addq.l	#4,sp
	clr.l	-(sp)
	jsr		($10FEAC).l		; 等待敵方[0201]動作
	addq.l	#4,sp
	jsr		($15E7F4).l		; 等待我方[0201]動作
; 展示對話內容
loc_1343DA:
	movea.l	#(ram_0025).l,a2	; 對話信息
	bra.s	loc_1343D9
loc_1343D8:
	moveq	#0,d0
	move.w	(a2)+,d0
	move.l	d0,-(sp)		; 對話內容
	move.w	(a2)+,d0
	move.l	d0,-(sp)		; 說話者
	jsr		$1343D6			; 對話處理
	addq.l	#8,sp
loc_1343D9:
	cmpi.l	#-$1,(a2)		; 是否結束對話
	bne.s	loc_1343D8
; 對話後的設定
	pea		(1).w
	jsr		($14B73E).l		; 投幣選人有效
	addq.l	#4,sp
	move.b	#1,($81A1F8).l	; 我方恢復行動
	move.b	#1,($81B5E0).l	; 敵方恢復行動
	movea.l	(sp)+,a2
	unlk	a6
	rts

off_1343D6:	; 敵將對話判斷表
	dc.l	sub_27AB72	; 孫權-09
	dc.l	sub_1FD476	; 曹操-1C
	dc.l	sub_201F76	; 司馬懿-13
	dc.l	sub_2053FE	; 程昱-1B
	dc.l	sub_208DE0	; 曹仁-0C
	dc.l	sub_20B7DC	; 夏侯淵-1A
	dc.l	sub_20FBEE	; 夏侯惇-0B
	dc.l	sub_214024	; 牛金-16
	dc.l	sub_217DF4	; 許褚-20
	dc.l	sub_21C0B4	; 張郃-11
	dc.l	sub_222A98	; 張遼-19
	dc.l	sub_225922	; 甘寧-14
	dc.l	sub_22A694	; 周泰-1D
	dc.l	sub_22EDB4	; 黃蓋-18
	dc.l	sub_232702	; 呂蒙-1F
	dc.l	sub_235782	; 徐晃-17
	dc.l	sub_23B38A	; 呂布-21
	dc.l	sub_23F080	; 孟獲-10
	dc.l	sub_23F080	; 孟優-10
	dc.l	sub_245DA0	; 沙摩柯-1E
	dc.l	sub_247EB2	; 左慈-15

sub_27AB72:	; 孫權-09
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	8(sp)			; 對話類型
	bne.s	loc_27AB73
; 出場對話|孫權在場
	pea		(9).w			; 真孫權
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_27AB72
	move.w	#($126),(a2)+	; 「何方豎子？」
	move.w	#(9),(a2)+		; 我孫權說
	move.w	#($127),(a2)+	; 「何方妖孽？」
	move.w	#($23),(a2)+	; 敵孫權說
	move.w	#($128),(a2)+	; 「冀州上將潘鳳！」
	move.w	#(9),(a2)+		; 我孫權說
	move.w	#($129),(a2)+	; 「零陵上將邢道榮！」
	move.w	#($23),(a2)+	; 敵孫權說
	move.w	#($12A),(a2)+	; 「戰！」
	move.w	#(9),(a2)+		; 我孫權說
	move.w	#($12A),(a2)+	; 「戰！」
	move.w	#($23),(a2)+	; 敵孫權說
	bra.s	locret_27AB72
; 出場對話|一般情況
loc_27AB72:
	move.w	#($5D),(a2)+	; 「孤統領江南六郡八十一州，克成帝業指日可待，汝等何不順天意歸順共創大業！」
	move.w	#($23),(a2)+	; 敵孫權說
	move.w	#($5E),(a2)+	; 「住口，逆賊還不快納命請罪！」
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a0
	movea.l	$58(a0),a0
	move.b	1(a0),d0
	ext.w	d0
	move.w	d0,(a2)+		; 我方說
	move.w	#($7E),(a2)+	; 「不自量力，死有餘辜！殺！」
	move.w	#($23),(a2)+	; 敵孫權說
	bra.s	locret_27AB72
; 退場對話
loc_27AB73:
	move.w	#($12B),(a2)+	; 「我是真的！」
	move.w	#($23),(a2)+	; 敵孫權說
	move.w	#($12B),(a2)+	; 「我是真的！」
	move.w	#(9),(a2)+		; 我孫權說
locret_27AB72:
	movea.l	(sp)+,a2
	rts

sub_1FD476:	; 曹操-1C
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_1FD476
; 出場對話
	move.w	#($FD),(a2)+	; 「山不厭高，水不厭深，周公吐哺，天下歸心。」
	bra.s	loc_1FD478
; 退場對話
loc_1FD476:
	movea.l	$10(sp),a3		; 曹操OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	locret_1FD476
	movea.l	$1EC(a3),a0		; 擊敗曹操的角色
	movea.l	$58(a0),a0
	movea.l	#(off_1FD476),a1
	moveq	#9,d0			; 從孫權起
loc_1FD477:
	cmp.b	1(a0),d0		; 循環判斷
	dble	d0,loc_1FD477	; d0<=1(a0)時跳出
	lsl.l	#1,d0
	move.w	(a1,d0.l),(a2)+
loc_1FD478:
	move.w	#($1C),(a2)+	; 曹操說
locret_1FD476:
	movem.l	(sp)+,a2-a3
	rts
off_1FD476:	; 招降對話表
	dc.w	$00FE	; 關羽「雲長……也罷……也罷……」
	dc.w	$00FF	; 張飛「果真百萬軍中取吾首級如探囊取物耳……」
	dc.w	$0100	; 趙雲「七進七出之力，將軍真神人也……」
	dc.w	$0073	; 黃忠「孤有何罪，天下無孤，不知有幾人稱帝，幾人稱王！」
	dc.w	$0101	; 馬超「今何不報殺父之仇……」
	dc.w	$0102	; 孔明「今日一見不敵臥龍，孟德無話可說……」
	dc.w	$0103	; 貂蟬「銅雀台鎖不住二喬，亦鎖不住你……」
	dc.w	$0073	; 默認「孤有何罪，天下無孤，不知有幾人稱帝，幾人稱王！」
	dc.w	$0104	; 龐統「江水連環恨在心，落鳳幸存意難平……」
	dc.w	$0105	; 孫權「生子當如孫仲謀……」

sub_201F76:	; 司馬懿-13
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
; 出場對話
	pea		(5).w			; 孔明
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_201F76
	move.w	#($DF),(a2)+	; 「巾帼女衣，雕蟲小技，堅守不出，魂歸九天！」
	move.w	#($13),(a2)+	; 司馬懿說
	move.w	#($E0),(a2)+	; 「上方谷落荒而逃，而今苟活於世，實乃豚犬之風，我從未見過如此厚顏無恥之人！」
	move.w	#(5),(a2)+		; 孔明說
	bra.s	locret_201F76
loc_201F76:
	move.w	#($E1),(a2)+	; 「肅清萬裏，總齊八荒！」
	move.w	#($13),(a2)+	; 司馬懿說
locret_201F76:
	movea.l	(sp)+,a2
	rts

sub_2053FE:	; 程昱-1B
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_2053FE
; 出場對話
	move.w	#($F9),(a2)+	; 「木人木人聽我令！千錘萬鑽力無邊！急急如律令！」
	bra.s	loc_205401
; 退場對話
loc_2053FE:
	movea.l	$10(sp),a3		; 程昱OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	locret_2053FE
	movea.l	$1EC(a3),a0		; 擊敗程昱的角色
	movea.l	$54(a0),a0
	cmpi.b	#$B,1(a0)		; 是否曹操
	beq.s	loc_2053FF
	cmpi.b	#8,1(a0)		; 是否龐統
	beq.s	loc_205400
	move.w	#($FC),(a2)+	; 「在下願用一身道術助爾一臂之力！」
	bra.s	loc_205401
loc_2053FF:
	move.w	#($FA),(a2)+	; 「主公無雙，在下拜服！」
	bra.s	loc_205401
loc_205400:
	move.w	#($FB),(a2)+	; 「弟子願歸師傅門下，精修道法，發揚光大！」
loc_205401:
	move.w	#($1B),(a2)+	; 程昱說
locret_2053FE:
	movem.l	(sp)+,a2-a3
	rts

sub_208DE0:	; 曹仁-0C
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	8(sp)			; 對話類型
	bne.s	loc_208DE1
; 出場對話
	cmpi.b	#2,($8182F9).l	; 是否白河[0202]
	bne.s	loc_208DE0
	cmpi.b	#2,($8182FA).l
	bne.s	loc_208DE0
	move.w	#($DC),(a2)+	; 「新野之敗不過詭計爾爾，區區白河之水怎能覆我？」
	bra.s	loc_208DE2
loc_208DE0:
	move.w	#($DD),(a2)+	; 「鐵壁銅墻在此！爾等休要猖狂，看吾取汝首級！」
	bra.s	loc_208DE2
; 退場對話
loc_208DE1:
	move.w	#($DE),(a2)+	; 「此地……鬼門關也！」
loc_208DE2:
	move.w	#($C),(a2)+		; 曹仁說
	movea.l	(sp)+,a2
	rts

sub_20B7DC:	; 夏侯淵-1A
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_20B7DC
; 出場對話
	pea		(3).w			; 黃忠
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_20B7DC
	move.w	#($F3),(a2)+	; 「聽聞將軍刀功了得，特來賜教。」
	move.w	#($1A),(a2)+	; 夏侯淵說
	move.w	#($F4),(a2)+	; 「有來無回！」
	move.w	#(3),(a2)+		; 黃忠說
	bra.s	locret_20B7DC
; 退場對話
loc_20B7DC:
	movea.l	$10(sp),a3		; 夏侯淵OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	locret_20B7DC
	movea.l	$1EC(a3),a0		; 擊敗夏侯淵的角色
	movea.l	$54(a0),a0
	cmpi.b	#$B,1(a0)		; 是否曹操
	beq.s	loc_20B7DD
	cmpi.b	#$12,1(a0)		; 是否夏侯惇
	beq.s	loc_20B7DE
	cmpi.b	#3,1(a0)		; 是否黃忠
	beq.s	loc_20B7DF
	move.w	#($F8),(a2)+	; 「將軍戰法精湛，末將願追隨將軍！」
	bra.s	loc_20B7E0
loc_20B7DD:
	move.w	#($F5),(a2)+	; 「願隨主公征戰一世！」
	bra.s	loc_20B7E0
loc_20B7DE:
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a1
	movea.l	$58(a1),a1
	move.b	1(a1),d0
	ext.w	d0
	move.w	#($40),(a2)+	; 「聽長兄忠言，何不歸順，共扶漢室！」
	move.w	d0,(a2)+		; 我方說
	move.w	#($41),(a2)+	; 「兄長所言甚是，兄弟同心，共扶漢室！」
	bra.s	loc_20B7E0
loc_20B7DF:
	move.w	#($F7),(a2)+	; 「豎子欺吾年老，吾手中寶刀不老。」
	move.w	#(3),(a2)+		; 黃忠說
	move.w	#($F6),(a2)+	; 「刀弓無雙，妙才願降。」
loc_20B7E0:
	move.w	#($1A),(a2)+	; 夏侯淵說
locret_20B7DC:
	movem.l	(sp)+,a2-a3
	rts

sub_20FBEE:	; 夏侯惇-0B
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_20FBEF
; 出場對話
	cmpi.b	#1,($8182F9).l	; 是否博望坡[0100]
	bne.s	loc_20FBEE
	move.w	#($D8),(a2)+	; 「故地重遊？必將功贖罪」
	bra.s	loc_20FBF2
loc_20FBEE:
	move.w	#($D9),(a2)+	; 「來者何人？吾刃不斬無名之輩。」
	bra.s	loc_20FBF2
; 退場對話
loc_20FBEF:
	movea.l	$10(sp),a3		; 夏侯惇OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	locret_20FBEE
	movea.l	$1EC(a3),a0		; 擊敗夏侯惇的角色
	movea.l	$54(a0),a0
	cmpi.b	#$B,1(a0)		; 是否曹操
	beq.s	loc_20FBF0
	cmpi.b	#$11,1(a0)		; 是否夏侯淵
	beq.s	loc_20FBF1
	move.w	#($B),(a2)+		; 「技不如人，某願降。」
	bra.s	loc_20FBF2
loc_20FBF0:
	move.w	#($DA),(a2)+	; 「元讓必隨阿瞞征戰一世！」
	bra.s	loc_20FBF2
loc_20FBF1:
	move.w	#($DB),(a2)+	; 「兄弟同心，蜀漢再興！」
loc_20FBF2:
	move.w	#($B),(a2)+		; 夏侯惇說
locret_20FBEE:
	movem.l	(sp)+,a2-a3
	rts

sub_214024:	; 牛金-16
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_214024
; 出場對話
	move.w	#($E8),(a2)+	; 「區區螻蟻，也敢在此放肆？」
	bra.s	loc_214025
; 退場對話
loc_214024:
	move.w	#($32),(a2)+	; 「將軍何須埋沒將才，不若歸順共展長才。」
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a0
	movea.l	$58(a0),a0
	move.b	1(a0),d0
	ext.w	d0
	move.w	d0,(a2)+		; 我方說
	move.w	#($33),(a2)+	; 「某必盡某所能，為漢效命！」
loc_214025:
	move.w	#($16),(a2)+	; 牛金說
	movem.l	(sp)+,a2-a3
	rts

sub_217DF4:	; 許褚-20
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_217DF5
; 出場對話|許褚邀戰
	move.w	#($11E),(a2)+	; 「虎癡來也！誰敢與我大戰三百回合？」
	move.w	#($20),(a2)+	; 許褚說
; 出場對話|張馬應戰
	pea		(1).w			; 張飛
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_217DF4
	move.w	#($11F),(a2)+	; 「此時不戰，更待何時！」
	move.w	#(1),(a2)+		; 張飛說
	bra.w	locret_217DF4
loc_217DF4:
	pea		(4).w			; 馬超
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.w	locret_217DF4
	move.w	#($11F),(a2)+	; 「此時不戰，更待何時！」
	move.w	#(4),(a2)+		; 馬超說
	bra.w	locret_217DF4
; 退場對話
loc_217DF5:
	movea.l	$10(sp),a3		; 許褚OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	loc_217DF6
	movea.l	$1EC(a3),a0		; 擊敗許褚的角色
	movea.l	$54(a0),a0
	cmpi.b	#$B,1(a0)		; 是否曹操
	beq.s	loc_217DF7
	cmpi.b	#1,1(a0)		; 是否張飛
	beq.s	loc_217DF8
	cmpi.b	#4,1(a0)		; 是否馬超
	beq.s	loc_217DF9
; 退場對話|一般情況
loc_217DF6:
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a1
	movea.l	$58(a1),a1
	move.b	1(a1),d0
	ext.w	d0
	move.w	#($60),(a2)+	; 「將軍何不歸降，一展虎痴雄風！」
	move.w	d0,(a2)+		; 我方說
	move.w	#($5F),(a2)+	; 「某平生不曾有敵手，今見將軍威猛更勝一籌，某願降也！」
	move.w	#($20),(a2)+	; 許褚說
	bra.s	locret_217DF4
loc_217DF7:	; 曹操
	move.w	#($61),(a2)+	; 「虎痴願隨本相再展雄風否？」
	move.w	#($1C),(a2)+	; 曹操說
	move.w	#($62),(a2)+	; 「某平生只服一人，惟主公矣，而今得見死而無憾！」
	move.w	#($20),(a2)+	; 許褚說
	bra.s	locret_217DF4
loc_217DF8:	; 張飛
	move.w	#($120),(a2)+	; 「武藝在某之上，某必精進武藝，有朝一日定叫汝等俯首！」
	move.w	#($20),(a2)+	; 許褚說
	move.w	#($121),(a2)+	; 「定當奉陪！」
	move.w	#(1),(a2)+		; 張飛說
	bra.s	locret_217DF4
loc_217DF9:	; 馬超
	move.w	#($120),(a2)+	; 「武藝在某之上，某必精進武藝，有朝一日定叫汝等俯首！」
	move.w	#($20),(a2)+	; 許褚說
	move.w	#($121),(a2)+	; 「定當奉陪！」
	move.w	#(4),(a2)+		; 馬超說
locret_217DF4:
	movem.l	(sp)+,a2-a3
	rts

sub_21C0B4:	; 張郃-11
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_21C0B5
; 出場對話
	cmpi.b	#3,($8182F9).l	; 是否長坂坡[0301]
	bne.s	loc_21C0B4
	cmpi.b	#1,($8182FA).l
	beq.s	locret_21C0B4
	* move.w	#($27),(a2)+	; 「阿斗在我手中，汝等不可輕舉妄動。」
	* bra.s	loc_21C0B9
loc_21C0B4:
	move.w	#($E2),(a2)+	; 「吾乃河間上將張郃是也，汝等速來受死！」
	bra.s	loc_21C0B9
; 退場對話
loc_21C0B5:
	movea.l	$10(sp),a3		; 張郃OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	loc_21C0B8
	movea.l	$1EC(a3),a0		; 擊敗張郃的角色
	movea.l	$54(a0),a0
; 退場對話|是否曹操
	cmpi.b	#$B,1(a0)
	beq.s	loc_21C0B6
; 退場對話|是否長板橋
	cmpi.b	#3,($8182F9).l
	bne.s	loc_21C0B8
	cmpi.b	#1,($8182FA).l
	bne.s	loc_21C0B8
; 退場對話|是否趙雲
	cmpi.b	#2,1(a0)
	beq.s	loc_21C0B7
loc_21C0B8:	; 一般情況
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a1
	movea.l	$58(a1),a1
	move.b	1(a1),d0
	ext.w	d0
	move.w	#($23),(a2)+	; 「將軍不需再戰，何不齊心共平亂世！」
	move.w	d0,(a2)+		; 我方說
	move.w	#($24),(a2)+	; 「果不枉為無雙國士，某服也！」
	bra.s	loc_21C0B9
loc_21C0B6:	; 曹操
	move.w	#($E3),(a2)+	; 「願為丞相以驅馳！」
	bra.s	loc_21C0B9
loc_21C0B7:	; 趙雲
	move.w	#($E4),(a2)+	; 「趙將軍蓋世無雙，末將甘拜下風！」
loc_21C0B9:
	move.w	#($11),(a2)+	; 張郃說
locret_21C0B4:
	movem.l	(sp)+,a2-a3
	rts

sub_222A98:	; 張遼-19
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	8(sp)			; 對話類型
	bne.s	loc_222A99
; 出場對話
	clr.l	-(sp)			; 關羽
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_222A98
	move.w	#($EE),(a2)+	; 「文遠，今日乃國家之事，某不敢以私廢公。你我二人，當決一死戰，以報國恩。」
	clr.w	(a2)+			; 關羽說
	move.w	#($EF),(a2)+	; 「君候高義，人生在世，有死而已，吾不懼也！」
	move.w	#($19),(a2)+	; 張遼說
	bra.s	locret_222A98
loc_222A98:
	move.w	#($F0),(a2)+	; 「縱轡著鞭馳駿騎，逍遙津上玉龍飛。」
	move.w	#($19),(a2)+	; 張遼說
	bra.s	locret_222A98
; 退場對話
loc_222A99:
	move.w	#($F1),(a2)+	; 「大丈夫死則死耳。」
	move.w	#($19),(a2)+	; 張遼說
	move.w	#($F2),(a2)+	; 「玉可碎而不可改其白，竹可焚而不可毀其節。」
	clr.w	(a2)+			; 關羽說
locret_222A98:
	movea.l	(sp)+,a2
	rts

sub_225922:	; 甘寧-14
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_225925
; 出場對話
	movea.l	#(off_225922),a3
	moveq	#5-1,d1			; 5個特定場景
loc_225923:
	move.b	(a3),d0
	cmp.b	($8182F9).l,d0
	bne.s	loc_225924
	move.b	1(a3),d0
	cmp.b	($8182FA).l,d0
	bne.s	loc_225924
	move.w	#($E5),(a2)+	; 「水軍聽令，隨我殺之！」
	bra.s	loc_225927
loc_225924:
	adda.l	#2,a3
	dbra	d1,loc_225923
	move.w	#($E6),(a2)+	; 「吾乃甘寧也！誰敢來與我決戰？」
	bra.s	loc_225927
; 退場對話
loc_225925:
	movea.l	$10(sp),a3		; 甘寧OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	loc_225928
	movea.l	$1EC(a3),a0		; 擊敗甘寧的角色
	movea.l	$54(a0),a0
	cmpi.b	#9,1(a0)		; 是否孫權
	beq.s	loc_225926
loc_225928:	; 一般情況
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a1
	movea.l	$58(a1),a1
	move.b	1(a1),d0
	ext.w	d0
	move.w	#($30),(a2)+	; 「將軍身手不凡，不若一同效命，共扶漢室。」
	move.w	d0,(a2)+		; 我方說
	move.w	#($31),(a2)+	; 「閣下豪氣干雲，甘某願為麾下，效犬馬之勞！」
	bra.s	loc_225927
loc_225926:	; 孫權
	move.w	#($E7),(a2)+	; 「閣下豪氣干雲，甘某願率水軍歸降！」
loc_225927:
	move.w	#($14),(a2)+	; 甘寧說
locret_225922:
	movem.l	(sp)+,a2-a3
	rts
off_225922:	; 特定場景表
	dc.w	$0400,$0409,$0604,$0700,$0705

sub_22A694:	; 周泰-1D
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_22A696
; 出場對話|是否孫權
	pea		(9).w			; 孫權
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_22A694
	move.w	#($106),(a2)+	; 「主公願一戰否？」
	move.w	#($1D),(a2)+	; 周泰說
	move.w	#($107),(a2)+	; 「戰則必勝！」
	move.w	#(9),(a2)+		; 孫權說
	bra.s	locret_22A694
; 出場對話|一般情況
loc_22A694:
	move.w	#($108),(a2)+	; 「幼平在此，擺陣禦敵！」
	bra.s	loc_22A698
; 退場對話
loc_22A696:
	movea.l	$10(sp),a3		; 周泰OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	loc_22A699
	movea.l	$1EC(a3),a0		; 擊敗周泰的角色
	movea.l	$54(a0),a0
	cmpi.b	#9,1(a0)		; 是否孫權
	beq.s	loc_22A697
loc_22A699:	; 一般情況
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a1
	movea.l	$58(a1),a1
	move.b	1(a1),d0
	ext.w	d0
	move.w	#($43),(a2)+	; 「汝軍兵敗勢危，本將惜才如金，將軍願降否？」
	move.w	d0,(a2)+		; 我方說
	move.w	#($44),(a2)+	; 「將軍英明神武，威不可擋，某服也！」
	bra.s	loc_22A698
loc_22A697:	; 孫權
	move.w	#($109),(a2)+	; 「願為主公赴湯蹈火，再傷一眼也不惜！」
loc_22A698:
	move.w	#($1D),(a2)+	; 周泰說
locret_22A694:
	movem.l	(sp)+,a2-a3
	rts

sub_22EDB4:	; 黃蓋-18
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	8(sp)			; 對話類型
	bne.s	loc_22EDB4
; 出場對話
	pea		(9).w			; 孫權
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_22EDB4
	move.w	#($122),(a2)+	; 「請主公賜教」
	move.w	#($18),(a2)+	; 黃蓋說
	move.w	#($123),(a2)+	; 「黃老將軍看槊！」
	move.w	#(9),(a2)+		; 孫權說
	bra.s	locret_22EDB4
; 退場對話
loc_22EDB4:
	move.w	#($124),(a2)+	; 「主公英明神武，某來世再報！」
	move.w	#($18),(a2)+	; 黃蓋說
	move.w	#($125),(a2)+	; 「定當保家眷周全！」
	move.w	#(9),(a2)+		; 孫權說
locret_22EDB4:
	movea.l	(sp)+,a2
	rts

sub_232702:	; 呂蒙-1F
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	8(sp)			; 對話類型
	bne.s	loc_232703
; 出場對話
	clr.l	-(sp)			; 關羽
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_232702
	move.w	#($10A),(a2)+	; 「白衣渡江，荊州歸吳！」
	move.w	#($1F),(a2)+	; 呂蒙說
	move.w	#($10B),(a2)+	; 「奸詐小人，親手戮之！」
	clr.w	(a2)+			; 關羽說
	bra.s	locret_232702
loc_232702:
	move.w	#($10C),(a2)+	; 「明者防禍於未萌，智者圖患於將來。」
	move.w	#($1F),(a2)+	; 呂蒙說
	bra.s	locret_232702
; 退場對話
loc_232703:
	move.w	#($10D),(a2)+	; 「插標賣首耳！」
	clr.w	(a2)+			; 關羽說
locret_232702:
	movea.l	(sp)+,a2
	rts

sub_235782:	; 徐晃-17
	movem.l	a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	$C(sp)			; 對話類型
	bne.s	loc_235784
; 出場對話|是否趙雲
	pea		(2).w			; 趙雲
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_235782
	move.w	#($E9),(a2)+	; 「全軍聽令！若取得子龍首級者，重賞千金！」
	bra.s	loc_235787
; 出場對話|是否北彝陵
loc_235782:
	cmpi.b	#5,($8182F9).l	; 是否北彝陵[0501]
	bne.s	loc_235783
	cmpi.b	#1,($8182FA).l
	bne.s	loc_235783
	move.w	#($EA),(a2)+	; 「巨斧開山！速速退散！」
	bra.s	loc_235787
loc_235783:	; 一般情況
	move.w	#($EB),(a2)+	; 「巨斧在此，反賊安敢耀武揚威，速下馬受降！」
	bra.s	loc_235787
; 退場對話
loc_235784:
	movea.l	$10(sp),a3		; 徐晃OBJ
	tst.l	$1EC(a3)		; 是否攻擊者
	beq.s	loc_235788
	movea.l	$1EC(a3),a0		; 擊敗徐晃的角色
	movea.l	$54(a0),a0
	cmpi.b	#$B,1(a0)		; 是否曹操
	beq.s	loc_235785
	cmpi.b	#2,1(a0)		; 是否趙雲
	beq.s	loc_235786
; 退場對話|一般情況
loc_235788:
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a1
	movea.l	$58(a1),a1
	move.b	1(a1),d0
	ext.w	d0
	move.w	#($7F),(a2)+	; 「將軍何苦助紂為虐，願降否？」
	move.w	d0,(a2)+		; 我方說
	move.w	#($80),(a2)+	; 「將軍威名遠播，某服也。」
	bra.s	loc_235787
loc_235785:	; 曹操
	move.w	#($EC),(a2)+	; 「公明願降！」
	bra.s	loc_235787
loc_235786:	; 趙雲
	move.w	#($ED),(a2)+	; 「巨斧撼山易，撼子龍難。」
loc_235787:
	move.w	#($17),(a2)+	; 徐晃說
locret_235782:
	movem.l	(sp)+,a2-a3
	rts

sub_23B38A:	; 呂布-21
	movem.l	d2-d4/a2-a3,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	movea.l	#(off_23B38A).l,a3	; 對話信息列表
	move.l	$18(sp),d4			; 對話類型
	lsl.l	#4,d4				; 列表偏移
; 是否關張趙
	moveq	#0,d2			; 計算人數
	moveq	#2,d3			; 關張趙[0][1][2]
loc_23B38A:
	move.l	d3,-(sp)
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	add.l	d0,d2
	subq.l	#1,d3
	bge.s	loc_23B38A
	tst.l	d2
	beq.s	loc_23B38B
	lsl.l	#1,d2
	add.l	d4,d2
	move.w	(a3,d2.l),(a2)+
	move.w	#($21),(a2)+	; 呂布對關張趙說
	bra.s	locret_23B38A
; 是否貂蟬
loc_23B38B:
	pea		(6).w
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_23B38C
	moveq	#5+5,d2
	add.l	d4,d2
	move.w	(a3,d2.l),(a2)+
	move.w	#($21),(a2)+	; 呂布說
	move.w	2(a3,d2.l),(a2)+
	move.w	#(6),(a2)+		; 貂蟬說
	bra.s	locret_23B38A
; 一般情況
loc_23B38C:
	moveq	#7+7,d2
	add.l	d4,d2
	move.w	(a3,d2.l),(a2)+
	move.w	#($21),(a2)+	; 呂布說
	tst.l	$18(sp)			; 是否退場投降
	beq.s	locret_23B38A
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a0
	movea.l	$58(a0),a0
	move.b	1(a0),d0
	ext.w	d0
	move.w	#($4E),(a2)+	; 「奉先威名遠播，某求之不得！」
	move.w	d0,(a2)+		; 我方說
locret_23B38A:
	movem.l	(sp)+,d2-d4/a2-a3
	rts
off_23B38A:	; 對話信息列表
	dc.w	0,$110	; 關張趙其中一人在場「三分武藝足矣！」
	dc.w	$10F	; 關張趙其中兩人在場「七分武藝可敵！」
	dcb.w	2,$10E	; 關張趙三人在場「本將必以十二分武藝拼死一戰！」
	dc.w	$111	; 貂蟬在場「在天願作比翼鳥，從此不問世間事。」
	dc.w	$112	; 貂蟬說「妾身願往，可歎雙雙兵戎相見，實乃不忍。」
	dc.w	$113,0	; 一般情況「大丈夫生居天地間，豈能郁郁久居人下！」
	dcb.w	4,$114	; 被關張趙其中一人擊敗「布技不如前，今已服矣。」
	dc.w	$115	; 貂蟬在場「比翼雙飛，共度餘生。」
	dc.w	$116	; 貂蟬說「甚好甚好」
	dc.w	$117	; 一般情況「汝為大將，布副之，天下不難定也。」

sub_23F080:	; 孟獲、孟優-10
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	tst.l	8(sp)			; 對話類型
	bne.s	loc_23F080
; 出場對話
	cmpi.b	#2,(ram_0026).l	; 是否二出場
	bcs.s	locret_23F080
	pea		(5).w			; 孔明
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_23F080
	move.w	#($11C),(a2)+	; 「吾昔日誤中丞相詭計，如何肯服？今欲捨一死命，報六番之恨！」
	move.w	#($10),(a2)+	; 孟獲說
	move.w	#($12C),(a2)+	; 「這番擒住，再若支吾，必不輕恕！」
	move.w	#($5),(a2)+		; 孔明說
	bra.s	locret_23F080
; 退場對話
loc_23F080:
	move.w	#($11D),(a2)+	; 「公，天威也，南人不復反矣！」
	move.w	#($10),(a2)+	; 孟獲說
locret_23F080:
	movea.l	(sp)+,a2
	rts

sub_245DA0:	; 沙摩柯-1E
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
	move.w	#($11B),(a2)+	; 「五溪蠻王來矣，來將休走，吃我一記！」
	move.w	#($1E),(a2)+	; 沙摩柯說
	movea.l	(sp)+,a2
	rts

sub_247EB2:	; 左慈-15
	move.l	a2,-(sp)
	movea.l	#(ram_0025).l,a2	; 對話信息寄存
; 出場對話
	pea		(8).w			; 龐統
	jsr		sub_15EC88		; 是否在場
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_247EB2
	move.w	#($118),(a2)+	; 「道友請留步，何不來切磋論道一番？」
	move.w	#($15),(a2)+	; 左慈說
	move.w	#($119),(a2)+	; 「恭敬不如從命。」
	move.w	#(8),(a2)+		; 龐統說
	bra.s	locret_247EB2
loc_247EB2:
	move.w	#($11A),(a2)+	; 「冰錐刻骨，福桶入肉，紙符亂神，鶴爪斷首！」
	move.w	#($15),(a2)+	; 左慈說
locret_247EB2:
	movea.l	(sp)+,a2
	rts


sub_1A7EAC:	; 對戰進度
	move.l	a2,-(sp)
	moveq	#0,d0
	move.w	(ram_000A).l,d0		; 對戰進度
	cmpi.b	#3,d0
	bhi.w	locret_1A7EAC		; 高於則退出
	add.l	d0,d0
	move.w	jpt_1A7EAC(pc,d0.w),d0
	jmp		jpt_1A7EAC(pc,d0.w)	; switch jmp
jpt_1A7EAC:
	dc.w	loc_1A7EAD-jpt_1A7EAC
	dc.w	loc_1A7EAE-jpt_1A7EAC
	dc.w	loc_1A7EAF-jpt_1A7EAC
	dc.w	loc_1A7EB0-jpt_1A7EAC
* 敵將出場[1]
loc_1A7EAD:	; 開場初始化
	jsr		$12E914				; 關閉路線指示標
	jsr		$15FD62				; 原版設定
	jsr		sub_13AED4			; 隨機音樂
	clr.b	($81B93C).l			; 敵方不攻擊
	clr.b	($80C2B5).l			; 全局無判定
; 敵將一出場
	moveq	#0,d0
	move.b	(ram_000E+0).l,d0	; 敵將編號
	move.l	d0,-(sp)
	jsr		sub_17592E			; 敵將出場
	addq.l	#4,sp
	move.l	d0,(ram_000E+2).l	; 記錄敵將OBJ
; 敵將二出場
	cmpi.b	#3,(ram_0003).l		; 是否雙王
	bne.w	loc_1A7EB1			; 下一進度
	moveq	#0,d0
	move.b	(ram_0010+0).l,d0	; 敵將編號
	move.l	d0,-(sp)
	jsr		sub_17592E			; 敵將出場
	addq.l	#4,sp
	move.l	d0,(ram_0010+2).l	; 記錄敵將OBJ
	bra.w	loc_1A7EB1			; 下一進度
* 計時設定[2]
loc_1A7EAE:
	jsr		sub_175D2E				; 賦兵鎖版
; 設定敵將一速殺計時器
	pea		(ram_000E+8).l			; 敵將一速殺計時器編號寄存
	move.l	(ram_000E+2).l,-(sp)	; 敵將一OBJ
	moveq	#0,d0
	move.b	(ram_000E+0).l,d0		; 敵將一序號
	move.l	d0,-(sp)
	jsr		sub_1841BA				; 設定速殺計時器
	lea		$C(sp),sp
	clr.w	(ram_000E+6).l			; 重置敵將一招降寄存
; 設定敵將二速殺計時器
	cmpi.b	#3,(ram_0003).l			; 是否雙王
	bne.w	loc_1A7EB1				; 下一進度
	pea		(ram_0010+8).l			; 敵將二速殺計時器編號寄存
	move.l	(ram_0010+2).l,-(sp)	; 敵將二OBJ
	moveq	#0,d0
	move.b	(ram_0010+0).l,d0		; 敵將二序號
	move.l	d0,-(sp)
	jsr		sub_1841BA				; 設定速殺計時器
	lea		$C(sp),sp
	clr.w	(ram_0010+6).l			; 重置敵將二招降寄存
	bra.w	loc_1A7EB1				; 下一進度
* 擊敗敵將[3]
loc_1A7EAF:
	pea		(ram_000E+0).l		; 敵將一序號寄存
	jsr		sub_1A80BA			; 敵將死亡設定
	addq.l	#4,sp
	pea		(ram_0010+0).l		; 敵將二序號寄存
	jsr		sub_1A80BA			; 敵將死亡設定
	addq.l	#4,sp
; 是否擊殺
	move.b	(ram_000E+1).l,d0	; 敵將[1]是否在場
	move.b	(ram_0010+1).l,d1	; 敵將[2]是否在場
	or.b	d1,d0
	tst.b	d0
	beq.s	loc_1A7EB1			; 下一進度
	tst.w	(ram_000B).l		; 是否刷兵
	beq.w	loc_1A7EB2			; 繼續循環
	jsr		$12EF80.l			; 刷新敵兵
	bra.w	loc_1A7EB2			; 繼續循環
* 關底收場[4]
loc_1A7EB0:
	clr.b   $81B614.l		; 敵方無行動
	jsr		sub_1B00C0		; 清除敵兵
; 主循環5秒
	pea		$13A646.l
	pea		$12C.w
	jsr		$100EA4.l
	addq.l	#8,sp
; 退出對戰
	clr.w	(ram_000A).l	; 重置進度
	moveq	#$1,d0			; 退出循環
	bra.s	locret_1A7EAC
loc_1A7EB1:
	addq.w	#1, (ram_000A).l
loc_1A7EB2:
	moveq	#$0,d0			; 繼續循環
locret_1A7EAC:
	movea.l	(sp)+,a2
	rts

sub_1A80BA:	; 敵將死亡設定
	link	a6,#0
	movem.l	d2-d3/a2-a5,-(sp)
	movea.l	8(a6),a2	; 敵將序號寄存地址
	tst.b	1(a2)		; 是否已擊敗
	beq.w	locret_1A80BA
	movea.l	2(a2),a3	; 敵將OBJ
	tst.w	$6C(a3)		; 敵將是否擊殺
	bne.w	locret_1A80BA
; 是否速殺
	tst.l	8(a2)		; 計時器是否開啟
	beq.s	loc_1A80BB
	move.l	8(a2),-(sp)	; 計時器編號
	jsr		$100E62.l	; 剩餘時間
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_1A80BC
	move.w	#1,6(a2)	; 成功速殺
; 關閉計時
loc_1A80BC:
	move.l	8(a2),-(sp)	; 計時器編號
	jsr		$100DC2.l	; 關閉計時
	addq.l	#4,sp
	clr.l	8(a2)		; 清除編號
	clr.w	(ram_000B).l	; 暫停刷兵|保留OBJ
loc_1A80BB:
; 是否爆令
	move.l	#seg_175D2E,a4
	moveq	#0,d0
	move.b	(a2),d0		; 敵將編號
	lsl.l	#3,d0
	adda.l	d0,a4		; 敵將信息
	tst.w	(a4)		; 敵將是否可招降
	beq.w	loc_1A80BD
	movea.l	$1EC(a3),a0	; 擊殺者OBJ
	movea.l	$54(a0),a0	; 擊殺者指針
	move.b	1(a0),d0
	cmp.b	2(a4),d0	; 是否必降[1]
	beq.s	loc_1A80BE
	cmp.b	3(a4),d0	; 是否必降[2]
	beq.s	loc_1A80BE
	tst.w	6(a2)		; 是否速殺敵將
	beq.w	loc_1A80BD
; 招降對話
loc_1A80BE:
	move.w	#1,$6C(a3)		; 保留人身
	move.b	#1,(ram_0027).l	; 打開敵將生命保險
	clr.b	($81B93C).l		; 敵方取消攻擊
	clr.b	($80C2B5).l		; 全局取消判定
loc_1A80C0:
	move.w	#1,$174(a3)		; 無敵容錯
	jsr		($13A646).l		; 主循環
	cmpi.w	#$B,$50(a3)		; 是否消失
	beq.w	loc_1A80C1
	cmpi.w	#2,$50(a3)		; 是否起身
	bne.w	loc_1A80C0		; 繼續循環
loc_1A80C1:
	pea		(1).w			; 退場對話
	moveq	#0,d0
	move.b	(a2),d0			; 敵將編號
	move.l	d0,-(sp)
	move.l	a3,-(sp)		; 敵將OBJ
	jsr 	sub_1343D6		; 處理對話
	lea		$C(sp),sp
	clr.b	(ram_0027).l	; 敵將生命保險關
	move.b	#1,($81B93C).l	; 敵方開始攻擊
	move.b	#1,($80C2B5).l	; 全局判定恢復
; 援軍退場
	move.w	$20(a3),d0		; 援軍離場
	ext.l	d0
	move.w	($D0A000).l,d1
	ext.l	d1
	sub.l	d1,d0
	cmpi.l	#$E0,d0
	bge.s	loc_11D0EE
	moveq	#1,d3
	bra.s	loc_11D0F0
loc_11D0EE:
	moveq	#0,d3
loc_11D0F0:
	movea.l	$54(a3),a0
	move.b	1(a0),d0
	andi.l	#$FF,d0
	movea.l	#$1C2AE8,a0		; 援軍編號表
	move.b	(a0,d0.w),d2
	jsr		$14DF94			; 分配機關OBJ
	movea.l	d0,a5
	move.l	d3,-(sp)
	move.w	$24(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	moveq	#0,d0
	move.b	d2,d0
	lsl.w	#2,d0
	movea.l	#$2ABC02,a0		; 援軍機關表
	move.l	(a0,d0.w),-(sp)
	move.l	a5,-(sp)
	jsr		$14E076			; 設定機關
	lea		$18(sp),sp
	move.w	$1C8(a3),$D2(a5)
	moveq	#0,d0
	move.b	d2,d0
	lsl.w	#2,d0
	movea.l	#$1C2B68,a0		; 援軍退場動作表
	move.l	(a0,d0.w),$2C(a5)
	clr.w	$3C(a5)
	clr.w	$54(a5)
	clr.w	$68(a5)
	move.w	$60(a3),$50(a5)
	move.w	$60(a3),$8A(a5)
	clr.w	$6C(a5)			; 僅判定敵方
; 援軍爆令
	clr.l	-(sp)
	clr.l	-(sp)
	pea		(1).w
	clr.l	-(sp)
	moveq	#0,d0
	move.w	(a4),d0		; 援軍令
	move.l	d0,-(sp)
	pea		($FFCE).w	; 高度
	move.w	$22(a3),d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	move.l	d0,-(sp)
	jsr		$123D26		; 掉物
	lea		$20(sp),sp
	bra.s	loc_1A80BF
; 清除敵將
loc_1A80BD:
	jsr		($13A646).l	; 主循環
	cmpi.w	#$B,$50(a3)	; 敵將是否消失
	bne.w	loc_1A80BD	; 繼續循環
loc_1A80BF:
	clr.w	$6C(a3)		; 置零生命值|sub_18571E
	moveq	#0,d0
	move.w	$E(a3),d0	; 敵將OBJ序號
	move.l	d0,-(sp)
	jsr		$109D38.l	; 關閉血槽
	addq.l	#4,sp
	clr.b	1(a2)		; 關閉敵將
	jsr		sub_12EF80	; 繼續刷兵
; 敵將爆物
	moveq	#0,d0
	move.b	(a2),d0		; 敵將編號
	move.l	d0,-(sp)
	jsr		sub_17DC4E	; 敵將爆物
	addq.l	#4,sp
locret_1A80BA:
	movem.l	(sp)+,d2-d3/a2-a5
	unlk	a6
	rts

sub_1B00C0:	; 清除敵兵
	move.l	a2,-(sp)
	jsr		$10B08C.l		; 第一順位敵方OBJ
	bra.s	loc_1B00F4
loc_1B00C0:
	movea.l	$58(a2),a0
	cmpi.b	#2,(a0)			; 是否敵兵
	bne.s	loc_1B00EA
	pea		($3A0160).l		; 強制死亡動作
	move.l	a2,-(sp)
	jsr		($10EF18).l
	addq.l	#8,sp
loc_1B00EA:
	move.l	a2,-(sp)
	jsr		$10B0AC.l		; 下一順位敵方OBJ
	addq.l	#4,sp
loc_1B00F4:
	movea.l	d0,a2
	move.l	a2,d0
	bne.s	loc_1B00C0
	movea.l	(sp)+,a2
	rts


sub_13AED4:
	movem.l	a2,-(sp)
	pea		(24).w				; 音樂[#0-23]
	jsr		$102480				; 大隨機
	addq.l	#4,sp
	moveq	#$1,d1				; 大循環1次
loc_13AED4_1:
	movea.l	#ram_0015+2,a2		; 音樂標記
	adda.l	d0,a2				; 從隨機號開始
loc_13AED4_2:
	tst.b	(a2)
	bne.s	loc_13AED4_3
	move.b	#1,(a2)				; 標記已播音樂
	move.w	d0,(ram_0015+0).l	; 當前音樂號
	movea.l	#off_2B3CD0,a2		; 音樂表
	mulu.w	#$C,d0				; 每$C一偏移
	adda.l	d0,a2				; 當前音樂值
	pea		($2BEC9E).l
	move.l	4(a2),-(sp)			; 曲目
	move.l	(a2),-(sp)			; 音樂組
	jsr		$12BC40
	pea		($7F).w				; 音量
	move.l	8(a2),-(sp)			; 編號
	jsr		$12BDA0
	lea		$14(sp),sp
	bra.s	locret_13AED4
loc_13AED4_3:
	addq.l	#1,d0
	addq.l	#1,a2				; 循環判斷隨機值的最近音樂
	cmpi.l	#24,d0				; 音樂目不超過#24
	blt.s	loc_13AED4_2
	moveq	#0,d0				; 輪回到音樂號一
	dbf		d1,loc_13AED4_2
locret_13AED4:
	movem.l	(sp)+,a2
	rts

off_2B3CD0:	; $音樂組,$曲目,$編號
	dc.l	$2E0CE4,$A,$1	; 演示
	dc.l	$2C355E,$4,$1	; 夏侯惇
	dc.l	$2C73E6,$8,$1	; 鳥鳴水流|0201
	dc.l	$2C73E6,$8,$2	; 第二章|0202
	dc.l	$2CBC40,$4,$0	; 長坂坡
	dc.l	$2CBC40,$4,$2	; 張郃
	dc.l	$2CDE3E,$2,$1	; 司馬懿
	dc.l	$2D2AF0,$6,$0	; 甘寧
	dc.l	$2D2AF0,$6,$1	; 牛金
	dc.l	$2D4B86,$2,$0	; 徐晃
	dc.l	$2D4B86,$2,$1	; 曹仁|夏侯淵
	dc.l	$2DBE6E,$8,$5	; 黃蓋馬車|0805
	dc.l	$2DBE6E,$8,$6	; 黃蓋領駕|0806
	dc.l	$2D7578,$2,$0	; 華容道|江陵道
	dc.l	$2D7578,$2,$1	; 第五章
	dc.l	$2E4EBC,$5,$0	; 周泰
	dc.l	$2E4EBC,$5,$1	; 沙漠柯
	dc.l	$2E4EBC,$5,$2	; 呂布|左慈
	dc.l	$2E4EBC,$5,$3	; 孟優孟獲
	dc.l	$2E4EBC,$5,$4	; 呂蒙
	dc.l	$2F199C,$5,$0	; 真呂布
	dc.l	$2F199C,$5,$1	; 黃蓋|孫權
	dc.l	$2F199C,$5,$2	; 許褚
	dc.l	$2F199C,$5,$3	; 群雄大廳


sub_175D2E:
	movem.l	a2-a3,-(sp)
; 刷新兵表
	clr.l	-(sp)
	pea		seg_12EF1A
	jsr		$12EF1A.l			; 刷新敵兵表
	addq.l	#8,sp
	jsr		sub_12EF80			; 是否出兵
; 刷新邊界
	movea.l	#seg_154F44,a2
	move.w	(ram_0013+0).l,d0	; 場景序號
	ext.l	d0
	lsl.l	#3,d0				; 場景序號*8對應鎖版序號
	adda.l	d0,a2
	tst.l	(a2)				; 是否變更邊界數據
	bmi.s	locret_175D2E
	move.w	(a2),($819830).l	; 鎖定邊界左
	move.w	2(a2),($819832).l
	move.w	4(a2),($819834).l	; 鎖定邊界右
	move.w	6(a2),($819836).l
locret_175D2E:
	movem.l	(sp)+,a2-a3
	rts

seg_12EF1A:	; [單兵]同[雙兵]
	dcb.l	2,off_12EF1A
off_12EF1A:
	dc.l	unk_12EF1A,$46500000
	dc.w	$0000
unk_12EF1A:	; 隨機敵兵
	dc.l	$FF120000,$FF0C0400	; [FF0C]敵兵攻擊慾望？
	dc.l	$FF050000,$00000000,$00000000,unk_12EF1B	; 敵兵內容
	dc.l	$FF0A0700,$FF0B0100	; [FF0B]刷兵間隔
	dc.l	$FF010200,$FF130000	; [FF010200]重置到第二個敵兵索引[INDEX]
unk_12EF1B:	; [3字|坐標軸XYZ][2字|$216()$218()][1字節|縱坐標隨機偏移量][1字節|携帶物品]
	dc.l	$00000000,$00000000,$00000000

seg_175D2E:	; [援軍令編號][必降角色][對話信息編號][是否出兵]
	dc.w	$0000,$FFFF,$0009,$0001	; 00[孫權09]
	dc.w	$0010,$FFFF,$001C,$0001	; 01[曹操0B]
	dc.w	$0000,$FFFF,$0013,$0000	; 02[司馬懿0C]
	dc.w	$0006,$0BFF,$001B,$0000	; 03[程昱0D]
	dc.w	$0000,$FFFF,$000C,$0001	; 04[曹仁0F]
	dc.w	$0007,$120B,$001A,$0001	; 05[夏侯淵11]
	dc.w	$0008,$110B,$000B,$0001	; 06[夏侯惇12]
	dc.w	$000C,$0BFF,$0016,$0001	; 07[牛金13]
	dc.w	$000A,$0BFF,$0020,$0001	; 08[許褚14]
	dc.w	$000B,$0BFF,$0011,$0001	; 09[張郃15]
	dc.w	$0000,$FFFF,$0019,$0001	; 0A[張遼16]
	dc.w	$000D,$09FF,$0014,$0001	; 0B[甘寧18]
	dc.w	$000E,$09FF,$001D,$0001	; 0C[周泰19]
	dc.w	$0000,$FFFF,$0018,$0001	; 0D[黃蓋1A]
	dc.w	$0000,$FFFF,$001F,$0001	; 0E[呂蒙1B]
	dc.w	$0009,$0BFF,$0017,$0001	; 0F[徐晃1C]
	dc.w	$000F,$06FF,$0021,$0000	; 10[呂布1D]
	dc.w	$0000,$FFFF,$0010,$0001	; 11[孟獲1E]
	dc.w	$0000,$FFFF,$0010,$0000	; 12[孟優1F]
	dc.w	$0000,$FFFF,$001E,$0001	; 13[沙摩柯20]
	dc.w	$0000,$FFFF,$0015,$0000	; 14[左慈21]

sub_12EF80:	; 是否出兵
	move.w	#1,(ram_000B).l		; 默認出兵
; 是否出兵[1]
	tst.b	(ram_000E+1).l		; 敵將一是否在場
	beq.s	loc_12EF80
	moveq	#0,d0
	move.b	(ram_000E+0).l,d0	; 敵將一編號
	lsl.l	#3,d0
	move.l	#seg_175D2E,a3		; 敵將信息表
	adda.l	d0,a3				; 敵將信息
	move.w	(ram_000B).l,d1
	and.w	6(a3),d1			; 兩者為真則出兵
	move.w	d1,(ram_000B).l		; 出兵寄存
; 是否出兵[2]
loc_12EF80:
	tst.b	(ram_0010+1).l		; 敵將二是否在場
	beq.s	locret_12EF80
	moveq	#0,d0
	move.b	(ram_0010+0).l,d0	; 敵將二編號
	lsl.l	#3,d0
	move.l	#seg_175D2E,a3		; 敵將信息表
	adda.l	d0,a3				; 敵將信息
	move.w	(ram_000B).l,d1
	and.w	6(a3),d1			; 兩者為真則出兵
	move.w	d1,(ram_000B).l		; 出兵寄存
locret_12EF80:
	rts

seg_154F44:
	dcb.w	4,$FFFF	; 0100博望坡#$00
	dc.w	$0239,$0000,$0639,$00FC	; 0205新野城右#$01
	dc.w	$01EF,$0000,$05EF,$00FC	; 0202白河水壩#$02
	dc.w	$01F6,$0000,$05F6,$00FC	; 0203白河上游#$03
	dcb.w	4,$FFFF	; 0208屋頂密室#$04
	dc.w	$01FC,$0000,$05FC,$00FA	; 0300襄江#$05
	dc.w	$020D,$0001,$060D,$00FA	; 0301長坂坡#$06
	dc.w	$037C,$0000,$077C,$00FA	; 0302江夏#$07
	dc.w	$0200,$0000,$0600,$00FA	; 0400南坪山碼頭#$08
	dc.w	$0100,$0000,$0600,$00FA	; 0403東吳戰船#$09
	dc.w	$03A2,$0000,$069A,$00FF	; 040B曹魏戰船#$0A
	dc.w	$0000,$0000,$0400,$00FA	; 0500烏林#$0B
	dc.w	$01FC,$0000,$05FC,$00FA	; 0501北彝陵#$0C
	dcb.w	4,$FFFF	; 0505江陵道#$0D
	dc.w	$0000,$0000,$0400,$00FA	; 0508葫蘆口#$0E
	dc.w	$03FC,$0000,$07FC,$00FA	; 0504華容道#$0F
	dc.w	$023F,$0000,$063F,$0100	; 0600山寨#$10
	dc.w	$0358,$0000,$0728,$00FE	; 0601火焰洞#$11
	dcb.w	4,$FFFF	; 0605白虎密室#$12
	dc.w	$03FF,$0000,$07FF,$00FE	; 0603南郡道#$13
	dc.w	$03FF,$0061,$07FF,$01B1	; 0701前庭#$14
	dc.w	$03FC,$0000,$07FC,$00FF	; 0703大廳#$15
	dc.w	$0400,$0000,$0800,$0100	; 0700南郡城門#$16
	dc.w	$03FF,$0000,$07FF,$0101	; 0705下水道#$17
	dcb.w	4,$FFFF	; 0604油江#$18
	dc.w	$03E0,$0000,$07E0,$00FE	; 0602古墓#$19
	dcb.w	4,$FFFF	; 0706長廊#$1A


sub_1841BA:	; 設定速殺計時器
	link	a6, #0
	movem.l	a2-a5,-(sp)
	movea.l	$10(a6),a2		; 速殺計時器編號寄存地址
	clr.l	(a2)			; 重置敵將速殺計時器編號
; 敵將是否招降
	move.l	#seg_175D2E,a3
	move.l	8(a6),d0		; 敵將編號
	lsl.l	#3,d0
	adda.l	d0,a3			; 敵將信息
	tst.w	(a3)
	bne.s	loc_1841BA
; 是否速殺任務
	movea.l	#seg_17592E,a4	; 場景坐標表
	move.w	(ram_0013).l,d0	; 場景序號
	mulu.w	#$C,d0			; 運算結果覆蓋高位
	adda.l	d0,a4			; 場景信息
	tst.w	(a4)			; 是否速殺任務
	beq.s	locret_1841BA
; 設定速殺計時
loc_1841BA:
	jsr		$100D74			; 分配計時器編號
	move.l	d0,(a2)
	movea.l	$C(a6),a5
	move.w	$6C(a5),d0		; 敵將生命值
	mulu.w	#4,d0			; 每15個生命值加時1秒|15除60乘
	move.l	d0,-(sp)
	move.l	(a2),-(sp)
	jsr		$100E1A
	addq.l	#8,sp
locret_1841BA:
	movem.l	(sp)+,a2-a5
	unlk	a6
	rts


sub_1450EA:
	movem.l	d2/a2-a4,-(sp)
; 是否完成新任務
	jsr		sub_1B43D4			; 計算已完成任務數[d0]
	beq.w	loc_1450F0
	movea.l	#ram_001B,a2		; 任務獎賞標記寄存
	adda.l	d0,a2
	tst.b	-(a2)				; 是否已獎賞
	bne.w	loc_1450F0
	move.b	#1,(a2)				; 標記已獎賞
; 判斷獎賞物品類
	moveq	#0,d1
	moveq	#0,d2
	move.b	(ram_0002).l,d1		; 敵人模式|難度+等級
	mulu.w	#22,d1				; 每個等級偏移22字節
	add.l	d1,d0
	movea.l	#unk_1450EC,a2		; 固定獎賞對應任務數
	move.b	(a2,d0.l),d2
	bne.s	loc_1450ED			; 是否固定獎賞
; 設定獎賞盲盒[隨機編號]
	pea		(31).w				; [00-30]獎賞
	jsr		$102480				; 大隨機
	addq.l	#4,sp
	moveq	#$1,d1				; 大循環1次
loc_1450EA:
	movea.l	#ram_001C,a3		; 盲盒標記寄存
	adda.l	d0,a3				; 從隨機號開始
loc_1450EB:
	tst.b	(a3)				; 是否已賞
	bne.s	loc_1450EC
; 設定獎賞盲盒[設定盲盒]
	move.b	#1,(a3)				; 標記盲盒
	movea.l	#unk_1450EB,a4		; 獎賞表格
	lsl.l	#1,d0
	move.w	(a4,d0.l),d0		; 隨機獎賞
	move.l	d0,-(sp)
	jsr		$15EC62				; 角色OBJ
	move.l	d0,-(sp)
	jsr		sub_1B1172
	addq.l	#8,sp
	bra.s	loc_1450F0
; 設定獎賞盲盒[循環判斷]
loc_1450EC:
	addq.l	#1,d0
	addq.l	#1,a3				; 循環判斷隨機值的最近盲盒
	cmpi.l	#21,d0				; 盲盒目不超過#21
	blt.s	loc_1450EB
	moveq	#$0,d0				; 輪回到盲盒號一
	dbf		d1,loc_1450EA
; 設定固定獎賞
loc_1450ED:
	movea.l	#unk_1450EA,a3
	jsr		$15EC62				; 第一順位角色
	bra.s	loc_1450EE
; 設定固定獎賞[計算固定獎賞]
loc_1450EF:
	move.l	d2,d0				; 第幾次固定獎賞
	lsl.l	#1,d0
	movea.l	$58(a4),a0
	move.b	1(a0),d1
	lsl.b	#3,d1				; 每個角色8個字節偏移
	add.b	d1,d0
	move.w	(a3,d0.l),d0		; 獎賞物品值
; 設定固定獎賞[設定獎賞寶盒]
	move.l	d0,-(sp)
	move.l	a4,-(sp)
	jsr		sub_1B1172
	addq.l	#8,sp
	addq.b	#1,(ram_0021).l		; 記錄一次不掉落|一把武器
; 設定固定獎賞[下一順位角色]
	move.l	a4,-(sp)
	jsr		$15EC88
	addq.l	#4,sp
loc_1450EE:
	movea.l	d0,a4
	move.l	a4,d0
	bne.s	loc_1450EF
; 關底劇情設定
loc_1450F0:
	pea		$13A646.l
	pea		$12C.w				; 主循環5秒
	jsr		$100EA4.l
	addq.l	#8,sp
	jsr		$12E5FC				; 關閉路線指示與計時
	jsr		$12EEF6				; 關閉退兵計時器
	moveq	#4,d0				; 關底結算
; 轉場進入終章
	cmpi.b	#21,(ram_000C).l	; 是否最後一位敵將#1-21
	bcs.s	locret_1450EA
	move.b	#4,($8182F8).l		; 場景臨時04
	clr.b	($8182F9).l			; 重置關卡00
	clr.b	($8182FA).l			; 重置場景00
	clr.b	(byte_8168C2).l		; 重置遁入青室進度
	clr.b	(byte_8168DC).l		; 重置是否完成遁入
loc_1450F1:
	jsr		($13A646).l			; 主循環
	jsr		(sub_1CB978).l		; 左慈攜人遁入青室
	beq.s	loc_1450F1
	moveq	#3,d0				; 直接進入終章[0004]
locret_1450EA:
	movem.l	(sp)+,d2/a2-a4
	rts

unk_1450EC:	; 各難度+每個固定獎勵對應所需的任務數
	dc.b	0, 0,0,$01,0,0,0,0,0,$02,0,0,0,0,0,0,0,0,$03,0,0,0	; 正常難度|3/9/18|至多21任務
	dc.b	0, 0,0,$01,0,0,0,0,$02,0,0,0,0,0,0,$03,0,0,0,0,0,0	; 難度+1|3/8/15|至多21任務
	dc.b	0, 0,0,$01,0,0,0,$02,0,0,0,0,$03,0,0,0,0,0,0,0,0,0	; 難度+2|3/7/12|至多20任務
	dc.b	0, 0,0,$01,0,0,$02,0,0,$03,0,0,0,0,0,0,0,0,0,0,0,0	; 難度+3|3/6/9|至多12任務

unk_1450EA:	; 固定獎賞-03
	dc.w	0, $0017,$0018,$003F	; 關羽
	dc.w	0, $001A,$0018,$003F	; 張飛
	dc.w	0, $001C,$0018,$003F	; 趙雲
	dc.w	0, $001F,$0020,$001E	; 黃忠
	dc.w	0, $0022,$0023,$0024	; 馬超
	dc.w	0, $0025,$0026,$003F	; 孔明
	dc.w	0, $0028,$0029,$003F	; 貂蟬
	dcb.w	4,$0	; 無
	dc.w	0, $002B,$002C,$003F	; 龐統
	dc.w	0, $002E,$004A,$003F	; 孫權

unk_1450EB:	; 獎賞盲盒-31
	dc.w	$0032,$0033,$0034,$0035, $0032,$0033,$0034,$0035, $0032,$0034, $0032,$0034	; [32-35]12神器
	dc.w	$003C,$003C,$003C,$003C,$003C, $0041,$0041,$0041,$0041,$0041, $003F,$003F	; [3C]5威靈仙 | [41]5木牛 | [3F]2七星燈
	dc.w	$0043,$0044,$0045, $004B,$004C,$004D,$004E	; [43-4F]7防具

sub_1B43D4:; 計算已完成的任務數目
	movem.l	d2-d4,-(sp)
	moveq	#0,d4		; 完成任務數
	moveq	#0,d2		; 章節數
loc_1B43D8:
	moveq	#0,d3		; 每章節的任務數
loc_1B43DA:
; 該任務是否完成
	move.l	d3,-(sp)
	move.l	d2,-(sp)
	jsr		$145110
	addq.l	#8,sp
	andi.l	#$FFFF,d0
	add.l	d0,d4
; 每章節3任務[0-2]
	addq.l	#1,d3
	moveq	#3,d0
	cmp.l	d3,d0
	bgt.s	loc_1B43DA
; 八個章節[0-7]
	addq.l	#1,d2
	moveq	#8,d0
	cmp.l	d2,d0
	bgt.s	loc_1B43D8
	move.l	d4,d0
	movem.l	(sp)+,d2-d4
	rts

sub_1B1172:	; 設定獎賞寶盒
	link	a6,#0
	movem.l	a2-a3,-(sp)
	movea.l	8(a6),a2			; 角色OBJ
	jsr		$14DF94
	movea.l	d0,a3
	clr.l	-(sp)
	pea		($FF24).w			; 豎坐標
	moveq	#0,d0
	move.w	$22(a2),d0
	move.l	d0,-(sp)			; 縱坐標
	move.w	$20(a2),d0
	move.l	d0,-(sp)			; 橫坐標
	pea		($1E2AFE).l			; 鐵盒指針
	move.l	a3,-(sp)
	jsr		$14E076
	move.l	#$2A4682,$2C(a3)	; 鐵盒落地
	clr.b	$F5(a3)				; 一擊即毀
	clr.w	$3C(a3)
	clr.w	$54(a3)
	clr.w	$68(a3)
	clr.l	$78(a3)
	move.w	#3,$6C(a3)
	move.w	$E(a6),$DE(a3)		; 獎賞物品
	lea		$18(sp),sp
	movem.l	(sp)+,a2-a3
	unlk	a6
	rts


sub_1CB978:	; 左慈攜人遁入青室劇情
	movem.l	d2/a2-a3,-(sp)
	moveq	#0,d0
	move.b	(byte_8168C2).l,d0	; 遁入青室進度
	moveq	#4,d1
	cmp.l	d1,d0
	bhi.w	loc_1CC162
	add.l	d0,d0
	move.w	jpt_1CB996(pc,d0.l),d0
	jmp		jpt_1CB996(pc,d0.w)
jpt_1CB996:
	dc.w	loc_1CB9A4-jpt_1CB996	; 左慈出場
	dc.w	loc_1CBAD0-jpt_1CB996	; 左慈對話
	dc.w	loc_1CBB16-jpt_1CB996	; 左慈施波
	dc.w	loc_1CBCF6-jpt_1CB996	; 雷電搬運
	dc.w	loc_1CBF96-jpt_1CB996	; 雷擊長空
; 左慈出場
loc_1CB9A4:
	clr.l	-(sp)
	jsr		($14B73E).l			; 投幣選人無效
	addq.l	#4,sp
	jsr		$1578E4				; 封我行關道具
	clr.b	($80C2B5).l			; 取消所有判定
	pea		(3600).w			; 時長
	jsr		$124C1E				; 陰暗背景
	addq.l	#4,sp
; 背景音樂
	pea		($2BEC9E).l			; 群雄左慈大廳
	pea		(5).w				; 曲目
	pea		($2F199C).l			; 音樂組
	jsr		$12BC40				; 背景音樂
	pea		($7F).w				; 音量
	pea		(3).w				; 編號
	jsr		$12BDA0				; 音樂音量等
	lea		$14(sp),sp
; 出場設定
	jsr		$109CC2				; 分配敵人OBJ
	move.l	d0,d2
	clr.l	-(sp)				; 色盤
	pea		(1).w				; 面左
	pea		($FF9C).w			; 豎坐標
	pea		($A0).w				; 縱坐標
	move.w	($D0A000).l,d0
	ext.l	d0
	addi.l	#$1C0-$28+$438,d0	; 橫坐標
	move.l	d0,-(sp)
	pea		($247EB2).l			; 左慈
	move.l	d2,-(sp)
	jsr		$10A1BA				; 敵方出場
	move.l	d2,-(sp)
	jsr		$10F2C2				; 計算敵人OBJ
	move.l	d0,(dword_8168D0).l	; 左慈OBJ
	movea.l d0,a2
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10FC92
	pea		(off_24A4D2).l		; 出場動作指針
	move.l	a2,-(sp)
	jsr		$10EF18				; 寫入動作
	lea		$30(sp),sp
	clr.w	$1DE(a2)
	move.w	#$78,$216(a2)
	move.w	#$708,$218(a2)
	move.w	#1,$A2(a2)			; 無視地形
	addq.b	#1,(byte_8168C2).l	; 下一進度
	bra.w	loc_1CC162
; 左慈對話
loc_1CBAD0:
; 定點懸停
	moveq	#0,d0
	move.w	($D0A000).l,d0
	addi.w	#$1C0-$28,d0		; 左慈定點停止飛行
	movea.l	dword_8168D0.l,a2	; 左慈OBJ
	move.w	$20(a2),d1
	cmp.w	d1,d0
	bcs.w	loc_1CC162
	move.w	#$52,$44(a2)		; 下一動作|0201
; 對話內容
	pea		($131).w			; 「狂妄妖道，汝邪法已破，還不束手就擒！」
	jsr		($15EC62).l			; 第一順位角色
	movea.l	d0,a0
	movea.l	$58(a0),a1
	move.b	1(a1),d0
	andi.l	#$FF,d0
	move.l	d0,-(sp)			; 我方說
	jsr		$1343D6				; 對話框
	addq.l	#8,sp
	pea		($132).w			; 「神仙之術，豈會僅止於此呢…星旋斗轉，星移地轉。收！」
	pea		($15).w				; 左慈說
	jsr		$1343D6				; 對話框
	addq.l	#8,sp
	addq.b	#1,(byte_8168C2).l	; 下一進度
	bra.w	loc_1CC162
; 左慈施波
loc_1CBB16:
	movea.l	dword_8168D0.l,a2	; 左慈OBJ
	pea		(4).w				; 左慈施波
	pea		(3).w
	move.l	a2,-(sp)
	jsr		$10EBDE				; 動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18				; 寫入動作
	lea		$14(sp),sp
	bra.s	loc_1CBC00
loc_1CBBFA:
	jsr		($13A646).l			; 主循環
loc_1CBC00:
	cmpi.w	#2,$50(a2)
	bne.s	loc_1CBBFA
; 角色翻騰
	jsr		$15EC62				; 第一順位角色
	bra.w	loc_1CBB18
loc_1CBB17:
	pea		(off_31520E).l		; 浮空翻騰動作
	move.l	a2,-(sp)
	jsr		$15E2DA				; 寫入動作
	addq.l	#8,sp
; 翻騰附電
	clr.l	-(sp)
	pea		($14).w
	clr.l	-(sp)
	move.w	$22(a2),d0
	addq.w	#1,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	move.l	d0,-(sp)
	jsr		($153FCC).l			; 浮空揚塵
	clr.l	-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	subi.l	#$A,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#2,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$28,d0
	move.l	d0,-(sp)
	pea		(off_31544E).l		; 翻騰附電
	jsr		$1517D4				; 佈置機關
	movea.l	d0,a3
	move.l	a3,$D4(a2)
	move.w	#1,$6A(a3)
	clr.w	$AC(a3)
	clr.w	$AE(a3)
	clr.w	$B0(a3)
	move.l	a2,-(sp)
	jsr		$15EC88				; 下一順位角色
	lea		$2C(sp),sp
loc_1CBB18:
	movea.l	d0,a2
	move.l	a2,d0
	bne.w	loc_1CBB17
	addq.b	#1,(byte_8168C2).l	; 下一進度
	bra.w	loc_1CC162
; 雷電搬運
loc_1CBCF6:
; 四秒計時
	jsr		$100D74				; 分配計時器
	move.l	d0,d2
	pea		(240).w				; 四秒
	move.l	d2,-(sp)
	jsr		$100E1A				; 設定計時器
	addq.l	#8,sp
	bra.s	loc_1CBD1A
loc_1CBD0E:
	jsr		($106266).l
	jsr		($13A646).l			; 主循環
loc_1CBD1A:
	move.l	d2,-(sp)
	jsr		$100E62				; 剩餘計時
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_1CBD30
	bsr.w	sub_1CB932			; 任意角色是否按[A]
	tst.w	d0
	bne.s	loc_1CBD0E
; 佈置雷電
loc_1CBD30:
	move.l	d2,-(sp)
	jsr		$100DC2				; 關閉計時
	addq.l	#4,sp
	moveq	#0,d2
loc_1CBD3C:
	clr.l	-(sp)
	clr.l	-(sp)
	move.w	d2,d0
	add.w	d0,d0
	movea.l	#(word_3154C2+$C),a0	; 縱坐標
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.w	($D0A002).l,d1
	add.w	d1,d0
	move.l	d0,-(sp)
	move.w	d2,d0
	add.w	d0,d0
	movea.l	#(word_3154C2),a0		; 橫坐標
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.w	($D0A000).l,d1
	add.w	d1,d0
	move.l	d0,-(sp)
	pea		(off_1E5C40).l		; 搬運雷電
	jsr		$1517D4				; 佈置機關
	lea		$14(sp),sp
	movea.l	d0,a3
	move.l	#dword_315332,$2C(a3)	; 無聲搬運
	clr.w	$3C(a3)
	clr.w	$54(a3)
	addq.l	#1,d2
	moveq	#5,d0				; 六道雷電
	cmp.l	d2,d0
	bgt.s	loc_1CBD3C
	clr.l	-(sp)
	clr.l	-(sp)
	move.w	d2,d0
	add.w	d0,d0
	movea.l	#(word_3154C2+$C),a0	; 縱坐標
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.w	($D0A002).l,d1
	add.w	d1,d0
	move.l	d0,-(sp)
	move.w	d2,d0
	add.w	d0,d0
	movea.l	#(word_3154C2),a0		; 橫坐標
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.w	($D0A000).l,d1
	add.w	d1,d0
	move.l	d0,-(sp)
	pea		(off_1E5C40).l		; 搬運雷電
	jsr		$1517D4				; 佈置機關
	movea.l	d0,a3
	move.l	#dword_31539E,$2C(a3)	; 有聲搬運
	clr.w	$3C(a3)
	clr.w	$54(a3)
; 三秒計時
	jsr		$100D74				; 分配計時器
	move.l	d0,d2
	pea		($B4).w				; 3秒
	move.l	d2,-(sp)
	jsr		$100E1A				; 設定計時器
	lea		$1C(sp),sp
	bra.s	loc_1CBDFA
loc_1CBDEE:
	jsr		($106266).l
	jsr		($13A646).l			; 主循環
loc_1CBDFA:
	move.l	d2,-(sp)
	jsr		$100E62				; 剩餘計時
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_1CBE10
	bsr.w	sub_1CB932			; 任意角色是否按[A]
	tst.w	d0
	bne.s	loc_1CBDEE
; 離心動作
loc_1CBE10:
	move.l	d2,-(sp)
	jsr		$100DC2				; 關閉計時
	addq.l	#4,sp
	jsr		$15EC62				; 第一順位角色
	bra.s	loc_1CBE12
loc_1CBE11:
	pea		(off_31531C).l		; 離心動作
	move.l	a2,-(sp)
	jsr		$15E2DA				; 寫入動作
	move.l	a2,-(sp)
	jsr		$15EC88				; 下一順位角色
	lea		$C(sp),sp
loc_1CBE12:
	movea.l	d0,a2
	move.l	a2,d0
	bne.s	loc_1CBE11
	jsr		$100D74				; 分配計時器
	move.l	d0,d2
	pea		($1E0).w			; 8妙
	move.l	d2,-(sp)
	jsr		$100E1A				; 設定計時器
	addq.l	#8,sp
	bra.s	loc_1CBE62
loc_1CBE56:
	jsr		($106266).l
	jsr		($13A646).l			; 主循環
loc_1CBE62:
	move.l	d2,-(sp)
	jsr		$100E62				; 剩餘計時
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_1CBEB0
	bsr.w	sub_1CB932			; 任意角色是否按[A]
	tst.w	d0
	bne.s	loc_1CBE56
; 完成遁入
loc_1CBEB0:
	move.l	d2,-(sp)
	jsr		$100DC2				; 關閉計時
	jsr		$105C38
	jsr		$15EC62				; 第一順位角色
	bra.s	loc_1CBEB2
loc_1CBEB1:
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		(sub_1107E8).l		; 清除身上特效
	move.l	a2,-(sp)
	jsr		$15EC88				; 下一順位角色
	lea		$C(sp),sp
loc_1CBEB2:
	movea.l	d0,a2
	move.l	a2,d0
	bne.s	loc_1CBEB1
	clr.l	-(sp)
	jsr		$10459C				; 延時白屏
	addq.l	#8,sp
	jsr		$105C42
	move.b	#1,(byte_8168DC).l	; 完成遁入
	jsr		($145548).l			; 清除時間標題
	move.w	#1,($80D032).l		; 清除當前道具選定圖
	jsr		($1453AA).l			; 場景刷新[03|04]
	addq.b	#1,(byte_8168C2).l	; 下一進度
	bra.w	loc_1CC162
; 雷擊長空
loc_1CBF96:
	jsr		($107346).l
	jsr		($1075AE).l
	jsr		($10297C).l
; 雷擊音效
	jsr		($12D4B4).l
	tst.l	d0
	beq.s	loc_14287A
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.s	loc_14287A
	jsr		$13A578
	pea		(1).w
	move.l	#$F000000,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA				; 寫入音效
	lea		$C(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_142874
	move.l	($81B4A8).l,($81B4B0).l
loc_142874:
	jsr		$13A58E
loc_14287A:
	jsr		$12D48C
	tst.l	d0
	beq.s	loc_1428E2
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.s	loc_1428E2
	jsr		$13A578
	pea		(1).w
	move.l	#$14000000,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA				; 寫入音效
	lea		$C(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_1428DC
	move.l	($81B4A8).l,($81B4B0).l
loc_1428DC:
	jsr		$13A58E
loc_1428E2:
	pea		($2BEC9E).l
	pea		($A).w
	pea		($2E0CE4).l
	jsr		$12BC40				; 背景音樂
	pea		($EF).w
	clr.l	-(sp)
	jsr		$12BDA0				; 音樂音量等
	lea		$14(sp),sp
	bsr.w	(sub_13EFD4).l		; 雷擊長空動畫
	pea		(1).w
	jsr		($14B73E).l			; 投幣選人有效
	addq.l	#4,sp
	moveq	#1,d0				; 退出循環
	bra.s	loc_1CC164
loc_1CC162:
	moveq	#0,d0
loc_1CC164:
	movem.l	(sp)+,d2/a2-a3
	rts

off_24A4D2:	; 向前飛行後懸停
	dc.w	$020D
	dc.l	dword_2499DC,$01000000,0,0
dword_2499DC:
	dc.l	$F00BEF00,$01B30000	; 先聞其聲
	dc.l	$F02B0300	; 每次移動橫坐標$C
	dc.l	$F0330100
	dc.l	$F0260100
	dc.l	$F0280600
	dc.l	$F03400FF,$000F0000,$00060000
	dc.l	$F02700FF,$00170000,$00060000,$00001800
	dc.l	$F0290000
	dc.l	$F0280600
	dc.l	$F03400FF,$00100000,$00060000
	dc.l	$F02700FF,$00180000,$00060000,$00011800
	dc.l	$F0290000
	dc.l	$F00B4F00,$00A60000
	dc.l	$F0280600
	dc.l	$F03400FF,$00110000,$00060000
	dc.l	$F02700FF,$00190000,$00060000,$00021800
	dc.l	$F0290000
	dc.l	$F0280600
	dc.l	$F03400FF,$00120000,$00060000
	dc.l	$F02700FF,$001A0000,$00060000,$00031800
	dc.l	$F0290000
	dc.l	$F0280600
	dc.l	$F03400FF,$00130000,$00060000
	dc.l	$F02700FF,$001B0000,$00060000,$00041800
	dc.l	$F0290000
	dc.l	$F0280600
	dc.l	$F03400FF,$00140000,$00060000
	dc.l	$F02700FF,$001C0000,$00060000,$00051800
	dc.l	$F0290000
	dc.l	$F0280600
	dc.l	$F03400FF,$00150000,$00060000
	dc.l	$F02700FF,$001D0000,$00060000,$00061800
	dc.l	$F0290000
	dc.l	$F0280600
	dc.l	$F03400FF,$00160000,$00060000
	dc.l	$F02700FF,$001E0000,$00060000,$00071800
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$F0260000
	dc.l	$F0010200
	dc.l	$F0040201	; 再見其人|定點懸停

off_31520E:	; 浮空翻騰
	dc.w	$0C1F
	dc.l	dword_315156,$02000001,0,0
dword_315156:
	dc.l	$F00E0200
	dc.l	$F0020F00,$001C00FF
	dc.l	$F01001FF,$001B00FF
	dc.l	$F010FF01
	dc.l	$F0020300,$001B00FF
	dc.l	$F01001FF,$001C00FE
	dc.l	$F010FF01
	dc.l	$F0020300,$001C00FE
	dc.l	$F01001FF,$001B00FF
	dc.l	$F010FF01
	dc.l	$F0020300,$001B00FF
	dc.l	$F01001FF,$001C0000
	dc.l	$F010FF01
	dc.l	$F0020300,$001C0000
	dc.l	$F01001FF,$001B0001
	dc.l	$F010FF01
	dc.l	$F0020300,$001B0001
	dc.l	$F01001FF,$001C0002
	dc.l	$F010FF01
	dc.l	$F0020300,$001C0002
	dc.l	$F01001FF,$001B0001
	dc.l	$F010FF01
	dc.l	$F0020300,$001B0001
	dc.l	$F01001FF,$001C0001
	dc.l	$F010FF01
	dc.l	$F0020300,$001C0000
	dc.l	$F0010200

off_31544E:	; 浮空翻騰附帶電
	dc.l	dword_315412,$001C9D96,$00000000,$00000000
	dc.l	$00319CE8,$00587F33,$00090020,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000,0
dword_315412:
	dc.l	$000A0000,$000B0000,$000C0000,$000D0000
	dc.l	$000E0000,$000F0000,$00100000,$00110000
	dc.l	$00120000,$00130000,$00140000,$00150000
	dc.l	$00160000,$00170000
	dc.l	$F0010000

sub_1CB932:	; 是否按[A]
	move.l	a2,-(sp)
	jsr		$15EC62			; 第一順位角色
	bra.s	loc_1CB96C
loc_1CB93C:
	move.w	$E(a2),d0
	movea.l	#byte_3154DA,a0
	move.b	(a0,d0.w),d0
	andi.l	#$FF,d0
	move.l	d0,-(sp)
	jsr		$101144			; 是否按鍵
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_1CB962
	moveq	#0,d0
	bra.s	loc_1CB974
loc_1CB962:
	move.l	a2,-(sp)
	jsr		$15EC88			; 下一順位角色
	addq.l	#4,sp
loc_1CB96C:
	movea.l	d0,a2
	move.l	a2,d0
	bne.s	loc_1CB93C
	moveq	#1,d0
loc_1CB974:
	movea.l	(sp)+,a2
	rts
byte_3154DA:	; 每個玩家按鈕[A]對應的值
	dc.b	$06,$0E,$16,$1E

word_3154C2:; 復活雷電坐標
	dc.w	$0029,$006A,$00CE,$010A,$0092,$0132	; 橫
	dc.w	$00C8,$00BE,$00DC,$00B4,$00AA,$00E6	; 縱

off_1E5C40:	; 搬運雷電
	dc.l	dword_1E5B4A,$001C9D96,$001CA74E,$001CAA74
	dc.l	$00319D02,$00587F33,$09010420,$00000000	; [$1A(OBJ)=04]屏幕外不消失
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000609
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00004000,$00000000,$00000000,$00000000,0
dword_1E5B4A:
	dc.l	$F00B9F00,$02DA0000
	dc.l	$20000000,$40000000,$00010000,$40010000
	dc.l	$00020000,$40020000,$00030000,$40030000
	dc.l	$F0140303,$00000100,$20040000,$40040000,$00050000,$40050000
	dc.l	$F0140304,$00000100,$00060000,$40060000,$00070000,$40070000
	dc.l	$F0140305,$00000100
	dc.l	$80000000

dword_315332:
	dc.l	$F0070000,sub_1CB8EC
	dc.l	$01711800,$41711800,$01721800,$41721800
	dc.l	$01731800,$41731800,$01741800,$41741800
	dc.l	$F0140303,$00000100
	dc.l	$F0070000,sub_1CB8EC
	dc.l	$01751800,$41751800,$01761800,$41761800
	dc.l	$F0140304,$00000100
	dc.l	$01771800,$41771800,$01781800,$41781800
	dc.l	$F0140305,$00000100
	dc.l	$F0010000
sub_1CB8EC:	; 雷電是否停止，是否回走
	movea.l	4(sp),a0
	tst.b	(byte_8168DC).l	; 遁入青室是否完成
	beq.s	loc_1CB90E
	move.l	#dword_31532E,$2C(a0)
	clr.w	$3C(a0)
	clr.w	$54(a0)
	clr.w	$68(a0)
	bra.s	locret_1CB930
loc_1CB90E:	; 走右
	move.w	$20(a0),d0		; 雷電橫坐標
	move.w	($D0A000).l,d1
	tst.w	$5C(a0)
	beq.s	loc_1CB922
	addi.w	#$70,d1			; 屏幕左邊緣
	cmp.w	d1,d0
	bge.s	locret_1CB930
	clr.w	$5C(a0)
	bra.s	locret_1CB930
loc_1CB922:	; 走左
	addi.w	#$150,d1		; 屏幕右邊緣
	cmp.w	d1,d0
	ble.s	locret_1CB930
	move.w	#1,$5C(a0)
locret_1CB930:
	rts
dword_31532E:
	dc.l	$80000000

dword_31539E:
	dc.l	$F00B9F01,$02DA0000
	dc.l	$F0070000,sub_1CB8EC
	dc.l	$01711800,$41711800,$01721800,$41721800
	dc.l	$01731800,$41731800,$01741800,$41741800
	dc.l	$F0140303,$00000100
	dc.l	$F0070000,sub_1CB8EC
	dc.l	$01751800,$41751800,$01761800,$41761800
	dc.l	$F0140304,$00000100
	dc.l	$01771800,$41771800,$01781800,$41781800
	dc.l	$F0140305,$00000100
	dc.l	$F0010200

off_31531C:	; 離心動作
	dc.w	$0C1F
	dc.l	dword_315220,$02001001,0,0
dword_315220:
	dc.l	$F0130100,$F01C0100
	dc.l	$001CEB00,$001CEBFF,$001CECFF,$001CEDFE
	dc.l	$001CEDFD,$001CEEFD,$001CF0FD,$001CF1FC
	dc.l	$001CF3FC,$001CF5FC,$001CF6FB,$001CF9FB
	dc.l	$001CFAFB,$001CFDFB,$001CFFFB,$001C01FB
	dc.l	$001C03FB,$001C06FB,$001C07FB,$001C0AFB
	dc.l	$001C0BFC,$001C0DFC,$001C0FFC,$001C10FD
	dc.l	$001C12FD,$001C13FD,$001C13FE,$001C14FF
	dc.l	$001C15FF,$001C1500,$001C1500,$001C1501
	dc.l	$001C1401,$001C1302,$001C1303,$001C1203
	dc.l	$001C1003,$001C0F04,$001C0D04,$001C0B04
	dc.l	$001C0A05,$001C0705,$001C0605,$001C0305
	dc.l	$001C0105,$001CFF05,$001CFD05,$001CFA05
	dc.l	$001CF905,$001CF605,$001CF504,$001CF304
	dc.l	$001CF104,$001CF003,$001CEE03,$001CED03
	dc.l	$001CED02,$001CEC01,$001CEB01,$001CEB00
	dc.l	$F0010000

sub_1107E8:	; 清除敵我身上的道具、特效等
	movem.l	d2/a2,-(sp)
	move.l	$10(sp),d2
	movea.l	$C(sp),a2
	moveq	#5,d0
	cmp.l	d2,d0
	beq.s	loc_110800
	moveq	#6,d0
	cmp.l	d2,d0
	bne.s	loc_110828
loc_110800:
	move.l	d2,d0
	lsl.l	#2,d0
	movea.l	d0,a0
	lea		$D4(a2),a1
	movea.l	(a1,a0.l),a0
	clr.w	$6A(a0)
	move.l	d2,d0
	lsl.l	#2,d0
	movea.l	d0,a0
	lea		$D4(a2),a1
	move.l	(a1,a0.l),-(sp)
	jsr		$14E464		; 關閉機關
	bra.s	loc_11084E
loc_110828:
	move.l	d2,d0
	lsl.l	#2,d0
	movea.l	d0,a0
	lea		$D4(a2),a1
	movea.l	(a1,a0.l),a0
	clr.w	$6A(a0)
	move.l	d2,d0
	lsl.l	#2,d0
	movea.l	d0,a0
	lea		$D4(a2),a1
	move.l	(a1,a0.l),-(sp)
	jsr		$151A3A		; 清除特效
loc_11084E:
	addq.l	#4,sp
	move.l	d2,d0
	lsl.l	#2,d0
	movea.l	d0,a0
	lea		$D4(a2),a1
	clr.l	(a1,a0.l)
	movem.l	(sp)+,d2/a2
	rts

sub_13EFD4:	; 雷擊長空
	link	a6,#-$40
	movem.l	d2-d3/a2,-(sp)
	jsr		$103F30
	pea		($1EE2D8).l
	pea		(1).w
	pea		(2).w
	jsr		$10388E		; 預寫色盤
	move.b	d0,-$1E(a6)
	pea		($1EE2D8).l
	clr.l	-(sp)
	pea		(2).w
	jsr		$10388E		; 預寫色盤
	lea		$18(sp),sp
	move.b	d0,-$1D(a6)
	jsr		$103CB2		; 上色
	moveq	#0,d2
loc_13F01C:
	clr.l	-(sp)
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($1E9C6C).l
	clr.l	-(sp)
	pea		($75).w
	jsr		$13EDA4
	lea		$18(sp),sp
	move.w	d2,d1
	lsl.w	#2,d1
	move.l	d0,-$3E(a6,d1.w)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#4,d0
	move.w	d2,d1
	lsl.w	#2,d1
	movea.l	-$3E(a6,d1.w),a0
	move.w	d0,$20(a0)
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	-$3E(a6,d0.w),a0
	clr.w	$22(a0)
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	-$3E(a6,d0.w),a0
	clr.w	$24(a0)
	addq.l	#1,d2
	moveq	#8,d0		; 打印紫色方塊|原數[4]右下角缺圖
	cmp.l	d2,d0
	bgt.s	loc_13F01C
	moveq	#0,d3
	moveq	#4,d2
loc_13F078:
	clr.l	-(sp)
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($1E9C6C).l
	clr.l	-(sp)
	pea		($75).w
	jsr		$13EDA4
	lea		$18(sp),sp
	move.w	d2,d1
	lsl.w	#2,d1
	move.l	d0,-$3E(a6,d1.w)
	move.w	d3,d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#4,d0
	move.w	d2,d1
	lsl.w	#2,d1
	movea.l	-$3E(a6,d1.w),a0
	move.w	d0,$20(a0)
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	-$3E(a6,d0.w),a0
	move.w	#$70,$22(a0)
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	-$3E(a6,d0.w),a0
	clr.w	$24(a0)
	addq.l	#1,d3
	addq.l	#1,d2
	moveq	#8,d0
	cmp.l	d2,d0
	bgt.s	loc_13F078
	clr.l	-(sp)
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($1E9C6C).l
	pea		(1).w
	pea		($76).w
	jsr		$13EDA4
	movea.l	d0,a2
	pea		($13A646).l	; 主循環
	pea		(2).w
	jsr		$100EA4		; 計時器
	lea		$20(sp),sp
	pea		(2).w
	pea		($31BC2E).l
	pea		(1).w
	pea		(2).w
	moveq	#0,d0
	move.b	-$1E(a6),d0
	move.l	d0,-(sp)
	jsr		$1036D0		; 計算色盤RAM
	pea		(2).w
	pea		($31BC2E).l
	clr.l	-(sp)
	pea		(2).w
	moveq	#0,d0
	move.b	-$1D(a6),d0
	move.l	d0,-(sp)
	jsr		$1036D0		; 計算色盤RAM
	jsr		$103CB2		; 上色
	pea		($13A646).l	; 主循環
	pea		(2).w
	jsr		$100EA4		; 計時器
	lea		$30(sp),sp
	moveq	#0,d2
loc_13F15C:
	move.w	d2,d0
	lsl.w	#2,d0
	move.l	-$3E(a6,d0.w),-(sp)
	jsr		$14E464		; 關閉機關
	addq.l	#4,sp
	addq.l	#1,d2
	moveq	#8,d0
	cmp.l	d2,d0
	bgt.s	loc_13F15C
	move.w	#$77,$3E(a2)
	pea		(1).w
	jsr		$10454C
	move.l	a2,-(sp)
	jsr		$14E464		; 關閉機關
	pea		($13A646).l	; 主循環
	pea		($3C).w
	jsr		$100EA4		; 計時器
	lea		$10(sp),sp
	movem.l	-$4C(a6),d2-d3/a2
	unlk	a6
	rts


sub_17DC4E:
; 敵將爆物程序
	movem.l	d2-d6/a2-a3,-(sp)
; 計算爆物表地址
	movea.l	#seg_17DC4E,a2	; 爆物表指針
	jsr		$12EF06
	lsl.l	#2,d0
	adda.l	d0,a2			; 單兵或雙兵表
	move.l	a2,-(sp)
	move.l	$24(sp),d0		; 敵將編號>>爆物表編號[0-20]
	lsl.l	#2,d0
	add.l	d0,d0
	add.l	(sp)+,d0
	movea.l	d0,a2
	movea.l	(a2),a2
; 重置已用爆物坐標的標記
	moveq	#0,d3
loc_17DC54:
	moveq	#$0,d2
loc_17DC56:
	move.w	d3,d0
	lsl.w	#3,d0
	add.w	d2,d0
	movea.l	#$81AAD6,a0		; 已用爆物坐標的標記表
	clr.b	(a0,d0.w)
	addq.l	#1,d2
	moveq	#8,d0
	cmp.l	d2,d0
	bgt.s	loc_17DC56
	addq.l	#1,d3
	moveq	#$10,d0
	cmp.l	d3,d0
	bgt.s	loc_17DC54		; 循環清零
; 特殊地形爆物限定坐標
	move.l	$D0A000.l,d6	; 保存原屏幕橫縱坐標
	moveq	#0,d0
	move.w	(ram_0013).l,d0	; 場景序號
	lsl.l	#2,d0
	move.l	#seg_81AAD6,a3	; 特殊地形限定屏幕坐標表
	adda.l	d0,a3
	tst.w	(a3)
	bmi.s	loc_17DC4E
	move.w	(a3),$D0A000.l	; 使用規定屏幕橫坐標
loc_17DC4E:
	tst.w	2(a3)
	bmi.s	loc_17DC4F
	move.w	2(a3),$D0A002.l	; 使用規定屏幕縱坐標
loc_17DC4F:
	bra.w	loc_17DD58
; 隨機標記位是否已使用
loc_17DCC8:
	pea		$F.w
	jsr		$1024b0.l
	move.l	d0,d3			; 16個橫坐標
	pea		$7.w
	jsr		$1024b0.l
	addq.l	#8,sp
	move.l	d0,d2			; 8個縱坐標
	move.w	d3,d0
	lsl.w	#3,d0
	add.w	d2,d0
	movea.l	#$81AAD6,a0
	tst.b	(a0,d0.w)
	bne.s	loc_17DCC8
	move.b	#1,(a0,d0.w)	; 標記
; 計算隨機橫坐標[d5]
	move.l	d3,d5
	lsl.l	#3,d5			; 每個橫坐標相距$8
	move.w	$D0A000.l,d0	; 根據屏幕X坐標計算橫坐標
	addi.l	#$A0,d0
	add.l	d0,d5
; 計算隨機縱坐標[d4]
	move.l	d2,d4
	lsl.l	#3,d4			; 每個縱坐標相距$8
	move.w	$D0A002.l,d0	; 根據屏幕Y坐標計算縱坐標
	addi.l	#$A0,d0
	add.l	d0,d4
; 調用掉物程序
	btst	#7,(a2)			; 判斷掉落物品的類別
	beq.s	loc_17DD3A
; 編號$80以上的不可攜物品
	clr.l	-(sp)
	moveq	#0,d0
	move.b	(a2),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	d4,d0
	move.l	d0,-(sp)
	move.w	d5,d0
	move.l	d0,-(sp)
	jsr		$11C1CA.l
	bra.s	loc_17DD52
loc_17DD3A:
; 編號$0~$7F的可攜帶物品
	clr.l	-(sp)
	moveq	#0,d0
	move.b	(a2),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	d4,d0
	move.l	d0,-(sp)
	move.w	d5,d0
	move.l	d0,-(sp)
	jsr		$123B96.l
loc_17DD52:
	lea		$14(sp),sp
; 下一爆物
	addq.l	#1,a2
loc_17DD58:
	tst.b	(a2)
	bne.w	loc_17DCC8
	move.l	d6,$D0A000.l	; 恢復原屏幕橫縱坐標
	movem.l	(sp)+,d2-d6/a2-a3
	rts

seg_81AAD6:	; [特殊地形限定屏幕坐標XY]
	dc.w	$FFFF,$FFFF	; 0100博望坡
	dc.w	$FFFF,$001D	; 0205新野城右
	dc.w	$FFFF,$FFFF	; 0202白河水壩
	dc.w	$FFFF,$FFFF	; 0203白河上游
	dc.w	$FFFF,$FFFF	; 0208屋頂密室
	dc.w	$FFFF,$001B	; 0300襄江
	dc.w	$0450,$FFFF	; 0301長坂坡
	dc.w	$FFFF,$FFFF	; 0302江夏
	dc.w	$FFFF,$0000	; 0400南坪山碼頭
	dc.w	$0255,$FFFF	; 0403東吳戰船
	dc.w	$0428,$FFFF	; 040B曹魏戰船
	dc.w	$FFFF,$FFFF	; 0500烏林
	dc.w	$043D,$FFFF	; 0501北彝陵
	dc.w	$FFFF,$FFFF	; 0505江陵道
	dc.w	$0241,$FFFF	; 0508葫蘆口
	dc.w	$FFFF,$FFFF	; 0504華容道
	dc.w	$FFFF,$FFFF	; 0600山寨
	dc.w	$FFFF,$FFFF	; 0601火焰洞
	dc.w	$FFFF,$FFFF	; 0605白虎密室
	dc.w	$FFFF,$FFFF	; 0603南郡道
	dc.w	$0620,$0050	; 0701前庭
	dc.w	$04B0,$FFFF	; 0703大廳
	dc.w	$0400,$FFFF	; 0700南郡城門
	dc.w	$FFFF,$FFFF	; 0705下水道
	dc.w	$FFFF,$FFFF	; 0604油江#$18
	dc.w	$FFFF,$FFFF	; 0602古墓#$19
	dc.w	$FFFF,$0018	; 0706長廊#$1A


seg_17DC4E:
	dc.l	unk_1B5656_2,unk_1B5656_4
	dc.l	unk_19D4C2_2,unk_19D4C2_4,unk_185970_2,unk_185970_4
	dc.l	unk_19D9C6_2,unk_19D9C6_4,unk_287B16_2,unk_287B1E_4
	dc.l	unk_1A6E80_2,unk_1A6E80_4,unk_177FBC_2,unk_177FBC_4
	dc.l	unk_194EFA_2,unk_194EFA_4,unk_1B80D2_2,unk_1B80D2_4
	dc.l	unk_1867BC_2,unk_1867BC_4,unk_1A0BC8_2,unk_1A0BC8_4
	dc.l	unk_18F744_2,unk_18F744_4,unk_1A84AA_2,unk_1A84AA_4
	dc.l	unk_1B8DB2_2,unk_1B8DB2_4,unk_1B92F8_2,unk_1B92F8_4
	dc.l	unk_19A440_2,unk_19A440_4,unk_1AFEB0_2,unk_1AFEB0_4
	dc.l	unk_1ACCB4_2,unk_1ACCB4_4,unk_1ACE46_2,unk_1ACE46_4
	dc.l	unk_1A9CAA_2,unk_1A9CAA_4,unk_1AB200_2,unk_1AB200_4

unk_1B5656_2:	; 01.孫權[霸王戰甲]
	dc.b	$02,$04,$04,$05,$81,$82,$48,0
unk_1B5656_4	; 4P
	dc.b	$02,$04,$04,$04,$05,$81,$82,$41,$48,0
unk_19D4C2_2:	; 02.曹操
	dc.b	$04,$11,$14,$05,$85,0
unk_19D4C2_4	; 4P
	dc.b	$04,$11,$14,$05,$03,$85,$83,0
unk_185970_2:	; 03.司馬懿[天師道袍]
	dc.b	$03,$11,$13,$14,$82,$86,$4E,0
unk_185970_4	; 4P
	dc.b	$03,$11,$13,$14,$11,$13,$82,$82,$84,$4E,0
unk_19D9C6_2:	; 04.程昱[太平道袍]
	dc.b	$04,$03,$13,$02,$11,$12,$14,$81,$4D,0
unk_19D9C6_4	; 4P
	dc.b	$04,$03,$13,$02,$11,$12,$14,$11,$05,$81,$82,$4D,0
unk_287B16_2:	; 05.曹仁
	dc.b	$13,$14,$83,$11,$82,0
unk_287B1E_4	; 4P
	dc.b	$13,$14,$83,$11,$82,$13,$82,0
unk_1A6E80_2:	; 06.夏侯淵
	dc.b	$04,$05,$02,$14,$11,$86,0
unk_1A6E80_4	; 4P
	dc.b	$04,$05,$02,$14,$11,$13,$3E,$86,$84,0
unk_177FBC_2:	; 07.夏侯惇[青銅甲|鎖子甲]
	dc.b	$11,$86,$82,$44,0
unk_177FBC_4	; 4P
	dc.b	$11,$86,$82,$82,$43,$44,0
unk_194EFA_2:	; 08.牛金[明光铠]
	dc.b	$12,$14,$82,$82,$45,0
unk_194EFA_4	; 4P
	dc.b	$12,$14,$13,$82,$82,$84,$45,0
unk_1B80D2_2:	; 09.許褚
	dc.b	$04,$05,$03,$13,$82,$86,0
unk_1B80D2_4	; 4P
	dc.b	$04,$05,$03,$13,$04,$82,$86,$84,0
unk_1867BC_2:	; 0A.張郃
	dc.b	$04,$12,$14,$84,$82,0
unk_1867BC_4	; 4P
	dc.b	$04,$12,$11,$14,$84,$84,$82,0
unk_1A0BC8_2:	; 0B.張遼[張魯戰袍]
	dc.b	$04,$03,$05,$3E,$93,$82,$4F,0
unk_1A0BC8_4	; 4P
	dc.b	$04,$03,$05,$3E,$14,$11,$93,$82,$84,$4F,0
unk_18F744_2:	; 0C.甘寧[魚鱗寶衣]
	dc.b	$14,$13,$12,$84,$82,$4B,0
unk_18F744_4	; 4P
	dc.b	$14,$13,$12,$04,$84,$82,$82,$4B,0
unk_1A84AA_2:	; 0D.周泰[蚩尤戰甲]
	dc.b	$03,$05,$14,$3C,$83,$81,$46,0
unk_1A84AA_4	; 4P
	dc.b	$03,$05,$14,$3C,$05,$83,$81,$87,$46,0
unk_1B8DB2_2:	; 0E.黃蓋[秦皇寶甲]
	dc.b	$04,$03,$05,$03,$87,$82,$47,0
unk_1B8DB2_4	; 4P
	dc.b	$04,$03,$05,$03,$04,$05,$03,$87,$82,$81,$47,0
unk_1B92F8_2:	; 0F.呂蒙[於吉仙衣]
	dc.b	$14,$03,$05,$11,$04,$04,$82,$84,$4C,0
unk_1B92F8_4	; 4P
	dc.b	$14,$03,$05,$11,$11,$04,$04,$82,$84,$82,$4C,0
unk_19A440_2:	; 10.徐晃
	dc.b	$3E,$04,$05,$14,$91,$82,$86,0
unk_19A440_4	; 4P
	dc.b	$3E,$04,$05,$14,$12,$91,$82,$84,$83,$8F,0
unk_1AFEB0_2:	; 11.呂布
	dc.b	$02,$03,$05,$11,$82,0
unk_1AFEB0_4	; 4P
	dc.b	$02,$03,$05,$11,$82,0
unk_1ACCB4_2:	; 12.孟獲
	dc.b	$14,$82,0
unk_1ACCB4_4	; 4P
	dc.b	$14,$13,$14,$82,0
unk_1ACE46_2:	; 13.孟優[蠻王藤甲]
	dc.b	$12,$04,$3C,$8F,$86,$83,$49,0
unk_1ACE46_4	; 4P
	dc.b	$12,$04,$3C,$8F,$86,$83,$49,0
unk_1A9CAA_2:	; 14.沙摩柯
	dc.b	$05,$13,$04,$82,$87,0
unk_1A9CAA_4	; 4P
	dc.b	$05,$13,$04,$13,$82,$87,$84,0
unk_1AB200_2:	; 15.左慈[鶴羽寶衣]
	dc.b	$13,$04,$05,$86,$82,$93,$4A,0
unk_1AB200_4	; 4P
	dc.b	$13,$04,$05,$13,$11,$86,$82,$93,$84,$4A,0,0	; 雙零佔位
; 強制偶數字對齊
	ds.w	0


sub_175D3A:	; 是否至少速殺一敵將
	move.w	(ram_000E+6).l,d0	; 是否速殺敵將[1]
	move.w	(ram_0010+6).l,d1	; 是否速殺敵將[2]
	or.w	d1,d0
	ext.l	d0
	rts


sub_175EB8:
; 敵將[1]速殺計時器
	tst.l	(ram_000E+8).l	; 計時器是否開啟
	beq.s	loc_175EB8
	pea		(2).w			; 暫停速殺計時器
	move.l	(ram_000E+8).l,-(sp)
	jsr		sub_100E62		; 設定速殺計時器
	addq.l	#8,sp
; 敵將[2]速殺計時器
loc_175EB8:
	tst.l	(ram_0010+8).l	; 計時器是否開啟
	beq.s	locret_175EB8
	pea		(2).w			; 暫停速殺計時器
	move.l	(ram_0010+8).l,-(sp)
	jsr		sub_100E62		; 設定速殺計時器
	addq.l	#8,sp
locret_175EB8:
	rts


sub_100E62:	; 暫停或繼續計時
	movem.l	d2/a2,-(sp)
	move.l	$C(sp),d2
	tst.l	d2
	ble.s	loc_100E74
	moveq	#$16,d0
	cmp.l	d2,d0
	bge.s	loc_100E8E
loc_100E74:
	pea		($5B).w
	pea		($2F1D2C).l		; "c\timer.c"
	pea		($2F1D12).l		; "ht > 0 && ht <= MAXTIMER"
	jsr		$13A50C
	lea		$C(sp),sp
loc_100E8E:
	move.l	d2,d0
	lsl.l	#4,d0
	movea.l	#$803DD0,a0
	adda.l	d0,a0
	movea.l	a0,a2
	move.b	$13(sp),8(a2)	; 是否暫停計時器
	movem.l	(sp)+,d2/a2
	rts

sub_175F2A:
	pea		$3.w		; "手下敗將，哪裏逃？"
	jsr		sub_175F26	; 敵將對話信息編號
	move.l	d0,-(sp)
	jsr		$1343D6		; 對話框
	addq.l	#8,sp
	rts

sub_175F26:
	movem.l	A2, -(A7)	
	moveq	#0,d0
	move.b	(ram_000E+0).l,d0	; 敵將一編號
	tst.b	(ram_000E+1).l		; 敵將一在場否
	bne.s	loc_175F26
	move.b	(ram_0010+0).l,d0	; 替換為敵將二	
loc_175F26:
	lsl.l	#3,d0
	move.l	#seg_175D2E,a2		; 敵將信息表
	adda.l	d0,a2				; 敵將信息
	move.w	4(a2),d0
	movem.l	(A7)+, A2
	rts


sub_175F38:
	pea		($2BEC9E).l
	pea		(4).w		; 曲目
	pea		($2C355E).l	; 博望坡音樂組
	jsr		$12BC40
	pea		($7F).w		; 音量
	pea		(2).w		; 編號02
	jsr		$12BDA0
	lea		$14(sp),sp
	rts
	
sub_175FB8:
	movem.l	a2,-(sp)
	clr.b	(ram_0027).l		; 敵將生命保險關
	bsr.s	(sub_175EB9).l		; 繼續速殺計時器
; 恢復原背景音樂
	move.w	(ram_0015).l,d0
	movea.l	#off_2B3CD0,a2		; 音樂表
	mulu.w	#$C,d0				; 每$C一偏移
	adda.l	d0,a2				; 當前音樂值
	pea		($2BEC9E).l
	move.l	($4,a2),-(sp)		; 曲目
	move.l	(a2),-(sp)			; 音樂組
	jsr		$12BC40
	pea		($7F).w				; 音量
	move.l	($8,a2),-(sp)		; 編號
	jsr		$12BDA0
	lea		$14(sp),sp
	movem.l	(sp)+,a2
	rts

sub_175EB9:
; 繼續速殺計時器[1]
	tst.l	(ram_000E+8).l		; 計時器是否開啟
	beq.s	loc_175EB9
	pea		(1).w				; 繼續速殺計時器
	move.l	(ram_000E+8).l,-(sp)
	jsr		sub_100E62			; 設定速殺計時器
	addq.l	#8,sp
; 繼續速殺計時器[2]
loc_175EB9:
	tst.l	(ram_0010+8).l		; 計時器是否開啟
	beq.s	locret_175EB9
	pea		(1).w				; 繼續速殺計時器
	move.l	(ram_0010+8).l,-(sp)
	jsr		sub_100E62			; 設定速殺計時器
	addq.l	#8,sp
locret_175EB9:
	rts


sub_176A96:	; 敵人追擊
	link	a6,#0
	move.l	a2,-(sp)
	jsr		$10B08C		; 第一順位已佔用的敵方OBJ
	bra.s	loc_176AD8
loc_176AA4:
	tst.w	$6C(a2)		; 是否死亡
	beq.s	loc_176ACC
	moveq	#0,d0
	move.b	$B(a6),d0
	move.w	d0,$C8(a2)
; 跑步動作
	pea		($D).w
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$10EBDE		; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EE74		; 強制寫入動作
	lea		$14(sp),sp
loc_176ACC:
; 下一敵人
	move.l	a2,-(sp)
	jsr		$10B0AC		; 下一順位已佔用的敵方OBJ
	addq.l	#4,sp
loc_176AD8:
	movea.l	d0,a2
	move.l	a2,d0
	bne.s	loc_176AA4
	movea.l	(sp)+,a2
	unlk	a6
	rts


sub_183E66:
	movem.l	d2-d5/a2-a3,-(sp)
	jsr		sub_1A7EAC			; 敵將出場
	jsr		$15EC62
	movea.l	d0,a3				; 第一順位角色OBJ
	pea		1.w
	pea		3.w
	jsr		$145110				; 长坂救少主任務[$818370]
	lea		$8(sp),sp
	tst.w	d0
	bne.s	locret_183E66		; 完成[长坂救少主]則跳出
	move.l	(ram_000E+2).l, a2	; 敵將OBJ
	jsr		$10F520				; 封禁敵方行動
	jsr		$1578E4				; 封禁我方行動，關閉道具欄
	pea		$27.w				; "阿斗在俺(我)手中，汝等不可輕舉妄動。"
	jsr		sub_175F26			; 敵將說
	move.l	d0,-(sp)
	jsr		$1343D6				; 對話框
	pea		$28.w
	movea.l	$58(a3),a0
	move.b	1(a0),d0
	andi.l	#$FF,d0
	move.l	d0,-(sp)			; 我方說
	jsr		$1343D6
	pea		3.w
	pea		$28B378.l			; 撞擊敵將3次掉落阿斗
	move.l	a2,-(sp)
	jsr		$12ECE6
	jsr		$10F516				; 解封敌人行动
	jsr		$1578DA				; 解封我方行動
	lea		$1C(A7), A7
locret_183E66:
	movem.l	(sp)+,d2-d5/a2-a3
	rts


sub_18571E:
	movem.l	a2-a4,-(sp)
; 敵將是否全部擊殺
	tst.b	(ram_000E+1).l		; 敵將[1]是否在場
	beq.s	loc_18571E
	movea.l	ram_000E+2.l,a2
	tst.w	$6C(a2)
	bne.s	locret_18571E
loc_18571E:
	tst.b	(ram_0010+1).l		; 敵將[2]是否在場
	beq.s	loc_18571F
	movea.l	ram_0010+2.l,a3
	tst.w	$6C(a3)
	bne.s	locret_18571E
; 劉琦贈物
loc_18571F:
	tst.w	($81A924).l			; 劉琦死活
	bne.s	locret_18571E
	move.w	($D0A000).l,d0
	addi.w	#-$14,d0
	movea.l	$81ABE2.l,a4		; 劉琦OBJ
	move.w	d0,$20(a4)
	movea.l	$81ABE2.l,a4
	move.l	#$1F3598,$2C(a4)	; 贈物動作
	movea.l	$81ABE2.l,a4
	clr.w	$3C(a4)
	movea.l	$81ABE2.l,a4
	clr.w	$54(a4)
	movea.l	$81ABE2.l,a4
	clr.w	$68(a4)
	movea.l	$81ABE2.l,a4
	clr.w	$58(a4)
locret_18571E:
	movem.l	(sp)+,a2-a4
	rts


sub_199D80:
	move.l	a2,-(sp)
; 檢查生命值
	movea.l	$81B9C0.l,a2	; 第一敵方OBJ
	bra.w	loc_199D80
loc_199D81:
	movea.l	$58(a2),a0
	cmpi.b	#1,(a0)			; 是否敵將
	bne.w	loc_199D82
	cmpi.w	#1,$6C(a2)		; 敵將是否殘血
	bhi.w	loc_199D82
; 敵將對話
	jsr		sub_175EB8		; 暫停速殺計時[2]
	clr.l	-(sp)
	jsr		($14B73E).l
	clr.l	-(sp)
	jsr		($10FEAC).l		; 等待敵方[0201]動作 
	jsr		($15E7F4).l		; 等待我方[0201]動作 
	addq.l	#8,sp
	pea		($138).w		; 「不可輕敵，速退！整兵再戰！」
	pea		($15).w			; 左慈說
	jsr		$1343D6			; 對話框
	addq.l	#8,sp
; 背景音樂
	pea		($2BEC9E).l
	pea		(8).w
	pea		($2DBE6E).l
	jsr		$12BC40
	pea		($7F).w
	clr.l	-(sp)
	jsr		$12BDA0
	lea		$14(sp),sp
; 撤退動作
	clr.l	-(sp)			; 向右跑步
	pea		(1).w			; 停止動作
	clr.l	-(sp)			; 穿景無效
	jsr		sub_10F602		; 敵將撤退
	pea		($13A646).l
	pea		(30).w			; 主循環
	jsr		($100EA4).l
	lea		$14(sp),sp
; 任務計時
	jsr		$100D74			; 分配計時器編號
	move.l	d0,(ram_0019).l
	pea		($A8C).w		; 任務時間[45秒]
	move.l	(ram_0019).l,-(sp)
	jsr		$100E1A
	addq.l	#8,sp
; 下一進度
	pea		(1).w
	jsr		($14B73E).l
	addq.l	#4,sp
	move.b	#1,($81A1F8).l	; 我方恢復行動
	move.b	#1,($81B5E0).l	; 敵方恢復行動
	move.b	#1,($81B93C).l	; 敵方開始攻擊
	move.b	#1,($80C2B5).l	; 全局恢復判定
	clr.b	(ram_0027).l	; 敵將生命保險關
	addq.b	#1,($81AF26).l	; 下一進度#5
	bra.s	locret_199D80
; 下一敵將生命值
loc_199D82:
	movea.l	4(a2),a2
loc_199D80:
	move.l	a2,d0
	bne.w	loc_199D81
locret_199D80:
	movea.l	(sp)+,a2
	rts


sub_19A1EC:	; 敵將補充生命值
	movem.l	a2-a3,-(sp)
; 敵將一補充生命值
	movea.l	ram_000E+2.l,a2
	cmpi.w  #$7D0,$20(a2)	; 是否到達最終點
	ble.s	loc_19A1EC
	cmpi.w	#1,$50(a2)		; 是否回血0102
	beq.s	loc_19A1EC
	pea		off_2368DC.l	; 補血動作指針
	move.l	a2,-(sp)
	jsr		$10EF18
	addq.l	#8,sp
; 敵將二補充生命值
loc_19A1EC:
	tst.b	(ram_0010+1).l
	beq.s	locret_19A1EC
	movea.l	ram_0010+2.l,a3
	cmpi.w  #$7D0,$20(a3)	; 是否到達最終點
	ble.s	locret_19A1EC
	cmpi.w	#1,$50(a3)		; 是否回血0102
	beq.s	locret_19A1EC
	pea		off_2368DC.l	; 補血動作指針
	move.l	a3,-(sp)
	jsr		$10EF18
	addq.l	#8,sp
locret_19A1EC:
	movem.l	(sp)+,a2-a3
	rts

off_2368DC:
	dc.w	$0102
	dc.l	unk_236038,$02000800,$0,$0

unk_236038:
	dc.l	$F0130100
	dc.l	$F0070022,sub_16C4F4
	dc.l	$F0020500,$00000000
	dc.l	$F0070022,sub_16C4F4
	dc.l	$F0020500,$00000000
	dc.l	$F0070022,sub_16C4F4
	dc.l	$F0020500,$00000000
	dc.l	$F0070022,sub_16C4F4
	dc.l	$F0020500,$00000000
	dc.l	$F0070022,sub_16C4F4
	dc.l	$F0020500,$00000000
	dc.l	$F0070022,sub_16C4F4
	dc.l	$F0020500,$00000000
	dc.l	$F0070022,sub_16C4F4
	dc.l	$F0020500,$00000000
	dc.l	$F0070022,sub_16C4F4
	dc.l	$F0020500,$00000000
	dc.l	$F0010100
	dc.l	$F0020A00,$00000000
	dc.l	$F0010000
	dc.l	$80000000

sub_16C4F4:
	link	a6,#0
	movem.l	d2/a2,-(sp)
	movea.l	8(a6),a2
; 增加兩生命值
loc_16C4F4:
	move.l	a2,-(sp)
	jsr		sub_1A87EC		; 計算敵將生命值
	addq.l	#4,sp
	cmp.w	$6C(a2),d0		; 停止於補血上限
	bls.s	loc_16C52A
	clr.l	-(sp)
	pea		($FFFF).w		; 每次循環增加1生命值
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10FAC4
	lea		$10(sp),sp
	btst	#0,$6D(a2)		; 偶數則再循環
	beq.s	loc_16C4F4
; 重複當前動作
	move.b	$F(a6),d0
	ext.w	d0
	move.w	d0,$44(a2)		; 恢復到某一動作偏移
	move.w	#1,$C8(a2)		; 面向左方
	move.w	$286(a2),$24(a2)	; 強制恢復高度
loc_16C52A:
	movem.l	(sp)+,d2/a2
	unlk	a6
	rts


sub_19A272:
	movem.l	a2-a3,-(sp)
; 恢復敵將動作
	pea		(1).w				; 向左跑步
	clr.l	-(sp)				; 刷新動作
	clr.l	-(sp)				; 取消穿景
	jsr		sub_10F602			; 敵將前行
	lea		$C(sp),sp
; 刷新敵兵表
loc_19A272:
	clr.l	-(sp)
	pea		seg_12EF1A
	jsr		$12EF1A.l
	addq.l	#8,sp
; 設定計時器
	move.l	(ram_0019).l,-(sp)	; 任務計時器是否清零
	jsr		$100E62
	addq.l	#4,sp
	tst.l	d0
	beq.s	loc_19A273
	move.w	#1,($81837A).l		; 第五章節第一任務[追擊逃兵]
loc_19A273:
	jsr		sub_175FB8			; 繼續速殺計時器|恢復原背景音樂
	move.b	#$63,($81833E).l	; 99秒遊戲時間
	movem.l	(sp)+,a2-a3
	rts


sub_1AFB8E:
	cmpi.b	#$15,(ram_000C).l	; 是否最後一位敵將
	bcc.s	loc_1AFB8F
	jsr		sub_2B3D36			; 隨機敵將
	moveq	#0,d0				; 繼續循環
	bra.s	locret_1AFB8E		; 下一場景
loc_1AFB8F:
	jsr		sub_1450EA			; 任務獎賞|結束周目
locret_1AFB8E:
	rts


sub_1AE982:	; 敵將是否已擊殺
	movem.l	a2-a3,-(sp)
	tst.w	($81B604).l		; 油江敵將是否已擊殺
	bne.s	loc_1AE996
; 是否已擊殺敵將一
	tst.b	(ram_000E+1).l
	beq.s	loc_1AE982
	movea.l	ram_000E+2.l,a2	; 敵將一OBJ
	tst.w	$6C(a2)
	bne.s	loc_1AE99C
; 是否已擊殺敵將二
loc_1AE982:
	tst.b	(ram_0010+1).l
	beq.s	loc_1AE996
	movea.l	ram_0010+2.l,a3	; 敵將二OBJ
	tst.w	$6C(a3)	
	bne.s	loc_1AE99C
loc_1AE996:
	moveq	#1,d0			; 取消左慈洪水
	bra.s	locret_1AE982
loc_1AE99C:
	moveq	#0,d0			; 左慈洪水繼續
locret_1AE982:
	movem.l	(sp)+,a2-a3
	rts


sub_10F602:
	move.l	a2,-(sp)
loc_10F60C:
	movea.l	$81B9C0.l,a2	; 第一敵方
	bra.w	loc_10F66E
loc_10F614:
; 是否寫入撤退
	movea.l	$58(a2),a0
	cmpi.b	#1,(a0)			; 是否敵將
	beq.s	loc_10F61E
	clr.w	$C4(a2)			; 設定敵兵
	move.w	#1,$C2(a2)		; 屏外清除
loc_10F61E:
	cmpi.w	#2,$CA(a2)		; 是否浮空狀態
	beq.s	loc_10F636
	cmpi.w	#2,$50(a2)		; 是否移動動作
	beq.s	loc_10F636
	cmpi.w	#1,$50(a2)		; 是否開始動作
	bne.s	loc_10F66A
; 寫入撤退動作
loc_10F636:
	pea		($D).w
	pea		(2).w
	move.l	a2,-(sp)
	jsr		($10EBDE).l		; 動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		($10EF18).l		; 寫入動作
	lea		$14(sp),sp
	move.w	#1,$174(a2)		; 動作無敵
	move.w	$A(sp),$A2(a2)	; 是否穿景
	move.w	$E(sp),$C6(a2)	; 刷新動作
	move.w	$12(sp),$C8(a2)	; 跑步方向
loc_10F66A:
	movea.l	4(a2),a2		; 下一敵方
loc_10F66E:
	move.l	a2,d0
	bne.w	loc_10F614
locret_10F602:
	movea.l	(sp)+,a2
	rts

sub_1AE94A:	; 敵方撤退
; 暫停計時
	jsr		(sub_175EB8).l	; 暫停速殺計時器
	move.b	#1,(ram_0027).l	; 打開敵將生命保險
	clr.w	(ram_000B).l	; 暫停刷兵
	clr.l	-(sp)
	jsr		($14B73E).l
	clr.l	-(sp)
	jsr		($10FEAC).l		; 等待敵方[0201]動作 
	jsr		($15E7F4).l		; 等待我方[0201]動作 
	addq.l	#8,sp
; 敵方撤退
	clr.l	-(sp)			; 向東撤退
	pea		(1).w			; 停止動作
	pea		(1).w			; 動作穿景
	jsr		(sub_10F602).l	; 敵方撤退
	lea		$C(sp),sp
; 左慈對話
	pea		($139).w		; 「且讓貧道助爾等一臂之力。」
	pea		($15).w			; 左慈說
	jsr		($1343D6).l		; 對話框
	addq.l	#8,sp
; 恢復狀態
	pea		(1).w
	jsr		($14B73E).l
	addq.l	#4,sp
	move.b	#1,($81A1F8).l	; 我方恢復行動
	move.b	#1,($81B5E0).l	; 敵方恢復行動
	move.b	#1,($81B93C).l	; 敵方開始攻擊
	move.b	#1,($80C2B5).l	; 全局恢復判定
	clr.b	(ram_0027).l	; 敵將生命保險關
	addq.b	#1,($81B102).l	; 原代碼
	rts


sub_1AED86:
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	pea		($F).w			; 扣血兩次[#30]
	move.l	a2,-(sp)
	jsr		$15ED1A
	lea		$10(sp),sp
	rts


sub_1AEBD6:
	movem.l	a2-a3,-(sp)
; 敵將坐標[一]
	tst.b	(ram_000E+1).l
	beq.s	loc_1AEBD6
	movea.l	ram_000E+2.l,a2		; 敵將一OBJ
	move.w	($D0A000).l,d0
	addi.w	#$240,d0
	move.w	d0,$20(a2)			; 左慈洪水后出場橫坐標
	move.w	#$D0,$22(a2)		; 左慈洪水后出場縱坐標
	move.w	$286(a2),$24(a2)	; 左慈洪水后出場豎坐標
	clr.w	$1C8(a2)
	clr.w	$A2(a2)				; 取消穿景
	clr.w	$C6(a2)				; 刷新動作
; 敵將坐標[二]
loc_1AEBD6:
	tst.b	(ram_0010+1).l
	beq.s	loc_1AEBD7
	movea.l	ram_0010+2.l,a3		; 敵將二OBJ
	move.w	($D0A000).l,d0
	addi.w	#$240,d0
	move.w	d0,$20(a3)			; 左慈洪水后出場橫坐標
	move.w	#$D0,$22(a3)		; 左慈洪水后出場縱坐標
	move.w	$286(a3),$24(a3)	; 左慈洪水后出場豎坐標
	clr.w	$1C8(a3)
	clr.w	$A2(a3)				; 取消穿景
	clr.w	$C6(a3)				; 刷新動作
; 其他設定
loc_1AEBD7:
	jsr		(sub_175EB9).l		; 繼續速殺計時器
	jsr		sub_12EF80			; 是否刷兵
	movem.l	(sp)+,a2-a3
	rts


sub_1B84EA:
	movem.l	a2-a3,-(sp)
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.s	loc_1B86F2			; 取消機關
	move.l	$81B1FE.l,-(sp)		; 排水管機關計時器
	jsr		$100E62
	addq.l	#4,sp
	tst.l	d0
	bne.s	loc_1B86F2
	jsr		$1B8496				; 排水管排出毒水
	movea.l	d0,a3
	movea.l	ram_000E+2.l,a2
	cmpi.w	#$C8,$6C(a2)		; 敵將生命值是否低於#200
	bls.s	loc_1B86D2
	move.w	#$3C,$EA(a3)
	move.w	#1,$6E(a3)
	pea		$384.w				; 每十五秒
	bra.s	loc_1B86E2
loc_1B86D2:
	move.w	#$14,$EA(a3)
	move.w	#1,$6E(a3)
	pea		$258.w				; 每十秒
loc_1B86E2:
	move.l	$81B1FE.l,-(sp)
	jsr		$100E1A
	addq.l	#8,sp
loc_1B86F2:
	movem.l	(sp)+,a2-a3
	rts


sub_1B44D2:
; 0706長廊傳送門
	clr.l	-(sp)
	pea		(6).w
	pea		($FA).w
	pea		($76C).w
	clr.l	-(sp)
	jsr		$12E93C
	pea		($1E).w
	pea		($1DE68A).l
	clr.l	-(sp)
	jsr		$157748
	lea		$20(sp),sp
	tst.w	($81B196).l
	beq.s	locret_1B44D2
; 0702長廊密道傳送門
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($C8).w
	pea		($76C).w
	pea		(1).w
	jsr		$12E93C
	pea		($1E).w
	pea		($1DE68E).l
	pea		(1).w
	jsr		$157748
	lea		$20(sp),sp
locret_1B44D2:
	rts

; --------------- 地轉星旋 --------------------------------------------------

sub_1AB4B4:
	movem.l	a2-a3,-(sp)
	tst.w	(ram_001A).l
	bne.w	loc_1AB4EA
	jsr     $15EC62				; 第一順位角色OBJ
	tst.l	d0
	beq.s	locret_1AB4B4
	movea.l	d0,a3
	jsr		$14DF94
	movea.l	d0,a2
	clr.l	-(sp)
	clr.l	-(sp)				; Z
	pea		($1F).w
	jsr		$1024B0
	addq.l	#4,sp
	move.w	$22(a3),d1
	ext.l	d1
	sub.l	d0,d1
	subi.l	#$14,d1
	move.l	d1,-(sp)			; Y
	pea		($4F).w
	jsr		$1024B0
	addq.l	#4,sp
	move.w	$20(a3),d1
	ext.l	d1
	add.l	d1,d0
	addi.l	#$30,d0
	move.l	d0,-(sp)			; X
	pea		($2A1D5A).l			; 隨人雷
	move.l	a2,-(sp)
	jsr		$14E076
	clr.l	$78(a2)
	move.w	#1,$6C(a2)			; 僅判定我方
	lea		$18(sp),sp
	pea		$B4.w				; 隨機時間加值
	jsr		$1024B0
	addq.l	#4,sp
	addi.w	#$B4,d0				; [3-6]秒/次
	move.w	d0,(ram_001A).l		; 頻率
loc_1AB4EA:
	subq.w	#1,(ram_001A).l
locret_1AB4B4:
	movem.l	(sp)+,a2-a3
	rts


sub_175BFA:
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.s	loc_175BFA			; 取消機關
	jsr		sub_1AB4B4			; 隨人雷
loc_175BFA:
	jsr		$12EF80				; 原代碼
	rts


sub_17843E:
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.s	locret_17843E		; 取消機關
	jsr		$176DBC				; 佈置遇人箭
locret_17843E:
	rts

sub_17865C:
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.s	locret_17865C		; 取消機關
	jsr		$176E28				; 清除遇人箭
locret_17865C:
	rts


sub_177854:	; 佈置詐降地雷
	move.b	#1,($81C775).l	; 標記佈置地雷
	clr.b	($81C3D5).l		; 重置計數
; 地雷[1]
	jsr		$14DF94
	movea.l	d0,a2
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($C8).w
	pea		($64).w
	pea		(off_2822DC).l	; 計數地雷
	move.l	a2,-(sp)
	jsr		$14E076			; 設定機關
	lea		$18(sp),sp
	moveq	#0,d0
	move.b	d2,d0
	move.w	d0,$50(a2)
	moveq	#0,d0
	move.b	d2,d0
	move.w	d0,$8A(a2)
	clr.l	$78(a2)
	clr.w	$6C(a2)			; 判定敵方
	jsr		$13A646			; 主循環
; 地雷[2]
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a2
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($C8).w
	pea		($12C).w
	pea		(off_2822DC).l	; 計數地雷
	move.l	a2,-(sp)
	jsr		$14E076			; 設定機關
	lea		$18(sp),sp
	moveq	#0,d0
	move.b	d2,d0
	move.w	d0,$50(a2)
	moveq	#0,d0
	move.b	d2,d0
	move.w	d0,$8A(a2)
	clr.l	$78(a2)
	clr.w	$6C(a2)			; 判定敵方
	jsr		$13A646			; 主循環
; 地雷[3]
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a2
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($A0).w
	pea		($C8).w
	pea		(off_2822DC).l	; 計數地雷
	move.l	a2,-(sp)
	jsr		$14E076			; 設定機關
	lea		$18(sp),sp
	moveq	#0,d0
	move.b	d2,d0
	move.w	d0,$50(a2)
	moveq	#0,d0
	move.b	d2,d0
	move.w	d0,$8A(a2)
	clr.l	$78(a2)
	clr.w	$6C(a2)			; 判定敵方
	jsr		$13A646			; 主循環
; 地雷[4]
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a2
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($F0).w
	pea		($C8).w
	pea		(off_2822DC).l	; 計數地雷
	move.l	a2,-(sp)
	jsr		$14E076			; 設定機關
	lea		$18(sp),sp
	moveq	#0,d0
	move.b	d2,d0
	move.w	d0,$50(a2)
	moveq	#0,d0
	move.b	d2,d0
	move.w	d0,$8A(a2)
	clr.l	$78(a2)
	clr.w	$6C(a2)			; 判定敵方
	jsr		$13A646			; 主循環
	rts

off_2822DC:
	dc.l	dword_282204,$001D6302,$001D70EC,$001D70E2
	dc.l	$003675C4,$00738443,$07010438,$00178762	; $1A()=04|地雷屏外不消失
	dc.b	0,0,$64,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0	; $22()=100|地雷傷害值
	dc.l	sub_178782,0,0,0,0,0,0,0,0,0	; 敵將踩一雷計一數
	dc.b	$03,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0

dword_282204:	; 地雷機關動作
	dc.l	$F0410100,$20410000	; F041=01|機關被硬漢判定後仍然有效
	dc.l	$F0070000,$00178740
	dc.l	$00410000,$00410000,$00410000,$00410000,$00410000
	dc.l	$F0010000

sub_178762:	; 地雷未爆狀態
	movea.l	4(sp),a0
	move.l	#dword_282204,$2C(a0)
	clr.w	$3C(a0)
	clr.w	$54(a0)
	clr.w	$68(a0)
	move.w	#$E,$58(a0)
	rts

sub_178782:
	movem.l	a2-a3,-(sp)
	movea.l	$C(sp),a2		; 機關OBJ
	movea.l	$80(a2),a1		; 接觸者OBJ
	move.l	a1,d0			; 是否道具攻擊
	beq.s	loc_1787EC
	move.l	#$2821F0,$2C(a2)	; 地雷爆炸消失
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	moveq	#1,d0			; 完成
	movea.l	$54(a1),a0
	cmpi.b	#1,(a0)			; 是否[01]敵將
	bne.s	loc_1787F4
	addq.b	#1,($81C3D5).l	; 敵將踩一雷計一數
	cmpi.b	#2,($81C3D5).l	; 至少觸發兩個地雷
	bcs.s	loc_1787F4
	move.w	#1,($81835E).l	; 0100博望坡[火燒博望]任務
	bra.s	loc_1787F4
loc_1787EC:	; 保持原樣
	move.w	#$E,$58(a2)
	moveq	#0,d0
loc_1787F4:
	movem.l	(sp)+,a2-a3
	rts


sub_1717BE:	; 初始化
	movea.l	4(sp),a0
	move.w	$E(a0),d0		; 角色位號
	lsl.w	#3,d0
	ext.l	d0
	movea.l	#dword_1717BE,a1
	adda.l	d0,a1			; 寄存基址
	movea.l	(a1)+,a0
	clr.l	(a0)			; 當前角色每次抬手按壓[A]鍵計數
	movea.l	(a1),a0
	clr.l	(a0)			; 當前角色每次抬手按壓[A]鍵計數同步
	rts

sub_1717CC:	; 按壓計數
	movea.l	4(sp),a0
	movea.l	$F8(a0),a1
	btst	#2,$20(a1)
	beq.s	locret_1717E2
	move.w	$E(a0),d0		; 角色位號
	lsl.w	#3,d0
	ext.l	d0
	movea.l	#dword_1717BE,a1
	adda.l	d0,a1			; 寄存基址
	movea.l	(a1),a0
	addq.l	#1,(a0)			; 當前角色每次抬手按壓[A]鍵計數+1
locret_1717E2:
	rts

sub_1717E4:	; 同步計數
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	move.w	$E(a2),d0		; 角色位號
	lsl.w	#3,d0
	ext.l	d0
	movea.l	#dword_1717BE,a1
	adda.l	d0,a1			; 寄存基址
	movea.l	(a1)+,a0		; 當前角色每次抬手按壓[A]鍵計數
	movea.l	(a1),a1
	move.l	(a1),d0			; 當前角色每次抬手按壓[A]鍵計數同步值
	cmp.l	(a0),d0
	bne.s	loc_171800
	move.b	$F(sp),d0
	ext.w	d0
	move.w	d0,$44(a2)
loc_171800:	; 同步
	move.l	(a0),(a1)
	movea.l	(sp)+,a2
	rts

sub_17180C:	; 累計所有角色
	movea.l	4(sp),a0
	move.w	$E(a0),d0		; 角色位號
	lsl.w	#3,d0
	ext.l	d0
	movea.l	#dword_1717BE,a1
	adda.l	d0,a1			; 寄存基址
	movea.l	4(a1),a0
	move.l	(a0),d0			; 當前角色每次抬手按壓[A]鍵計數同步
	add.l	d0,($81B918).l	; 所有角色按壓[A]鍵次數累計
	addq.l	#1,($81C770).l	; 所有角色抬手次數
	rts

dword_1717BE:	; [1234P]每次抬手按壓[A]鍵計數與同步
	dc.l	$81A960,$81A964	; 1P
	dc.l	$81A96E,$81A972	; 2P
	dc.l	$81A97E,$81A982	; 3P
	dc.l	$81A98C,$81A990	; 4P


dword_250AD4:	; 關羽放火動作
	dc.l	$F0070000,sub_1717BE
	dc.l	$F0020400,$006B0000
	dc.l	$F0020200,$006C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006F0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006F0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006F0000
	dc.l	$F0070035,sub_1717E4
	dc.l	$F0010400
	dc.l	$F0070000,sub_17180C
	dc.l	$F0020100,$00700000
	dc.l	$F00E0500
	dc.l	$00010000,$00020000,$00030000,$00040000
	dc.l	$00050000,$00060000,$00070000,$00080000
	dc.l	$00090000,$000A0000,$000B0000,$000C0000
	dc.l	$F0013A00
	dc.l	$80000000


dword_255EAA:	; 張飛、黃忠放火動作
	dc.l	$F0070000,sub_1717BE
	dc.l	$F0020400,$005F0000
	dc.l	$F0020200,$00600000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00600000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00600000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00610000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00610000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00610000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00620000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00620000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00620000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00620000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00620000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00620000
	dc.l	$F0070035,sub_1717E4
	dc.l	$F0010400
	dc.l	$F0070000,sub_17180C
	dc.l	$F0020100,$00630000
	dc.l	$F00E0500
	dc.l	$00010000,$00020000,$00030000,$00040000
	dc.l	$00050000,$00060000,$00070000,$00080000
	dc.l	$00090000,$000A0000,$000B0000,$000C0000
	dc.l	$F0013A00
	dc.l	$80000000


dword_25B3C6:	; 趙雲放火動作
	dc.l	$F0070000,sub_1717BE
	dc.l	$F0020400,$006B0000
	dc.l	$F0020200,$006C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006E0000
	dc.l	$F0070035,sub_1717E4
	dc.l	$F0010400
	dc.l	$F0070000,sub_17180C
	dc.l	$F0020100,$006F0000
	dc.l	$F00E0700
	dc.l	$00020000,$00030000,$00040000,$00050000
	dc.l	$00060000,$00070000,$00080000,$00090000
	dc.l	$000A0000,$000B0000,$000C0000,$000D0000
	dc.l	$F0013A00
	dc.l	$80000000


dword_26686C:	; 馬超放火動作
	dc.l	$F0070000,sub_1717BE
	dc.l	$F0020400,$005B0000
	dc.l	$F0020200,$005C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005D0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005E0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005E0000
	dc.l	$F0070035,sub_1717E4
	dc.l	$F0010400
	dc.l	$F0070000,sub_17180C
	dc.l	$F0020100,$005F0000
	dc.l	$F00E0700
	dc.l	$00010000,$00020000,$00030000,$00040000
	dc.l	$00050000,$00060000,$00070000,$00080000
	dc.l	$00090000,$000A0000,$000B0000,$000C0000
	dc.l	$000D0000,$000E0000
	dc.l	$F0013A00
	dc.l	$80000000


dword_26BC6C:	; 孔明放火動作
	dc.l	$F0070000,sub_1717BE
	dc.l	$F0020400,$005F0000
	dc.l	$F0020200,$00600000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00600000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00600000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00610000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00610000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00610000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005C0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$005C0000
	dc.l	$F0070035,sub_1717E4
	dc.l	$F0010400
	dc.l	$F0070000,sub_17180C
	dc.l	$F0020100,$005F0000
	dc.l	$F00E0500
	dc.l	$00010000,$00020000,$00030000,$00040000
	dc.l	$00050000,$00060000,$00070000,$00080000
	dc.l	$00090000,$000A0000,$000B0000,$000C0000
	dc.l	$F0013A00
	dc.l	$80000000


dword_270DA4:	; 貂蟬放火動作
	dc.l	$F0070000,sub_1717BE
	dc.l	$F0020400,$00680000
	dc.l	$F0020200,$00690000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00690000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00690000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006A0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006A0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006A0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006B0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006B0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$006B0000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070035,sub_1717E4
	dc.l	$F0010400
	dc.l	$F0070000,sub_17180C
	dc.l	$F0020100,$006B0000
	dc.l	$F00E0500
	dc.l	$00090000,$000A0000,$000B0000,$000C0000
	dc.l	$000D0000,$000E0000,$000F0000,$00100000
	dc.l	$F0013A00
	dc.l	$80000000


dword_2762CC:	; 龐統放火動作
	dc.l	$F0070000,sub_1717BE
	dc.l	$F0020400,$00650000
	dc.l	$F0020200,$00660000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00660000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00660000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00670000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00670000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00670000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00680000
	dc.l	$F0070035,sub_1717E4
	dc.l	$F0010400
	dc.l	$F0070000,sub_17180C
	dc.l	$F0020100,$00690000
	dc.l	$F00E0700
	dc.l	$00000000,$00010000,$00020000,$00030000
	dc.l	$00040000,$00050000,$00060000,$00070000
	dc.l	$00080000,$00090000,$000A0000,$000B0000
	dc.l	$F0013A00
	dc.l	$80000000


dword_27BF74:	; 孫權放火動作
	dc.l	$F0070000,sub_1717BE
	dc.l	$F0020400,$00550000
	dc.l	$F0020200,$00560000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00560000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00560000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00570000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00570000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00570000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00580000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00580000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00580000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00580000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00580000
	dc.l	$F0070000,sub_1717CC
	dc.l	$F0020200,$00580000
	dc.l	$F0070035,sub_1717E4
	dc.l	$F0010400
	dc.l	$F0070000,sub_17180C
	dc.l	$F0020100,$00590000
	dc.l	$F00E0700
	dc.l	$00000000,$00010000,$00020000,$00030000
	dc.l	$00040000,$00050000,$00060000,$00070000
	dc.l	$00080000,$00090000,$000A0000,$000B0000
	dc.l	$F0013A00
	dc.l	$80000000


sub_17F956:
	move.l	a2,-(sp)
	clr.w	($D00002).l		; 原代碼
	movea.l	#ram_0022,a2	; 重置進入武器庫的角色標記表
	moveq	#9,d0			; 10個字節
loc_17F956:
	clr.b	(a2)+
	dbf		d0,loc_17F956
	movea.l	(sp)+,a2
	rts

sub_17F7DA:	; 判斷是否進入0206武器庫密室
	move.l	a2,-(sp)
	movea.l	$58(a2),a0
	move.b	1(a0),d1		; 角色編號
	andi.l	#$FF,d1
	movea.l	#ram_0022,a2	; 已進入武器庫的角色標記表寄存
	move.b	(a2,d1.l),d0	; [00]允許進入[01]無法進入
	move.b	#1,(a2,d1.l)	; 標記已進入
	movea.l	(sp)+,a2
	rts
	
sub_17FB7E:
	movem.l	d2/a2,-(sp)
; 計算角色編號
	movea.l	$81AB94.l,a2	; 進入武器庫的角色OBJ
	movea.l	$58(a2),a0
	move.b	1(a0),d0		; 角色編號
	andi.l	#$FF,d0
; 計算對應武器二
	movea.l	#seg_17FB7E,a2	; 二級武器表
	move.b	(a2,d0.l),d2
	andi.l	#$FF,d2
; 計算同角色數目
	move.l	d0,-(sp)
	jsr		sub_15EC88		; 判斷同角色數目
	addq.l	#4,sp
; 存放武器到角色道具格
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	move.l	($81AB94).l,-(sp)
	jsr		$1293C6.l
	lea		$C(sp),sp
	movem.l	(sp)+,d2/a2
	rts

seg_17FB7E:	; 各角色對應的二級武器
	dc.b	$17,$1A,$1C,$1F,$22,$25,$28,0,$2B,$2E


sub_17C21C:
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.s	loc_17C22A
	moveq	#1,d0
	bra.s	locret_17C22C
loc_17C22A:
	moveq	#0,d0				; 取消機關
locret_17C22C:
	rts


sub_1B6E5A:
	movem.l	d2/a2,-(sp)
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.s	locret_1B6E5A		; 取消機關
	move.l	$81B1D8.l,-(sp)
	jsr		$100E62
	addq.l	#4,sp
	tst.l	d0
	bne.s	locret_1B6E5A
	moveq	#2-1,d2				; 雙鷹
loc_1B6E5A:
	jsr		$14df94.l			; 老鷹機關
	movea.l	D0, A2
	pea		$1.w
	jsr		$1024b0.l
	addq.l	#4, A7
	move.l	D0, -(A7)
	clr.l	-(A7)
	clr.l	-(A7)
	clr.l	-(A7)
	pea		$2a923a.l			; 機關老鷹
	move.l	A2, -(A7)
	jsr		$14e076.l
	clr.l	($78,A2)
	move.w	#$2, ($6c,A2)
	lea		($18,A7), A7
	dbra	d2,loc_1B6E5A
	pea		$12C.w				; 隨機時間加值
	jsr		$102480
	addi.w	#$1A4,d0
	move.l	d0,-(sp)			; [7-12]秒/次
	move.l	$81B1D8.l,-(sp)
	jsr		$100E1A
	lea		$C(sp),sp
locret_1B6E5A:
	movem.l	(sp)+,d2/a2
	rts


sub_17E3E8:
	jsr		($1B6E30).l		; 佈置老鷹機關
	clr.b	($81AB56).l		; 原代碼
	rts


sub_17E64E:
	jsr		(sub_1B6E5A).l	; 觸發老鷹機關
	jsr		($12EF80).l		; 原代碼
	rts


sub_17E2B8:
	move.w	#1,($81836C).l	; 第二章節第三任務[屋頂密室]
	addq.b	#1,($81AB56).l	; 原代碼
	rts


sub_2827A8:
	pea		(2).w			; 第三任務
	pea		(2).w			; 第二章節
	jsr		$145110			; [屋頂密室]是否完成
	move.l	$C(a7),-(sp)	; 進屋角色OBJ
	tst.l	d0
	beq.s	loc_2827A8
	jsr		$180AF0
	bra.s	locret_2827A8
loc_2827A8:
	jsr		$17F982			; 正面走進屋頂密室
locret_2827A8:
	lea		$C(sp),sp
	rts


sub_17CF6C:	; 0202白河水壩水沖敵將
; 寫入動作
	movea.l	#seg_17CF6C,a1	; 水沖動作表
	moveq	#0,d0
	move.b	1(a0),d0		; 敵將編號
	subi.l	#9,d0			; 從孫權開始
	lsl.l	#2,d0			; 一長字偏移
	move.l	(a1,d0.l),-(sp)	; 對應動作
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	addq.l	#8,sp
; 任務檢查
	cmpi.w	#$15E,$6C(a2)	; 敵將生命值是否低於#350
	bhi.s	locret_17CF6C
	move.w	#1,($81836A).l	; 第二章節第二任務[水淹白河]
locret_17CF6C:
	rts

seg_17CF6C:
	dc.l	off_24D75A,0,off_1FDEEE,off_238A5E	; 09-0C
	dc.l	off_205B3E,0,off_2095F8,0	; 0D-10
	dc.l	off_20C098,off_212C84,off_2169B6,off_21ABDE	; 11-14
	dc.l	off_255AA6,off_223044,0,off_226E58	; 15-18
	dc.l	off_22C93A,off_22F248,off_234F2C,off_2368CA	; 19-1C
	dc.l	off_23B77E,off_23F66C,$2453E8,off_2464DC,$0024B958	; 1D-21

off_2095F8:	; 曹仁水沖動作
	dc.w	$0101
	dc.l	dword_20904A,$02001800,0,0
dword_20904A:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BEF00,$01340000	; 慘叫
	dc.l	$F0020600,$002B0000
	dc.l	$F0020300,$002CF9FA
	dc.l	$F0020300,$002CF9FB
	dc.l	$F0020300,$002CF9FC
	dc.l	$F0020300,$002CF9FD
	dc.l	$F0020300,$002CF9FE
	dc.l	$F0020300,$002CF9FF
	dc.l	$F0020300,$002CF901
	dc.l	$F0020300,$002CF902
	dc.l	$F0020300,$002CF903
	dc.l	$F0020300,$002DF904
	dc.l	$F0020300,$002DF905
	dc.l	$F0020300,$002DF906
	dc.l	$F0030000,$202EF90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$002EFC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$002E0000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F0020300,$002E0000
	dc.l	$F00E0300	; 起身動作
	dc.l	$F0020C00,$00350000
	dc.l	$F0020200,$002F0000
	dc.l	$F0020200,$00300000,$00311900,$00310000
	dc.l	$F0020200,$00320000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F0280400
	dc.l	$F0020800,$00240000
	dc.l	$F0020800,$00250000
	dc.l	$F0020800,$00260000
	dc.l	$F0020800,$00250000
	dc.l	$F0290000
	dc.l	$F0020800,$00240000
	dc.l	$80000000
sub_168D4E:	; 0202白河水壩水沖後動作
	move.l	a2,-(sp)
	movea.l	8(sp),a2
; 設定坐標
	move.w	($D0A000).l,d0
	addi.w	#$64,d0
	move.w	d0,$20(a2)	; X
	move.w	$286(a2),$24(a2)	; Z
	tst.w	$6C(a2)
	bne.s	loc_168D88
; 延時死亡
	pea     $13A646.l
	pea     ($F0).w		; 4秒主循環
	jsr     $100EA4.l
	addq.l	#8,sp
	pea		(2).w		; 0805死亡
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$10EBDE		; 動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18		; 寫入動作
	addq.l	#8,sp
loc_168D88:
	jsr		$139340
	tst.l	d0
	beq.s	loc_168D9E
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$139400
	addq.l	#8,sp
loc_168D9E:
	movea.l	(sp)+,a2
	rts

off_212C84:	; 夏侯惇水沖動作
	dc.w	$0101
	dc.l	dword_212126,$02001800,0,0
dword_212126:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$01410000	; 慘叫
	dc.l	$F0020600,$00210000
	dc.l	$F0020300,$0022F9FA
	dc.l	$F0020300,$0022F9FB
	dc.l	$F0020300,$0022F9FC
	dc.l	$F0020300,$0022F9FD
	dc.l	$F0020300,$0022F9FE
	dc.l	$F0020300,$0022F9FF
	dc.l	$F0020300,$0022F901
	dc.l	$F0020300,$0022F902
	dc.l	$F0020300,$0022F903
	dc.l	$F0020300,$0023F904
	dc.l	$F0020300,$0023F905
	dc.l	$F0020300,$0023F906
	dc.l	$F0030000,$2024F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0024FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00240000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0400	; 起身動作0805
	dc.l	$F0020A00,$002A0000
	dc.l	$F0020200,$00250000
	dc.l	$F0020200,$00260000
	dc.l	$F0020300,$00270000
	dc.l	$F0020200,$00280000
	dc.l	$F0020100,$00290000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$01400000
	dc.l	$F0280400
	dc.l	$F0020800,$001A0000
	dc.l	$F0020800,$001B0000
	dc.l	$F0020800,$001C0000
	dc.l	$F0020800,$001B0000
	dc.l	$F0290000
	dc.l	$F0020800,$001A0000
	dc.l	$80000000

off_255AA6:	; 張郃水沖動作
	dc.w	$0101
	dc.l	dword_256F00,$02001800,0,0
dword_256F00:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$01570000	; 慘叫
	dc.l	$F0020600,$003A0000
	dc.l	$F0020300,$003BF9FA
	dc.l	$F0020300,$003BF9FB
	dc.l	$F0020300,$003BF9FC
	dc.l	$F0020300,$003BF9FD
	dc.l	$F0020300,$003BF9FE
	dc.l	$F0020300,$003BF9FF
	dc.l	$F0020300,$003BF901
	dc.l	$F0020300,$003BF902
	dc.l	$F0020300,$003BF903
	dc.l	$F0020300,$003CF904
	dc.l	$F0020300,$003CF905
	dc.l	$F0020300,$003CF906
	dc.l	$F0030000,$203DF90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$003DFC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$003D0000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0400	; 起身動作0805
	dc.l	$F0020C00,$00430000
	dc.l	$F0020200,$003E0000
	dc.l	$F0020200,$003F0000
	dc.l	$F0020200,$00400000,$00411900,$00410000
	dc.l	$F0020200,$00420000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$01560000
	dc.l	$F0280400
	dc.l	$F0020800,$00330000
	dc.l	$F0020800,$00340000
	dc.l	$F0020800,$00350000
	dc.l	$F0020800,$00340000
	dc.l	$F0290000
	dc.l	$F0020800,$00330000
	dc.l	$80000000

off_2169B6:	; 牛金水沖動作
	dc.w	$0101
	dc.l	dword_2166A4,$02001800,0,0
dword_2166A4:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BFF00,$01490000	; 慘叫
	dc.l	$F0020600,$002E0000
	dc.l	$F0020310,$002FF9FA
	dc.l	$F0020310,$002FF9FB
	dc.l	$F0020310,$002FF9FC
	dc.l	$F0020310,$002FF9FD
	dc.l	$F0020310,$002FF9FE
	dc.l	$F0020310,$002FF9FF
	dc.l	$F0020310,$002FF901
	dc.l	$F0020310,$002FF902
	dc.l	$F0020310,$002FF903
	dc.l	$F0020310,$0030F904
	dc.l	$F0020310,$0030F905
	dc.l	$F0020310,$0030F906
	dc.l	$F0031000,$2031F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0031FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00310000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0600	; 起身動作0805
	dc.l	$F0020500,$00310000
	dc.l	$F0020200,$00320000
	dc.l	$F0020200,$00330000
	dc.l	$F0020310,$00340000
	dc.l	$F0020200,$00350000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BFF00,$01460000
	dc.l	$F0280400
	dc.l	$F0020800,$00270000
	dc.l	$F0020800,$00280000
	dc.l	$F0020800,$00290000
	dc.l	$F0020800,$00280000
	dc.l	$F0290000
	dc.l	$F0020800,$00270000
	dc.l	$80000000

off_226E58:	; 甘寧水沖動作
	dc.w	$0101
	dc.l	dword_226E5A,$02001800,0,0
dword_226E5A:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$016B0000	; 慘叫
	dc.l	$F0020600,$00310000
	dc.l	$F0020310,$0032F9FA
	dc.l	$F0020310,$0032F9FB
	dc.l	$F0020310,$0032F9FC
	dc.l	$F0020310,$0032F9FD
	dc.l	$F0020310,$0032F9FE
	dc.l	$F0020310,$0032F9FF
	dc.l	$F0020310,$0032F901
	dc.l	$F0020310,$0032F902
	dc.l	$F0020310,$0032F903
	dc.l	$F0020310,$0033F904
	dc.l	$F0020310,$0033F905
	dc.l	$F0020310,$0033F906
	dc.l	$F0031000,$2034F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0034FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00340000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0500	; 起身動作0805
	dc.l	$F0020600,$00340000
	dc.l	$F0020200,$00350000
	dc.l	$F0020200,$00360000
	dc.l	$F0020300,$00370000
	dc.l	$F0020200,$00380000
	dc.l	$F0020100,$00390000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$01670000
	dc.l	$F0280400
	dc.l	$F0020800,$003A0000
	dc.l	$F0020800,$003B0000
	dc.l	$F0020800,$003C0000
	dc.l	$F0020800,$003B0000
	dc.l	$F0290000
	dc.l	$F0020800,$003A0000
	dc.l	$80000000

off_2368CA:	; 徐晃水沖動作
	dc.w	$0101
	dc.l	dword_235F8C,$02001800,0,0
dword_235F8C:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$018E0000	; 慘叫
	dc.l	$F0020600,$00360000
	dc.l	$F0020310,$0037F9FA
	dc.l	$F0020310,$0037F9FB
	dc.l	$F0020310,$0037F9FC
	dc.l	$F0020310,$0037F9FD
	dc.l	$F0020310,$0037F9FE
	dc.l	$F0020310,$0037F9FF
	dc.l	$F0020310,$0037F901
	dc.l	$F0020310,$0037F902
	dc.l	$F0020310,$0037F903
	dc.l	$F0020310,$0038F904
	dc.l	$F0020310,$0038F905
	dc.l	$F0020310,$0038F906
	dc.l	$F0031000,$2039F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0039FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00390000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020A00,$00390000
	dc.l	$F0020400,$003A0000
	dc.l	$F0020200,$003B0000
	dc.l	$F0020300,$003C0000
	dc.l	$F0020300,$003D0000
	dc.l	$F0020200,$003E0000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$018A0000
	dc.l	$F0280400
	dc.l	$F0020800,$00330000
	dc.l	$F0020800,$00340000
	dc.l	$F0020800,$00350000
	dc.l	$F0020800,$00340000
	dc.l	$F0290000
	dc.l	$F0020800,$00330000
	dc.l	$80000000

off_223044:	; 張遼水沖動作
	dc.w	$0101
	dc.l	dword_222CF2,$02001800,0,0
dword_222CF2:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BEF00,$01620000	; 慘叫
	dc.l	$F0020600,$00270000
	dc.l	$F0020310,$0028F9FA
	dc.l	$F0020310,$0028F9FB
	dc.l	$F0020310,$0028F9FC
	dc.l	$F0020310,$0028F9FD
	dc.l	$F0020310,$0028F9FE
	dc.l	$F0020310,$0028F9FF
	dc.l	$F0020310,$0028F901
	dc.l	$F0020310,$0028F902
	dc.l	$F0020310,$0028F903
	dc.l	$F0020310,$0029F904
	dc.l	$F0020310,$0029F905
	dc.l	$F0020310,$0029F906
	dc.l	$F0031000,$202AF90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$002AFC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$002A0000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020600,$00300000
	dc.l	$F0020200,$002B0000
	dc.l	$F0020200,$002C0000
	dc.l	$F0020300,$002D0000
	dc.l	$F0020200,$002E0000
	dc.l	$F0020200,$002F0000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F0280400
	dc.l	$F0020800,$00200000
	dc.l	$F0020800,$00210000
	dc.l	$F0020800,$00220000
	dc.l	$F0020800,$00210000
	dc.l	$F0290000
	dc.l	$F0020800,$00200000
	dc.l	$80000000

off_20C098:	; 夏侯淵水沖動作
	dc.w	$0101
	dc.l	dword_20BB82,$02001800,0,0
dword_20BB82:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BEF00,$013B0000	; 慘叫
	dc.l	$F0020600,$00320000
	dc.l	$F0020310,$0033F9FA
	dc.l	$F0020310,$0033F9FB
	dc.l	$F0020310,$0033F9FC
	dc.l	$F0020310,$0033F9FD
	dc.l	$F0020310,$0033F9FE
	dc.l	$F0020310,$0033F9FF
	dc.l	$F0020310,$0033F901
	dc.l	$F0020310,$0033F902
	dc.l	$F0020310,$0033F903
	dc.l	$F0020310,$0034F904
	dc.l	$F0020310,$0034F905
	dc.l	$F0020310,$0034F906
	dc.l	$F0031000,$2035F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0035FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00350000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020400,$003B0000
	dc.l	$F0020200,$00360000
	dc.l	$F0020200,$00370000
	dc.l	$F0020300,$00380000
	dc.l	$F0020200,$00390000,$003A0200,$003A0000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F0280500
	dc.l	$F0020800,$002B0000
	dc.l	$F0020800,$002C0000
	dc.l	$F0020800,$002D0000
	dc.l	$F0020800,$002C0000
	dc.l	$F0290000
	dc.l	$F0020800,$002B0000
	dc.l	$80000000

off_238A5E:	; 司馬懿水沖動作
	dc.w	$0101
	dc.l	dword_238868,$02001800,0,0
dword_238868:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$011C0000	; 慘叫
	dc.l	$F0020600,$00240000
	dc.l	$F0020310,$0025F9FA
	dc.l	$F0020310,$0025F9FB
	dc.l	$F0020310,$0025F9FC
	dc.l	$F0020310,$0025F9FD
	dc.l	$F0020310,$0025F9FE
	dc.l	$F0020310,$0025F9FF
	dc.l	$F0020310,$0025F901
	dc.l	$F0020310,$0025F902
	dc.l	$F0020310,$0025F903
	dc.l	$F0020310,$0026F904
	dc.l	$F0020310,$0026F905
	dc.l	$F0020310,$0026F906
	dc.l	$F0031000,$2027F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0027FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00270000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020C00,$002E0000
	dc.l	$F0020200,$00280000
	dc.l	$F0020200,$00290000
	dc.l	$F0020300,$002A0000
	dc.l	$F0020200,$002B0000
	dc.l	$F0020200,$002C0000,$002D0300,$002D0000
	dc.l	$F00E0200	; 暈眩動作0815
	dc.l	$F0020200,$001A0000
	dc.l	$F0020200,$001B0000
	dc.l	$F0020200,$001C0000
	dc.l	$F0280500
	dc.l	$F0020200,$001D0000
	dc.l	$F0020200,$001E0000
	dc.l	$F0020200,$001F0000
	dc.l	$F0020200,$00200000
	dc.l	$F0290000
	dc.l	$F0020200,$00210000
	dc.l	$80000000

off_205B3E:	; 程昱水沖動作
	dc.w	$0101
	dc.l	dword_20576C,$02001800,0,0
dword_20576C:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BFF00,$012A0000	; 慘叫
	dc.l	$F0020600,$003C0000
	dc.l	$F0020310,$003DF9FA
	dc.l	$F0020310,$003DF9FB
	dc.l	$F0020310,$003DF9FC
	dc.l	$F0020310,$003DF9FD
	dc.l	$F0020310,$003DF9FE
	dc.l	$F0020310,$003DF9FF
	dc.l	$F0020310,$003DF901
	dc.l	$F0020310,$003DF902
	dc.l	$F0020310,$003DF903
	dc.l	$F0020310,$003EF904
	dc.l	$F0020310,$003EF905
	dc.l	$F0020310,$003EF906
	dc.l	$F0031000,$203FF90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$003FFC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$003F0000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020500,$00460000
	dc.l	$F0020200,$00410000
	dc.l	$F0020200,$00420000
	dc.l	$F0020300,$00430000,$00440000,$00440000
	dc.l	$F0020200,$00450000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F0070000,$0016830C
	dc.l	$F0280600,$00330000,$00340000
	dc.l	$F0290000
	dc.l	$F0280600,$00360000,$00370000
	dc.l	$F0290000
	dc.l	$F0280600,$00330000,$00340000
	dc.l	$F0290000
	dc.l	$F0280600,$00360000,$00370000
	dc.l	$F0290000
	dc.l	$F0280600,$00330000,$00340000
	dc.l	$F0290000
	dc.l	$F00BFF00,$01260000
	dc.l	$F0280600,$00360000,$00370000
	dc.l	$F0290000
	dc.l	$F0280600,$00330000,$00340000
	dc.l	$F0290000
	dc.l	$F0280600,$00360000,$00370000
	dc.l	$F0290000
	dc.l	$F0280600,$00330000,$00340000
	dc.l	$F0290000
	dc.l	$F0280600,$00360000,$00370000
	dc.l	$F0290000
	dc.l	$F0280600,$00330000,$00340000
	dc.l	$F0290000
	dc.l	$F0280600,$00360000,$00370000
	dc.l	$F0290000
	dc.l	$80000000

off_1FDEEE:	; 曹操水沖動作
	dc.w	$0101
	dc.l	dword_1FDD3C,$02001800,0,0
dword_1FDD3C:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$010F0000	; 慘叫
	dc.l	$F0020600,$00260000
	dc.l	$F0020310,$0027F9FA
	dc.l	$F0020310,$0027F9FB
	dc.l	$F0020310,$0027F9FC
	dc.l	$F0020310,$0027F9FD
	dc.l	$F0020310,$0027F9FE
	dc.l	$F0020310,$0027F9FF
	dc.l	$F0020310,$0027F901
	dc.l	$F0020310,$0027F902
	dc.l	$F0020310,$0027F903
	dc.l	$F0020310,$0028F904
	dc.l	$F0020310,$0028F905
	dc.l	$F0020310,$0028F906
	dc.l	$F0031000,$2029F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0029FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00290000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020400,$00290000
	dc.l	$F0020200,$002A0000
	dc.l	$F0020200,$002A0000
	dc.l	$F0020300,$002B0000
	dc.l	$F0020200,$002C0000
	dc.l	$F0020200,$002C0000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$010C0000
	dc.l	$F0280500
	dc.l	$F0020800,$001F0000
	dc.l	$F0020800,$00200000
	dc.l	$F0020800,$00210000
	dc.l	$F0020800,$00200000
	dc.l	$F0290000
	dc.l	$F0020800,$001F0000
	dc.l	$80000000

off_22C93A:	; 周泰水沖動作
	dc.w	$0101
	dc.l	dword_22C49C,$02001800,0,0
dword_22C49C:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$01760000	; 慘叫
	dc.l	$F0020600,$002C0000
	dc.l	$F0020310,$002DF9FA
	dc.l	$F0020310,$002DF9FB
	dc.l	$F0020310,$002DF9FC
	dc.l	$F0020310,$002DF9FD
	dc.l	$F0020310,$002DF9FE
	dc.l	$F0020310,$002DF9FF
	dc.l	$F0020310,$002DF901
	dc.l	$F0020310,$002DF902
	dc.l	$F0020310,$002DF903
	dc.l	$F0020310,$002EF904
	dc.l	$F0020310,$002EF905
	dc.l	$F0020310,$002EF906
	dc.l	$F0031000,$202FF90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$002FFC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$002F0000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020600,$002F0000
	dc.l	$F0020200,$00300000
	dc.l	$F0020200,$00300000
	dc.l	$F0020300,$00310000
	dc.l	$F0020200,$00270000
	dc.l	$F0020200,$00320000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$01740000
	dc.l	$F0280400
	dc.l	$F0020800,$00250000
	dc.l	$F0020800,$00260000
	dc.l	$F0020800,$00270000
	dc.l	$F0020800,$00260000
	dc.l	$F0290000
	dc.l	$F0020800,$00250000
	dc.l	$80000000

off_234F2C:	; 呂蒙水沖動作
	dc.w	$0101
	dc.l	dword_234972,$02001800,0,0
dword_234972:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$01840000	; 慘叫
	dc.l	$F0020600,$002F0000
	dc.l	$F0020310,$0030F9FA
	dc.l	$F0020310,$0030F9FB
	dc.l	$F0020310,$0030F9FC
	dc.l	$F0020310,$0030F9FD
	dc.l	$F0020310,$0030F9FE
	dc.l	$F0020310,$0030F9FF
	dc.l	$F0020310,$0030F901
	dc.l	$F0020310,$0030F902
	dc.l	$F0020310,$0030F903
	dc.l	$F0020310,$0031F904
	dc.l	$F0020310,$0031F905
	dc.l	$F0020310,$0031F906
	dc.l	$F0031000,$2032F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0032FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00320000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020200,$00390000
	dc.l	$F0020200,$00340000
	dc.l	$F0020200,$00350000
	dc.l	$F0020300,$00360000,$00373400,$00370000
	dc.l	$F0020200,$00380000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$01820000
	dc.l	$F0280500
	dc.l	$F0020800,$00290000
	dc.l	$F0020800,$002A0000
	dc.l	$F0020800,$002B0000
	dc.l	$F0020800,$002A0000
	dc.l	$F0290000
	dc.l	$F0020800,$00290000
	dc.l	$80000000

off_23B77E:	; 呂布水沖動作
	dc.w	$0101
	dc.l	dword_23B63C,$02001800,0,0
dword_23B63C:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$01990000	; 慘叫
	dc.l	$F0020600,$002A0000
	dc.l	$F0020310,$002BF9FA
	dc.l	$F0020310,$002BF9FB
	dc.l	$F0020310,$002BF9FC
	dc.l	$F0020310,$002BF9FD
	dc.l	$F0020310,$002BF9FE
	dc.l	$F0020310,$002BF9FF
	dc.l	$F0020310,$002BF901
	dc.l	$F0020310,$002BF902
	dc.l	$F0020310,$002BF903
	dc.l	$F0020310,$002CF904
	dc.l	$F0020310,$002CF905
	dc.l	$F0020310,$002CF906
	dc.l	$F0031000,$202DF90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$002DFC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$002D0000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020200,$00330000
	dc.l	$F0020200,$002E0000
	dc.l	$F0020200,$002F0000
	dc.l	$F0020300,$00300000
	dc.l	$F0020200,$00310000,$00321500,$00320000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$01970000
	dc.l	$F0280500
	dc.l	$F0020800,$00230000
	dc.l	$F0020800,$00240000
	dc.l	$F0020800,$00250000
	dc.l	$F0020800,$00240000
	dc.l	$F0290000
	dc.l	$F0020800,$00230000
	dc.l	$80000000

off_2464DC:	; 沙摩柯水沖動作
	dc.w	$0101
	dc.l	dword_24626E,$02001800,0,0
dword_24626E:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BEF00,$01A70000	; 慘叫
	dc.l	$F0020600,$001B0000
	dc.l	$F0020310,$001CF9FA
	dc.l	$F0020310,$001CF9FB
	dc.l	$F0020310,$001CF9FC
	dc.l	$F0020310,$001CF9FD
	dc.l	$F0020310,$001CF9FE
	dc.l	$F0020310,$001CF9FF
	dc.l	$F0020310,$001CF901
	dc.l	$F0020310,$001CF902
	dc.l	$F0020310,$001CF903
	dc.l	$F0020310,$001DF904
	dc.l	$F0020310,$001DF905
	dc.l	$F0020310,$001DF906
	dc.l	$F0031000,$201EF90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$001EFC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$001E0000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020C00,$00240000
	dc.l	$F0020200,$001F0000
	dc.l	$F0020200,$00200000
	dc.l	$F0020300,$00210000
	dc.l	$F0020200,$00220000,$00231A00,$00230000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F0020800,$00130000
	dc.l	$F0280300
	dc.l	$F0020800,$00140000
	dc.l	$F0020800,$00150000
	dc.l	$F0020800,$00160000
	dc.l	$F0020800,$00150000
	dc.l	$F0020800,$00140000
	dc.l	$F0290000
	dc.l	$F0020800,$00130000
	dc.l	$80000000

off_23F66C:	; 孟獲水沖動作
	dc.w	$0101
	dc.l	dword_23F23A,$02001800,0,0
dword_23F23A:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$01A10000	; 慘叫
	dc.l	$F0020600,$00390000
	dc.l	$F0020310,$003AF9FA
	dc.l	$F0020310,$003AF9FB
	dc.l	$F0020310,$003AF9FC
	dc.l	$F0020310,$003AF9FD
	dc.l	$F0020310,$003AF9FE
	dc.l	$F0020310,$003AF9FF
	dc.l	$F0020310,$003AF901
	dc.l	$F0020310,$003AF902
	dc.l	$F0020310,$003AF903
	dc.l	$F0020310,$003BF904
	dc.l	$F0020310,$003BF905
	dc.l	$F0020310,$003BF906
	dc.l	$F0031000,$203CF90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$003CFC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$003C0000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020800,$00430000
	dc.l	$F0020200,$003D0000
	dc.l	$F0020200,$003E0000
	dc.l	$F0020300,$003F0000
	dc.l	$F0020200,$00400000
	dc.l	$F0020200,$00410000
	dc.l	$F0020200,$00420000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$019FF830
	dc.l	$F0280400
	dc.l	$F0020800,$002E0000
	dc.l	$F0020800,$002F0000
	dc.l	$F0020800,$00300000
	dc.l	$F0020800,$002F0000
	dc.l	$F0290000
	dc.l	$F0020800,$002E0000
	dc.l	$80000000

off_21ABDE:	; 許褚水沖動作
	dc.w	$0101
	dc.l	dword_21A6F0,$02001800,0,0
dword_21A6F0:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$01510000	; 慘叫
	dc.l	$F0020600,$002E0000
	dc.l	$F0020310,$002FF9FA
	dc.l	$F0020310,$002FF9FB
	dc.l	$F0020310,$002FF9FC
	dc.l	$F0020310,$002FF9FD
	dc.l	$F0020310,$002FF9FE
	dc.l	$F0020310,$002FF9FF
	dc.l	$F0020310,$002FF901
	dc.l	$F0020310,$002FF902
	dc.l	$F0020310,$002FF903
	dc.l	$F0020310,$0030F904
	dc.l	$F0020310,$0030F905
	dc.l	$F0020310,$0030F906
	dc.l	$F0031000,$2031F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0031FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00310000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020C00,$00370000
	dc.l	$F0020200,$00320000
	dc.l	$F0020200,$00330000
	dc.l	$F0020300,$00340000
	dc.l	$F0020200,$00350000,$00360500,$00360000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$01500000
	dc.l	$F0280400
	dc.l	$F0020800,$00270000
	dc.l	$F0020800,$00280000
	dc.l	$F0020800,$00290000
	dc.l	$F0020800,$00280000
	dc.l	$F0290000
	dc.l	$F0020800,$00270000
	dc.l	$80000000

off_22F248:	; 黃蓋水沖動作
	dc.w	$0101
	dc.l	dword_22F1A6,$02001800,0,0
dword_22F1A6:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$017E0000	; 慘叫
	dc.l	$F0020600,$004E0000
	dc.l	$F0020310,$004FF9FA
	dc.l	$F0020310,$004FF9FB
	dc.l	$F0020310,$004FF9FC
	dc.l	$F0020310,$004FF9FD
	dc.l	$F0020310,$004FF9FE
	dc.l	$F0020310,$004FF9FF
	dc.l	$F0020310,$004FF901
	dc.l	$F0020310,$004FF902
	dc.l	$F0020310,$004FF903
	dc.l	$F0020310,$0050F904
	dc.l	$F0020310,$0050F905
	dc.l	$F0020310,$0050F906
	dc.l	$F0031000,$2051F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0051FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00510000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0330100
	dc.l	$F0280200
	dc.l	$F0020200
	dc.l	$F03400FF,$00520000,$00000000,$004D0000
	dc.l	$F0020200
	dc.l	$F03400FF,$00530000,$00000000,$004D0000
	dc.l	$F0020200
	dc.l	$F03400FF,$00540000,$00000000,$004D0000
	dc.l	$F0290000
	dc.l	$F00E0100
	dc.l	$F0280200
	dc.l	$F03400FF,$00560000,$00000000,$00550000
	dc.l	$F0290000
	dc.l	$F0280200
	dc.l	$F03400FF,$00580000,$00000000,$00570000
	dc.l	$F0290000
	dc.l	$F0280200
	dc.l	$F03400FF,$005A0000,$00000000,$00590000
	dc.l	$F0290000
	dc.l	$F0280200
	dc.l	$F03400FF,$005C0000,$00000000,$005B0000
	dc.l	$F0290000
	dc.l	$F03400FF,$005E0000,$00210000,$005D2100
	dc.l	$F03400FF,$005E0000,$00000000,$005D0000
	dc.l	$F0330000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$017C0000
	dc.l	$F0330100
	dc.l	$F0020800
	dc.l	$F03400FF,$003B0000,$00000000,$003A0000
	dc.l	$F0280500
	dc.l	$F0020800
	dc.l	$F03400FF,$003F0000,$00000000,$003C0000
	dc.l	$F0020800
	dc.l	$F03400FF,$00400000,$00000000,$003D0000
	dc.l	$F0020800
	dc.l	$F03400FF,$00410000,$00000000,$003E0000
	dc.l	$F0290000
	dc.l	$F0020800
	dc.l	$F03400FF,$003B0000,$00000000,$003A0000
	dc.l	$F0330000
	dc.l	$80000000

off_24D75A:	; 孫權水沖動作
	dc.w	$0101
	dc.l	dword_24D3D0,$02001800,0,0
dword_24D3D0:
	dc.l	$F0310000
	dc.l	$F03C017F
	dc.l	$F00BDF00,$023D0000	; 慘叫
	dc.l	$F0020600,$00630000
	dc.l	$F0020310,$0064F9FA
	dc.l	$F0020310,$0064F9FB
	dc.l	$F0020310,$0064F9FC
	dc.l	$F0020310,$0064F9FD
	dc.l	$F0020310,$0064F9FE
	dc.l	$F0020310,$0064F9FF
	dc.l	$F0020310,$0064F901
	dc.l	$F0020310,$0064F902
	dc.l	$F0020310,$0064F903
	dc.l	$F0020310,$0065F904
	dc.l	$F0020310,$0065F905
	dc.l	$F0020310,$0065F906
	dc.l	$F0031000,$2066F90A
	dc.l	$F00E0000
	dc.l	$F0020D00,$0066FC00
	dc.l	$F00E0A00
	dc.l	$F0020F00,$00660000	; 限時停止
	dc.l	$F0070000,sub_168D4E	; 死亡動作
	dc.l	$F00E0300	; 起身動作0805
	dc.l	$F0020800,$00660000
	dc.l	$F0020200,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F0020200,$006E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0020200,$00700000
	dc.l	$F00E0000	; 暈眩動作0815
	dc.l	$F00BDF00,$023B0000
	dc.l	$F0280600
	dc.l	$F0020800,$00520000
	dc.l	$F0020800,$00530000
	dc.l	$F0020800,$00540000
	dc.l	$F0290000
	dc.l	$80000000


sub_17D0C8:	; 水壩拆毀後暫停速殺計時器
	jsr		(sub_175EB8).l	; 暫停速殺計時器
	move.l	#1,($81AAAC).l	; 水淹白河進度
	rts

sub_17D070:	; 水淹白河後繼續速殺計時器
	jsr		(sub_175EB9).l	; 繼續速殺計時器
	move.l	#5,($81AAAC).l	; 水淹白河進度
	rts


sub_17D08A:	; 非本武攻擊對水壩有效
	jsr		$12571C			; 敵將不在場擊打無效
	tst.w   d0
	beq.s 	loc_17D08A
	movea.l	$74(a2),a3
	move.w	$10C(a3),d0
	movea.l	#off_17D08E,a3	; 非本武表
	tst.b	(a3,d0.w)
	bne.s	locret_17D08A
loc_17D08A:
	addq.w	#1,$F4(a2)		; 水壩恢復原先狀態
locret_17D08A:
	rts

off_17D08E:
	dc.b	$0,$0,$1,$1,$0,$1,$0,$1,$0,$1,$1,$1,$0,$1,$1,$1
	dc.b	$1,$1,$0,$1,$1,$0,$1,$1,$0,$1


sub_17DA02:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_17DA02		; 取消機關
	cmpi.l	#5,($81AAD2).l	; 三胖火甲車出現次數
	bgt.s	loc_17DA02
	moveq	#1,d0			; 不超過5次
	bra.s	locret_17DA02
loc_17DA02:
	moveq	#0,d0
locret_17DA02:
	rts


sub_181550:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_181550
	jsr		sub_198BBC		; 機關運作
loc_181550:
	jsr		$12EF80			; 原代碼
	rts

sub_198BBC:	; 箭雨機關
	tst.w	(ram_001A).l	; 計時寄存
	beq.s	loc_198BBC
	subq.w	#1, (ram_001A).l
	bra.w	locret_198BBC
loc_198BBC:
	pea		(1).w
	pea		(1).w			; 從右往左
	jsr		$198BBC			; 箭雨
	pea		$B4.w			; 隨機時間加值
	jsr		$102480
	addi.w	#$168,d0		; [6-9]秒/次
	move.w	d0,(ram_001A).l	; 頻率
	lea		$C(sp),sp
locret_198BBC:
	rts


sub_166BAE:
	addq.b	#1,($81A922).l		; 襄江難民存活數+1
	cmpi.l	#$1F2854, $10(a2)	; 是否老者
	bne.s	locret_166BAE
	move.b	#1,($8010A0).l		; 記錄
locret_166BAE:
	rts

sub_181616:
	cmpi.b	#9,($81A922).l		; 襄江難民存活數是否9人及以上
	bls.s	loc_181616
	tst.b	($8010A0).l			; 老者幸存否
	beq.s	loc_181616
	move.w	#1,($81836E).l		; 第三章節第一任務[携民渡江]|老者在内的08個難民
	jsr		sub_18245A			; 老者贈物
loc_181616:
	move.b	#1,($80C2B5).l		; 全局無判定[$181638]
	move.b	#1,($81A1F8).l		; 我方可行動
	pea     $13A646.l			; 3秒主循環
	pea     $B4.w
	jsr     $100EA4.l
	addq.l  #8, A7
	move.b	#$1B,($81ABBC).l	; 襄江進度#27
	rts

sub_18245A:
	movem.l	a2-a3,-(sp)
	jsr		$15EC62				; 判斷第一順位角色OBJ
	movea.l	d0,a2
	move.w	$20(a2),d0
	ext.l	d0
	move.w	($D0A000).l,d1
	ext.l	d1
	addi.l	#$E0,d1
	cmp.l	d1,d0
	ble.s	loc_1824CC
	move.w	#1,$C8(a2)
	clr.l	-(sp)
	clr.l	-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$186,d0
	bra.s	loc_1824EA
loc_1824CC:
	clr.w	$C8(a2)
	pea		(1).w
	clr.l	-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$186,d0
loc_1824EA:
	move.l	d0,-(sp)
	pea		($1F29A4).l			; 襄江贈物老者
	jsr		$1517D4
	movea.l	d0,a3
	clr.w	$D2(a3)
	pea		($13A646).l
	pea		($B4).w
	jsr		$100EA4
	pea		($14).w				; 「將軍義薄雲天，請接受老夫家傳寶器。」
	pea		($D).w				; 老者說
	jsr		$1343D6
	clr.l	-(sp)				; 丟物
	clr.l	-(sp)
	pea		(1).w
	clr.l	-(sp)
	pea		($33).w				; 白虎神器
	pea		($FFCE).w
	move.w	$22(a3),d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	move.l	d0,-(sp)
	jsr		$123D26
	lea		$44(sp),sp			; 平衡堆棧
	moveq	#1,d0
	eor.w	d0,$5C(a3)
	move.l	#$1F28C8,$2C(a3)
	clr.w	$3C(a3)
	clr.w	$54(a3)
	movem.l	(sp)+,a3-a2
	rts


sub_185148:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_185148		; 取消機關
	tst.b	($81ABF2).l 	; 轟炸機頻率
	bne.s	loc_185148
	moveq	#0,d0			; 觸發機關
	bra.s	locret_185148
loc_185148:
	moveq	#1,d0
locret_185148:
	rts


sub_18530E:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_18530E		; 取消機關
	cmpi.b	#$B,($81ABD8).l	; 0302江夏末取消[火鴉]機關
	bcc.s	loc_18530E
	jsr		$185144			; 轟炸火鴉機
loc_18530E:
	jsr		$18530E			; 0302江夏卷軸
	rts


sub_18A964:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_18A964		; 取消機關
	jsr		$190140			; 機關設定
	clr.b	($81AD3C).l		; 開啓機關
loc_18A964:
	addq.b	#1,($81AC8A).l	; 下一進度
	rts

sub_18D550:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_18D550		; 取消機關
	jsr		$190140			; 機關設定
	clr.b	($81AD3C).l		; 開啓機關
loc_18D550:
	addq.b	#1,($81ACE8).l	; 下一進度
	rts


sub_196438:
	clr.l	-(sp)
	pea		($4A).w			; 鶴羽寶衣
	clr.l	-(sp)
	move.w	$22(a2),d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	move.l	d0,-(sp)
	jsr		$123B96
	lea		$14(sp),sp
	moveq	#-$1,d0
	move.l	d0,($81ADD8).l
	move.w	#1,($818378).l	; 第四章節第三任務[復活鐵甲]
	rts


sub_190140:	; 0403東吳戰船左慈出場屠殺蜀兵
	movem.l	d2/a2,-(sp)
	jsr		$109CC2
	move.l	d0,d2
	move.l	d0,($81AD30).l
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($FFB0).w
	pea		($B4).w
	move.w	($D0A000).l,d0
	ext.l	d0
	subi.l	#$12C,d0
	move.l	d0,-(sp)
	pea		($247EB2).l				; 左慈
	move.l	d2,-(sp)
	jsr		$10A1BA
	move.l	d2,-(sp)
	jsr		$10F2C2
	movea.l	d0,a2
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10FC92
	pea		off_24D11A				; 出場動作[俯衝擊冰]
	move.l	a2,-(sp)
	jsr		$10EF18
	lea		$30(sp),sp
	clr.w	$1DE(a2)
	move.w	#$78,$216(a2)
	move.w	#$708,$218(a2)
	move.l	($81AD30).l,-(sp)
	jsr		$10F2C2
	move.l	d0,-(sp)				; 左慈OBJ
	jsr		$16B150					; 原甘寧出場動作調用子程序
	addq.l	#8,sp
	move.b	#1,($81AD3C).l			; 關閉機關左慈
	movem.l	(sp)+,d2/a2
	rts

off_24D11A:
	dc.w	$0105	; 原版左慈0105動作
	dc.l	$0024CBBC,$02000800,$0,$0


sub_1A5E4C:	; 隨人箭機關
	movem.l	d2-d3/a2-a4,-(sp)
	tst.w	(ram_001A).l		; 頻率
	beq.s	loc_1A5E6C
	subq.w	#1,(ram_001A).l
	bra.w	loc_1A5F4E
loc_1A5E6C:
	jsr		$15E72C
	move.b  d0,d2
	tst.b	d2					; 玩家是否存在
	beq.w	loc_1A5F4E
	move.w	#300,(ram_001A).l	; 5秒/次|遊戲時間3秒/次
	jsr		$15EC62
	movea.l	d0,a2				; 第一順位角色OBJ
	cmpi.b	#1,d2
	bls.s	loc_1A5EC8			; 單人直接設定
	movea.l	a2,a4
	moveq	#0,d0
	move.b	d2,d0
	move.l	d0,-(sp)
	jsr		$102480				; 隨機值
	addq.l	#4,sp
	move.b	d0,d3
	bra.s	loc_1A5EC4
loc_1A5EAE:
	tst.b	d3
	bne.s	loc_1A5EB6
	movea.l	a4,a2
	bra.s	loc_1A5EC8
loc_1A5EB6:
	subq.b	#1,d3
	move.l	a4,-(sp)
	jsr		$15EC88
	addq.l	#4,sp
	movea.l	d0,a4
loc_1A5EC4:
	move.l	a4,d0
	bne.s	loc_1A5EAE
loc_1A5EC8:	; 設定機關
	jsr		$14DF94
	movea.l	d0,a3
	pea		(1).w
	pea		($FED4).w
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$12C,d0
	move.l	d0,-(sp)
	pea		unk_390D08			; 爆箭
	move.l	a3,-(sp)
	jsr		$14E076
	lea		$18(sp),sp
loc_1A5F40:
	clr.l	$78(a3)
	move.w	#2,$6C(a3)
	clr.w	$D2(a3)
loc_1A5F4E:
	movem.l	(sp)+,d2-d3/a2-a4
	rts

unk_390D08:
	dc.l	$00390CC8,$0038CCE6,$0038CCEA,$0038CCEC
	dc.l	$0034A488,$004E664D,$0E0204D4,$00170296
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000039,$0CE4001A,$5F540000	; $30()|取消火屬性
	dc.l	$00000034,$A4A20000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000100,$00000000,$00000000,$00000000,$0	; $62()=01|爆屬性


sub_1944A6:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1944A6		; 取消機關
	jsr		sub_1A5E4C		; 隨人箭[爆]
loc_1944A6:
	jsr		$12EF80			; 原代碼
	rts


sub_1B34B0:
	movem.l	d2-d3/a2,-(sp)
	tst.w	(ram_001A).l		; 計時器
	bne.w	loc_1B36E0
	pea		($FF).w
	jsr		$1024B0
	addq.l	#4,sp
	move.w	($D0A000).l,d1
	ext.l	d1
	add.l	d1,d0
	addi.l	#$C0,d0
	move.l	d0,d3				; 橫坐標
	pea		($3F).w
	jsr		$1024B0
	addq.l	#4,sp
	addi.l	#$B8,d0
	move.l	d0,d2				; 縱坐標
	jsr		$14DF94				; 一箭[火]
	movea.l	d0,a2
	pea		(1).w
	pea		($FEFC).w
	move.l	d2,d0
	subq.l	#3,d0
	move.l	d0,-(sp)
	pea		($1F).w
	jsr		$1024B0
	addq.l	#4,sp
	move.l	d3,d1
	sub.l	d0,d1
	subi.l	#$A,d1
	move.l	d1,-(sp)
	pea		unk_2A60D6
	move.l	a2,-(sp)
	jsr		$14E076
	clr.l	$78(a2)
	move.w	#2,$6C(a2)
	jsr		$14DF94				; 二箭[冰]
	movea.l	d0,a2
	pea		(1).w
	pea		($FEFC).w
	move.l	d2,-(sp)
	move.l	d3,-(sp)
	pea		unk_2A60D7
	move.l	a2,-(sp)
	jsr		$14E076
	clr.l	$78(a2)
	move.w	#2,$6C(a2)
	jsr		$14DF94				; 三箭[電]
	movea.l	d0,a2
	pea		(1).w
	pea		($FEFC).w
	move.l	d2,d0
	addq.l	#3,d0
	move.l	d0,-(sp)
	pea		($1F).w
	jsr		$1024B0
	addq.l	#4,sp
	add.l	d3,d0
	addi.l	#$A,d0
	move.l	d0,-(sp)
	pea		unk_2A60D8
	move.l	a2,-(sp)
	jsr		$14E076
	clr.l	$78(a2)
	move.w	#2,$6C(a2)
	pea		$78.w			; 隨機時間加值
	jsr		$102480
	addi.w	#$F0,d0			; [4-6]秒/次
	move.w	d0,(ram_001A).l	; 隨機頻率
	lea		$4C(sp),sp
loc_1B36E0:
	subq.w	#1,(ram_001A).l
	movem.l	(sp)+,d2-d3/a2
	rts

unk_2A60D6:
	dc.l	$002A604E,$0038CCE6,$0038CCEA,$0038CCEC
	dc.l	$0034A488,$004E664D,$07020474,$00000000
	dc.l	$00000A00,$0038E1E8,$00000000,$00000000
	dc.l	$40000000,$0000002A,$60CA0000,$00000000	; $30()=40|火屬性
	dc.l	$00000034,$A4A20000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000E00,$00000000,$0

unk_2A60D7:
	dc.l	$002A604E,$0038CCE6,$0038CCEA,$0038CCEC
	dc.l	$0034A488,$004E664D,$07020474,$00000000
	dc.l	$00000A00,$0038E1E8,$00000000,$00000000
	dc.l	$00000000,$0000002A,$60CA0000,$00000000
	dc.l	$00000034,$A4A20000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00002000,$00000000,$00000E00,$00000000,$0	; $62()=20|冰屬性

unk_2A60D8:
	dc.l	$002A604E,$0038CCE6,$0038CCEA,$0038CCEC
	dc.l	$0034A488,$004E664D,$07020474,$00000000
	dc.l	$00000A00,$0038E1E8,$00000000,$00000000
	dc.l	$00000000,$0000002A,$60CA0000,$00000000
	dc.l	$00000034,$A4A20000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00004000,$00000000,$00000E00,$00000000,$0	; $62()=40|電屬性


sub_199CDE:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_199CDE		; 取消機關
	jsr		sub_1B34B0		; 排三箭[火冰電]
loc_199CDE:
	jsr		$12EF80			; 原代碼
	rts


sub_19956A:	; 第五章初始化
	clr.w	($81B5E2).l	; 重置從0507北彝陵密道而來的記錄
	clr.b	($81AF37).l	; 重置0507北彝陵密道進度
	rts


sub_2981D0:
	move.l	$4(sp),-(sp)	; $199636
	tst.b	$81AF37			; 是否已完成北彝陵路綫
	bne.s	loc_2981D0
	jsr		$19AD8E			; 一進場
	bra.s	locret_2981D0
loc_2981D0:
	bsr.s	sub_19AD8E		; 二進場
locret_2981D0:
	addq.l	#4,sp
	rts

sub_19AD8E:
	move.l	d2,-(sp)		; 0501北彝陵二進場動作設定
	movea.l	$8(sp),a0
	moveq	#0,d2
	move.w	$E(a0),d2
	pea		$E.w
	pea		$2.w			; 020E斜跑
	pea		$1.w			; 角色朝左
	clr.l	-(sp)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#2,d0
	add.w	d1,d0
	addi.w	#$18,d0			; 縱坐標
	move.l	d0,-(sp)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#2,d0
	add.w	d1,d0
	move.w	#$4C0,d1		; 橫坐標
	sub.w	d0,d1
	move.l	d1,-(sp)
	move.l	a0,-(sp)
	jsr		$15CD32
	lea		$1C(sp),sp	
	move.l	(sp)+,d2
	rts


sub_2981BC:
	tst.b	$81AF37			; 是否已完成北彝陵路綫
	bne.s	loc_2981BC
	jsr		$19AC0E			; 一進場
	bra.s	locret_2981BC
loc_2981BC:
	bsr.s	sub_19AC0E		; 二進場
locret_2981BC:
	rts

sub_19AC0E:
; 0501北彝陵二進場場景設定
	movem.l	d2-d3,-(sp)
	clr.l	-(sp)
	jsr		$14B73E
	jsr		$1578E4
	jsr		$10F4F4
	pea		$2BEC9E.l
	pea		$8.w
	pea		$2DBE6E.l
	jsr		$12BC40
	pea		$7F.w
	pea		$1.w
	jsr		$12BDA0
	clr.l	-(sp)
	jsr		$14BD34
	clr.l	-(sp)
	pea		$1D865E.l
	jsr		$155552
	pea		$1.w
	pea		$1DBFE6.l
	jsr		$155552
	move.w	#5,$D00002.l
	move.w	#1,$D00004.l
	pea		$62.w
	jsr		$13A27E
	pea		$363504.l
	jsr		$1552C4
	move.l	d0,d3
	jsr		$1556B4
	jsr		$155DEC
	jsr		$1559EE
	jsr		$12EE6E
	lea		$34(sp),sp
; 屏幕邊界
	pea		$10.w			; Y
	pea		$300.w			; X
	jsr		$14DC36			; 調整出場初始屏幕視野
	jsr		$19AC02
	pea		$3C.w
	jsr		$15EAF8
	pea		$1.w
	jsr		$14B73E
	jsr		$1578DA
	jsr		$10F4FC
	pea		$FA.w
	pea		$4FE.w			; 右
	pea		$6.w
	pea		$2C0.w			; 左
	jsr		$154F44			; 鎖定邊界
	lea		$20(sp),sp
; 路線指示標
	jsr		$12E5E8			; 路線指示初始化
	pea		(1).w
	pea		(6).w
	pea		($96).w
	pea		($180).w
	clr.l	-(sp)
	jsr		$12E93C
	lea		$14(sp),sp
; 北彝陵後段進度
	move.b	#5,$81AF36.l
	clr.b	$81AF37.l
	moveq	#0,d2
loc_19AD70:
	movea.l	#$81AF38,a0
	clr.b	(a0,d2.l)
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_19AD70
	clr.w	$81AF40.l
	movem.l	(sp)+,d2-d3
	rts


sub_1A5F78:
	move.w	#1,($81837C).l	; 第五章節第二任務[引爆炸藥]
; 原代碼
	clr.w	$3C(a1)
	clr.w	$54(a1)
	clr.w	$68(a1)
	rts


sub_1A492C:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1A492C		; 取消機關
	jsr		sub_1B173C		; 落石機關
loc_1A492C:
	jsr		$12EF80			; 原代碼
	rts

sub_1B173C:	; 落石機關
	movem.l	d2/a2,-(sp)
	tst.w	(ram_001A).l	; 機關計時寄存
	beq.s   loc_1B173C
	subq.w  #1, (ram_001A).l
	bra.w   locret_1B173C
loc_1B173C:
	moveq	#0,d2
loc_1B1742:
	jsr		$14DF94
	movea.l	d0,a2
	clr.l	-(sp)
	pea		($FF20).w
	pea		($3F).w
	jsr		$1024B0
	addq.l	#4,sp
	addi.l	#$A0,d0
	move.l	d0,-(sp)
	pea		($1FF).w
	jsr		$1024B0
	addq.l	#4,sp
	move.w	($D0A000).l,d1
	ext.l	d1
	add.l	d1,d0
	move.l	d0,-(sp)
	pea		($1C5250).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$18(sp),sp
	move.l	#off_315048,$2C(a2)	; 落石預落
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.w	#$11E,$3E(a2)
	move.w	d2,d0
	move.w	d0,d1
	add.w	d0,d0
	add.w	d1,d0
	lsl.w	#3,d0
	add.w	d1,d0
	move.w	d0,$EA(a2)
	move.w	#1,$6E(a2)
	clr.l	$78(a2)
	move.w	#2,$6C(a2)
	addq.l	#1,d2
	moveq	#8,d0			; 8個落石
	cmp.l	d2,d0
	bgt.w	loc_1B1742
	pea		$B4.w			; 隨機時間加值
	jsr		$102480
	addq.l	#4,sp
	addi.w	#$1E0,d0		; [8-11]秒/次
	move.w	d0,(ram_001A).l	; 頻率
locret_1B173C:
	movem.l	(sp)+,d2/a2
	rts

off_315048:
	dc.l	$00000002
	dc.l	$F0070000,sub_1CAFEA
	dc.l	$F0010000
	dc.l	$F0021400,$00000000
	dc.l	$F0030000,$20000009
	dc.l	$F00BFF00,$02820000
	dc.l	$F0140009,$00000100
	dc.l	$F00B9F00,$02CF0000
	dc.l	$F0100004,$00000000
	dc.l	$F01000FC,$00000000
	dc.l	$F0020200,$00010000
	dc.l	$F0020400,$00020000
	dc.l	$F0280300,$00030000,$40030000
	dc.l	$F0290000
	dc.l	$F0280300,$00040000,$40040000
	dc.l	$F0290000
	dc.l	$80000000

sub_1CAFEA:
	movea.l	4(sp),a0
	move.w	$22(a0),d0
	ext.l	d0
	move.w	$24(a0),d1
	ext.l	d1
	add.l	d1,d0
	move.w	($D0A002).l,d1
	ext.l	d1
	addi.l	#$1C,d1
	cmp.l	d1,d0
	ble.s	locret_1CB014
	move.w	#4,$3C(a0)
locret_1CB014:
	rts


sub_1A2E4E:
	move.b	#8,$8182F8.l	; 0506葫蘆口密室>0508葫蘆口下坡
	tst.w	($81B5E2).l		; 是否0507北彝陵密道出
	beq.s	locret_1A2E4E
	move.b	#1,$8182F8.l	; 0507北彝陵密道>0501北彝陵二
locret_1A2E4E:
	rts


sub_19C632:
	tst.w	($81BA12).l		; 0503葫蘆口上坡入口處[卡樁巨石]是否打開
	bne.s	locret_19C632
	move.w	#1,($81837E).l	; 第五章節第三任務[阻止滾石]
locret_19C632:
	move.b	#6,($8182F8).l	; [原代碼]0503葫蘆口上坡>>0506葫蘆口密室
	rts


sub_1A72E6:
	move.l	d2,-(sp)
	moveq	#$B,d2			; 刷兵次數
loc_1A72E6:
	jsr		$12EF80			; 刷新敵兵表
	dbra	d2,loc_1A72E6
	move.l	(sp)+,d2
	rts


sub_19CFD0:
	move.b	#1,($81B93C).l		; [原代碼]敵方可攻擊
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.s	loc_19CFD0
	move.b	#$A+1,($81833E).l	; 時間[10秒]
	bra.s	locret_19CFD0
loc_19CFD0:
	move.b	#$1E+1,($81833E).l	; 時間[30秒]
locret_19CFD0:
	rts

sub_19D43A:
	link	a6,#0
	move.l	a2,-(sp)
; 敵兵掉物[原代碼]
	move.l	8(a6),-(sp)
	jsr		$12F7F2
	addq.l	#4,sp
	cmpi.b	#$13,($81AF5E).l
	bcc.w	loc_19D448		; 敵將出場後不再獎勵
; 計算敵人基址
	move.l	8(a6),-(sp)
	jsr		$10F2C2
	addq.l	#4,sp
	movea.l	d0,a2
; 是否敵兵
	cmpi.w	#2,$1A6(a2)
	bne.s	loc_19D448
	tst.w	$6C(a2)			; 是否死亡
	bne.s	loc_19D448
	addq.b	#1,$81833E.l	; 擊殺[1]個敵兵獎勵[1]個遊戲秒
; 刷新時間顯存
	clr.l	-(sp)
	moveq	#0,d0
	move.b	($81833E).l,d0
	subq.l	#1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)			; 不刷新[TIME]
	jsr		$145574
	lea		$C(sp),sp
; 顯示上升文字
	clr.l	-(sp)
	pea		($1C1F32).l
	pea		(unk_1206F4).l	; TIME +1
	move.w	$24(a2),d0
	ext.l	d0
	subq.l	#4,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#2,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$40,d0
	move.l	d0,-(sp)
	jsr		$12D506
	move.l	d0,-(sp)
	jsr		$12D72C
	lea		$1C(sp),sp
loc_19D448:
	movea.l	(sp)+,a2
	unlk    a6
	rts

unk_1206F4:
	dc.b	'TIME +1',0


sub_19B9A2:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_19B9A2
	tst.w	($81AF4E).l		; 機關計時
	beq.s	locret_19B9A2
loc_19B9A2:
	moveq	#1,d0			; 取消機關
locret_19B9A2:
	rts


sub_19B8D6:
	move.w	#$47,$1C6(a0)	; 0502南彝陵後段候騎二出場[秦皇寶甲]
	move.w	#1,($81835C).l	; 第五章節第四任務[攔截候騎]
	rts


sub_1A0490:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1A0490		; 取消
	clr.l	-(sp)			; 封禁[0]
	jsr		$129462			; 封禁道具
	addq.l	#4,sp
loc_1A0490:
	rts
			

sub_1A81F2:	; 0600山寨橋樑處敵兵
	move.l	d2,-(sp)
; 賦兵
	clr.l   -(sp)
	pea     seg_2B727E		; 0600山寨橋樑處[紫色弓兵]敵兵表
	jsr     $12EF1A.l
	addq.l	#8,sp
; 刷兵
	moveq   #8,d2			; 提前刷新8次敵兵表[5個敵兵]
loc_1A81F2:
	jsr		$12EF80			; 刷新
	dbra	d2,loc_1A81F2
	move.l	(sp)+,d2
	rts

seg_2B727E:	; [單兵]同[雙兵]
	dcb.l	2,off_2B727E
off_2B727E:
	dc.l	unk_2A031A,$003C0000
	dc.w	$0000
unk_2A031A:	; [紫色弓兵]敵兵表
	dc.l	$FF1100A0,$FF120100,$FF0C0300
	dc.l	$FF050006,$0038D30E,$00020006,unk_2A01B2+$00
	dc.l	$FF050006,$00370D1A,$00000006,unk_2A01B2+$0C
	dc.l	$FF050006,$00370D1A,$00000006,unk_2A01B2+$18
	dc.l	$FF050006,$00370D1A,$00000006,unk_2A01B2+$24
	dc.l	$FF050006,$00370D1A,$00000006,unk_2A01B2+$30
	dc.l	$FF0A0000,$FF130000
unk_2A01B2:	; 坐標表
	dc.l	$07F000D8,$00000002,$00041700
	dc.l	$07C000D7,$00000002,$00040000
	dc.l	$07C000EF,$00000002,$00040000
	dc.l	$07C000E3,$00000002,$00040000
	dc.l	$07C000CB,$00000002,$00040000


off_38E270:
	dc.l	$00000000
	dc.l	$F0070007,$0016EE32	; 一定距離觸發0007
	dc.l	$F0010000

off_371898:
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0280000,$F0070000,sub_371898	; 隨機起身時間
	dc.l	$F0020500,$00000000
	dc.l	$F0290000
	dc.l	$F0020500,$00190000
	dc.l	$F0020400,$001A0000
	dc.l	$F0280500
	dc.l	$F0020400,$00030001
	dc.l	$F0020400,$00040000
	dc.l	$F0020400,$00050001
	dc.l	$F0020400,$00060000
; 站立發射
	dc.l	$F0020300,$00280000
	dc.l	$F0020C00,$00290000
	dc.l	$F015FF00,$00371668,$003CFFC3,$002AFF00,$002A0100
	dc.l	$F0020200,$002A0000
	dc.l	$F0020400,$00290000
	dc.l	$F0020200,$00280000
	dc.l	$F0020400,$00070001
	dc.l	$F0020400,$00080000
	dc.l	$F0020400,$00090001
	dc.l	$F0020400,$000A0000
	dc.l	$F0020400,$000300FF
	dc.l	$F0020400,$00040000
	dc.l	$F0020400,$000500FF
	dc.l	$F0020400,$00060000
; 下蹲發射
	dc.l	$F0020100,$003C0000
	dc.l	$F0020500,$003D0000
	dc.l	$F015FF00,$00371668,$0026FFD5
	dc.l	$F0020100,$003EFF00
	dc.l	$F0020300,$003E0000
	dc.l	$F0020300,$003D0000
	dc.l	$F0020100,$003C0000
	dc.l	$F0020400,$000700FF
	dc.l	$F0020400,$00080000
	dc.l	$F0020400,$000900FF
	dc.l	$F0020400,$000A0000
	dc.l	$F0290000
	dc.l	$F0070000,sub_371899	; 全場退兵
	dc.l	$80000000

sub_371898:
	move.l	a2,-(sp)
	movea.l 8(sp),a2
	pea		$30.w
	jsr		$102480
	addq.l	#4,sp
	move.w	d0,$12C(a2)	; 隨機重複次數
	movea.l	(sp)+,a2
	rts

sub_371899:	; 向右退兵
	clr.l	-(sp)
	jsr		$10F602
	addq.l	#4,sp
	rts


sub_1A7688:	; 第六章初始化
	clr.w	($81B60C).l	; 重置左慈洪水是否出現
	clr.b	($81B99F).l	; 重置上一場景號
	clr.b	($81B9A0).l	; 重置當前場景號
	rts


sub_1AA9F4:
	movem.l	d2-d4/a2-a4,-(sp)
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.w	loc_1AABFA			; 取消機關
	tst.w	($81B9E0).l			; 鉄刺橫柱觸發頻率
	bne.w	loc_1AABFA
	move.w	($D0A000).l,d2
	addi.w	#$24C,d2
	move.w	#$A0,d3
	moveq	#0,d4
loc_1AAA1A:
	jsr		$14DF94
	movea.l	d0,a4
	clr.l	-(sp)
	pea		($FFEC).w
	move.w	d3,d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	d2,d0
	ext.l	d0
	move.l	d0,-(sp)
	pea		($2A18E4).l
	move.l	a4,-(sp)
	jsr		$14E076
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$50(a4)
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$8A(a4)
	jsr		$14DF94
	movea.l	d0,a2
	clr.l	-(sp)
	pea		($FF99).w
	move.w	d3,d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	d2,d0
	ext.l	d0
	subi.l	#$21,d0
	move.l	d0,-(sp)
	pea		($2A1958).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$30(sp),sp
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$50(a2)
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$8A(a2)
	move.l	a2,-(sp)
	clr.l	-(sp)
	move.l	a4,-(sp)
	jsr		$15101E
	jsr		$14DF94
	movea.l	d0,a2
	clr.l	-(sp)
	pea		($FFB5).w
	move.w	d3,d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	d2,d0
	ext.l	d0
	addi.l	#$2B,d0
	move.l	d0,-(sp)
	pea		($2A1958).l
	move.l	a2,-(sp)
	jsr		$14E076
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$50(a2)
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$8A(a2)
	move.l	a2,-(sp)
	pea		(1).w
	move.l	a4,-(sp)
	jsr		$15101E
	lea		$30(sp),sp
	tst.l	d4
	beq.w	loc_1AABC8
	jsr		$14DF94
	movea.l	d0,a3
	clr.l	-(sp)
	pea		($FF99).w
	move.w	d3,d0
	ext.l	d0
	subi.l	#$80,d0
	move.l	d0,-(sp)
	move.w	d2,d0
	ext.l	d0
	subi.l	#$21,d0
	move.l	d0,-(sp)
	pea		($2A1958).l
	move.l	a3,-(sp)
	jsr		$14E076
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$50(a3)
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$8A(a3)
	move.l	a3,-(sp)
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$15101E
	lea		$24(sp),sp
	jsr		$14DF94
	movea.l	d0,a3
	clr.l	-(sp)
	pea		($FFB5).w
	move.w	d3,d0
	ext.l	d0
	subi.l	#$80,d0
	move.l	d0,-(sp)
	move.w	d2,d0
	ext.l	d0
	addi.l	#$2B,d0
	move.l	d0,-(sp)
	pea		($2A1958).l
	move.l	a3,-(sp)
	jsr		$14E076
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$50(a3)
	moveq	#0,d0
	move.b	($81B9B9).l,d0
	move.w	d0,$8A(a3)
	move.l	a3,-(sp)
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$15101E
	lea		$24(sp),sp
loc_1AABC8:
	addi.w	#$91,d2
	addi.w	#$46,d3
	pea		($7F).w
	jsr		$1024B0
	addq.l	#4,sp
	moveq	#$3F,d1
	cmp.l	d0,d1
	bge.s	loc_1AABE6
	addi.w	#$32,d2
loc_1AABE6:
	jsr		$13A646
	addq.l	#1,d4
	moveq	#2,d0				; 重複2次
	cmp.l	d4,d0
	bgt.w	loc_1AAA1A
	move.w	#$2D0,($81B9E0).l	; 頻率
loc_1AABFA:
	movem.l	(sp)+,d2-d4/a2-a4
	rts


sub_1AA8F0:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1AA8F0
	tst.w	($81B9E0).l		; 機關計時器
	beq.s	loc_1AA8F1
	subq.w	#1,($81B9E0).l	; 計時-1
loc_1AA8F0:
	moveq	#1,d0			; 取消機關
	bra.s	locret_1AA8F0
loc_1AA8F1:
	moveq	#0,d0			; 觸發機關
locret_1AA8F0:
	rts


sub_1AC8D4:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	locret_1AC8D4	; 取消機關
	move.w	#1,($81B0C2).l	; 開啟三男弓蠻兵陣
locret_1AC8D4:
	rts


sub_1AF11A:	; 0605[白虎密室]任務|爆物
	jsr		$1B0248			; 0605四神獸、白虎雕塑[原代碼]
	jsr		sub_1BA9DC		; 0605白虎密室爆物
	move.w	#1,($818382).l	; 第六章節第二任務[白虎密室]
; 設定計時器
	jsr		$100D74			; 分配計時器編號
	move.l	d0,(ram_0019).l
	pea		($B4).w			; 時間[3秒]
	move.l	(ram_0019).l,-(sp)
	jsr		$100E1A
	addq.l	#8,sp
	rts


sub_1B117A:	; 第六章節第三任務[智取寶盒]
	move.l	a2,($81B5F0).l	; 原代碼
	move.w	#1,($818384).l	; 任務0603
	moveq	#1,d3			; 固定掉落寶盒
	rts


sub_1BA9DC:	; 0605白虎密室爆物
	movem.l	d2-d4/a2,-(sp)
	moveq	#$7C,d4
	clr.b	d2
	bra.w	loc_1BAC20
loc_1BAB9E:
	moveq	#0,d0
	move.b	d2,d0
	movea.l	#byte_2AB472,a0	; 白虎密室爆物表
	move.b	(a0,d0.w),d3
	btst	#7,d3
	beq.s	loc_1BABE6
	clr.l	-(sp)
	moveq	#0,d0
	move.b	d3,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	pea		($3F).w
	jsr		$1024B0
	addq.l	#4,sp
	addi.w	#$AA,d0
	move.l	d0,-(sp)
	pea		($FF).w
	jsr		$1024B0
	addq.l	#4,sp
	add.w	d4,d0
	move.l	d0,-(sp)
	jsr		$11C1CA
	bra.s	loc_1BAC18
loc_1BABE6:
	clr.l	-(sp)
	moveq	#0,d0
	move.b	d3,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	pea		($3F).w
	jsr		$1024B0
	addq.l	#4,sp
	addi.w	#$AA,d0
	move.l	d0,-(sp)
	pea		($FF).w
	jsr		$1024B0
	addq.l	#4,sp
	add.w	d4,d0
	move.l	d0,-(sp)
	jsr		$123B96
loc_1BAC18:
	lea		$14(sp),sp
	movea.l	d0,a2
	addq.b	#1,d2
loc_1BAC20:
	cmpi.b	#$C,d2
	bcs.w	loc_1BAB9E
	movem.l	(sp)+,d2-d4/a2
	rts

byte_2AB472:	; 白兔密室爆物表12|白虎神器[$33]
	dc.b	$03,$93,$8D,$87,$05,$8F,$03,$91,$8E,$3E,$05,$33


sub_10F4EA:
	move.b	#1,($81B614).l	; 敵方可行動
	move.b	#1,($81B93C).l	; 敵方可攻擊
	rts
	
sub_1890C0:
	link	A6, #-$30
	movem.l	D2/A2, -(A7)
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.w	locret_1890C0		; 取消機關
	lea		(-$30,A6), A0
	movea.l	#off_3082E2, A1
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	move.l	(A1)+, (A0)+
	clr.b	$81ac34.l
	moveq	#$0, D2
loc_1890F2:
	jsr		$14df94.l
	movea.l	D0, A2
	move.w	D2, D1
	lsl.w	#2, D1
	movea.l	#$81ac36, A0
	move.l	D0, (A0,D1.w)
	clr.l	-(A7)
	clr.l	-(A7)
	move.w	D2, D0
	lsl.w	#3, D0
	move.l	(-$2c,A6,D0.w), -(A7)
	move.w	D2, D0
	lsl.w	#3, D0
	move.l	(-$30,A6,D0.w), -(A7)
	pea		$297ff0.l			; 暗矛
	move.l	A2, -(A7)
	jsr		$14e076.l
	clr.w	($d2,A2)
	clr.l	($78,A2)
	move.w	#$2, ($6c,A2)
	move.l	#$290558, ($2c,A2)
	clr.w	($3c,A2)
	clr.w	($54,A2)
	clr.w	($68,A2)
	pea		$18908e.l
	move.l	A2, -(A7)
	jsr		$150838.l
	lea		($20,A7), A7
	addq.l	#1, D2
	moveq	#$6, D0
	cmp.l	D2, D0
	bgt.s	loc_1890F2
locret_1890C0:
	movem.l	(-$38,A6), D2/A2
	unlk	A6
	rts

off_3082E2:	; 暗矛坐標
	dc.l	$0000028C,$0000009E
	dc.l	$0000026D,$000000D8
	dc.l	$00000301,$000000AC
	dc.l	$000002F3,$000000D1
	dc.l	$0000033A,$000000B8
	dc.l	$00000385,$000000C2
	dc.l	$000002FC,$000000A4
	dc.l	$000002AA,$000000D5
	dc.l	$000002F1,$000000C2
	dc.l	$00000366,$000000B2
	dc.l	$00000346,$000000CE
	dc.l	$00000396,$000000C6


sub_1B182C:	; 第七章初始化
	clr.b	($81C7A8).l	; 重置上一場景號
	clr.b	($81C7A9).l	; 重置當前場景號
	rts


sub_1B6C2C:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1B6C2C
	clr.b   ($81B1D0).l		; 開啟機關
	bra.s	locret_1B6C2C
loc_1B6C2C:
	move.b	#1,($81B1D0).l	; 關閉機關
locret_1B6C2C:
	rts


sub_1B6AEE:
	clr.l	-(sp)
	pea		(4).w		; 指向正南
	pea		($C8).w
	pea		($698).w
	clr.l	-(sp)
	jsr		$12E93C		; 路線指示標
	lea		$14(sp),sp
	rts


sub_1B2E50:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	locret_1B2E50
	move.b	#1,($81B168).l	; 開啟機關
locret_1B2E50:
	rts

sub_1B305C:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1B305C
	cmp.l	#2,($81B16E).l	; 摧毀的菜刀車數目
	bge.s	loc_1B305C
	moveq	#1,d0			; 觸發機關
	bra.s	locret_1B305C
loc_1B305C:
	moveq	#0,d0			; 取消機關
locret_1B305C:
	rts


sub_1B34C2:
	cmpi.b	#4,($81A326).l		; 難度[1-4]
	bls.s	loc_1B34C2
	move.l	($81B178).l,-(sp)	; 機關計時器
	jsr		$100E62
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_1B34C2		; 觸發機關
loc_1B34C2:
	moveq	#1,d0				; 取消機關
locret_1B34C2:
	rts


sub_1B7A3E:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1B7A3E		; 取消機關
	cmpi.b	#7,($81B1DC).l	; 0705下水道後段關閉水雷機關
	bcc.s	loc_1B7A3E
	jsr		$1B761C			; 水雷機關
loc_1B7A3E:
	tst.b	($81B1F6).l		; 原代碼
	rts


sub_1B972C:
	jsr		$15EC62						; 第一順位角色OBJ
	move.l  d0,a0
	move.w	$6c(a0),d0
	ext.l	d0
	divu.w	#$4,d0						; 生命值除以四
	swap	d0							; 高低位字交換得到[餘數.w]
	lsl.w	#2,d0
	movea.l	#off_2AAE04,a0
	movea.l	(a0,d0.w),a0				; 計算小寶箱物品表地址
	move.w  d2,d0
	lsl.w   #1,d0						; 物品地址一字一偏移
	cmpi.w	#$80,(a0,d0.w)
	bcs.s	loc_1B9752
	move.w	(a0,d0.w),$DC(a2)			; 道具>=$80
	bra.s	locret_1B972C
loc_1B9752:
	move.w	(a0,d0.w),$DE(a2)			; 道具<$80
locret_1B972C:
	rts
off_2AAE04:
	dc.l	off_2AAE03,off_2AAE02,off_2AAE01,off_2AAE00
off_2AAE03:
	dc.w	$3C,$3E,$11,$82,$89
off_2AAE02:
	dc.w	$11,$82,$89,$3C,$3E
off_2AAE01:
	dc.w	$89,$3C,$3E,$11,$82
off_2AAE00:
	dc.w	$3E,$89,$82,$11,$3C


sub_1B4806:
	move.l	#$C8,($81B19C).l
	rts


sub_1B481E:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1B481E
	tst.l	($81B198).l		; 機關計時
	beq.s	locret_1B481E
loc_1B481E:
	moveq	#1,d0			; 取消機關
locret_1B481E:
	rts


sub_1B403A:
; 前庭段保護白兔成功
	move.w	#1,($81B196).l
; 主循環時間3秒[白兔進入密道]
	pea     $13A646.l
	pea     $B4.w
	jsr     $100EA4.l
	addq.l  #8,sp
; 刪除OBJ
	move.w	($e,a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	jsr		$109D38.l
	addq.l	#4,sp
	rts


sub_1B45DC:
	move.w	#1,($81B192).l	; 白兔死亡
	tst.w	($81B196).l		; 白兔是否保護成功
	bne.s	locret_1B45DC
	move.l	d2,-(sp)
	jsr		$10F2C2			; 計算OBJ
	movea.l	d0,a2
	clr.l	-(sp)
	pea		($35).w			; 玄武神器
	clr.l	-(sp)
	move.w	$22(a2),d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	move.l	d0,-(sp)
	jsr		$123B96			; 敵方掉物
	lea		$18(sp),sp
locret_1B45DC:
	rts


sub_1BA48E:
; 1秒進場
	pea		($3C).w			; 1秒
	jsr		$15EAF8			; 停止進場動作|敵方不攻擊
	addq.l	#4,sp
; 賦兵
	clr.l   -(sp)
	pea     seg_2B735A		; 0708白兔密室毒蝎敵兵表
	jsr     $12EF1A.l
	addq.l	#8,sp
; 任務
	move.w	#1,($818388).l	; 第七章節第二任務[白兔密室]
	move.b	#1,($81B93C).l	; 敵方開始攻擊
	move.w	#1,($81835A).l	; 原代碼
	rts


sub_1BA842:
	jsr		$12EF80			; 刷兵
	move.l	($81B282).l,-(sp)
	jsr		$100E62			; 計時器
	addq.l	#4,sp
	tst.l	d0
	bne.w	locret_1BA842
	jsr		$12482A
	jsr		$11C82C
	addq.b	#1,($81B280).l	; 下一進度
locret_1BA842:
	rts


seg_2B735A:	; [單兵]同[雙兵]
	dcb.l	2,off_2AAF34
off_2AAF34:
	dc.l	unk_2AAEAA,$00000000
	dc.w	$0000
unk_2AAEAA:	; 0708白兔密室毒蝎敵兵表
	dc.l	$FF120000,$FF0F0000,$FF0C0400
	dc.l	$FF050102,$003A4E0E,$00000103,unk_2AAE16+$0C,$FF0B0014
	dc.l	$FF050101,$003A4E0E,$00000101,unk_2AAE16+$18,$FF0B0014
	dc.l	$FF050104,$003A4E0E,$00000104,unk_2AAE16+$24,$FF0B0014
	dc.l	$FF050104,$003A4E0E,$00000104,unk_2AAE16+$30,$FF0B0014
	dc.l	$FF050100,$003A4E0E,$00000100,unk_2AAE16+$3C,$FF0B0014
	dc.l	$FF050100,$003A4E0E,$00000100,unk_2AAE16+$48,$FF0B0014
	dc.l	$FF050100,$003A4E0E,$00000100,unk_2AAE16,$FF0A0000,$FF130000
unk_2AAE16:	; 坐標表
	dc.l	$01CC00AA,$FF100000,$00100000
	dc.l	$018800C2,$FF100000,$00100000
	dc.l	$01000090,$00000000,$00100000
	dc.l	$000000B3,$00000000,$00100000
	dc.l	$FF9800C8,$00000000,$00100000
	dc.l	$01D000C4,$00000000,$00000000
	dc.l	$008B00F7,$00000000,$00000000


sub_1B4C8C:
	movem.l	d2/a2,-(sp)
	movea.l	$C(sp),a2
	movea.l	$F8(a2),a0
	move.b	1(a0),d2
	andi.l	#$FF,d2
	cmpi.b	#8,($81C7A8).l	; 上一場景號是否08[0708白兔密室]
	beq.s	loc_1B4CD0
; 0706長廊一進場[場景第一段從左往右]
	pea		(5).w
	pea		(2).w
	clr.l	-(sp)
	clr.l	-(sp)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#2,d0
	add.w	d1,d0
	addi.w	#$C8,d0
	move.l	d0,-(sp)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#2,d1
	add.w	d0,d1
	move.w	#$FFE2,d0
	sub.w	d1,d0
	bra.s	loc_1B4CF6
loc_1B4CD0:
; 0706長廊二進場[場景第三段從下至上]
	pea		($35).w
	pea		(2).w
	clr.l	-(sp)
	clr.l	-(sp)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#2,d0
	add.w	d1,d0
	addi.w	#$100,d0
	move.l	d0,-(sp)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#2,d0
	add.w	d1,d0
	addi.w	#$4DE,d0		; 出場橫坐標
loc_1B4CF6:
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15CD32
	lea		$1C(sp),sp
	movem.l	(sp)+,d2/a2
	rts

sub_1B88A8:
	cmpi.b	#8,($81C7A8).l	; 上一場景號是否08[0708白兔密室]
	bne.s	locret_1B88A8
; 調整場景初始屏幕坐標
	clr.l	-(sp)			; Y
	pea		($3FE).w		; X
	jsr		$14DC36
	addq.l	#8,sp
locret_1B88A8:
	rts

sub_1B88F8:
; 調整0706長廊進度
	clr.b	($81B202).l		; 原代碼
	cmpi.b	#8,($81C7A8).l	; 上一場景號是否08[0708白兔密室]
	bne.s	locret_1B88F8
	move.b	#5,($81B202).l	; 0706長廊進度[第三段]
; 路線指向標
	pea		(1).w
	pea		(6).w
	pea		($96).w
	pea		($173).w
	clr.l	-(sp)
	jsr		$12E93C
	lea		$14(sp),sp
locret_1B88F8:
	rts


sub_1B893A:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1B893A
	move.l	#1,($81B204).l	; 開啟機關|取消黃蓋出場
	clr.l	($81B208).l		; 機關進度0[補]
	bra.s	locret_1B893A
loc_1B893A:
	move.l	#7,($81B204).l	; 取消機關
locret_1B893A:
	rts


sub_1B52DE:
	cmpi.b	#4,($81A326).l	; 難度[1-4]
	bls.s	loc_1B52DE
	cmpi.b	#6,($81B1A8).l	; 0703大廳後段跳過
	bcc.s	loc_1B52DE
	jsr		sub_1B5554		; 殿下暗箭機關
loc_1B52DE:
	jsr		$1B52DE			; 原代碼[0703大廳卷軸]
	rts

sub_1B5554:	; 殿下暗箭機關
	moveq   #$0,d0
	move.w  $81b1ae.l,d0
	bne.s	loc_1B5572
	pea		$F0.w						; 隨機時間加值
	jsr		$102480
	addq.l	#4,sp
	addi.w	#$168,d0					; [6-10]秒/次
	move.w	d0,($81b1ae).l				; 暗箭頻率[6]
loc_1B5572:
	moveq   #$78,d1						; [$78]觸發暗箭[2]
	cmp.w   d1,d0
	beq.s	loc_1B557A
	cmpi.w  #$B4,d0						; [$B4]觸發暗箭[3]
	bne.s	loc_1B5554
loc_1B557A:
	jsr     sub_1B6270					; 暗箭機關
loc_1B5554:
	subq.w  #1, $81b1ae.l
	rts

sub_1B6270:
	movem.l	d2/a2-a3,-(sp)
	movea.l	#unk_1B6270,a3				; 縱坐標表格
	moveq	#3,d2						; 循環三次
loc_1B6276:
	jsr		$14DF94						; 分配機關OBJ
	movea.l	d0,a2
	clr.l	-(sp)
	pea		($FFF9).w					; 高度
	pea		(7).w						; 隨機8個縱坐標
	jsr		$1024B0
	addq.l	#4,sp
	lsl.l	#1,d0
	move.w	(a3,d0.l),d0				; 縱坐標
	move.l	d0,-(sp)
	move.w	($D0A000).l,d0
	addi.l	#$1E0,d0
	move.l	d0,-(sp)					; 橫坐標
	pea		($2A832A).l					; 殿前暗箭
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$18(sp),sp
	clr.l	$78(a2)
	move.w	#2,$6C(a2)
	move.w	d2,d0
	lsl.w	#4,d0
	move.w	d0,$EA(a2)
	move.w	#1,$6E(a2)
	jsr		$13A646						; 主循環
	subq.l	#1,d2
	tst.l	d2
	bne.w	loc_1B6276
	movem.l	(sp)+,d2/a2-a3
	rts

unk_1B6270:	; 縱坐標表格
	dc.l	$00BC,$00CE,$00DF,$00F3
	dc.l	$00C5,$00D5,$00E6,$00F9


sub_15E72C:	; 原版「傳遞玩家數量」子程序	
	move.b	$81A1BB.l, D0
	ext.w	D0
	ext.l	D0
	rts

; --------------- 劇情調整 --------------------------------------------------

sub_1742EA:	; 序章初始化|章頭動畫後
	clr.b	($8182FA).l		; 序章跑馬場景[0000]
	jsr		($175432).l		; 第一章初始化
	jsr		($178D28).l		; 第二章初始化
	jsr		($180F52).l		; 第三章初始化
	jsr		($187776).l		; 第四章初始化
	jsr		(sub_19956A).l	; 第五章初始化
	jsr		(sub_1A7688).l	; 第六章初始化
	jsr		(sub_1B182C).l	; 第七章初始化
	jsr		($1BE2EA).l		; 第八章初始化
	rts

sub_1742EC:	; 序章地圖設定
	link	a6,#0
	move.w	$A(a6),d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#2,d0
	movea.l	#off_27FDA0,a1
	movea.l	(a1,d0.w),a0
	jsr		(a0)
	unlk	a6
	rts

sub_17430C:	; 序章卷軸進度
	link	a6,#0
	move.w	$A(a6),d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#2,d0
	movea.l	#(off_27FDA0+4),a1
	movea.l	(a1,d0.w),a0
	jsr		(a0)
	unlk	a6
	rts

sub_17432C:	; 序章切換場景
	link	a6,#0
	move.w	$A(a6),d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#2,d0
	movea.l	#(off_27FDA0+8),a1
	movea.l	(a1,d0.w),a0
	jsr		(a0)
	unlk	a6
	rts

sub_17434C:	; 序章敵兵死亡
	link	a6,#0
	move.l	$C(a6),-(sp)
	move.w	$A(a6),d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#2,d0
	movea.l	#(off_27FDA0+$C),a1
	movea.l	(a1,d0.w),a0
	jsr		(a0)
	unlk	a6
	rts

sub_174370:	; 序章敵將死亡
	link	a6,#0
	move.l	$C(a6),-(sp)
	move.w	$A(a6),d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#2,d0
	movea.l	#(off_27FDA0+$10),a1
	movea.l	(a1,d0.w),a0
	jsr		(a0)
	unlk	a6
	rts

sub_174394:	; 序章進場動作
	link	a6,#0
	move.l	$C(a6),-(sp)
	move.w	$A(a6),d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#2,d0
	movea.l	#(off_27FDA0+$14),a1
	movea.l	(a1,d0.w),a0
	jsr		(a0)
	unlk	a6
	rts

sub_1743B8:	; 序章基礎時間
	move.w	6(sp),d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#2,d0
	movea.l	#(off_27FDA0+$18),a0
	move.w	(a0,d0.w),d0
	andi.l	#$FFFF,d0
	rts

sub_1743D6:	; 序章
	move.w	6(sp),d0
	move.w	d0,d1
	lsl.w	#3,d0
	sub.w	d1,d0
	lsl.w	#2,d0
	movea.l	#(off_27FDA0+$1A),a0
	move.w	(a0,d0.w),d0
	andi.l	#$FFFF,d0
	rts

off_27FDA0:
	dc.l	$001750B0,$001753B0,$00175426,$00174A02,$00174A52,$0017537A,$00630000	; 跑馬序言[0000]
	dc.l	$00174674,$0017484E,$00174A00,$00174A02,$00174A52,$001747FE,$00500000	; 樊城奪糧[0001]
	dc.l	$00174A54,$00174B78,$00174A00,$00174A02,$00174A52,$001747FE,$00500000	; 樊城演示[0002]
; 序章劇情[0003]|樊城奪糧左慈尋徒
	dc.l	sub_174674		; 序章地圖設定
	dc.l	sub_1753B0		; 序章卷軸進度
	dc.l	sub_175426		; 序章切換場景
	dc.l	$00174A02		; 序章敵兵死亡
	dc.l	$00174A52		; 序章敵將死亡
	dc.l	sub_1747FE		; 序章進場動作
	dc.w	99,0			; 序章基礎時間
; 終章劇情[0004]|青龍密室戰真呂布
	dc.l	sub_1AEFAE		; 終章地圖設定
	dc.l	sub_1AF652		; 終章卷軸進度
	dc.l	nullsub			; 終章切換場景
	dc.l	($1A9C8E).l		; 終章敵兵死亡
	dc.l	nullsub			; 終章敵將死亡
	dc.l	sub_1AF41A		; 終章進場動作
	dc.w	200,0			; 終章基礎時間

sub_174674:	; 序章地圖設定
	move.l	d2,-(sp)
	jsr		$1578E4			; 封我行關道具
	clr.b	($81B5E0).l		; 關閉敵方行動
	clr.l	-(sp)
	jsr		$14B73E
	pea		($1E).w
	clr.l	-(sp)
	jsr		$146882			; 背景音樂
	clr.l	-(sp)
	jsr		$14BD34
	clr.l	-(sp)
	pea		($1D70EE).l
	jsr		$155552
	pea		(1).w
	pea		($1D96E2).l
	jsr		$155552
	lea		$20(sp),sp
	pea		($D).w
	pea		($27FF00).l
	jsr		$156D5C
	jsr		$1556B4
	jsr		$1743F4
	jsr		$155DEC
	jsr		$1559EE
	pea		($10).w
	clr.l	-(sp)
	jsr		$14DC36
	move.w	#1,($80D032).l	; 取消當前道具展示
	jsr		$174668
	pea		($5A).w
	jsr		$15EAF8
	lea		$14(sp),sp
	jsr		$14A12C
	clr.b	(ram_0028).l	; 卷軸進度
	move.l	(sp)+,d2
	rts

sub_1753B0:
	movem.l	d2/a2,-(sp)
	moveq	#0,d0
	move.b	(ram_0028).l,d0		; 卷軸進度
	moveq	#3,d1
	cmp.l	d1,d0
	bhi.w	loc_1749F8
	add.l	d0,d0
	move.w	jpt_1753B0(pc,d0.l),d0
	jmp		jpt_1753B0(pc,d0.w)
jpt_1753B0:
	dc.w	loc_1753B0-jpt_1753B0
	dc.w	loc_1753B1-jpt_1753B0
	dc.w	loc_1753B2-jpt_1753B0
	dc.w	loc_1753B3-jpt_1753B0
; 左慈出場[0]
loc_1753B0:
	jsr		$109CC2				; 分配敵人OBJ
	move.l	d0,d2
	clr.l	-(sp)				; 色盤
	pea		(1).w				; 面左
	pea		($FFAB).w			; 豎坐標
	pea		($B4).w				; 縱坐標
	move.w	($D0A000).l,d0
	ext.l	d0
	addi.l	#$1C0+$50,d0		; 橫坐標
	move.l	d0,-(sp)
	pea		($247EB2).l			; 左慈
	move.l	d2,-(sp)
	jsr		$10A1BA				; 敵方出場
	move.l	d2,-(sp)
	jsr		$10F2C2				; 計算敵人OBJ
	move.l	d0,(dword_8168D0).l	; 左慈OBJ
	movea.l d0,a2
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10FC92
	pea		(off_24A4D2).l		; 出場動作指針
	move.l	a2,-(sp)
	jsr		$10EF18				; 寫入動作
	lea		$30(sp),sp
	clr.w	$1DE(a2)
	move.w	#$78,$216(a2)
	move.w	#$708,$218(a2)
	move.w	#1,$A2(a2)			; 無視地形
	bra.w	loc_1753B4
; 左慈進場[1]
loc_1753B1:
	moveq	#0,d0
	move.w	($D0A000).l,d0
	addi.w	#$1C0-$28,d0		; 左慈定點停止飛行
	movea.l	dword_8168D0.l,a2	; 左慈OBJ
	move.w	$20(a2),d1
	cmp.w	d1,d0
	bcs.w	loc_1749F8
	move.w	#$52,$44(a2)		; 下一動作|0201
; 孔明出場
	jsr		$15EC62				; 第一順位角色
	bra.s	loc_187F9C
loc_187F7C:
	movea.l	$58(a2),a0
	cmpi.b	#5,1(a0)			; 是否孔明
	bne.s	loc_187F92
	addq.b	#1,(ram_0028).l		; 下一進度
	bra.w	loc_1753B4			; 下一進度+
loc_187F92:
	move.l	a2,-(sp)
	jsr		$15EC88				; 下一順位角色
	addq.l	#4,sp
loc_187F9C:
	movea.l	d0,a2
	move.l	a2,d0
	bne.s	loc_187F7C
	jsr		sub_188570			; 機關孔明出場
	bra.w	loc_1753B4
; 孔明中間[2]
loc_1753B2:
	jsr		$1885D8				; 是否行至中間
	tst.l	d0
	beq.w	loc_1749F8
	jsr		$1885EA				; 孔明停於中間
	bra.w	loc_1753B4			; 下一進度
; 左慈對話[3]
loc_1753B3:
	pea		($12D).w		; 「先生止步，貧道於西川嘉陵峨嵋山中，學道三十年，騰雲跨風，穿山透石，藏形變身，無所不能。」
	pea		($15).w			; 左慈說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	pea		($12E).w		; 「先生雖位極人臣，然大道為先，何不退步，隨貧道往峨嵋山中修行？當以仙術相授。」
	pea		($15).w			; 左慈說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	pea		($12F).w		; 「亮本南陽一布衣，蒙受吾主三顧之恩，遂許以驅馳。今天下未定，安肯棄之而去乎？」
	pea		(5).w			; 孔明說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	pea		($130).w		; 「汝不知天命，猶欲抗拒，須教你知我道法莫測。斗轉星旋，地轉星移。開！！！」
	pea		($15).w			; 左慈說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
; 左慈施法
	pea		(off_24D0D2).l		; 駕鶴落地
	movea.l	dword_8168D0.l,a2	; 左慈OBJ
	move.l	a2,-(sp)
	jsr		$10EF18				; 寫入動作
	addq.l  #8,sp
	pea		($13A646).l
	pea		($50).w				; 1秒半主循環
	jsr		($100EA4).l
	addq.l  #8,sp
; 白屏特效
	clr.l	-(sp)
	jsr		$104580				; 白屏暈開
	pea		($13A646).l
	pea		($3C).w				; 1秒延時白屏
	jsr		($100EA4).l
	lea		$C(sp),sp
	moveq	#3,d0				; 直接進入下一場景
	bra.s	locret_1753B0
loc_1753B4:
	addq.b	#1,(ram_0028).l		; 下一進度
loc_1749F8:
	moveq	#0,d0		
locret_1753B0:
	movem.l	(sp)+,d2/a2
	rts

off_24D0D2:	; 駕鶴落地施法
	dc.w	$0101
	dc.l	dword_24CA34,$02000800,0,0
dword_24CA34:
	dc.l	$00080228
	dc.l	$F0030000,$00080204
	dc.l	$F0020600,$00090000
	dc.l	$F0020600,$000A0000
	dc.l	$F0020600,$000B0000
	dc.l	$F0020600,$000C0000
	dc.l	$F00BFF00,$01AC0000
	dc.l	$F0280200
	dc.l	$F0020600,$000D0000
	dc.l	$F0020600,$000E0000
	dc.l	$F0290000
	dc.l	$F0140343,$0000FF80	; 閃光
	dc.l	$F00B7F00,$02870000
	dc.l	$F00B7F00,$02D50000
	dc.l	$F0020600,$000D0000	; 循環
	dc.l	$F0020600,$000E0000
	dc.l	$F0011900

sub_188570:	; 機關孔明出場
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($BE).w			; 縱坐標
	clr.l	-(sp)			; 橫坐標
	pea		($2901D4).l		; 機關孔明
	jsr		$1517D4			; 佈置機關
	lea		$14(sp),sp
	move.l	d0,($81AC1C).l	; 機關孔明OBJ
	movea.l	d0,a0
	clr.w	$D2(a0)
	movea.l	$81AC1C.l,a0
	move.l	#$26C04C,$2C(a0)
	movea.l	$81AC1C.l,a0
	clr.w	$3C(a0)
	movea.l	$81AC1C.l,a0
	clr.w	$54(a0)
	clr.b	($81AC20).l		; 機關孔明坐標點
	movea.l	$81AC1C.l,a0
	clr.l	$78(a0)
	movea.l	$81AC1C.l,a0
	move.w	#3,$6C(a0)
	rts

sub_1747FE:	; 序章進場動作
	move.l	d2,-(sp)
	movea.l	8(sp),a1
	movea.l	$F8(a1),a0
	move.b	1(a0),d2
	andi.l	#$FF,d2
	pea		($13).w
	pea		(1).w
	clr.l	-(sp)
	clr.l	-(sp)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#2,d0
	add.w	d1,d0
	lsl.w	#2,d0
	addi.w	#$A0,d0		; 縱坐標偏移量
	move.l	d0,-(sp)
	move.w	d2,d0
	move.w	d0,d1
	lsl.w	#5,d0		; 按位計算距離
	add.w	d1,d0
	move.w	#$FF60,d1	; 橫坐標偏移量
	sub.w	d0,d1
	move.l	d1,-(sp)
	move.l	a1,-(sp)
	jsr		$15CD32		; 開始動作
	lea		$1C(sp),sp
	move.l	(sp)+,d2
	rts

sub_175426:	; 序章切換場景|隨機初始化
; 遊戲難度對應傷害
	moveq	#0,d0
	move.b	($803B82).l,d0		; 難度等級
	lsl.w	#5,d0
	movea.l	#$2B441A,a2			; 各難度傷害表
	lea		(a2,d0.w),a2
	move.l	a2,($8186BC).l		; 難度傷害設定
; 隨機敵將隨機場景
	jsr		sub_2B3D36			; 隨機敵將
	tst.b	(ram_0004).l		; 開局是否隨機場景
	beq.s	loc_175426
	moveq	#0,d0
	move.b	(ram_0004).l,d0		; 選定的場景序號
	subq.l	#1,d0
	movea.l	#(ram_0013+2),a2	; 場景標記寄存
	adda.l	d0,a2				; 固定場景號
	move.w	d0,(ram_0013).l		; 下一固定場景序號
	move.b	#1,(a2)				; 標記已出場景
	movea.l	#unk_1465E6,a2		; 關卡表
	lsl.l	#$1,d0
	adda.l	d0,a2				; 下一場景值
	move.b	(a2),($8182F9).l	; 下一章節序號
	move.b	1(a2),($8182F8).l	; 下一場景臨時
	bra.s	locret_175426
loc_175426:
	jsr		sub_1465E6			; 隨機場景
	move.b	($8182FA).l,($8182F8).l	; 寫入場景臨時
locret_175426:
	rts


sub_145F3A:
	move.b	($8182F9).l,d0	; 當前章節
	or.b	($8182FA).l,d0	; 當前場景
	bne.s	loc_145F4C
	moveq	#1,d0
	bra.s	locret_145F4E
loc_145F4C:
	moveq	#0,d0
; 是否序章[0003]
	tst.b	($8182F9).l
	bne.s	locret_145F4E
	cmpi.b	#3,($8182FA).l
	bne.s	locret_145F4E
	moveq	#1,d0
locret_145F4E:
	rts


NewChief:	; 新增魔王
	dc.l	unk_23B38A	; 真呂布

unk_23B38A:	; 真呂布指針
	dc.b	1				; 人物類型[01]敵將
	dc.b	$A				; 人物ID
	dc.l	$20000000		; 特征碼
	dcb.l	4,nullsub
	dc.l	off_23AD36		; 動作指針
	dc.l	$23ACCA			; 被打指針|圖片編號|$15ADAE|格擋等
	dc.l	nullsub
	dc.l	$23AD2A,0		; 03類動作攻擊力
	dc.l	$23AD32,0		; 06類動作攻擊力
	dc.l	off_23ACC2		; 人物顏色
	dcb.l	2,0
	dc.l	$35A298			; 圖片坐標
	dc.l	$23AC7A			; 判定索引
	dc.l	$23AC7E			; 判定信息
	dc.l	$23AC80			; 圖片基址
	dc.l	$35A2B2			; 人物影子
	dc.l	$3BE6A1			; 圖片基址
	dc.w	0,$15,0,0,0,0,0,0,$4E20, $199,0,$198,0	; 死亡音頻編號|$68()=199
	dc.l	$23AD7E			; 格擋率|0011A86A
	dc.l	$1E5166			; 06類攻擊對呂布的加成
	dc.b	0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.l	off_23AC8A		; 受擊強反|0010D15C|F0510000
	dc.b	0,0,0,0,0,$8C,$10,0
	dc.l	$2B5BA4,$23AE82
	dc.w	$10
	dc.l	$23B332
	dc.l	word_23AF2A		; 攻擊表
	dc.w	$20				; 指針結尾

off_23AD36:	; 動作指針
	dc.l	$23B570		; 00類動作|等待
	dc.l	$23B76C		; 01類動作|開始
	dc.l	$23BB92		; 02類動作|移動
	dc.l	word_23D128	; 03類動作|攻擊
	dcb.l	2,0
	dc.l	$23D420		; 06類動作|擊殺
	dc.l	$23D4D4		; 07類動作|被打狀態
	dc.l	word_23BF2C	; 08類動作|受擊
	dc.l	$23C19E		; 09類動作|勝利
	dcb.l	2,0

off_23ACC2:	; 人物顏色
	dcb.l	2,word_38BA6C
word_38BA6C:	; 真呂布色盤
	dc.w	$0040,$25F4,$0002,$0044,$0487,$0CEB,$1570,$0467
	dc.w	$1886,$34C5,$5104,$7120,$3129,$4A2F,$6335,$7FFB
	dc.w	$6DA4,$7E85,$7F80,$30C2,$49A8,$628F,$7F74,$0062
	dc.w	$10A7,$20EC,$3531,$4A2F,$6335,$7FFB,$7C00,$0000

word_388A6C:	; 真呂布毒屬性色盤
	dc.w	$0040,$25F4,$0002,$0044,$0487,$0CEB,$1570,$0467
	dc.w	$1886,$34C5,$5104,$7120,$3129,$4A2F,$6335,$7FFB
	dc.w	$6DA4,$7E85,$7F80,$1CEE,$4194,$6635,$7ED6,$0062
	dc.w	$10A7,$20EC,$3531,$4A2F,$6335,$7FFB,$7C00,$0000

word_23D128:	; 03類動作
	dc.w	$0300	; 撥雲見日
	dc.l	unk_23E0E2,$01002240,0,0
	dc.w	$0301	; 三步殺人
	dc.l	unk_23C700,$01001240,0,0	; [12]快拳
	dc.w	$0302	; 黑虎掏心
	dc.l	$0023D200,$01002240,$10000000,0
	dc.w	$0303	; 白虎穿雲
	dc.l	unk_27A41A,$02000240,0,0	; [02]空中
	dc.w	$0304	; 雷奔云譎
	dc.l	unk_23CA78,$01000240,0,0
	dc.w	$0305	; 雷動虎行
	dc.l	unk_23CD48,$01000240,0,0
	dc.w	$0306	; 晴天霹靂
	dc.l	unk_27AA32,$01002240,0,0
	dc.w	$0307	; 霸氣無雙
	dc.l	$0023D078,$01002240,0,0
	dc.w	$0308	; 六甲奇門
	dc.l	unk_27ABE2,$01002240,0,0
	dc.w	$0309	; 飛砂走石
	dc.l	unk_27BA42,$01002240,0,0
	dc.w	$030A	; 調兵遣將|武神
	dc.l	unk_11CE50,$01002240,0,0
	dc.w	$030B	; 調兵遣將|鬼卒
	dc.l	unk_11CE50,$01002240,0,0
	dc.w	$030C	; 雲合影從
	dc.l	dword_23CA78,$01000240,0,0
	dc.w	$030D	; 十里荊棘
	dc.l	dword_27BD72,$02000000,0,0
	dc.w	$030E	; 起身掏心
	dc.l	$0023D200,$01000240,0,0
	dc.w	$030F	; 起身召神
	dc.l	dowrd_11CE50,$01001240,0,0
	dc.w	$0310	; 起身出洞
	dc.l	dword_23CD48,$01000240,0,0

word_23BF2C:	; 08類動作|受擊
	dc.w	$0800
	dc.l	$0036F500,$01001001,0,0
	dc.w	$0801
	dc.l	$0036F52C,$01001001,0,0
	dc.w	$0802
	dc.l	$0036F57C,$02000001,0,0
	dc.w	$0803
	dc.l	$0036F61C,$02000001,0,0
	dc.w	$0804
	dc.l	$0036F6CC,$02000001,0,0
	dc.w	$0805
	dc.l	dword_23BD78,$01003800,0,0
	dc.w	$0806
	dc.l	$0036F57C,$02000001,0,0
	dc.w	$0807
	dc.l	$0036F57C,$02000001,0,0
	dc.w	$0808
	dc.l	$0036F8B0,$02000001,0,0
	dc.w	$0809
	dc.l	$0036F91C,$02000001,0,0
	dc.w	$080A
	dc.l	$0036FF34,$01001001,0,0
	dc.w	$080B
	dc.l	$0036FF60,$01001001,0,0
	dc.w	$080C
	dc.l	$0036FADC,$02000001,0,0
	dc.w	$080D
	dc.l	$0036FB7C,$02000001,0,0
	dc.w	$080E
	dc.l	$0036FC2C,$02000001,0,0
	dc.w	$080F
	dc.l	dword_23BD78,$01003800,0,0
	dc.w	$0810
	dc.l	$0036FADC,$02000001,0,0
	dc.w	$0811
	dc.l	$0036FADC,$02000001,0,0
	dc.w	$0812
	dc.l	$0036FDA4,$02000001,0,0
	dc.w	$0813
	dc.l	$0036FE10,$02000001,0,0
	dc.w	$0814
	dc.l	$0023BDDC,$02000800,0,0
	dc.w	$0815
	dc.l	$0023BE9C,$01000000,0,0
	dc.w	$0816
	dc.l	$0023BEE0,$01000000,0,0
	dc.w	$0817,0,0,0,0,0,0,0,0
	dc.w	$0818
	dc.l	$0036F558,$01001001,0,0
	dc.w	$0819,0,0,0,0,0,0,0,0
	dc.w	$081A
	dc.l	$0036F78C,$01000001,0,0
	dc.w	$081B
	dc.l	$0036FC80,$01000001,0,0
	dc.w	$081C
	dc.l	$0036FAB8,$01001001,0,0
	dc.w	$081D
	dc.l	$0036F57C,$02000001,0,0
	dc.w	$081E
	dc.l	$0036FADC,$02000001,0,0

off_23AC8A:	; 受擊強反
	dcb.l	5,sub_16C8DA
	dcb.l	9,0
sub_16C8DA:
	movem.l	d2/a2,-(sp)
	movea.l	$C(sp),a2
; 是否強反
	move.l	a2,-(sp)
	jsr		$12022E
	addq.l	#4,sp
	tst.l	d0
	bne.w	loc_16C9D2
	jsr		$10F538
	tst.l	d0
	bne.w	loc_16C9D2
	move.l	a2,-(sp)
	jsr		$11014A
	addq.l	#4,sp
	tst.l	d0
	bne.w	loc_16C9D2
	jsr		$14D960			; 難度傷害等級
	asr.l	#2,d0			; 0-3
	move.w	d0,d2
	move.l	a2,-(sp)
	jsr		$10F786			; 當前受擊段數
	addq.l	#4,sp
	move.w	d2,d1
	add.w	d1,d1
	movea.l	#word_23AD66,a0 ; 各難度強反時的受擊段數
	move.w	(a0,d1.w),d1
	andi.l	#$FFFF,d1
	cmp.l	d1,d0
	blt.s	loc_16C9D2
	pea		($3FF).w
	jsr		$1024B0			; 小隨機
	addq.l	#4,sp
	move.w	d2,d1
	add.w	d1,d1
	movea.l	#word_23AD76,a0	; 各難度強反時的閾值
	move.w	(a0,d1.w),d1
	andi.l	#$FFFF,d1
	cmp.l	d1,d0
	bge.s	loc_16C9D2
; 強反招式
	pea		($7F).w
	jsr		$1024B0			; 小隨機
	addq.l	#4,sp
	andi.l	#7,d0			; 0-7
	move.l	d0,-(sp)		; 動作編號
	pea		(3).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10F796
	lea		$1C(sp),sp
loc_16C9D2:
	movem.l	(sp)+,d2/a2
	rts
word_23AD66: ; 各難度強反時的受擊段數
	dc.w	6,5,4,3
word_23AD76: ; 各難度強反時的閾值
	dc.w	$C0, $140, $300, $340

word_23AF2A:	; 攻擊表
	*		動作編號|-|橫坐標範圍|-|縱坐標範圍|-|是否觸發續招|00110E20
	dc.w	0,$0304, $0000,$0096, $0000,$0006,  0
	*		續招內容 條件$B8(OBJ)=0001|-|續招的難度下限 長度.w|-|跳轉子程序
	dc.l	0,0,0
	dc.w	0,$030A, $0000,$0096, $0008,$0064,  1
	dc.l	word_23AF10,0,0
	dc.w	0,$0301, $000A,$0136, $0000,$0006,  0
	dc.l	0,0,0
	dc.w	0,$0304, $012C,$01F4, $0004,$0010,  0
	dc.l	0,0,0
	dc.w	0,$0307, $0000,$0096, $0000,$0008,  0
	dc.l	0,0,0
	dc.w	0,$0309, $012C,$01F4, $0000,$0006,  0
	dc.l	0,0,0
	dc.w	0,$0300, $0000,$007D, $0000,$0008,  0
	dc.l	0,0,0
	dc.w	0,$0302, $000A,$0136, $0000,$0006,  1
	dc.l	word_23AEDC,0,0
	dc.w	0,$030D, $00C8,$01C2, $0008,$0064,  0
	dc.l	0,0,0
	dc.w	0,$0301, $000A,$00B4, $0000,$0007,  1
	dc.l	word_23AEC2,0,0
	dc.w	0,$0301, $0000,$00FA, $0000,$0007,  0
	dc.l	0,0,0
	dc.w	0,$0309, $00C8,$01C2, $0008,$0064,  0
	dc.l	0,0,0
	dc.w	0,$0302, $0000,$007D, $0000,$0008,  0
	dc.l	0,0,0
	dc.w	0,$030C, $0028,$00FA, $0000,$0006,  0
	dc.l	0,0,0
	dc.w	0,$0304, $0000,$00FA, $0000,$0007,  1
	dc.l	word_23AEF6,0,0
	dc.w	0,$0305, $0000,$0096, $0000,$0006,  0
	dc.l	0,0,0
	dc.w	0,$0308, $0000,$0096, $0008,$0064,  1
	dc.l	word_23AF10,0,0
	dc.w	0,$0303, $000A,$0136, $0000,$0006,  0
	dc.l	0,0,0
	dc.w	0,$0305, $012C,$01F4, $0004,$0010,  0
	dc.l	0,0,0
	dc.w	0,$0308, $0032,$00C8, $0000,$0008,  0
	dc.l	0,0,0
	dc.w	0,$0306, $000A,$0136, $0000,$0006,  1
	dc.l	word_23AEDC,0,0
	dc.w	0,$030D, $012C,$01F4, $0000,$0006,  0
	dc.l	0,0,0
	dc.w	0,$0307, $0000,$007D, $0000,$0008,  0
	dc.l	0,0,0
	dc.w	0,$030C, $00C8,$01C2, $0008,$0064,  0
	dc.l	0,0,0
	dc.w	0,$0302, $000A,$00B4, $0000,$0007,  1
	dc.l	word_23AEC2,0,0
	dc.w	0,$030D, $0028,$00FA, $0000,$0007,  0
	dc.l	0,0,0
	dc.w	0,$0306, $0064,$00C8, $0008,$0064,  0
	dc.l	0,0,0
	dc.w	0,$0308, $0000,$007D, $0000,$0008,  0
	dc.l	0,0,0
	dc.w	0,$0302, $0028,$00FA, $0000,$0006,  0
	dc.l	0,0,0
	dc.w	0,$0305, $0000,$00FA, $0000,$0007,  1
	dc.l	word_23AEF6,0,0
	dc.w	0,$0308, $000A,$0096, $0000,$0006,  0
	dc.l	0,0,0
	dc.w	0,$0308, $0000,$0096, $0000,$0008,  0
	dc.l	0,0,0
word_23AEC2:
	dc.w	0,$0301,0,0,0,0,0
	dc.l	0,0,0
word_23AEDC:
	dc.w	0,$0303,0,0,0,0,0
	dc.l	0,0,0
word_23AEF6:
	dc.w	0,$0307,0,0,0,0,0
	dc.l	0,0,0
word_23AF10:
	dc.w	0,$0306,0,0,0,0,0
	dc.l	0,0,0

unk_23E0E2:	; 撥雲見日
	dc.l	$F0540600
	dc.l	$F04F060E
	dc.l	$F0550000
	dc.l	$F0580100
	dc.l	$F0020200,$00A20000	; 挑來
	dc.l	$F00B9F00,$02C30000,$20A30000,$20A30000
	dc.l	$F0330100
	dc.l	$F0340004,$00A50000,$00000000,$20A40000
	dc.l	$F0340004,$00A70000,$00000000,$00A60000
	dc.l	$F0340004,$00A80000,$00000000,$00A60000
	dc.l	$F0330000
	dc.l	$F0450300	; 撥去
	dc.l	$F0020200,$00A90000
	dc.l	$F05E0100
	dc.l	$F0020300,$20AA0000
	dc.l	$F00B9F00,$02C30000
	dc.l	$F0330100
	dc.l	$F0340004,$00AC0000,$00000000,$20AB0000
	dc.l	$F0340004,$00AD0000,$00000000,$20AB0000
	dc.l	$F0330000
	dc.l	$F0020200,$00AE0000
	dc.l	$F0020200,$00AF0000
	dc.l	$F05E0000
	dc.l	$F0020200,$00B00000
	dc.l	$80000000

unk_23C700:	; 三步殺人
	dc.l	$F0540600
	dc.l	$F0410100
	dc.l	$F04F1100
	dc.l	$F05E0100
	dc.l	$F00B9F00,$02C20000
	dc.l	$F0020100,$203E0000
	dc.l	$F0020300,$203F0000
	dc.l	$F0020100,$00400000
	dc.l	$F00B9F00,$02C20000
	dc.l	$F0410100,$204140FB,$20410000
	dc.l	$F0020300,$20420000
	dc.l	$F0020200,$00430000
	dc.l	$F0410100
	dc.l	$F00B9F00,$02C30000
	dc.l	$F04F060E,$20440E06,$20440000
	dc.l	$F0450200
	dc.l	$F0330100
	dc.l	$F0340004,$00460000,$00000000,$20450000
	dc.l	$F0340004,$00460000,$00000000,$20450000
	dc.l	$F0340004,$00480000,$00000000,$00470000
	dc.l	$F0340004,$00490000,$00000000,$00470000
	dc.l	$F0330000,$004A33FF
	dc.l	$F0020200,$004A0000
	dc.l	$F0450300
	dc.l	$F04F270D
	dc.l	$F0410100
	dc.l	$F00B9F00,$02C30000,$204B2001,$204B0000
	dc.l	$F0330100
	dc.l	$F0340004,$004D0000,$00000000,$204C0000
	dc.l	$F0340004,$004E0000,$00000000,$204C0000
	dc.l	$F0330000
	dc.l	$F0020200,$004F0000
	dc.l	$F0020200,$00500000
	dc.l	$F0020200,$00510000
	dc.l	$80000000

unk_27A41A:	; 白虎穿雲
	dc.l	$F0540800
	dc.l	$F04F0612
	dc.l	$F0450700
	dc.l	$F0020400,$00520000
	dc.l	$205305F9,$205305F9,$205305F9,$205305FA,$205305FA
	dc.l	$F00BFF00,$01950000
	dc.l	$F05E0100
	dc.l	$205405FA,$205405FC,$205505FC,$205505FC
	dc.l	$205605FD,$205605FD,$205605FD,$005705FF
	dc.l	$005705FF,$00570502,$00570504,$00570504,$00570505,$00570505
	dc.l	$F05E0000
	dc.l	$F05C0400
	dc.l	$F0410100
	dc.l	$F0330100
	dc.l	$F0340004,$00590000,$00050500,$20580505
	dc.l	$F0340004,$00590000,$00050600,$20580506
	dc.l	$F0340004,$00590000,$00050600,$20580506
	dc.l	$F0340004,$005B0000,$00050600,$005A0506
	dc.l	$F0340004,$005B0000,$00050800,$005A0508
	dc.l	$F0340004,$005B0000,$00050800,$005A0508
	dc.l	$F00BBF00,$00D10000
	dc.l	$F0140009,$00000100
	dc.l	$F0340004,$005D0000,$00000000
	dc.l	$F0020200,$005C0000
	dc.l	$F0340004,$005F0000,$00000000
	dc.l	$F0020200,$005E0000
	dc.l	$F0340004,$00610000,$00000000,$00600000
	dc.l	$F0340004,$00620000,$00000000,$00600000
	dc.l	$F0340004,$00610000,$00000000,$00600000
	dc.l	$F0340004,$00640000,$00000000,$00630000
	dc.l	$F0340004,$00650000,$00000000,$00630000
	dc.l	$F0340004,$00640000,$00000000,$00630000
	dc.l	$F0340004,$00670000,$00000000,$00660000
	dc.l	$F0340004,$00680000,$00000000,$00660000
	dc.l	$F0340004,$00670000,$00000000,$00660000
	dc.l	$F0340004,$00680000,$00000000,$00660000
	dc.l	$F0340004,$00690000,$00000000,$00660000
	dc.l	$F0340004,$006A0000,$00000000,$00660000
	dc.l	$F0330000
	dc.l	$F0030000,$006B0008
	dc.l	$F0020600,$006B0000
	dc.l	$80000000

unk_27AA32:	; 晴天霹靂
	dc.l	$F0540A00
	dc.l	$F0020200,$006C0000
	dc.l	$F00BFF00,$01960000
	dc.l	$F0130100
	dc.l	$F0020200,$006D0000
	dc.l	$F0130000
	dc.l	$F061FE00,off_27A9BE,$00000000
	dc.l	$F0280200
	dc.l	$F0020200,$006E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0290000
	dc.l	$80000000
off_27A9BE:	; 霹靂三雷
	dc.l	dword_27A992,$001C9D96,$001CA74E,$001CAA74
	dc.l	$00319D02,$00587F33,$07090420,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000,0
dword_27A992:
	dc.l	$F0070000,sub_182968
	dc.l	$F0020C00,$40000000
	dc.l	$F0070001,sub_182968
	dc.l	$F0020C00,$40000000
	dc.l	$F0070002,sub_182968
	dc.l	$80000000

sub_182968:	; 三道雷電
	link	a6,#-4
	movem.l	d2-d3/a2-a4,-(sp)
	movea.l	8(a6),a4
	tst.b	$F(a6)
	bne.w	loc_182A32
	moveq	#0,d2
loc_18297E:
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#dword_816052,a0
	clr.l	(a0,d0.w)
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_18297E
	moveq	#0,d2
	jsr		$15EC62		; 第一順位角色OBJ
	bra.w	loc_182A28
loc_1829A0:
	moveq	#0,d3
	move.w	$50(a2),d3
	moveq	#0,d0
	move.w	$52(a2),d0
	move.l	d0,-4(a6)
	moveq	#$A,d0
	cmp.l	d3,d0
	beq.s	loc_182A1E
	moveq	#$B,d0
	cmp.l	d3,d0
	beq.s	loc_182A1E
	jsr		$14DF94		; 分配機關OBJ
	movea.l	d0,a3
	pea		($1).w
	clr.l	-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$10,d0
	move.l	d0,-(sp)
	pea		($23CE60).l	; 雷電一
	move.l	a3,-(sp)
	jsr		$14E076		; 設定機關
	lea		$18(sp),sp
	move.l	$78(a4),$78(a3)
	move.w	#2,$6C(a3)
	tst.l	$78(a4)
	beq.s	loc_182A0E
	movea.l	$78(a4),a0
	move.l	$58(a0),$7C(a3)
loc_182A0E:
	move.l	d2,d0
	addq.l	#1,d2
	lsl.w	#2,d0
	movea.l	#dword_816052,a0
	move.l	a2,(a0,d0.w)
loc_182A1E:
	move.l	a2,-(sp)
	jsr		$15EC88		; 下一順位角色OBJ
	addq.l	#4,sp
loc_182A28:
	movea.l	d0,a2
	move.l	a2,d0
	bne.w	loc_1829A0
	bra.s	loc_182AA0
loc_182A32:
	moveq	#0,d2
loc_182A34:
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#dword_816052,a0
	movea.l	(a0,d0.w),a2
	move.l	a2,d0
	beq.s	loc_182A98
	jsr		$14DF94		; 分配機關OBJ
	movea.l	d0,a3
	pea		($1).w
	clr.l	-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$10,d0
	move.l	d0,-(sp)
	pea		($23CE60).l	; 雷電二
	move.l	a3,-(sp)
	jsr		$14E076		; 設定機關
	lea		$18(sp),sp
	move.l	$78(a4),$78(a3)
	move.w	#2,$6C(a3)
	tst.l	$78(a4)
	beq.s	loc_182A98
	movea.l	$78(a4),a0
	move.l	$58(a0),$7C(a3)
loc_182A98:
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_182A34
loc_182AA0:
	movem.l	-$18(a6),d2-d3/a2-a4
	unlk	a6
	rts

unk_23CD48:	; 雷動虎行
	dc.l	$F0540800
	dc.l	$F04F0612
	dc.l	$F0450700
	dc.l	$F0020200,$006C0000
	dc.l	$F00BFF00,$01960000
	dc.l	$F0130100
	dc.l	$F0020200,$006D0000
	dc.l	$F0130000
	dc.l	$F0070000,$0016CD94	; 雷電
	dc.l	$F0280200
	dc.l	$F0020200,$006E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0290000
	dc.l	$F05E0100	; 正向閃現
	dc.l	$F00BFF00,$019B0000
	dc.l	$F0020200,$00700000
	dc.l	$F0020200,$00710000
	dc.l	$F00B9F00,$02CD0000
	dc.l	$00720000,$00740000,$00760000,$00780000,$007A0000
	dc.l	$F05E0000
	dc.l	$F0130100
	dc.l	$F0280300
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0290000
	dc.l	$F0070000,$0016CCF6,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76
	dc.l	$F0110000,$40579C00,$40579C00
	dc.l	$F0040602	; 黑虎出洞
	
unk_23CA78:	; 雷奔云譎
	dc.l	$F0540800
	dc.l	$F04F0612
	dc.l	$F0450700
	dc.l	$F0020200,$006C0000
	dc.l	$F00BFF00,$01960000
	dc.l	$F0130100
	dc.l	$F0020200,$006D0000
	dc.l	$F0130000
	dc.l	$F0070000,$0016CD94	; 雷電
	dc.l	$F0280200
	dc.l	$F0020200,$006E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0290000
	dc.l	$F05E0100	; 反向閃現
	dc.l	$F00BFF00,$019B0000
	dc.l	$F0020200,$00700000
	dc.l	$F0020200,$00710000
	dc.l	$F00B9F00,$02CD0000,$00720000,$00740000,$00760000,$00780000,$007A0000
	dc.l	$F05E0000
	dc.l	$F0130100
	dc.l	$F0280300
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0290000
	dc.l	$F0070000,$0016CCF6,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76
	dc.l	$F02B0100	; 空中動作0010C594
	dc.l	$40579CC1,$4057CE00,$00570301,$00570301
	dc.l	$40570301,$40570302,$00570302,$00570302
	dc.l	$40570303,$40570303,$00570303,$00570304
	dc.l	$40570304,$40570304
	dc.l	$F0130000
	dc.l	$F05E0100	; 白虎穿雲
	dc.l	$F05C0600	; 電屬性
	dc.l	$F0410100
	dc.l	$F0330100
	dc.l	$F0340004,$00590000,$00030500,$20580305
	dc.l	$F0340004,$00590000,$00030500,$20580305
	dc.l	$F0340004,$00590000,$00030500,$20580305
	dc.l	$F0340004,$005B0000,$00030600,$005A0306
	dc.l	$F0340004,$005B0000,$00030600,$005A0306
	dc.l	$F0340004,$005B0000,$00030600,$005A0306
	dc.l	$F00BBF00,$00D10000
	dc.l	$F0140009,$00000100
	dc.l	$F05E0000
	dc.l	$F0340004,$005D0000,$00000000
	dc.l	$F0020200,$005C0000
	dc.l	$F0340004,$005F0000,$00000000
	dc.l	$F0020200,$005E0000
	dc.l	$F0340004,$00610000,$00000000,$00600000
	dc.l	$F0340004,$00620000,$00000000,$00600000
	dc.l	$F0340004,$00610000,$00000000,$00600000
	dc.l	$F0340004,$00640000,$00000000,$00630000
	dc.l	$F0340004,$00650000,$00000000,$00630000
	dc.l	$F0340004,$00640000,$00000000,$00630000
	dc.l	$F0340004,$00670000,$00000000,$00660000
	dc.l	$F0340004,$00680000,$00000000,$00660000
	dc.l	$F0340004,$00670000,$00000000,$00660000
	dc.l	$F0340004,$00680000,$00000000,$00660000
	dc.l	$F0340004,$00690000,$00000000,$00660000
	dc.l	$F0340004,$006A0000,$00000000,$00660000
	dc.l	$F0330000
	dc.l	$F0030000,$006B000C
	dc.l	$F0020400,$006B0000
	dc.l	$80000000

unk_27ABE2:	; 六甲奇門
	dc.l	$F0540A00
	dc.l	$F04F060D
	dc.l	$F0450300
	dc.l	$F0130100
	dc.l	$F00BFF00,$019B0000
	dc.l	$F0020400,$00700000
	dc.l	$F00BFF00,$019B0000
	dc.l	$F00BDF00,$00D10FA0
	dc.l	$F015FE00,off_2BCF9A,$0020F100
	dc.l	$F01000FD,$00710000
	dc.l	$F0100003
	dc.l	$F015FE00,off_2BCF9A,$00640000,$00710000
	dc.l	$F00BDF00,$00D10FA0
	dc.l	$F015FE00,off_2BCF9A,$00360F00
	dc.l	$F0130000
	dc.l	$F05E0100
	dc.l	$F00B9F00,$02CD0000
	dc.l	$F0330100
	dc.l	$F01000FE
	dc.l	$F0340004,$00730000,$00000000,$00720000
	dc.l	$F0100002
	dc.l	$F00BDF00,$00D10FA0
	dc.l	$F015FE01,off_2BCF9A,$FFCA0F00
	dc.l	$F0340004,$00750000,$00000000,$00740000
	dc.l	$F015FE01,off_2BCF9A,$FF9C0000
	dc.l	$F01000FF
	dc.l	$F0340004,$00770000,$00000000,$00760000
	dc.l	$F0100001
	dc.l	$F015FE01,off_2BCF9A,$FFE0F100
	dc.l	$F0340004,$00790000,$00000000,$00780000
	dc.l	$F0340004,$007B0000,$00000000,$007A0000
	dc.l	$F0330000
	dc.l	$F0020200,$007C0000
	dc.l	$F05E0000
	dc.l	$80000000
off_2BCF9A:	; 地刺機關
	dc.l	dword_2BCF4A,$00274AA0,$00274AA4,$00274AA6
	dc.l	$003410D4,$0017A75B,$070D0420,$00000000
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000308	; 編號0308
	dc.l	$00000000,$00000000,$00000000,sub_1930DA
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00001C00,$00000000,0
dword_2BCF4A:
	dc.l	$20C80000,$00C90000,$20CA0000,$00CB0000,$20CC0000,$00CD0000
	dc.l	$F0410100
	dc.l	$F0020600,$20CE0000,$00CF0000,$00D00000,$00D10000,$00D20000,$00D30000,$00D40000,$00D50000,$00D60000,$00D70000,$00D80000
	dc.l	$80000000
sub_1930DA:	; 受擊動作
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	movea.l	$C(sp),a1
	movea.l	$54(a2),a0
	tst.b	(a0)
	bne.s	loc_19311A
	move.w	$C8(a2),d0
	cmp.w	$5C(a1),d0
	beq.s	loc_193108
	pea		($1D).w
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$15E152
	bra.s	loc_19313A
loc_193108:
	pea		($1E).w
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$15E152
	bra.s	loc_19313A
loc_19311A:
	move.w	$C8(a2),d0
	cmp.w	$5C(a1),d0
	beq.s	loc_19312A
	pea		($1D).w
	bra.s	loc_19312E
loc_19312A:
	pea		($1E).w
loc_19312E:
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$10EBDE
loc_19313A:
	lea		$C(sp),sp
	movea.l	(sp)+,a2
	rts

unk_27BA42:	; 飛砂走石
	dc.l	$F0130100
	dc.l	$F0020200,$00700000
	dc.l	$F0070000,sub_182E06	; 陰暗背景
	dc.l	$F00BBF00,$027DF448
	dc.l	$F0280900
	dc.l	$F01000FE,$00700000
	dc.l	$F0100002,$00700000
	dc.l	$F0290000
	dc.l	$F00BFF00,$019B0000
	dc.l	$F0020200,$00710000
	dc.l	$F00B9F00,$02CD0000
	dc.l	$F061FE00,$0023CF50,$0017FFDD	; 身後冰焰
	dc.l	$F061FE00,$0023CF50,$0000FF00	; 身後冰焰
	dc.l	$F0330100
	dc.l	$F0340004,$00730000,$00000000,$00720000
	dc.l	$F0340004,$00750000,$00000000,$00740000
	dc.l	$F0340004,$00770000,$00000000,$00760000
	dc.l	$F0340004,$00790000,$00000000,$00780000
	dc.l	$F0340004,$007B0000,$00000000,$007A0000
	dc.l	$F0330000
	dc.l	$F00E0100
	dc.l	$F01000FE
	dc.l	$F0070000,sub_182AE8,$000E0000
	dc.l	$F0070000,sub_182C58
	dc.l	$F0100002
	dc.l	$F0070001,sub_182AE8,$000E0000
	dc.l	$F01000FE
	dc.l	$F0070002,sub_182AE8,$000F0000
	dc.l	$F0100002
	dc.l	$F0070003,sub_182AE8,$000F0000
	dc.l	$F0070000,sub_182C58
	dc.l	$F00B7F00,$02C5FE0C
	dc.l	$F01000FE
	dc.l	$F0070004,sub_182AE8,$00100000
	dc.l	$F0100002
	dc.l	$F0070005,sub_182AE8,$00100000
	dc.l	$F01000FE
	dc.l	$F0070006,sub_182AE8,$00110000
	dc.l	$F0100002
	dc.l	$F0070007,sub_182AE8,$00110000
	dc.l	$F0070000,sub_182C58
	dc.l	$F01000FE
	dc.l	$F0070008,sub_182AE8,$000E0000
	dc.l	$F0100002
	dc.l	$F0070009,sub_182AE8,$000E0000
	dc.l	$F01000FE
	dc.l	$F007000A,sub_182AE8,$000F0000
	dc.l	$F00BBF00,$02C5FE0C
	dc.l	$F0100002
	dc.l	$F007000B,sub_182AE8,$000F0000
	dc.l	$F0070000,sub_182C58
	dc.l	$F01000FE
	dc.l	$F007000C,sub_182AE8,$00100000
	dc.l	$F0100002
	dc.l	$F007000D,sub_182AE8,$00100000
	dc.l	$F01000FE
	dc.l	$F007000E,sub_182AE8,$00110000
	dc.l	$F0100002
	dc.l	$F007000F,sub_182AE8,$00110000
	dc.l	$F0070000,sub_182C58
	dc.l	$F01000FE
	dc.l	$F0070010,sub_182AE8,$000E0000
	dc.l	$F00BDF00,$02C5FE0C
	dc.l	$F0100002
	dc.l	$F0070011,sub_182AE8,$000E0000
	dc.l	$F01000FE
	dc.l	$F0070012,sub_182AE8,$000F0000
	dc.l	$F0100002
	dc.l	$F0070013,sub_182AE8,$000F0000
	dc.l	$F0070000,sub_182C58
	dc.l	$F01000FE
	dc.l	$F0070014,sub_182AE8,$00100000
	dc.l	$F0100002
	dc.l	$F0070015,sub_182AE8,$00100000
	dc.l	$F01000FE
	dc.l	$F0070016,sub_182AE8,$00110000
	dc.l	$F00BDF00,$02C5FE0C
	dc.l	$F0100002
	dc.l	$F0070017,sub_182AE8,$00110000
	dc.l	$F0070000,sub_182C58
	dc.l	$F01000FE
	dc.l	$F0070018,sub_182AE8,$000E0000
	dc.l	$F0100002
	dc.l	$F0070019,sub_182AE8,$000E0000
	dc.l	$F01000FE
	dc.l	$F007001A,sub_182AE8,$000F0000
	dc.l	$F0100002
	dc.l	$F007001B,sub_182AE8,$000F0000
	dc.l	$F0070000,sub_182C58
	dc.l	$F01000FE
	dc.l	$F007001C,sub_182AE8,$00100000
	dc.l	$F00BDF00,$02C5FE0C
	dc.l	$F0100002
	dc.l	$F007001D,sub_182AE8,$00100000
	dc.l	$F00E0200
	dc.l	$F0130000
	dc.l	$F0020200,$00110000
	dc.l	$F0020200,$00120000
	dc.l	$80000000
sub_182E06:
	pea		($90).w			; 時長
	jsr		$124C1E			; 陰暗背景
	addq.l	#4,sp
	rts
sub_182AE8:
	movem.l	d2-d3/a2-a3,-(sp)
	move.l	$18(sp),d3
	movea.l	$14(sp),a3
	clr.w	d2
	tst.w	$C8(a3)
	beq.s	loc_182B12
	move.w	#$1C0,d2
	move.b	d3,d0
	ext.w	d0
	add.w	d0,d0
	movea.l	#word_27B9CA,a0
	sub.w	(a0,d0.w),d2
	bra.s	loc_182B22
loc_182B12:
	move.b	d3,d0
	ext.w	d0
	add.w	d0,d0
	movea.l	#word_27B9CA,a0
	move.w	(a0,d0.w),d2
loc_182B22:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	move.w	$24(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.b	d3,d0
	ext.w	d0
	add.w	d0,d0
	movea.l	#word_27BA06,a0
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.w	($D0A002).l,d1
	ext.l	d1
	add.l	d1,d0
	move.l	d0,-(sp)
	move.w	($D0A000).l,d0
	ext.l	d0
	move.w	d2,d1
	ext.l	d1
	add.l	d1,d0
	move.l	d0,-(sp)
	pea		(off_27B916).l	; 飛砂走石
	jsr		$1517D4			; 佈置機關
	lea		$14(sp),sp
	movea.l	d0,a2
	move.b	d3,d0
	ext.w	d0
	add.w	d0,d0
	movea.l	#word_27B98A,a0
	move.w	(a0,d0.w),$3E(a2)
	tst.w	$C8(a3)
	beq.s	loc_182B92
	move.w	#5,$5A(a2)
	bra.s	loc_182B98
loc_182B92:
	move.w	#6,$5A(a2)
loc_182B98:
	movem.l	(sp)+,d2-d3/a2-a3
	rts
word_27B98A:
	dc.w	$00BE,$00CA,$0106,$00D6,$010E,$00E2,$0116,$00EE	; 0
	dc.w	$00E2,$0106,$00BE,$00EE,$010E,$00CA,$00D6,$0116	; 8
	dc.w	$010E,$00CA,$00EE,$0106,$00D6,$0116,$00E2,$00BE	; $10
	dc.w	$010E,$00CA,$00EE,$0106,$00D6,$0116,$00E2,$00BE	; $18
word_27B9CA:
	dc.w	$FF9C,$003C,$FFC4,$0028,$FFEC,    0,$0014,$FFD8	; 0
	dc.w	$003C,$FFB0,$0064,$FFE2,$000A,$00A0,$FFBA,$0032	; 8
	dc.w	$00DC,$FFA6,$001E,$FFF6,$FF9C,$003C,$FFC4,$0028	; $10
	dc.w	$FFEC,    0,$0014,$FFD8,$003C,$FFB0	; $18
word_27BA06:
	dc.w	$00E6,$00E6,$008C,$008C,$00E6,$008C,$00E6,$00E6	; 0
	dc.w	$008C,$00E6,$00E6,$00E6,$008C,$00E6,$00E6,$008C	; 8
	dc.w	$00E6,$008C,$00E6,$00E6,$00E6,$00E6,$008C,$008C	; $10
	dc.w	$00E6,$008C,$00E6,$00E6,$008C,$00E6	; $18
off_27B916:
	dc.l	dword_27B8D2,$001C9D96,$00000000,$00000000
	dc.l	$00319D02,$00587F33,$09020120,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000,0
dword_27B8D2:
	dc.l	$000002FF,$000102FF,$000204FF,$000304FF
	dc.l	$00040CFB,$00050CFB,$000618F6,$000718F6
	dc.l	$000018F6,$000118F6,$000218F6,$000318F6
	dc.l	$000418F6,$000518F6,$000618F6,$000718F6
	dc.l	$F0010800
sub_182C58:
	link	a6,#0
	movem.l	d2-d4/a2,-(sp)
	tst.b	($80C2B5).l		; 敵我所有攻擊是否有效
	beq.w	loc_182DFC
	jsr		$15EC62			; 第一順位角色OBJ
	bra.w	loc_182DF4
loc_182C76:
	moveq	#0,d2
	move.w	$50(a2),d2
	moveq	#$A,d0
	cmp.l	d2,d0
	beq.w	loc_182DEA
	moveq	#$B,d0
	cmp.l	d2,d0
	beq.w	loc_182DEA
	tst.w	$6C(a2)
	beq.w	loc_182DEA
	moveq	#7,d0
	cmp.l	d2,d0
	beq.w	loc_182DEA
	moveq	#8,d0
	cmp.l	d2,d0
	beq.w	loc_182DEA
	tst.w	$174(a2)
	bne.w	loc_182DEA
	tst.w	$1E2(a2)
	bne.w	loc_182DEA
	cmpi.w	#$10,$CA(a2)	; 是否下蹲
	beq.w	loc_182DEA
	moveq	#0,d4
	move.w	$6C(a2),d4
	move.w	#1,$6C(a2)		; 一擊殘血
	subq.w	#1,d4
	neg.w	d4
	move.l	d4,-(sp)
	movea.l	$F8(a2),a0
	move.l	a0,-(sp)
	jsr		$14CF6A			; 生命條變動
	addq.l	#8,sp
	movea.l	8(a6),a0
	move.w	$C8(a0),d0
	cmp.w	$C8(a2),d0
	bne.s	loc_182CF4
	moveq	#$11,d3
	bra.s	loc_182CF6
loc_182CF4:
	moveq	#7,d3
loc_182CF6:
	movea.l	$54(a2),a0
	cmpi.w	#$29F,$6C(a0)
	beq.s	loc_182D0E
	jsr		$12D4B4
	tst.l	d0
	beq.w	loc_182DBE
loc_182D0E:
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_182D26
	subi.b	#$40,($81B4C4).l
loc_182D26:
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.w	loc_182DBE
	jsr		$13A578
	pea		($1).w
	movea.l	$54(a2),a0
	move.w	$6C(a0),d0		; 痛叫|0202
	andi.l	#$FFFF,d0
	asr.l	#8,d0
	andi.l	#3,d0
	move.l	d0,-(sp)
	movea.l	$54(a2),a0
	move.w	$6C(a0),d0
	andi.l	#$FFFF,d0
	lsl.l	#8,d0
	moveq	#0,d1
	move.b	($81B4C4).l,d1
	lsl.l	#2,d1
	or.l	d1,d0
	or.l	(sp)+,d0
	ori.l	#$EF0000,d0		; 音頻音量
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	lea		$C(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_182DB8
	move.l	($81B4A8).l,($81B4B0).l
loc_182DB8:
	jsr		$13A58E
loc_182DBE:
	move.w	d3,d0
	move.l	d0,-(sp)
	pea		($8).w			; 受擊動作
	move.l	a2,-(sp)
	jsr		$15E152			; 計算動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	addq.l	#8,sp
	move.w	#1,$174(a2)
loc_182DEA:
	move.l	a2,-(sp)
	jsr		$15EC88			; 下一順位角色OBJ
	addq.l	#4,sp
loc_182DF4:
	movea.l	d0,a2
	move.l	a2,d0
	bne.w	loc_182C76
loc_182DFC:
	movem.l	-$10(a6),d2-d4/a2
	unlk	a6
	rts


unk_11CE50:	; 調兵遣將|武神
	dc.l	$F0540A00
	dc.l	$F0020200,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F00BFF00,$015D0000		; 「殺」
	dc.l	$F0140336,$003400B8
	dc.l	$F0280600
	dc.l	$F01000FF,$006E0000
	dc.l	$F0100001,$006F0000
	dc.l	$F0290000
	dc.l	$F0070000,sub_11CF30	; 隨機召喚援將
	dc.l	$80000000

sub_11CF30:	; 調兵遣將|武神出場
	link	a6,#0
	movem.l	a2-a4/d2-d6,-(sp)
	movea.l	8(a6),a2		; 真呂布OBJ
; 是否召喚武神
	jsr		sub_109CC2		; 是否可刷新敵人
	tst.l	d0
	bne.s	loc_11CF30
	move.l	a2,-(sp)
	jsr		$16CD94.l		; 呂布雷電
	addq.l	#4,sp
	bra.w	locret_11CF30	; 取消召喚
loc_11CF30:
	tst.l	$1EC(a2)		; 是否有優先攻擊對象
	beq.s	loc_11CF31
	movea.l	$1EC(a2),a3
	bra.s	loc_11CF32
loc_11CF31:
	jsr		$15EC62			; 第一順位角色OBJ
	movea.l	d0,a3
loc_11CF32:
; 隨機出場援將
	pea		(17).w			; 十七援將
	jsr		($102480).l		; 大隨機
	addq.l	#4,sp
	move.l	d0,d2			; 援將序號
; 計算出場坐標
	move.w	$20(a3),d0
	ext.l	d0
	move.w	($D0A000).l,d1
	ext.l	d1
	sub.l	d1,d0
	cmpi.l	#$E0,d0
	bge.s	loc_11CF90
	moveq	#1,d3			; 面向[d3]
	move.l	d2,d0
	lsl.w	#2,d0
	movea.l	#off_1C3512,a0	; 出場坐標表|橫坐標
	move.w	(a0,d0.w),d4
	andi.l	#$FFFF,d4
	neg.l	d4				; 左側橫坐標偏移[d4]
	bra.s	loc_11CFAE
loc_11CF90:
	moveq	#0,d3			; 面向[d3]
	move.l	d2,d0
	lsl.w	#2,d0
	movea.l	#off_1C3512,a0	; 出場坐標表|橫坐標
	move.w	(a0,d0.w),d4
	andi.l	#$FFFF,d4		; 右側橫坐標偏移[d4]
loc_11CFAE:
	move.l	d2,d0
	lsl.w	#2,d0
	movea.l	#(off_1C3512+2),a0	; 出場坐標表|豎坐標
	move.w	(a0,d0.w),d5
	andi.l	#$FFFF,d5		; 豎坐標偏移[d5]
; 援將進場設定
	jsr		$109CC2			; 分配OBJ序號[d6]
	move.l	d0,d6
	move.l	d6,-(sp)
	jsr		$10F2C2			; 計算OBJ地址[a4]
	movea.l	d0,a4
	clr.l	-(sp)			; 色盤號
	move.l	d3,-(sp)		; 面向
	move.l	d5,-(sp)		; 豎坐標
	move.w	$22(a3),d0
	ext.l	d0
	move.l	d0,-(sp)		; 縱坐標
	move.w	$20(a3),d0
	ext.l	d0
	sub.l	d4,d0
	move.l	d0,-(sp)		; 橫坐標
	move.l	d2,d0
	lsl.w	#2,d0
	movea.l	#off_2ABBD6,a0	; 援將指針表
	move.l	(a0,d0.w),-(sp)
	move.l	d6,-(sp)
	jsr		$10A1BA			; 敵方出場
	lea		$20(sp),sp
; 援將進場動作
	move.l	d2,d0
	lsl.w	#2,d0
	movea.l	#off_1C2B3C,a0	; 援將動作指針表
	move.l	(a0,d0.w),-(sp)
	move.l	a4,-(sp)
	jsr		$10EF18			; 寫入動作
	addq.l	#8,sp
	clr.w	$6C(a4)			; 生命值零
	move.w  #1,$A2(a4)		; 無視地形
locret_11CF30:
	movem.l	-$20(a6),a2-a4/d2-d6
	unlk	a6
	rts

off_2ABBD6:	; 援將指針表
	dc.l	$001FD476,$00201F76,$002053FE,$00208DE0	; [00]曹操[01]司馬懿[02]程昱[03]曹仁
	dc.l	$0020B7DC,$0020FBEE,$00214024,$00217DF4	; [04]夏侯淵[05]夏侯惇[06]牛金[07]許褚
	dc.l	$0021C0B4,$00222A98,$00225922,$0022A694	; [08]張郃[09]張遼[0A]甘寧[0B]周泰
	dc.l	$0022EDB4,$00232702,$00235782,$0023F080,$00245DA0	; [0C]黃蓋[0D]呂蒙[0E]徐晃[0F]孟獲孟優[10]沙摩柯

off_1C3512:	; 援將坐標表
	dc.w	$003A,$FF93, $00A8,$0000, $00B0,$FF38, $0000,$FF6C
	dc.w	$0188,$FF93, $015A,$FFF0, $0165,$FF9D, $015C,$FF93
	dc.w	$0000,$FF24, $0188,$FF93, $0000,$FF10, $00CD,$FF74
	dc.w	$0200,$0000, $00CD,$FF74, $012E,$FF93, $0200,$0000, $0200,$0000

off_1C2B3C:	; 援將動作表
	dc.l	off_200D3A,off_2032CA,off_207D52,off_20ACD6
	dc.l	off_20E81E,off_212EBA,off_216BEC,off_21AE14
	dc.l	off_22143E,off_224562,off_229246,off_22DBF2
	dc.l	off_230E4E,off_2341A2,off_23A4E2,off_244FF8,off_247248

off_200D3A:	; 調兵遣將|曹操
	dc.w	$0303
	dc.l	dword_2007DE,$02000840,$10000000,0	; [08]速度0無敵8
dword_2007DE:	; 調兵遣將|曹操心是劍
	dc.l	$F0540600	; 出場動作|天斷劍
	dc.l	$F04F2E00
	dc.l	$F0450200
	dc.l	$007C0008,$007C0008,$007C0008
	dc.l	$F00BFF00,$010A0000
	dc.l	$F0330100
	dc.l	$F0340004,$007E0000,$00000008,$007D0008
	dc.l	$F0340004,$007F0000,$00000008,$007D0008
	dc.l	$F0340004,$00800000,$00000008,$007D0008
	dc.l	$F0340004,$00810000,$00000009,$007D0009
	dc.l	$F0340004,$007E0000,$00000009,$007D0009
	dc.l	$F0330000,$2082000C,$2082000C
	dc.l	$F0030000,$20820014
	dc.l	$F0070000,$001249C6
	dc.l	$F02A0000
	dc.l	$F0450300
	dc.l	$F0410100
	dc.l	$F0140009,$00000100
	dc.l	$F0330100
	dc.l	$F00BFF00,$00B40000
	dc.l	$F00BFF00,$00B40000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00860000,$001C0000,$00851C00
	dc.l	$F0340004,$00860000,$00000000,$00850000
	dc.l	$F0340004,$00860000,$00000000,$00850000
	dc.l	$F0330000
	dc.l	$F0260100
	dc.l	$F0270004,$00880000,$001E0000,$00871E00
	dc.l	$F0270004,$00880000,$00000000,$00870000
	dc.l	$F0270004,$00890000,$00000000,$00870000
	dc.l	$F0270004,$00890000,$00000000,$00870000
	dc.l	$F0270004,$008A0000,$00000000,$00870000
	dc.l	$F0270004,$008A0000,$00000000,$00870000
	dc.l	$F0260000
	dc.l	$F0020E00,$00870000
	dc.l	$F0020500,$00710000
	dc.l	$F00E0300,$003C0000	; 心是劍
	dc.l	$F0140332,$0000019E
	dc.l	$F00B9F00,$00B70000
	dc.l	$F0020500,$006B0000
	dc.l	$006C0000
	dc.l	$F00BFF00,$01080000
	dc.l	$F00E0000
	dc.l	$F0260100
	dc.l	$F02700FF,$006D0000,$000000F6,$006C0000
	dc.l	$F02700FF,$006D0000,$000000E2,$006C0000
	dc.l	$F02700FF,$006D0000,$000000C4,$006C0000
	dc.l	$F02700FF,$006D0000,$0000009C,$006C0000
	dc.l	$F0260000
	dc.l	$F00E0300
	dc.l	$F015FE00,$0020076A,$00000100
	dc.l	$F0020F00,$006C0000
	dc.l	$F00E0000
	dc.l	$F0260100
	dc.l	$F02700FF,$006D0000,$0000009C,$006C0000
	dc.l	$F02700FF,$006D0000,$000000C4,$006C0000
	dc.l	$F02700FF,$006D0000,$000000E2,$006C0000
	dc.l	$F02700FF,$006D0000,$000000F6,$006C0000
	dc.l	$F0260000
	dc.l	$F00E0300,$00700000,$00710000
	dc.l	$F061FF00,off_1C3472,$00000000	; 退場動作|色盤FF
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000
off_1C3472:	; 調兵遣將|曹操退場
	dc.l	dword_200DA6,$001FCD18,$001FCD1C,$001FCD1E
	dc.l	$0034F4EC,$001F1E60,$09020024,$00000000	; 速度頻率[$19(OBJ)=02|lsr #2|$15188C]
	dc.l	$00001400,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000606
	dc.l	$00000034,$F5060000,$001C2BC4,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000800,$00000000,$00000100,$00000000,0
dword_200DA6:	; 調兵遣將|曹操退場動作
	dc.l	$F0120400	; 顏色定義|藍身
	dc.l	$F00B4F00,$00B50000
	dc.l	$00731000,$00731000,$00741000,$00741000
	dc.l	$00751000,$00751000,$00761000,$00761000
	dc.l	$00771000,$00771000
	dc.l	$F0021600,$40771000
	dc.l	$80000000

off_20ACD6:	; 調兵遣將|曹仁
	dc.w	$0305
	dc.l	dword_20A600,$02000A40,0,0
dword_20A600:	; 調兵遣將|曹仁四連空刺
	dc.l	$F0540200	; 出場動作|四連空刺
	dc.l	$F04F0715
	dc.l	$F0450C00
	dc.l	$F0070000,$00168E72	; 定位
	dc.l	$F0020A00,$00690001	; 下地
	dc.l	$F00E0000
	dc.l	$F0410100
	dc.l	$F0030000,$20690012
	dc.l	$F061FE00,$002261D6,$FFE40000
	dc.l	$F061FE01,$002261D6,$00140000,$006A0000
	dc.l	$F061FE00,$00264AC4,$FFF401F2
	dc.l	$F061FE00,$00264AC4,$FFC001F2
	dc.l	$F0020700,$006A0000,$006B03FA,$006B03FA,$006B03FA
	dc.l	$006B03FB,$006B03FB,$006B03FB,$006B03FC
	dc.l	$006B03FC,$006B03FC,$006B03FD,$006B03FD
	dc.l	$006B03FD,$006B03FE,$006B03FE,$006B03FE
	dc.l	$006B03FF,$006B03FF,$006B03FF
	dc.l	$F0410100,$20690301,$20690301,$20690302,$20690302
	dc.l	$20690303,$20690303,$20690304,$20690304
	dc.l	$20690305,$20690305
	dc.l	$F0030000,$20690308
	dc.l	$F0020800,$206A0000
	dc.l	$F0020800,$006A0000
	dc.l	$F00B4F00,$00C00000	; 上天2
	dc.l	$F061FE00,$0021F406,$00000100
	dc.l	$F0020A00,$005300F4
	dc.l	$F0020A00,$005300F6
	dc.l	$F0070000,$00168E48	; 空中隨機待定時間
	dc.l	$F0070000,$00168E72	; 定位
	dc.l	$F0020A00,$00690001	; 下地2
	dc.l	$F00E0000
	dc.l	$F0410100
	dc.l	$F0030000,$20690012
	dc.l	$F061FE00,$002261D6,$FFE40000
	dc.l	$F061FE01,$002261D6,$00140000,$006A0000
	dc.l	$F061FE00,$00264AC4,$FFF401F2
	dc.l	$F061FE00,$00264AC4,$FFC001F2
	dc.l	$F0020700,$006A0000,$006B03FA,$006B03FA,$006B03FA
	dc.l	$006B03FB,$006B03FB,$006B03FB,$006B03FC
	dc.l	$006B03FC,$006B03FC,$006B03FD,$006B03FD
	dc.l	$006B03FD,$006B03FE,$006B03FE,$006B03FE
	dc.l	$006B03FF,$006B03FF,$006B03FF
	dc.l	$F0410100,$20690301,$20690301,$20690302,$20690302
	dc.l	$20690303,$20690303,$20690304,$20690304
	dc.l	$20690305,$20690305
	dc.l	$F0030000,$20690308
	dc.l	$F0020800,$206A0000,$006B03FD,$006B03FD,$006B03FE
	dc.l	$006B03FE,$006B03FF,$006B03FF,$006803C7
	dc.l	$F0030000,$0068030C
	dc.l	$F0140009,$00000000
	dc.l	$F0020A00,$00680000
	dc.l	$F0020700,$00420000	; 退場動作
	dc.l	$F00B4F00,$00C00000
	dc.l	$F061FE00,$0021F406,$00000100
	dc.l	$F0020700,$205300F4
	dc.l	$F0020800,$005300F4
	dc.l	$F0020A00,$40530000
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_207D52:	; 調兵遣將|程昱
	dc.w	$0305
	dc.l	dword_23D200,$02000A40,0,0
dword_23D200:	; 調兵遣將|程昱亂心符
	dc.l	$2086000A,$2086000E,$20860012,$20860014	; 出場動作
	dc.l	$20860016,$20860018,$2086001A,$2086001C
	dc.l	$F0030000,$20860028
	dc.l	$F00BDF00,$01280000
	dc.l	$F00B7F00,$02BA0000
	dc.l	$F01000FE
	dc.l	$F0140009,$00000400,$0087FCFB
	dc.l	$F0100002
	dc.l	$0087FCFC,$0087FCFE,$0087FCFF,$0087FC01
	dc.l	$0087FC02,$0087FC04,$0087FC05
	dc.l	$F0140009,$00000400
	dc.l	$F0020900,$00400000
	dc.l	$F0020200,$00410000
	dc.l	$F0020200,$00420000
	dc.l	$F0020200,$00440000
	dc.l	$F00E0300	; 亂心符
	dc.l	$F00BFF00,$01230000
	dc.l	$00660000,$00670000,$00680000,$00690000
	dc.l	$006A0000,$006B0000,$006C0000
	dc.l	$F0070000,$00168440
	dc.l	$006D0000,$006F0000
	dc.l	$F00BFF00,$01250000	; 召喚木人或紙人
	dc.l	$F00B9F00,$00BD0000
	dc.l	$F0330100
	dc.l	$F03400FF,$00710000,$00000000,$00700000
	dc.l	$F03400FF,$00720000,$00000000,$00700000
	dc.l	$F03400FF,$00730000,$00000000,$00700000
	dc.l	$F0070000,sub_1684CB
	dc.l	$F03400FF,$00710000,$00000000,$00700000
	dc.l	$F03400FF,$00720000,$00000000,$00700000
	dc.l	$F03400FF,$00730000,$00000000,$00700000
	dc.l	$F0330000
	dc.l	$F00E0000,$F0110000	; 退場動作|反向
	dc.l	$001B0AF5,$001B0AF6,$001B0AF6,$001B0AF6
	dc.l	$001C0AF7,$001C0AF7,$001C0AF8,$001C0AF8
	dc.l	$001D0AF8,$001D0AF9,$001D0AF9,$001D0AFA
	dc.l	$001E0AFA,$001E0AFA,$001E0AFB,$001E0AFB
	dc.l	$001F0AFC,$001F0AFC,$001F0AFC,$001F0AFD
	dc.l	$00200AFD,$00200AFE,$00200AFE,$00200AFE
	dc.l	$00210AFF,$00210AFF,$00210A00,$00210A00,$00210A00
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

sub_1684CB:
	move.l	4(a7),-(sp)		; 程昱OBJ
	jsr		sub_1684F8		; 木人數目
	tst.l	d0
	ble.s	loc_1684CB
	jsr		($1684F0).l		; 召喚木人
	bra.s	locret_1684CB
loc_1684CB:
	jsr		(sub_17D6C4).l	; 召喚紙人
locret_1684CB:
	addq.l	#4,sp
	rts

off_2032CA:	; 調兵遣將|司馬懿
	dc.w	$0305
	dc.l	dword_2030E4,$01000800,0,0
dword_2030E4:	; 調兵遣將|司馬懿氣罩|放蛇|分身
	dc.l	$00A600FE	; 出場動作
	dc.l	$F0020F00,$00A60000
	dc.l	$F0021400,$00A70000
	dc.l	$F0020800,$00A70500
	dc.l	$F00BFF00,$01200000
	dc.l	$F0020800,$00A70400
	dc.l	$F0020800,$00A70300
	dc.l	$F0020800,$00A70400
	dc.l	$F0020800,$00A70500
	dc.l	$F0020A00,$00A80000
	dc.l	$F0020800,$00A90000
	dc.l	$F0020600,$00AA0000
	dc.l	$F0020400,$00AB0000
	dc.l	$F0020400,$00AC0000
	dc.l	$F0020400,$006E0000,$006F0002
	dc.l	$F0020600,$006F0000
	dc.l	$F0020600,$00700000
	dc.l	$F0020600,$00710000
	dc.l	$F0020400,$00720000
	dc.l	$F00E0200	; 氣罩
	dc.l	$F0020200,$00730000
	dc.l	$F0020300,$00740000
	dc.l	$F0330100
	dc.l	$F0340004,$00760000,$00000000,$00750000
	dc.l	$F0340004,$00770000,$00000000,$00750000
	dc.l	$F0330000
	dc.l	$F00BFF00,$011A0000
	dc.l	$F0150400,$00203804,$00000000
	dc.l	$F0150400,$002038AC,$00000000
	dc.l	$F0020200,$00780000
	dc.l	$F0020C00,$00780000
	dc.l	$F0020200,$00780000
	dc.l	$F0540400	; 放蛇
	dc.l	$F0450800
	dc.l	$F04F0E00
	dc.l	$F0020200,$00690000
	dc.l	$F0020200,$006A0000
	dc.l	$F0020200,$006B0000
	dc.l	$F0020200,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F0020300,$206E0000
	dc.l	$F00BFF00,$01190000
	dc.l	$F00E0000
	dc.l	$F0070000,$00167E0E,$206F0000
	dc.l	$F0070001,$00167E0E,$206F0000
	dc.l	$F0070002,$00167E0E,$206F0000
	dc.l	$F0070003,$00167E0E,$206F0000
	dc.l	$F0070004,$00167E0E,$206F0000
	dc.l	$F0070005,$00167E0E,$206F0000
	dc.l	$F0020200,$20700000
	dc.l	$F0020200,$00710000
	dc.l	$F0020200,$00720000
	dc.l	$F0020A00,$00720000	; 退場動作
	dc.l	$F0020800,$00710000
	dc.l	$F0020600,$00700000
	dc.l	$F0020600,$006F0000
	dc.l	$F0020400,$006E0000
	dc.l	$F0020400,$00AC0000
	dc.l	$F0020400,$00AB0000
	dc.l	$F0020600,$00AA0000
	dc.l	$F0020800,$00A90000
	dc.l	$F0020A00,$00A80000
	dc.l	$F0070000,sub_167802	; 召喚分身
	dc.l	$F0020800,$00A70000
	dc.l	$F0020600,$00A60000
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_20E81E:	; 調兵遣將|夏侯淵
	dc.w	$0305
	dc.l	dword_20D332,$02000A40,0,0
dword_20D332:	; 調兵遣將|夏侯淵橫掃千軍
	dc.l	$F00BFF00,$01370000	; 出場動作
	dc.l	$008B0A00,$008B0A01,$008B0A02,$008B0A02,$008B0A03,$008B0A04,$008B0A04
	dc.l	$F0410100,$208C1205,$008C0A05,$008C0A06,$008C0A06,$008C0A07
	dc.l	$F0410100,$208C0A07,$008C0A08,$008C0A09,$008C0A09,$008C0A0A
	dc.l	$F0410100,$208C0A0A,$008C0A0B
	dc.l	$F0140009,$00000100,$007B0A00
	dc.l	$F0020400,$007B0000
	dc.l	$F0020800,$00290000
	dc.l	$F00E0200	; 橫掃千軍
	dc.l	$F0540A00
	dc.l	$F04F2011
	dc.l	$F0330100
	dc.l	$F03400FF,$005D0000,$001F0000,$003F1F00,$005C0000
	dc.l	$F03400FF,$005F0000,$00120000,$00411200,$005E0000
	dc.l	$F03400FF,$00610000,$00000000
	dc.l	$F0020200,$00600000
	dc.l	$F0330000
	dc.l	$F0330200
	dc.l	$F0340104,$00640000,$00240000
	dc.l	$F03400FF,$00630000,$00240000,$20622400
	dc.l	$F00BFF00,$02C00000
	dc.l	$F00BFF00,$02C00000
	dc.l	$F0410100
	dc.l	$F05C0900
	dc.l	$F04F2111
	dc.l	$F0340104,$00670000,$00000000
	dc.l	$F03400FF,$00660000,$00000000,$20650000
	dc.l	$F0410100
	dc.l	$F0450300
	dc.l	$F04F2511
	dc.l	$F0340104,$006A0000,$002E0000
	dc.l	$F03400FF,$00690000,$002E0000,$20682E00
	dc.l	$F0340104,$006D0000,$00000000
	dc.l	$F03400FF,$006C0000,$00000000,$006B0000
	dc.l	$F0340104,$00700000,$00000000
	dc.l	$F03400FF,$006F0000,$00000000,$006E0000
	dc.l	$F0340104,$00730000,$00000000
	dc.l	$F03400FF,$00720000,$00000000,$00710000
	dc.l	$F0340104,$00740000,$00000000
	dc.l	$F03400FF,$00720000,$00000000,$00710000
	dc.l	$F0330000
	dc.l	$F0330100
	dc.l	$F03400FF,$00720000,$00000000
	dc.l	$F0020200,$00710000
	dc.l	$F03400FF,$00760000,$00000000
	dc.l	$F0020200,$00750000
	dc.l	$F03400FF,$00780000,$00210200,$00772102,$00770000
	dc.l	$F0330000
	dc.l	$F00E0000	; 退場動作
	dc.l	$F0020700
	dc.l	$00240000,$00250AF5,$00250AF6,$00250AF6
	dc.l	$00250AF6,$00250AF7,$00250AF7,$00250AF8
	dc.l	$00250AF8,$00250AF8,$00250AF9,$00250AF9
	dc.l	$00250AFA,$00250AFA,$00250AFA,$00250AFB
	dc.l	$00250AFB,$00250AFC,$00250AFC,$00250AFC
	dc.l	$00250AFD,$00250AFD,$00250AFE,$00250AFE
	dc.l	$00250AFE,$00250AFF
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_212EBA:	; 調兵遣將|夏侯惇
	dc.w	$0301
	dc.l	dword_21082A,$02000840,0,0
dword_21082A:	; 調兵遣將|夏侯惇翻天斬
	dc.l	$F0540000	; 出場動作
	dc.l	$F0410100,$204D0000
	dc.l	$F00B4F00,$00C40000
	dc.l	$004D0D00,$004E0D00,$004F0D00
	dc.l	$F00BFF00,$013E0000
	dc.l	$004D0D00,$004E0D00
	dc.l	$F0410100,$204F0D00
	dc.l	$004D0D00,$004E0D00,$004F0D00,$004E0D00,$004F0D00
	dc.l	$F0410100,$204D0D00
	dc.l	$004E0D00,$004F0D00,$004E0D00,$004F0D00,$004D0D00
	dc.l	$F0410100,$20500D00
	dc.l	$F0030000,$00500010
	dc.l	$F0020200,$00500000
	dc.l	$F0020300,$00510000
	dc.l	$F0020700,$00520000
	dc.l	$F0540500	; 翻天斬
	dc.l	$F04F2E05
	dc.l	$F0450700
	dc.l	$F02A030A
	dc.l	$F00B4F00,$00C40000
	dc.l	$004D04FA,$004E04FA,$004F04FA,$004D04FB
	dc.l	$004E04FB,$004F04FB,$004D04FC,$004E04FC
	dc.l	$004F04FC,$004D04FD,$004E04FD,$004F04FD,$004D04FE
	dc.l	$F00BFF00,$013F0000
	dc.l	$004E04FE,$004F04FE
	dc.l	$004D04FF,$004E04FF,$004F04FF,$004D0400
	dc.l	$004E0400,$004F0400
	dc.l	$F02A0000
	dc.l	$004D0000,$004E0000,$004F0000,$004D0000
	dc.l	$004E0000,$004F0000
	dc.l	$F00B4F00,$00C30000
	dc.l	$F015FF00,$00211F6A,$002000E3,$004D0000
	dc.l	$F015FF00,$0021200E,$002800CA,$004E0000
	dc.l	$F015FF00,$002120B2,$000000B6,$004F0000
	dc.l	$F015FF01,$0021200E,$FFD800CA,$004D0000
	dc.l	$F015FF01,$00211F6A,$FFE000E3,$004E0000
	dc.l	$F015FF00,$002106F2,$000000F0,$004F0000
	dc.l	$F015FF00,$002107B6,$002800FC,$004D0400
	dc.l	$F015FF01,$002107B6,$FFD800FC
	dc.l	$004E0400,$004F0400,$004D0401,$004E0401
	dc.l	$004F0401,$004D0402,$004E0402,$004F0402
	dc.l	$004D0403,$004E0403,$004F0403,$004D0404
	dc.l	$004E0404,$004F0404,$004D0405,$004E0405
	dc.l	$004F0405,$004D0406,$004E0406,$00500801
	dc.l	$00500802,$00500803
	dc.l	$F0020300,$00510000
	dc.l	$F0140009,$00000100
	dc.l	$F0030000,$00521A08
	dc.l	$F0020A00,$00520000
	dc.l	$F0540000	; 退場動作
	dc.l	$F0020500,$004A0000
	dc.l	$F0020500,$004B0000
	dc.l	$F0020500,$004C0000
	dc.l	$F0410100,$204D0EF0
	dc.l	$F00B4F00,$00C40000
	dc.l	$004E0E00,$004F0E00,$004D0E00,$004E0E00,$004F0E00
	dc.l	$F0410100,$204D0E00
	dc.l	$004E0E00,$004F0E00,$004D0E00,$004E0E00
	dc.l	$F0410100,$204F0E00
	dc.l	$004D0E00,$004E0E00,$004F0E00,$004D0E00,$004E0E00
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_216BEC:	; 調兵遣將|牛金
	dc.w	$0301
	dc.l	dword_215488,$02000840,0,0
dword_215488:	; 調兵遣將|牛金細雨狂瀉
	dc.l	$F00BFF00,$014A0000	; 出場動作
	dc.l	$006E0B04,$006E0B04,$006E0B04,$206F0B05
	dc.l	$206F0B05,$206F0B05,$20700B06,$20700B06
	dc.l	$20700B06,$20710B08,$20710B08,$20710B08
	dc.l	$20710B0A,$20710B0A
	dc.l	$F0030000,$00720B0A
	dc.l	$F00B9F00,$02DC0000
	dc.l	$F00B9F00,$0104F830
	dc.l	$F0140009,$00000100
	dc.l	$F01000FC
	dc.l	$F0020200,$00720000
	dc.l	$F0100004
	dc.l	$F0020600,$00720000
	dc.l	$F0020300,$00330000
	dc.l	$F0020300,$00340000
	dc.l	$F0020300,$00350000
	dc.l	$F0540300	; 細雨狂瀉
	dc.l	$F04F1100
	dc.l	$F0450800
	dc.l	$F00BFF00,$01450000
	dc.l	$F0020300,$00360000
	dc.l	$F0020400,$00370000
	dc.l	$F0020200,$00380000
	dc.l	$F00B9F00,$00C60000
	dc.l	$F0280300
	dc.l	$F015FE00,$0021532C,$00000000
	dc.l	$00580000,$00580000
	dc.l	$F015FE00,$002153A0,$00000000
	dc.l	$00580000,$00580000,$20380000
	dc.l	$F015FE00,$00215414,$00000000
	dc.l	$00590000,$00590000,$00590000
	dc.l	$F015FE00,$0021532C,$00000000
	dc.l	$00590000,$00590000
	dc.l	$F015FE00,$002153A0,$00000000
	dc.l	$00580000,$00580000
	dc.l	$F015FE00,$00215414,$00000000
	dc.l	$00580000,$00580000,$20380000
	dc.l	$F015FE00,$0021532C,$00000000
	dc.l	$00590000,$00590000,$00590000
	dc.l	$F015FE00,$002153A0,$00000000
	dc.l	$00590000,$00590000
	dc.l	$F0290000
	dc.l	$F0540600	; 怒濤洶湧
	dc.l	$F04F1200
	dc.l	$F0450300
	dc.l	$F00E0100
	dc.l	$F0020100,$00690000
	dc.l	$F0020100,$006A0000
	dc.l	$F0020200,$006B0000
	dc.l	$F00E0000
	dc.l	$F015FF00,$002155A4,$001E1E00,$206C0A00,$006C0A00,$206C0A00
	dc.l	$F015FF00,$002155A4,$0032E200,$006C0800,$206C0800,$006C0800
	dc.l	$F015FF00,$002155A4,$001EF600,$206C0600,$006C0600,$206C0600
	dc.l	$F015FF00,$002155A4,$003C1900,$006C0400,$206C0400,$006C0400
	dc.l	$F015FF00,$002155A4,$0046EC00,$206C0200,$006C0200,$206C0200
	dc.l	$F015FF00,$002155A4,$00580700,$006C0000,$206C0000,$006C0000
	dc.l	$F015FF00,$002155A4,$006E0000,$006C5000
	dc.l	$F0020400,$006D0000
	dc.l	$F0020700	; 退場動作
	dc.l	$00730000,$00740AF6,$00740AF6,$00740AF6
	dc.l	$00740AF6,$00740AFA,$00740AFA,$00740AFA
	dc.l	$00740AFB,$00740AFB,$00740AFB,$00750AFC
	dc.l	$00750AFC,$00750AFC,$00750AFD,$00750AFD
	dc.l	$00750AFD,$00750AFE,$00750AFE,$00750AFE
	dc.l	$00750AFF,$00750AFF,$00750AFF
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_21AE14:	; 調兵遣將|許褚
	dc.w	$0305
	dc.l	dword_219380,$02000A40,0,0
dword_219380:	; 調兵遣將|許褚六丁開山
	dc.l	$F0540000	; 出場動作
	dc.l	$00740A00,$00740A01,$00740A02
	dc.l	$F00BFF00,$01520000
	dc.l	$00740A02,$00740A03,$00740A04,$00740A04,$00740A05
	dc.l	$F0410100
	dc.l	$20780A05,$00780A06,$00780A06,$00780A07,$00780A07
	dc.l	$F0410100
	dc.l	$20780A08,$00780A09,$00780A09,$00780A0A,$00780A0A
	dc.l	$F0410100,$20780A0B
	dc.l	$F00BEF00,$00C70000
	dc.l	$F01000FC,$007803FA,$007803FA
	dc.l	$F0100004
	dc.l	$007803FB,$007803FD,$007803FF,$00780301
	dc.l	$00780303,$00780305,$00780306,$00780306
	dc.l	$F0140009,$00000100
	dc.l	$F0020300,$007F0000
	dc.l	$F0540500	; 六丁開山
	dc.l	$F04F0F02
	dc.l	$F0450000
	dc.l	$F0021000,$00530000
	dc.l	$F00B9F00,$02C50000
	dc.l	$F0330100
	dc.l	$F03400FF,$00550000,$00000000,$20540000
	dc.l	$F0020300,$20540000
	dc.l	$F0330000
	dc.l	$F0260100
	dc.l	$F0410100
	dc.l	$F02700FF,$00570000,$00190000,$20561900
	dc.l	$F0020300,$20560000
	dc.l	$F0410100
	dc.l	$F02700FF,$00590000,$001D0000,$20581D00
	dc.l	$F0020300,$20580000
	dc.l	$F0260000
	dc.l	$F0330100
	dc.l	$F0410100
	dc.l	$F03400FF,$005B0000,$FFE90000,$205AE900
	dc.l	$F0020300,$205A0000
	dc.l	$F0410100
	dc.l	$F03400FF,$005D0000,$00330300,$205C3303
	dc.l	$F0020300,$205C0000
	dc.l	$F00B9F00,$02C50000
	dc.l	$F0410100
	dc.l	$F03400FF,$005F0000,$00080000,$205E0800
	dc.l	$F0020300,$205E0000
	dc.l	$F0410100
	dc.l	$F03400FF,$00610000,$00000000,$20600000
	dc.l	$F0020300,$20600000
	dc.l	$F0450300
	dc.l	$F0410100
	dc.l	$F03400FF,$00630000,$001E0000,$20621E00
	dc.l	$F0020300,$20620000
	dc.l	$F0330000
	dc.l	$F0260100
	dc.l	$F0410100
	dc.l	$F02700FF,$00590000,$001D0000,$20581D00
	dc.l	$F0020300,$20580000
	dc.l	$F0260000
	dc.l	$F0330100
	dc.l	$F0410100
	dc.l	$F03400FF,$005B0000,$FFE90000,$205AE900
	dc.l	$F0020300,$205A0000
	dc.l	$F0410100
	dc.l	$F03400FF,$005D0000,$00330300,$205C3303
	dc.l	$F0020300,$205C0000
	dc.l	$F00B9F00,$02C50000
	dc.l	$F0410100
	dc.l	$F03400FF,$005F0000,$00080000,$205E0800
	dc.l	$F0020300,$205E0000
	dc.l	$F0410100
	dc.l	$F03400FF,$00610000,$00000000,$20600000
	dc.l	$F0020300,$20600000
	dc.l	$F0450300
	dc.l	$F0410100
	dc.l	$F03400FF,$00630000,$001E0000,$20621E00
	dc.l	$F0020300,$20620000
	dc.l	$F0410100
	dc.l	$F03400FF,$00650000,$00000000,$20640000
	dc.l	$F0020300,$20640000
	dc.l	$F03400FF,$00670000,$00000000
	dc.l	$F0020400,$00660000
	dc.l	$F03400FF,$00690000,$00000000
	dc.l	$F0020400,$00680000
	dc.l	$F03400FF,$006B0000,$00000000
	dc.l	$F0020400,$006A0000
	dc.l	$F0330000
	dc.l	$F0021000,$006A0000
	dc.l	$F0020700	; 退場動作
	dc.l	$00220000,$00230AF5,$00230AF6,$00230AF6
	dc.l	$00230AF6,$00230AF7,$00230AF7,$00230AF8
	dc.l	$00230AF8,$00230AF8,$00230AF9,$00230AF9
	dc.l	$00230AFA,$00230AFA,$00230AFA,$00230AFB
	dc.l	$00230AFB,$00230AFC,$00230AFC,$00230AFC
	dc.l	$00230AFD,$00230AFD,$00230AFE,$00230AFE
	dc.l	$00230AFE,$00230AFF
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_22143E:	; 調兵遣將|張郃
	dc.w	$0303
	dc.l	dword_21CA1E,$02000800,0,0
dword_21CA1E:	; 調兵遣將|張郃掃蕩群魔
	dc.l	$F0070000,$00168E48	; 隨機空中待定時間|出場動作
	dc.l	$F0020A00,$00960000
	dc.l	$F00E0000
	dc.l	$F0280B00
	dc.l	$F03400FF,$00970000,$00000014
	dc.l	$F03401FF,$00970000,$000000E2
	dc.l	$F03402FF,$00970000,$000000B0,$20960014
	dc.l	$F0290000
	dc.l	$F0140008,$00000100
	dc.l	$F0280500
	dc.l	$F03400FF,$00990000,$00000000
	dc.l	$F03401FF,$00990000,$000000CE
	dc.l	$F03402FF,$00990000,$0000009C,$00980000
	dc.l	$F0290000
	dc.l	$F0330000,$009A1000
	dc.l	$F0020400,$009A0000
	dc.l	$F0020400,$009B0000
	dc.l	$F0110000
	dc.l	$F04F2E15
	dc.l	$F0540300
	dc.l	$F0020600,$00440000,$00452300
	dc.l	$F0020300,$00450000
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0450000
	dc.l	$F0260100
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$00590000,$00000000,$20460000
	dc.l	$F0020300
	dc.l	$F02700FF,$005A0000,$00000000,$20460000
	dc.l	$F0020300
	dc.l	$F02700FF,$005B0000,$00000000,$20470000
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$005C0000,$00000000,$20470000
	dc.l	$F0020300
	dc.l	$F02700FF,$005D0000,$00000000,$20480000
	dc.l	$F0020300
	dc.l	$F02700FF,$005E0000,$00000000,$20480000
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$005F0000,$00000000,$20490000
	dc.l	$F0020300
	dc.l	$F02700FF,$00600000,$00000000,$20490000
	dc.l	$F0450100
	dc.l	$F0020300
	dc.l	$F02700FF,$00590000,$00000000,$204A0000
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$005A0000,$00000000,$204A0000
	dc.l	$F0020300
	dc.l	$F02700FF,$005B0000,$00000000,$20580000
	dc.l	$F0020300
	dc.l	$F02700FF,$005C0000,$00000000,$20580000
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$005D0000,$00000000,$20460000
	dc.l	$F0020300
	dc.l	$F02700FF,$005E0000,$00000000,$20460000
	dc.l	$F0020300
	dc.l	$F02700FF,$005F0000,$00000000,$20470000
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$00600000,$00000000,$20470000
	dc.l	$F0450000
	dc.l	$F0020300
	dc.l	$F02700FF,$00590000,$00000000,$20480000
	dc.l	$F0020300
	dc.l	$F02700FF,$005A0000,$00000000,$20480000
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$005B0000,$00000000,$20490000
	dc.l	$F0020300
	dc.l	$F02700FF,$005C0000,$00000000,$20490000
	dc.l	$F0020300
	dc.l	$F02700FF,$005D0000,$00000000,$204A0000
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$005E0000,$00000000,$204A0000
	dc.l	$F0020300
	dc.l	$F02700FF,$005F0000,$00000000,$20580000
	dc.l	$F0020300
	dc.l	$F02700FF,$00600000,$00000000,$20580000
	dc.l	$F0450100
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$00590000,$00000000,$204B0000
	dc.l	$F0020300
	dc.l	$F02700FF,$005A0000,$00000000,$204B0000
	dc.l	$F0450700
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$005B0000,$00000000,$204C0000
	dc.l	$F0020300
	dc.l	$F02700FF,$005C0000,$00000000,$204C0000
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0410100
	dc.l	$F0020300
	dc.l	$F02700FF,$005D0000,$00000000,$204D0000
	dc.l	$F0020300
	dc.l	$F02700FF,$005E0000,$00000000,$204D0000
	dc.l	$F04F1115
	dc.l	$F0450000
	dc.l	$F0410100
	dc.l	$F00BFF00,$01550000
	dc.l	$F0020300
	dc.l	$F02700FF,$005F0000,$00000000,$204E0000
	dc.l	$F0020300
	dc.l	$F02700FF,$00600000,$00000000,$204E0000
	dc.l	$F0451500
	dc.l	$F0410100
	dc.l	$F02700FF,$00590000,$0000FA00,$204F01FA
	dc.l	$F02700FF,$00590000,$0000FE00,$204F01FE
	dc.l	$F02700FF,$005A0000,$0000FC00,$204F01FC
	dc.l	$F0260000
	dc.l	$F0410100
	dc.l	$F0020400,$205002FB
	dc.l	$F0020400,$205102FB
	dc.l	$F0410100
	dc.l	$F0020400,$205202FC
	dc.l	$F0020400,$205302FD
	dc.l	$F0410100
	dc.l	$F0020400,$205003FE
	dc.l	$F0020400,$205103FF
	dc.l	$F0410100
	dc.l	$F0020400,$20520301
	dc.l	$F0020400,$20530302
	dc.l	$F0020400,$00540403
	dc.l	$F0020400,$00550404
	dc.l	$F0020400,$00560405
	dc.l	$F0030000,$00570406
	dc.l	$F0140008,$00000100,$00442D00
	dc.l	$F0020B00,$00440000
	dc.l	$F0020500,$008D0000	; 退場動作
	dc.l	$F0020500,$008E0000
	dc.l	$F0020500,$008F0000
	dc.l	$F0020300,$00920000
	dc.l	$F0020E00,$009400F2
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_224562:	; 調兵遣將|張遼
	dc.w	$030C
	dc.l	dword_223F8E,$02000840,0,0
dword_223F8E:	; 調兵遣將|張遼雙刀車輪衝兵陣
	dc.l	$F00BFF00,$015B0000	; 出場動作|飛腿
	dc.l	$00650A00,$00650A01,$00650A02,$00650A02,$00650A03,$00650A04,$00650A04
	dc.l	$F0410100,$20661205,$00660A05,$00660A06,$00660A06,$00660A07
	dc.l	$F0410100,$20660A07,$00660A08,$00660A09,$00660A09,$00660A0A
	dc.l	$F0410100,$20660A0A,$00660A0B
	dc.l	$F0140009,$00000100
	dc.l	$F00B7F00,$00190000
	dc.l	$F0020200,$00670600
	dc.l	$F0020600,$00670000
	dc.l	$F00E0200	; 雙刀車輪
	dc.l	$F00BFF00,$01600000
	dc.l	$F0020200,$007E0000
	dc.l	$F00BBF00,$00C90000
	dc.l	$F015FE00,$0022436C,$00160000
	dc.l	$F0021700,$007F0000,$007F0000
	dc.l	$F0020200,$006E0000	; 衝兵陣
	dc.l	$F00BFF00,$015A0000
	dc.l	$F00B9F00,$0283FC18,$006F0000
	dc.l	$F0070000,$0011D488
	dc.l	$F0020200,$00700000
	dc.l	$F0020200,$00710000
	dc.l	$F0070001,$0011D488,$00720000
	dc.l	$F0070002,$0011D488,$00720000
	dc.l	$F0020200,$00700000
	dc.l	$F0020200,$00710000
	dc.l	$F0070003,$0011D488,$00720000
	dc.l	$F0070004,$0011D488,$00720000
	dc.l	$F00E0000,$F0110000	; 退場動作|反向
	dc.l	$F0020700
	dc.l	$001C0000,$001E0AF5,$001E0AF6,$001E0AF6
	dc.l	$001E0AF6,$001E0AF7,$001E0AF7,$001E0AF8
	dc.l	$001E0AF8,$001E0AF8,$001E0AF9,$001E0AF9
	dc.l	$001E0AFA,$001E0AFA,$001E0AFA,$001E0AFB
	dc.l	$001E0AFB,$001E0AFC,$001E0AFC,$001E0AFC
	dc.l	$001E0AFD,$001E0AFD,$001E0AFE,$001E0AFE
	dc.l	$001E0AFE,$001E0AFF
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_229246:	; 調兵遣將|甘寧
	dc.w	$0306
	dc.l	dword_228BAA,$02000840,0,0
dword_228BAA:	; 調兵遣將|甘寧小鬼獻寶
	dc.l	$F0540100	; 出場動作|上天下地
	dc.l	$F04F1113
	dc.l	$F0451300
	dc.l	$F0020A00,$00810000
	dc.l	$F0070000,$0016B3BC,$002800F7
	dc.l	$F0070000,$0016B464,$002800F7
	dc.l	$F0070000,$0016B464,$002800F7
	dc.l	$F0070000,$0016B464,$002800F8
	dc.l	$F0070000,$0016B464,$002800F8
	dc.l	$F0070000,$0016B464,$002800F8
	dc.l	$F0070000,$0016B464,$002800F9
	dc.l	$F0070000,$0016B464,$002800F9
	dc.l	$F0070000,$0016B464,$002800F9
	dc.l	$F0070000,$0016B464,$002800FA
	dc.l	$F0070000,$0016B464,$002800FA
	dc.l	$F0070000,$0016B464,$002800FA
	dc.l	$F0070000,$0016B464,$002800FB
	dc.l	$F0070000,$0016B464,$002800FB
	dc.l	$F0070000,$0016B464,$002900FB
	dc.l	$F0070000,$0016B464,$002900FB
	dc.l	$F0070000,$0016B464,$002900FC
	dc.l	$F0070000,$0016B464,$002900FC
	dc.l	$F0070000,$0016B464,$002900FC
	dc.l	$F0070000,$0016B464,$002900FD
	dc.l	$F0070000,$0016B464,$002A00FD
	dc.l	$F0070000,$0016B464,$002A00FD
	dc.l	$F0070000,$0016B464,$002A00FD
	dc.l	$F0070000,$0016B464,$002A0000
	dc.l	$F0070000,$0016B464,$002A0000
	dc.l	$F0070001,$0016B464
	dc.l	$F0020A00,$002A0000
	dc.l	$F0030000,$2078000F
	dc.l	$F061FE00,$00228742,$00000100
	dc.l	$F061FE00,$0022B756,$00000100
	dc.l	$F0020200,$00780000
	dc.l	$F0020700,$002C0000
	dc.l	$F00E0100	; 小鬼獻寶
	dc.l	$F00BFF00,$01650000
	dc.l	$F0020200,$00100000
	dc.l	$F0020200,$00110000
	dc.l	$F0020200,$00120000
	dc.l	$F0070000,$0016ADE2
	dc.l	$F0020200,$00130000
	dc.l	$F0020200,$00140000
	dc.l	$F0020A00,$00150000
	dc.l	$F00E0000	; 退場動作
	dc.l	$F0020400,$00810000,$00280AF6,$00280AF6,$00280AF6
	dc.l	$00280AFA,$00280AFA,$00280AFA,$00280AFB
	dc.l	$00280AFB,$00280AFB,$00280AFC,$00280AFC
	dc.l	$00280AFC,$00280AFC,$00290AFC,$00290AFC
	dc.l	$00290AFD,$00290AFD,$00290AFD,$00290AFD
	dc.l	$00290AFD,$00290AFD,$00290AFE,$00290AFE
	dc.l	$00290AFE,$00290AFE
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_22DBF2:	; 調兵遣將|周泰
	dc.w	$0304
	dc.l	dword_22BEFA,$02000840,$10000000,0
dword_22BEFA:	; 調兵遣將|周泰大地驚雷
	dc.l	$F0540600	; 出場動作|天降神兵
	dc.l	$F04F2E00
	dc.l	$F05C0100
	dc.l	$F00BFF00,$01700000
	dc.l	$007C0506,$007C0506,$007C0506,$007C0506
	dc.l	$007C0508,$007C0508,$007C0508,$007C0508
	dc.l	$007C050A,$007C050A
	dc.l	$F0330100
	dc.l	$F0340004,$007E0000,$00050009,$207D0509
	dc.l	$F0340004,$007E0000,$0005000F,$207D050F
	dc.l	$F0340004,$007E0000,$0005000E,$207D050E
	dc.l	$F0340004,$007E0000,$0004000F,$207D040F
	dc.l	$F0340004,$007E0000,$00040011,$207D0411
	dc.l	$F0340004,$00800000,$00040011
	dc.l	$F0030000,$207F0411
	dc.l	$F00BDF00,$00C707D0
	dc.l	$F061FE00,$00264AC4,$00440100
	dc.l	$F061FE01,$00264AC4,$00570100
	dc.l	$F061FE00,$0022B3DA,$004E0115
	dc.l	$F061FE00,$0022B46E,$004E0115
	dc.l	$F061FE00,$0022B502,$004E0115
	dc.l	$F061FE00,$0022B596,$004E0115
	dc.l	$F061FE00,$0022B62A,$004E0115
	dc.l	$F061FE00,$0022B6C2,$004E0115
	dc.l	$F061FE00,$0027D818,$00560106
	dc.l	$F01000FC
	dc.l	$F0340004,$00800000,$00000000,$207F0000
	dc.l	$F0340004,$00800000,$00000000,$207F0000
	dc.l	$F0100004
	dc.l	$F0340004,$00810000,$00000000,$007F0000
	dc.l	$F0340004,$00820000,$00000000,$007F0000
	dc.l	$F0330000
	dc.l	$F0020900,$007F0000
	dc.l	$F0020300,$00330000
	dc.l	$F00E0300	; 大地驚雷
	dc.l	$F05C0600
	dc.l	$00CB0000,$00CC0000
	dc.l	$F00BFF00,$016F0000
	dc.l	$F00B9F00,$02DA0000,$00CD0000
	dc.l	$F061FE00,$0022B0DE,$00000100
	dc.l	$F061FE00,$0022B172,$00000100
	dc.l	$F015FE00,$0022BA7A,$00000100
	dc.l	$F061FE00,$0022BB0E,$00000100
	dc.l	$F061FE00,$0022BBA2,$00000100
	dc.l	$F015FE00,$0022BC36,$00000100
	dc.l	$F015FE00,$0022BCCA,$00000100
	dc.l	$F061FE00,$0022BD5E,$00000100
	dc.l	$F061FE00,$0022BDF2,$00000100
	dc.l	$F061FE00,$0022BE86,$00000100
	dc.l	$F00E0200
	dc.l	$F0280200
	dc.l	$F0070000,$0016BB20,$20CE0000
	dc.l	$F0530000
	dc.l	$F0020200,$00CE0000
	dc.l	$F0290000
	dc.l	$F0530000
	dc.l	$F0020800,$00CE0000
	dc.l	$F00E0000	; 退場動作
	dc.l	$F0020900,$00520000,$005103F3,$005104F3,$005104F3
	dc.l	$005104F4,$005104F4,$005104F4,$005104F6
	dc.l	$005104F6,$005104F6,$005104F8,$005104F8
	dc.l	$005104F8,$005105F8,$005105FA,$005105FA
	dc.l	$005105FA,$005106FB,$005106FC,$005106FC,$005106FC
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_230E4E:	; 調兵遣將|黃蓋
	dc.w	$0300
	dc.l	dword_23163C,$01000840,0,0
dword_23163C:	; 調兵遣將|黃蓋分身體轉爆
	dc.l	$F0540800,$F04F1115,$F05C0500,$F0450200	; 出場動作|跑撞
	dc.l	$F0330100
	dc.l	$F0280600,$F03400FF,$002B0000,$00050000,$202A0500,$F0290000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280600,$F03400FF,$002D0000,$00050000,$202C0500,$F0290000
	dc.l	$F0280600,$F03400FF,$002F0000,$00050000,$202E0500,$F0290000
	dc.l	$F0280600,$F03400FF,$00310000,$00050000,$20300500,$F0290000
	dc.l	$F0280600,$F03400FF,$00330000,$00050000,$20320500,$F0290000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280600,$F03400FF,$00350000,$00050000,$20340500,$F0290000
	dc.l	$F0280600,$F03400FF,$00370000,$00050000,$20360500,$F0290000
	dc.l	$F0280600,$F03400FF,$00390000,$00050000,$20380500,$F0290000
	dc.l	$F0330000
	dc.l	$F00E0100	; 飛腿
	dc.l	$F0330100
	dc.l	$F0020200,$F03400FF,$00850000,$00000000,$00840000
	dc.l	$F0020200,$F03400FF,$00870000,$00000000,$00860000
	dc.l	$F0020200,$F03400FF,$00890000,$00000000,$00880000
	dc.l	$F0020200,$F03400FF,$008B0000,$00000000,$008A0000
	dc.l	$F00B6F00,$02C80000
	dc.l	$F0070000,$0016BE58
	dc.l	$F0330000
	dc.l	$F02B0100	; 踢彈|空中動作0010C594
	dc.l	$F04F0E00,$F0450300
	dc.l	$F00B9F00,$02C20000
	dc.l	$F0330100
	dc.l	$F03400FF,$00190000,$00080000,$00180800
	dc.l	$F03400FF,$00190000,$00000000,$00180000
	dc.l	$F00BFF00,$017A0000
	dc.l	$F03400FF,$00610000,$0004FC00,$006004FC
	dc.l	$F03400FF,$00610000,$0004FC00,$006004FC
	dc.l	$F03400FF,$00630000,$002AFC00,$00622AFC
	dc.l	$F03400FF,$00630000,$0004FC00,$006204FC
	dc.l	$F03400FF,$00650000,$0004FC00,$206404FC
	dc.l	$F03400FF,$00650000,$0004FC00,$206404FC
	dc.l	$F03400FF,$00670000,$00040400,$00660404
	dc.l	$F03400FF,$00670000,$00040400,$00660404
	dc.l	$F03400FF,$00690000,$00040400,$00680404
	dc.l	$F03400FF,$00690000,$00040400,$00680404
	dc.l	$F03400FF,$00690000,$00040400,$00680404
	dc.l	$F03400FF,$00690000,$00040400,$00680404
	dc.l	$F0140009,$00000100
	dc.l	$F0030000
	dc.l	$F03400FF,$006B0000,$00000800,$006A0008
	dc.l	$F03400FF,$006B0000,$00000000
	dc.l	$F0020300,$006A0000
	dc.l	$F0330000
	dc.l	$F02B0000	; 恢復地面動作
	dc.l	$F00E0000,$F04F2000,$F05C0500	; 分身體轉
	dc.l	$F0330100
	dc.l	$F03400FF,$00190000,$00000000
	dc.l	$F0020500,$00180000
	dc.l	$F03400FF,$00610000,$00000000
	dc.l	$F0020500,$00600000
	dc.l	$F03400FF,$00630000,$00000000
	dc.l	$F0020500,$00620000
	dc.l	$F00BFF00,$017F0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F0280800
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00020000,$20930200
	dc.l	$F03400FF,$00940000,$00020000,$00930200
	dc.l	$F03400FF,$00940000,$00020000,$20930200
	dc.l	$F03400FF,$00960000,$00020000,$00950200
	dc.l	$F03400FF,$00960000,$00020000,$20950200
	dc.l	$F03400FF,$00960000,$00020000,$00950200
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$00020000,$20970200
	dc.l	$F03400FF,$00980000,$00020000,$00970200
	dc.l	$F03400FF,$00980000,$00020000,$20970200
	dc.l	$F015FF00,off_26BD3C,$FFC40000
	dc.l	$F03400FF,$009A0000,$00020000,$00990200
	dc.l	$F03400FF,$009A0000,$00020000,$20990200
	dc.l	$F03400FF,$009A0000,$00020000,$00990200
	dc.l	$F0290000
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$0023040A,$000000D8
	dc.l	$F015FE01,$0023040A,$000000D8
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$002304CE,$000000D8
	dc.l	$F015FE01,$002304CE,$000000D8
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$00230592,$000000D8
	dc.l	$F015FE01,$00230592,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F015FE00,$00230656,$000000D8
	dc.l	$F015FE01,$00230656,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F015FE00,$0023071A,$000000D8
	dc.l	$F015FE01,$0023071A,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F012FF00
	dc.l	$F00E0200
	dc.l	$F0280300
	dc.l	$F03400FF,$009C0000,$00000000,$009B0000
	dc.l	$F03400FF,$009D0000,$00000000,$009B0000
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$F00E0000	; 退場動作
	dc.l	$F0280600,$F03400FF,$002B0000,$00050000,$002A0500,$F0290000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280600,$F03400FF,$002D0000,$00050000,$002C0500,$F0290000
	dc.l	$F0280600,$F03400FF,$002F0000,$00050000,$002E0500,$F0290000
	dc.l	$F0280600,$F03400FF,$00310000,$00050000,$00300500,$F0290000
	dc.l	$F0280600,$F03400FF,$00330000,$00050000,$00320500,$F0290000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280600,$F03400FF,$00350000,$00050000,$00340500,$F0290000
	dc.l	$F0280600,$F03400FF,$00370000,$00050000,$00360500,$F0290000
	dc.l	$F0280600,$F03400FF,$00390000,$00050000,$00380500,$F0290000
	dc.l	$F0330000
	dc.l	$F04C0000	; 屏外清除援將
	dc.l	$F0070000,sub_16D688
	dc.l	$80000000

sub_16D688:	; 循環退場動作
	movea.l	4(sp),a0
	move.w	#$13C,$44(a0)
	rts

off_2341A2:	; 調兵遣將|呂蒙
	dc.w	$0304
	dc.l	dword_233BEE,$02000840,0,0
dword_233BEE:	; 調兵遣將|呂蒙風卷人轉
	dc.l	$F0540600	; 出場動作|大地驚雷
	dc.l	$F04F2A11
	dc.l	$F0450800
	dc.l	$206A0503,$206A0503,$206A0506,$206A0506
	dc.l	$206A0506,$206A0506,$206A0509,$206A0509
	dc.l	$206A0509,$206A050C,$206A050C,$206A050C
	dc.l	$206A050F,$206A050F,$206A050F
	dc.l	$F0030000,$206A050F
	dc.l	$F061FE00,$00235C2C,$00580110
	dc.l	$F061FE00,$0022B3DA,$00580110
	dc.l	$F061FE00,$0022B46E,$00580110
	dc.l	$F04F2711
	dc.l	$F0450700
	dc.l	$F0330100
	dc.l	$F00B9F00,$02C30000
	dc.l	$F0410100
	dc.l	$F01000FE
	dc.l	$F0340004,$006C0000,$00000000,$206B0000
	dc.l	$F061FE00,$0022B502,$00580110
	dc.l	$F061FE00,$0022B596,$00580110
	dc.l	$F0340004,$006C0000,$00000000,$206B0000
	dc.l	$F061FE00,$0022B62A,$00580110
	dc.l	$F061FE00,$0027F850,$0050FF0E
	dc.l	$F0100002
	dc.l	$F0340004,$006E0000,$00000000,$006D0000
	dc.l	$F0340004,$006E0000,$00000000,$006D0000
	dc.l	$F061FE00,$0027F8E4,$0050FF0E
	dc.l	$F061FE00,$0027F97C,$0050FF0E
	dc.l	$F0330000
	dc.l	$F0020C00,$006F0000,$0070E700
	dc.l	$F0020600,$00700000
	dc.l	$F0540800	; 風卷人轉
	dc.l	$F04F2E15
	dc.l	$F0020600,$20710000
	dc.l	$F00B6F00,$00CF0000
	dc.l	$F0330100
	dc.l	$F0280300
	dc.l	$F0410100
	dc.l	$F0340004,$00730000,$0006FF00,$207206FF
	dc.l	$F0340004,$00730000,$0006FF00,$207206FF
	dc.l	$F0340004,$00750000,$0006FF00,$207406FF
	dc.l	$F0340004,$00750000,$0006FF00,$207406FF
	dc.l	$F0340004,$00770000,$0006FF00,$207606FF
	dc.l	$F0340004,$00770000,$0006FF00,$207606FF
	dc.l	$F0340004,$00790000,$0006FF00,$207806FF
	dc.l	$F0340004,$00790000,$0006FF00,$207806FF
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0410100
	dc.l	$F0340004,$00730000,$00060100,$20720601
	dc.l	$F0340004,$00730000,$00060100,$20720601
	dc.l	$F0340004,$00750000,$00060100,$20740601
	dc.l	$F0340004,$00750000,$00060100,$20740601
	dc.l	$F0340004,$00770000,$00060100,$20760601
	dc.l	$F0340004,$00770000,$00060100,$20760601
	dc.l	$F0340004,$00790000,$00060100,$20780601
	dc.l	$F0340004,$00790000,$00060100,$20780601
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$F0030000,$007A0008
	dc.l	$F0140009,$00000100
	dc.l	$F04C0000	; 屏外清除援將
	dc.l	$F0014F00
	dc.l	$80000000

off_23A4E2:	; 調兵遣將|徐晃
	dc.w	$0302
	dc.l	dword_237AD0,$02000800,0,0
dword_237AD0:	; 調兵遣將|徐晃誰敢阻擋
	dc.l	$F0450900	; 出場動作
	dc.l	$F05C0900	; 爆炸屬性
	dc.l	$F00BFF00,$01900000	; "快滾吧"
	dc.l	$206F0902,$206F0902,$206F0902,$206F0902
	dc.l	$206F0903,$206F0903,$206F0903,$206F0904
	dc.l	$206F0904,$206F0905,$206F0906,$206F0907
	dc.l	$206F0908,$206F0909,$206F090A,$206F090B
	dc.l	$F0030000,$20701E5A
	dc.l	$F00BFF00,$02CD0000
	dc.l	$F00E0200
	dc.l	$F0610400,$00235A18,$007500EE
	dc.l	$F0610400,$00235C2C,$00650122
	dc.l	$F0610600,$00235DA0,$00700123
	dc.l	$F0100004,$20700000
	dc.l	$F0610400,$00235CE4,$00700521
	dc.l	$F0150400,$00235ACC,$006902FC
	dc.l	$F00BEF00,$02CE0000
	dc.l	$F01000FC,$00700000
	dc.l	$F01504FF,$00235ACC,$00790309
	dc.l	$F00BCF00,$02CE0000
	dc.l	$F0100003
	dc.l	$F0020300,$00700000
	dc.l	$F01000FD
	dc.l	$F00BDF00,$02CE0000
	dc.l	$F0150400,$00235ACC,$00540410
	dc.l	$F0020700,$00700000
	dc.l	$F0020100,$00710000
	dc.l	$F00E0000	; 誰敢阻擋
	dc.l	$F05C0000	; 取消屬性
	dc.l	$F0540800
	dc.l	$F0450200
	dc.l	$F00BFF00,$01870000
	dc.l	$F0020200,$00470600
	dc.l	$F0330100
	dc.l	$F00B9F00,$02DF0000
	dc.l	$F0280500
	dc.l	$F0340004,$00490000,$00020000,$20480200
	dc.l	$F0290000
	dc.l	$F014000E,$008C0000
	dc.l	$F0280400
	dc.l	$F0340004,$004B0000,$00020000,$204A0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$004D0000,$00020000,$204C0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00420000,$00020000,$20410200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00440000,$00020000,$20430200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00450000,$00020000,$00470200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00460000,$00000000,$00000000
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F00B9F00,$02DF0000
	dc.l	$F0280500
	dc.l	$F0340004,$00490000,$00020000,$20480200
	dc.l	$F0290000
	dc.l	$F014000E,$008C0000
	dc.l	$F0280400
	dc.l	$F0340004,$004B0000,$00020000,$204A0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$004D0000,$00020000,$204C0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00420000,$00020000,$20410200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00440000,$00020000,$20430200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00450000,$00020000,$00470200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00460000,$00000000,$00000000
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F00B9F00,$02DF0000
	dc.l	$F0280500
	dc.l	$F0340004,$00490000,$00020000,$20480200
	dc.l	$F0290000
	dc.l	$F014000E,$008C0000
	dc.l	$F0280400
	dc.l	$F0340004,$004B0000,$00020000,$204A0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$004D0000,$00020000,$204C0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00420000,$00020000,$20410200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00440000,$00020000,$20430200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00450000,$00020000,$00470200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00460000,$00000000,$00000000
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$F0020A00,$00250000	; 退場動作
	dc.l	$F0020300,$00260DF5
	dc.l	$F0020300,$00260DF7
	dc.l	$F0020300,$00260DF9
	dc.l	$F0020300,$00260DFA,$00260DFB,$00260DFB,$00270DFC
	dc.l	$00270DFC,$00270DFC,$00270DFD,$00270DFD
	dc.l	$00270DFE,$00270DFE,$00270DFE
	dc.l	$F0070000,sub_109D38	; 清除援將
	dc.l	$80000000

off_244FF8:	; 調兵遣將|孟獲孟優
	dc.w	$0305
	dc.l	dword_244C32,$01002840,0,0
dword_244C32:	; 調兵遣將|孟獲孟優巨象蠻撞
	dc.l	$F0540800
	dc.l	$F04F0E00
	dc.l	$F0450200
	dc.l	$F0020500,$00750000
	dc.l	$F0020300,$20760000
	dc.l	$F0410100
	dc.l	$207C2900,$F0020100,$207C0000
	dc.l	$F0410100
	dc.l	$207D0000,$F0020100,$207D0000
	dc.l	$F00BBF00,$00D30000
	dc.l	$F0140009,$003C0100
	dc.l	$F0410100
	dc.l	$F01000FE,$207E3900,$207E0000
	dc.l	$F0410100
	dc.l	$F0100002,$207E0000
	dc.l	$F0410100
	dc.l	$207F1F00,$F0020100,$207F0000
	dc.l	$F0410100
	dc.l	$20802900,$F0020100,$20800000
	dc.l	$F0410100
	dc.l	$20811600,$F0020100,$20810000
	dc.l	$F00BBF00,$00D30000
	dc.l	$F0140009,$003C0100
	dc.l	$F0410100
	dc.l	$F01000FE,$20822E00,$20820000
	dc.l	$F0410100
	dc.l	$F0100002,$20820000
	dc.l	$F0410100
	dc.l	$20832700,$F0020100,$20830000
	dc.l	$F0410100
	dc.l	$207C2900,$F0020100,$207C0000
	dc.l	$F0410100
	dc.l	$207D0000,$F0020100,$207D0000
	dc.l	$F04C0000	; 屏外清除援將
	dc.l	$F0010500	; 循環動作
	dc.l	$80000000

off_247248:	; 調兵遣將|沙摩柯
	dc.w	$0308
	dc.l	dword_247142,$01002840,0,0
dword_247142:	; 調兵遣將|沙摩柯追蹤火炮
	dc.l	$F0540600	; 追蹤炸彈
	dc.l	$F04F0F00
	dc.l	$F00BFF00,$01A40000
	dc.l	$F0020200,$205E0000
	dc.l	$F061FE01,$00214DAC,$0000FFBD
	dc.l	$F061FE01,$00214DAC,$0034FFB5
	dc.l	$F0020200,$205F0000
	dc.l	$F0020200,$00600000
	dc.l	$F0070000,$0016DEA8
	dc.l	$F0020200,$00610000
	dc.l	$F0020200,$00620000
	dc.l	$F00E0000	; 出場動作
	dc.l	$F0020800,$000B0600
	dc.l	$F0020800,$000C0600
	dc.l	$F0020800,$000D0600
	dc.l	$F0020800,$000E0600
	dc.l	$F0020800,$000F0600
	dc.l	$F0020800,$00100600
	dc.l	$F0020800,$00110600
	dc.l	$F0020800,$00120600
	dc.l	$F00E0200	; 衝拳
	dc.l	$F04F0F15
	dc.l	$F05E0100
	dc.l	$F0020100,$00250000
	dc.l	$F0020400,$00260000
	dc.l	$F00B9F00,$02C30000
	dc.l	$20270000
	dc.l	$F0410100
	dc.l	$F0450300
	dc.l	$F0020400,$20280000,$00270000
	dc.l	$F05C0500	; 連火炮
	dc.l	$F0020100,$205B0000,$205B0000
	dc.l	$F014031F,$002801DD,$205C0000
	dc.l	$F0070000,$0016DDF8,$205C0000
	dc.l	$F0070001,$0016DDF8,$205C0000
	dc.l	$F0070002,$0016DDF8,$005D0000
	dc.l	$F0070003,$0016DDF8,$005D0000
	dc.l	$F0070004,$0016DDF8,$005D0000
	dc.l	$F0070005,$0016DDF8,$005D0000
	dc.l	$F0070006,$0016DDF8,$005D0000
	dc.l	$F00E0000	; 退場動作
	dc.l	$F0020800,$000B0600
	dc.l	$F0020800,$000C0600
	dc.l	$F0020800,$000D0600
	dc.l	$F0020800,$000E0600
	dc.l	$F0020800,$000F0600
	dc.l	$F0020800,$00100600
	dc.l	$F0020800,$00110600
	dc.l	$F0020800,$00120600
	dc.l	$F04C0000	; 屏外清除援將
	dc.l	$F0015300	; 循環動作
	dc.l	$80000000

sub_109D38:	; 清除援將
	move.l	a2,-(sp)
	movea.l	8(sp),a2		; 援將OBJ
	moveq	#0,d0
	move.w	$E(a2),d0
	move.l	d0,-(sp)		; OBJ序號
	jsr		$109D38.l		; 清除OBJ
	addq.l	#4,sp
	movea.l	(sp)+,a2
	rts


dword_23CA78:	; 雲合影從
	dc.l	$F0540800
	dc.l	$F04F0612
	dc.l	$F0450700
	dc.l	$F05E0100
	dc.l	$F00BFF00,$019B0000
	dc.l	$F061FE00,$00253B5C,$000420A8	; 必殺閃光
	dc.l	$F0280C00
	dc.l	$F01000FF,$00700000
	dc.l	$F0100001,$00700000
	dc.l	$F0290000
	dc.l	$F00B9F00,$02CD0000
	dc.l	$00720000,$00740000,$00760000,$00780000,$007A0000
	dc.l	$F05E0000
	dc.l	$F0130100
	dc.l	$F0280300
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0290000
	dc.l	$F00BFF00,$01950000
	dc.l	$F015FF00,off_1C33FE,$00A00080	; [1]
	dc.l	$F015FF00,off_1C33FE,$00302080	; [2]
	dc.l	$F015FF00,off_1C33FE,$0030E080	; [2]
	dc.l	$F015FF00,off_1C33FE,$FFC00080	; [3]
	dc.l	$F0021800,$407A0000
	dc.l	$F0070000,sub_16CCF6	; 同步坐標
	dc.l	$F00BFF00,$01950000
	dc.l	$F015FF00,off_1C33FE,$00300080	; [1]
	dc.l	$F015FF00,off_1C33FE,$FFC01880	; [2]
	dc.l	$F015FF00,off_1C33FE,$FFC0E880	; [2]
	dc.l	$F015FF00,off_1C33FE,$FF501080	; [3]
	dc.l	$F015FF00,off_1C33FE,$FF50F080	; [3]
	dc.l	$F015FF00,off_1C33FE,$FF503080	; [3]
	dc.l	$F015FF00,off_1C33FE,$FF50D080	; [3]
	dc.l	$F0070000,$00168E48	; 隨機待定時間
	dc.l	$F0022400,$407A0000
	dc.l	$F00E0000	; 白虎穿雲
	dc.l	$F02B0100	; 空中動作|$130(OBJ)
	dc.l	$F0070000,sub_16CCF6	; 同步坐標
	dc.l	$40579CC1,$4057CE00,$00570602,$40570603
	dc.l	$00570604,$40570606,$00570607,$40570608
	dc.l	$F0130000
	dc.l	$F05E0100
	dc.l	$F05C0900	; 爆炸屬性
	dc.l	$F0410100
	dc.l	$F00BFF00,$01950000
	dc.l	$F00BFF00,$01950000
	dc.l	$F0330100
	dc.l	$F0340004,$00590000,$00040700,$20580407
	dc.l	$F0340004,$00590000,$00050800,$20580508
	dc.l	$F0340004,$005B0000,$00040900,$005A0409
	dc.l	$F0340004,$005B0000,$00050900,$005A0509
	dc.l	$F00BBF00,$00D10000
	dc.l	$F0140009,$00000100
	dc.l	$F05E0000
	dc.l	$F0340004,$005D0000,$00000000
	dc.l	$F0020200,$005C0000
	dc.l	$F0340004,$005F0000,$00000000
	dc.l	$F0020200,$005E0000
	dc.l	$F0340004,$00610000,$00000000,$00600000
	dc.l	$F0340004,$00620000,$00000000,$00600000
	dc.l	$F0340004,$00640000,$00000000,$00630000
	dc.l	$F0340004,$00650000,$00000000,$00630000
	dc.l	$F0340004,$00670000,$00000000,$00660000
	dc.l	$F0340004,$00680000,$00000000,$00660000
	dc.l	$F0340004,$00690000,$00000000,$00660000
	dc.l	$F0340004,$006A0000,$00000000,$00660000
	dc.l	$F0330000
	dc.l	$F0030000,$006B0010
	dc.l	$F0020400,$006B0000
	dc.l	$80000000
	dc.l	$80000000

off_1C33FE:	; 機關呂布
	dc.l	dword_23DEEE	; 出場動作
	dc.l	$0023AC7A,$0023AC7E,$0023AC80,$0035A298
	dc.l	$003BE6A1,$09020024,$00000000,$00001400
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000300,$00000035
	dc.l	$A2B20000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000020	; 木化[$20]
	dc.l	$00000000,$00000600,$00000000,$00000000
dword_23DEEE:	; 白虎穿雲
	dc.l	$00570A06,$00570A06,$40570A08,$40570A08
	dc.l	$00570A0A,$40570A0A,$20580A0B,$20580A0B
	dc.l	$20580A0C,$20580A0C,$005A0A0E,$405A0A0E
	dc.l	$F0030000,$005A0A0E
	dc.l	$F061FE00,$0023DE7A,$00000000
	dc.l	$F00BBF00,$00D10000
	dc.l	$F0140009,$00000100
	dc.l	$F0020300,$005C0000
	dc.l	$F0020300,$005E0000
	dc.l	$F0020300,$40600000
	dc.l	$F0020300,$00630000
	dc.l	$F0020400,$40660000
	dc.l	$F0020300,$006B0000
	dc.l	$80000000

sub_16CCF6:
	movem.l	a2-a3,-(sp)
	movea.l	$C(sp),a3
	movea.l	$114(a3),a2
	tst.w	$6C(a2)
	bne.s	loc_16CD0C
	moveq	#0,d0
	movea.l	d0,a2
loc_16CD0C:
	move.l	a2,d0
	bne.s	loc_16CD18
	jsr		$15EC62
	movea.l	d0,a2
loc_16CD18:
	tst.w	$6C(a2)
	bne.s	loc_16CD22
	moveq	#0,d0
	movea.l	d0,a2
loc_16CD22:
	move.l	a2,d0
	beq.s	loc_16CD62
	move.w	$C8(a2),$C8(a3)
; 同步縱坐標
	move.w	$22(a2),d0
	move.w	$22(a3),d1
	sub.w	d1,d0
	bge.s	loc_16CD3E
	addq.w	#7,d0
loc_16CD3E:
	add.w	d0,$22(a3)
; 同步橫坐標
	move.w	$20(a2),d0
	move.w	$20(a3),d1
	sub.w	d1,d0
	bge.s	loc_16CD58
	addq.w	#7,d0
loc_16CD58:
	add.w	d0,$20(a3)
	bra.s	loc_16CD70
loc_16CD62:
	addi.w	#$50,$20(a3)
loc_16CD70:
	movem.l	(sp)+,a2-a3
	rts


dword_27BD72:	; 十里荊棘
	dc.l	$F0540A00
	dc.l	$F04F060D
	dc.l	$F0450300
	dc.l	$F0130100
	dc.l	$F03D0007	; 灰色身軀
	dc.l	$F0280C00
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0290000
	dc.l	$F0070000,sub_27BD72	; 定點空中
	dc.l	$F0030000,$004B0015
	dc.l	$F00BBF00,$027DF448
	dc.l	$F0140314,$00000100
	dc.l	$F0070000,$0016D404	; 孟獲獅吼功
	dc.l	$F00E0200
	dc.l	$F0280300
	dc.l	$F01000FD,$00700000
	dc.l	$F0100003,$00700000
	dc.l	$F0290000
	dc.l	$F03D0000	; 原色身軀
	dc.l	$F0130000
	dc.l	$F00BFF00,$019B0000
	dc.l	$F01000FC,$00710000,$F0100004,$00710000
	dc.l	$F061FE00,$0023CF50,$0017FFDD	; 身後冰焰
	dc.l	$F061FE00,$0023CF50,$0000FF00	; 身後冰焰
	dc.l	$F0330100
	dc.l	$F0340004,$00730000,$00000000,$00720000
	dc.l	$F01000FE
	dc.l	$F0340004,$00750000,$00000000,$00740000
	dc.l	$F0340004,$00770000,$00000000,$00760000
	dc.l	$F0100002
	dc.l	$F0340004,$00790000,$00000000,$00780000
	dc.l	$F0340004,$007B0000,$00000000,$007A0000
	dc.l	$F0330000
	dc.l	$F00E0200
	dc.l	$F05E0100
	dc.l	$F00B9F00,$02CD0000
	dc.l	$F015FE00,off_27BD72,$0020F100	; [2]右
	dc.l	$F015FE01,off_27BD72,$FFE0F100	; [2]左
	dc.l	$F015FE00,off_27BD72,$00640000	; [3]右
	dc.l	$F015FE01,off_27BD72,$FF9C0000	; [3]左
	dc.l	$F015FE00,off_27BD72,$00280F00	; [4]右
	dc.l	$F015FE01,off_27BD72,$FFD80F00	; [4]左
	dc.l	$F00BFF00,$019A0000
	dc.l	$F0020200,$000D0000,$F01000FE
	dc.l	$F0020200,$000E0000,$F0100002
	dc.l	$F015FE00,off_27BD72,$0000E200	; [1]中
	dc.l	$F015FE00,off_27BD72,$0060F100	; [2]右
	dc.l	$F015FE01,off_27BD72,$FFA0F100	; [2]左
	dc.l	$F015FE00,off_27BD72,$00C80000	; [3]右
	dc.l	$F015FE01,off_27BD72,$FF380000	; [3]左
	dc.l	$F015FE00,off_27BD72,$00780F00	; [4]右
	dc.l	$F015FE01,off_27BD72,$FF880F00	; [4]左
	dc.l	$F015FE01,off_27BD72,$00001E00	; [5]中
	dc.l	$F00BFF00,$019A0000
	dc.l	$F0020200,$000F0000,$F01000FE
	dc.l	$F0020200,$00100000,$F0100002
	dc.l	$F015FE00,off_27BD72,$004CE200	; [1]右
	dc.l	$F015FE01,off_27BD72,$FFB4E200	; [1]左
	dc.l	$F015FE00,off_27BD72,$00A0F100	; [2]右
	dc.l	$F015FE01,off_27BD72,$FF60F100	; [2]左
	dc.l	$F015FE00,off_27BD72,$012C0000	; [3]右
	dc.l	$F015FE01,off_27BD72,$FED40000	; [3]左
	dc.l	$F015FE00,off_27BD72,$00C80F00	; [4]右
	dc.l	$F015FE01,off_27BD72,$FF380F00	; [4]左
	dc.l	$F015FE00,off_27BD72,$004C1E00	; [5]右
	dc.l	$F015FE01,off_27BD72,$FFB41E00	; [5]左
	dc.l	$F00BFF00,$019A0000
	dc.l	$F0020200,$00110000,$F01000FE
	dc.l	$F0020200,$00120000,$F0100002
	dc.l	$F015FE00,off_27BD72,$0098E200	; [1]右
	dc.l	$F015FE01,off_27BD72,$FF68E200	; [1]左
	dc.l	$F015FE00,off_27BD72,$00E0F100	; [2]右
	dc.l	$F015FE01,off_27BD72,$FF20F100	; [2]左
	dc.l	$F015FE00,off_27BD72,$01900000	; [3]右
	dc.l	$F015FE01,off_27BD72,$FE700000	; [3]左
	dc.l	$F015FE00,off_27BD72,$01180F00	; [4]右
	dc.l	$F015FE01,off_27BD72,$FEE80F00	; [4]左
	dc.l	$F015FE00,off_27BD72,$00981E00	; [5]右
	dc.l	$F015FE01,off_27BD72,$FF681E00	; [5]左
	dc.l	$F05E0000
	dc.l	$F0280300
	dc.l	$F0020200,$000C0000,$F01000FF
	dc.l	$F0020200,$000D0000,$F0100001
	dc.l	$F0020200,$000E0000,$F01000FF
	dc.l	$F0020200,$000F0000,$F0100001
	dc.l	$F0020200,$00100000,$F01000FF
	dc.l	$F0020200,$00110000,$F0100001
	dc.l	$F0020200,$00120000,$F01000FF
	dc.l	$F0020200,$000B0000,$F0100001
	dc.l	$F0290000
	dc.l	$80000000

sub_27BD72:
	movea.l	4(sp),a0
	move.w	($D0A000).l,d0
	addi.w	#$E0,d0			; 橫坐標居中
	move.w	d0,$20(a0)
	move.w	#$CB,$22(a0)	; 縱坐標居中
	move.w	#$FED4,$24(a0)	; 豎坐標
	rts

off_27BD72:	; 地刺機關
	dc.l	lword_27BD72
	dc.l	$00274AA0,$00274AA4,$00274AA6,$003410D4
	dc.l	$0017A75B,$070D0420,$00000000,$00000A00
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$0000030D,$00000000
	dc.l	$00000000,$00000000,sub_27BD73,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00001C00,$00000000,$00000000
lword_27BD72:
	dc.l	$F00BDF00,$00D10FA0
	dc.l	$20C80000,$00C90000,$20CA0000,$00CB0000
	dc.l	$20CC0000,$00CD0000
	dc.l	$F0410100,$F0021200,$20CE0000
	dc.l	$00CF0000,$00D00000,$00D10000,$00D20000
	dc.l	$00D30000,$00D40000,$00D50000,$00D60000
	dc.l	$00D70000,$00D80000
	dc.l	$80000000
sub_27BD73:	; 傳出受擊動作指針|00113AC0
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	movea.l	$C(sp),a1
	move.w	$C8(a2),d0
	cmp.w	$5C(a1),d0
	beq.s	loc_27BD73
	pea		(7).w		; 正面浮空
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$15E152
	bra.s	loc_27BD74
loc_27BD73:
	pea		($C).w		; 反身浮空
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$15E152
loc_27BD74:
	lea		$C(sp),sp
	movea.l	(sp)+,a2
	rts


dowrd_11CE50:	; 起身召神
	dc.l	$F0540A00
	dc.l	$F04F0612
	dc.l	$F0450700
	dc.l	$F00BFF00,$015D0000		; 「殺」
	dc.l	$F0130100	; 起手無敵
	dc.l	$F0020200,$00700000		; 定點閃現
	dc.l	$F0020200,$00710000
	dc.l	$F00B9F00,$02CD0000
	dc.l	$00720000,$00740000,$00760000,$00780000,$007A0000
	dc.l	$F0070000,sub_11CF30	; 召喚援將
	dc.l	$F0280300
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0290000
	dc.l	$F0130000	; 取消無敵
	dc.l	$F0110000,$40249C14,$40249C14	; 反向出現
	dc.l	$F00BDF00,$01970000
	dc.l	$F0280200
	dc.l	$F0020800,$00230000
	dc.l	$F0020800,$00240000
	dc.l	$F0020800,$00250000
	dc.l	$F0020800,$00240000
	dc.l	$F0290000
	dc.l	$F0020800,$00230000
	dc.l	$80000000


dword_23CD48:	; 起身閃現-黑虎出洞
	dc.l	$F0540800
	dc.l	$F04F0612
	dc.l	$F0450700
	dc.l	$F05E0100	; 正向閃現
	dc.l	$F00BFF00,$019B0000
	dc.l	$F0020200,$00700000
	dc.l	$F0020200,$00710000
	dc.l	$F00B9F00,$02CD0000
	dc.l	$00720000,$00740000,$00760000,$00780000,$007A0000
	dc.l	$F05E0000
	dc.l	$F0130100
	dc.l	$F0280300
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0290000
	dc.l	$F0070000,$0016CCF6,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76,$40570000
	dc.l	$F0070000,$0016CD76
	dc.l	$F0110000,$40579C00,$40579C00
	dc.l	$F0040602	; 黑虎出洞

dword_23BD78:	; 起身動作
	dc.l	$F0061200	; 生命值為零則跳索引+$12
	dc.l	$F0130000
	dc.l	$F0020200,$00330000
	dc.l	$F0130100
	dc.l	$F0070000,sub_16C9D8
	dc.l	$F0020200,$002E0000
	dc.l	$F00E0100
	dc.l	$F0020200,$002F0000
	dc.l	$F0020300,$00300000
	dc.l	$F0020200,$00310000,$00321500,$00320000
	dc.l	$80000000
	dc.l	$F00E0000	; 索引+$12
	dc.l	$F0282800
	dc.l	$002D0000,$40000000
	dc.l	$F0290000
	dc.l	$80000000

sub_16C9D8:	; 真呂布起身後動作
	movem.l	d2-d4/a2,-(sp)
	movea.l	$14(sp),a2
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10F796
	addq.l	#8,sp
	move.l	a2,-(sp)
	jsr		$12022E
	addq.l	#4,sp
	tst.l	d0
	bne.w	loc_16CA9C
	jsr		$10F538
	tst.l	d0
	bne.w	loc_16CA9C
	move.l	a2,-(sp)
	jsr		$11014A
	addq.l	#4,sp
	tst.l	d0
	bne.w	loc_16CA9C
	jsr		$14D960		; 難度傷害等級
	asr.l	#2,d0		; 0-3
	move.w	d0,d4
	clr.b	d3
	pea		($3FF).w
	jsr		$1024B0		; 小隨機
	addq.l	#4,sp
	move.w	d4,d1
	add.w	d1,d1
	movea.l	#$23AD8A,a0
	move.w	(a0,d1.w),d1
	andi.l	#$FFFF,d1
	cmp.l	d1,d0
	bge.s	loc_16CA52
	moveq	#2,d3
loc_16CA52:
	tst.b	d3
	beq.s	loc_16CA9C
	pea		($7F).w
	jsr		$1024B0		; 小隨機
	move.w	d0,d2
	cmpi.w	#$26,d2
	bcc.s	loc_16CA6E
	pea		($E).w
	bra.s	loc_16CA7E
loc_16CA6E:
	cmpi.w	#$59,d2
	bcc.s	loc_16CA7A
	pea		($F).w
	bra.s	loc_16CA7E
loc_16CA7A:
	pea		($10).w
loc_16CA7E:
	pea		(3).w
	move.l	a2,-(sp)
	jsr		$10EBDE		; 計算動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18		; 寫入動作
	lea		$C(sp),sp
loc_16CA9C:
	movem.l	(sp)+,d2-d4/a2
	rts


sub_1AEFAE:	; 青龍密室地圖設定
	movem.l	d2-d7/a2-a3,-(sp)
	jsr		$1578E4			; 封禁我方行動|關閉道具格
	jsr		$10F4F4			; 敵方不攻擊
	clr.l	-(sp)
	jsr		$14B73E
; 背景音樂
	pea		($2BEC9E).l		; 神劍
	pea		(2).w			; 曲目
	pea		($2CDE3E).l		; 音樂組
	jsr		$12BC40			; 背景音樂
	pea		($7F).w			; 音量
	clr.l	-(sp)			; 編號
	jsr		$12BDA0			; 音樂音量等
; 背景地板
	clr.l	-(sp)
	jsr		$14BD34
	clr.l	-(sp)
	pea		(word_1D8F3A).l	; 地板圖片組
	jsr		$155552			; 分配背景墻、地板圖等
	pea		(1).w
	pea		(word_1DD406).l	; 背景墻圖組
	jsr		$155552			; 分配背景墻、地板圖等
	move.w	#0,($D00002).l
	move.w	#1,($D00004).l
	pea		($62).w
	jsr		$13A27E			; 計算邊界數據指針|0001
	lea		$30(sp),sp
	jsr		$1556B4
	jsr		$155DEC			; 刷新背景墻、地板圖等
	jsr		$1559EE
	jsr		$12E5E8			; 路線指示初始化
	jsr		$12EE6E			; 出兵初始化
	jsr		sub_1B0104		; 青龍雕塑
	clr.b	($81B108).l		; 四神獸密室進度
	pea		($10).w
	pea		($A0).w
	jsr		$14DC36			; 初始屏幕視野
	pea		($FE).w
	pea		($690).w
	clr.l	-(sp)
	clr.l	-(sp)
	jsr		$154F44			; 鎖定版邊
	lea		$18(sp),sp
	moveq	#$7F,d0
	move.l	d0,($81B112).l
; 雷公閃電
	pea		($363784).l
	jsr		$1552C4
	move.l	d0,d2
	pea		($363784).l
	move.l	d2,-(sp)
	pea		(2).w
	jsr		$10388E			; 預寫色盤
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($32).w
	pea		($180).w
	pea		($2A20E6).l		; 雷公雕塑上的閃電|左側
	jsr		$1517D4
	lea		$24(sp),sp
	movea.l	d0,a3
	move.l	#$2A2096,$2C(a3)	; 循環閃電
	clr.w	$3C(a3)
	clr.w	$54(a3)
	clr.w	$68(a3)
	move.w	d2,$50(a3)
	move.w	d2,$8A(a3)
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($32).w
	pea		($4E0).w
	pea		($2A20E6).l		; 雷公雕塑上的閃電|右側
	jsr		$1517D4
	movea.l	d0,a3
	move.l	#$2A2096,$2C(a3)	; 循環閃電
	clr.w	$3C(a3)
	clr.w	$54(a3)
	clr.w	$68(a3)
	move.w	d2,$50(a3)
	move.w	d2,$8A(a3)
; 其他設定
	jsr		$1AEFA2
	clr.l	-(sp)
	jsr		$1450D8
	pea		($B4).w			; 三秒內結束出場動作
	jsr		$15EAF8			; 進場後刷新站立動作
	pea		(1).w
	jsr		$14B73E
	jsr		$1578DA			; 我方可行動
	jsr		$10F4EA			; 敵方可行動
	jsr		$10F4FC			; 敵方可攻擊
	clr.b	($81B5D0).l
	moveq	#0,d2
loc_1AF3E2:
	movea.l	#$81B9A4,a0
	clr.b	(a0,d2.l)
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_1AF3E2
	lea		$20(sp),sp
	movem.l	(sp)+,d2-d7/a2-a3
	rts

word_1D8F3A:	; 青龍密室地板圖|地板長度$300+$300
	dc.w	$0376,$0080	; 橫縱坐標
	dc.l	$36E962		; 地板圖組
	dc.w	$7400,0,$0BA5,0
	dc.l	$36DC42		; 地板色盤
	dc.w	0,0,0,0		; 左地板圖[0000]
	dc.w	$0000,$0080	; 橫縱坐標
	dc.l	$36E962		; 地板圖組
	dc.w	$7400,0,$0BA5,0
	dc.l	$36DC42		; 地板色盤
	dc.w	0,0,0,0		; 左地板圖[0000]
	dc.w	$04F6,$0080	; 橫縱坐標
	dc.l	$36E962		; 地板圖組
	dc.w	$7400,0,$0BA5,0
	dc.l	$36DC42		; 地板色盤
	dc.w	0,0,1,0		; 右地板圖[0001]
	dc.w	$0180,$0080	; 橫縱坐標
	dc.l	$36E962		; 地板圖組
	dc.w	$7400,0,$0BA5,0
	dc.l	$36DC42		; 地板色盤
	dc.w	0,0,1,0		; 右地板圖[0001]
	dcb.l	7,0

word_1DD406:	; 青龍密室背景墻
; 左鏡像密室
	dc.w	$0121,$0000		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C100,$006F,$6AB3,$E186	; N=$C1|$E186[雷公雕塑]
	dc.l	$361F6A
	dc.w	0,$0108,$0800,0
	dc.w	$FFF0,$0066		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C300,$006F,$6AB3,$F5D7	; N=$C3左$F5D7[台階]
	dc.l	$361F6A
	dc.w	0,$0108,$0800,0
	dc.w	$01D0,$0066		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C400,$006F,$6AB3,$F5D7	; N=$C4右$F5D7[台階]
	dc.l	$361F6A
	dc.w	0,$0108,$0800,0
	dc.w	$FFF0,$0000		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C500,$006F,$6AB3,$D145	; $D145[左壁雕]
	dc.l	$361FAA
	dc.w	0,$0107,$0700,0
	dc.w	$00F0,$0000		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C600,$006F,$6AB3,$DD76	; $DD76[中壁雕]
	dc.l	$361FAA
	dc.w	0,$0107,$0700,0
	dc.w	$01F0,$0000		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C200,$006F,$6AB3,$E186	; N=$C2|$E186[右壁雕]
	dc.l	$361FAA
	dc.w	0,$0107,$0700,0
; 右鏡像密室
	dc.w	$0480,$0000		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C100,$006F,$6AB3,$E186	; N=$C1|$E186[雷公雕塑]
	dc.l	$361F6A
	dc.w	0,$0108,$0800,0
	dc.w	$034F,$0066		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C300,$006F,$6AB3,$F5D7	; N=$C3左$F5D7[台階]
	dc.l	$361F6A
	dc.w	0,$0108,$0800,0
	dc.w	$052F,$0066		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C400,$006F,$6AB3,$F5D7	; N=$C4右$F5D7[台階]
	dc.l	$361F6A
	dc.w	0,$0108,$0800,0
	dc.w	$02E0,$0000		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C500,$006F,$6AB3,$D145	; $D145[左壁雕]
	dc.l	$361FAA
	dc.w	0,$0107,$0700,0
	dc.w	$03E0,$0000		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C600,$006F,$6AB3,$DD76	; $DD76[中壁雕]
	dc.l	$361FAA
	dc.w	0,$0107,$0700,0
	dc.w	$04E0,$0000		; 橫縱坐標
	dc.l	$362D6A		; 背景墻
	dc.w	$C200,$006F,$6AB3,$D556	; $D556[右壁雕]
	dc.l	$361FAA
	dc.w	0,$0107,$0700,0
	dcb.l	7,0

sub_1B0104:
	movem.l	d2-d6/a2,-(sp)
	pea		($363B44).l
	jsr		$1552C4
	move.l	d0,d2			; 分配色表位
	pea		($363B44).l
	move.l	d2,-(sp)
	pea		(2).w
	jsr		$10388E			; 預寫色盤
	lea		$10(sp),sp
	moveq	#0,d3			; 第一根柱
	moveq	#0,d4			; 面右
	moveq	#3-1,d5			; 三柱
	moveq	#2-1,d6			; 三三六柱
loc_1B0132:
	move.l	d4,-(sp)		; 面向
	clr.l	-(sp)
	move.w	d3,d0
	add.w	d0,d0
	movea.l	#word_2A43E6,a0	; 青龍柱雕縱坐標
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	d3,d0
	add.w	d0,d0
	movea.l	#word_2A43DE,a0	; 青龍柱雕橫坐標
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.l	d0,-(sp)
	pea		($2A43FA).l		; 青龍柱雕
	jsr		$1517D4			; 佈置
	lea		$14(sp),sp
	movea.l	d0,a2
	move.w	#$35E,$3E(a2)	; 青龍[035E]
	move.w	d2,$50(a2)
	move.w	d2,$8A(a2)
	addq.l	#1,d3
	dbf		d5,loc_1B0132
	moveq	#1,d4			; 面左
	moveq	#3-1,d5			; 三柱
	dbf		d6,loc_1B0132
	clr.b	($81B136).l
	movem.l	(sp)+,d2-d6/a2
	rts

word_2A43DE:	; 青龍柱雕橫坐標
	dc.w $0050, $001E, $0356, $0646, $0678, $0318
word_2A43E6:	; 青龍柱雕縱坐標
	dc.w $00CA, $0100, $0100, $00CC, $0100, $0100


sub_1AF652:	; 青龍密室劇情
	movem.l	d2/a2-a3,-(sp)
	moveq	#0,d0
	move.b	($81B108).l,d0	; 卷軸進度
	moveq	#3,d1
	cmp.l	d1,d0
	bhi.w	loc_1AFD8C
	add.l	d0,d0
	move.w	jpt_1AF670(pc,d0.l),d0
	jmp		jpt_1AF670(pc,d0.w)
jpt_1AF670:
	dc.w	loc_1B0E8C-jpt_1AF670
	dc.w	loc_1AFA7A-jpt_1AF670
	dc.w	loc_1AFB8E-jpt_1AF670
	dc.w	loc_1AFD50-jpt_1AF670
; 卷軸進度[出場]
loc_1B0E8C:
; 左慈出場
	jsr		$10F520			; 敵方不行動
	jsr		$109CC2			; 分配OBJ
	move.l	d0,d2
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($FF24).w
	pea		($C8).w
	move.w	($D0A000).l,d0
	ext.l	d0
	addi.l	#$E0,d0
	move.l	d0,-(sp)
	pea		($247EB2).l		; 左慈
	move.l	d2,-(sp)
	jsr		$10A1BA			; 敵方出場
	move.l	d2,-(sp)
	jsr		$10F2C2			; 計算OBJ地址
	movea.l	d0,a2
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10FC92
	pea		(6).w
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$3C(sp),sp
; 真呂布出場
	jsr		$109CC2			; 分配OBJ
	move.l	d0,d2
	clr.l	-(sp)
	clr.l	-(sp)
	pea		($FF1F).w
	pea		($C8).w
	move.w	($D0A000).l,d0
	ext.l	d0
	addi.l	#$E0,d0
	move.l	d0,-(sp)
	pea		(unk_23B38A).l	; 真呂布指針
	move.l	d2,-(sp)
	jsr		$10A1BA			; 敵方出場
	move.l	d2,-(sp)
	jsr		$10F2C2			; 計算OBJ地址
	movea.l	d0,a2
	move.l	a2,($81B608).l	; 真呂布OBJ
	moveq	#0,d0
	move.b	($81A326).l,d0	; 遊戲難度[1-8]
	lsr.l	#1,d0
	addq.l	#2,d0			; 基礎兩血
	add.b	(ram_0002).l,d0	; 難度+[0/1/2/3]
	mulu.w	#$140,d0		; 計算生命值
	move.w  d0,$6C(a2)
	move.w	($D0A000).l,d0
	addi.w	#$E0,d0
	move.w	d0,($81C750).l
	clr.w	$1DE(a2)
	clr.w	$216(a2)
	move.w	#8,$218(a2)
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10FC92
	pea		(4).w
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$3C(sp),sp
	move.w	#$398,($80C2A8).l		; 出招頻率下限
	moveq	#0,d0
	move.b	($81A326).l,d0	; 遊戲難度[1-8]
	lsr.l	#1,d0
	lsl.l	#2,d0
	add.b	(ram_0002).l,d0	; 難度+[0/1/2/3]
	add.l	d0,d0
	movea.l	#(word_1C0FB0),a0
	move.w	(a0,d0.l),($80C2AA).l	; 出招頻率上限
	addq.b	#1,($81B108).l	; 下一進度
	bra.w	loc_1AFD8C
; 卷軸進度[對話]
loc_1AFA7A:
; 出場對話
	movea.l	$81B608.l,a0	; 真呂布OBJ
	cmpi.w	#2,$50(a0)
	bne.w	loc_1AFD8C
	move.w	#1,$174(a0)		; 真呂布無敵容錯
	jsr		$1578E4			; 封我行關道具
	pea		($13A646).l
	pea		($1E).w			; 主循環半秒
	jsr		$100EA4
	addq.l	#8,sp
	pea		($48).w			; 「來者何人！竟敢擾本尊清淨！」
	pea		($24).w			; 真呂布說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	pea		($133).w		; 「祖師息怒！今天下分崩，九州幅裂，干戈日起，生靈塗炭。」
	pea		($15).w			; 左慈說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	pea		($134).w		; 「元惡劉備，偽為亂階，群兇縱橫，殘剝海內。望祖師降罰，暴逆並殪，以漸冰消。」
	pea		($15).w			; 左慈說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	pea		($135).w		; 「好不知死，敢為欺天之謀，汝等助惡，其罪當誅！」
	pea		($24).w			; 真呂布說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	jsr		$1578DA			; 我方可行動
	jsr		$10F516			; 敵方可行動
; 出場動作
	movea.l	$81B608.l,a2	; 真呂布OBJ
	pea		(9).w			; 飛砂走石
	pea		(3).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
; 頭像血條
	move.l	a2,-(sp)
	clr.l	-(sp)
	jsr		$124DBE			; 設定血槽
	addq.l	#8,sp
	move.w	#1,$D0(a2)		; 完成血槽
	clr.w	$11E(a2)		; 第一血槽
	jsr		$1293A2			; 特殊技解禁
; 清除雷電
	moveq	#0,d2
loc_1AFB66:
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#$81B5BC,a0	
	move.l	(a0,d0.w),-(sp)
	jsr		$151A3A			; 清除環身雷電
	addq.l	#4,sp
	addq.l	#1,d2
	moveq	#3,d0
	cmp.l	d2,d0
	bgt.s	loc_1AFB66
	addq.b	#1,($81B108).l	; 下一進度
	bra.w	loc_1AFD8C
; 卷軸進度[對戰]
loc_1AFB8E:
; 對戰真呂布
	movea.l	$81B608.l,a2	; 真呂布OBJ
	tst.w	$6C(a2)
	bne.w	loc_1AFD8C
	clr.b	($80C2B5).l		; 全局無判定
	clr.b	($81B5E0).l		; 敵方不行動，停止刷新動作
	jsr		$1578E4			; 封禁我方行動，關閉道具格
loc_1AFB9C:
	move.w	#1,$174(a2)		; 無敵容錯
	jsr		$13A646.l		; 主循環
	cmpi.w	#$A,$50(a2)
	bne.w	loc_1AFB9C
; 真呂布不敗
	move.w	#1,$6C(a2)		; 保留身軀
	move.w	#1,$A2(a2)		; 無視地形
	pea		(5).w			; 起身動作
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
	jsr		sub_1B00C0		; 清除敵兵
	clr.l	-(sp)
	jsr		$14B73E
	addq.l	#4,sp
; 真呂布走近
loc_1AF434:
	move.w	#1,$174(a2)		; 無敵容錯
	jsr		$13A646.l		; 主循環
	cmpi.w	#2,$50(a2)
	bne.s	loc_1AF434
	move.w	$20(a2),d0
	ext.l	d0
	move.w	($D0A000).l,d1
	ext.l	d1
	addi.l	#$32,d1
	cmp.l	d1,d0
	bge.s	loc_1AF4A6
; 向右走近
	clr.w	$C8(a2)
	pea		($D).w
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
loc_1AF486:
	move.w	#1,$174(a2)		; 無敵容錯
	jsr		$13A646			; 主循環
	move.w	$20(a2),d0
	ext.l	d0
	move.w	($D0A000).l,d1
	ext.l	d1
	addi.l	#$32,d1
	cmp.l	d1,d0
	blt.s	loc_1AF486
	bra.s	loc_1AF504
loc_1AF4A6:
; 向左走近
	move.w	$20(a2),d0
	ext.l	d0
	move.w	($D0A000).l,d1
	ext.l	d1
	addi.l	#$18E,d1
	cmp.l	d1,d0
	ble.s	loc_1AF504
	move.w	#1,$C8(a2)
	pea		($D).w
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
loc_1AF4E6:
	move.w	#1,$174(a2)		; 無敵容錯
	jsr		$13A646			; 主循環
	move.w	$20(a2),d0
	ext.l	d0
	move.w	($D0A000).l,d1
	ext.l	d1
	addi.l	#$18E,d1
	cmp.l	d1,d0
	bgt.s	loc_1AF4E6
loc_1AF504:
; 面對站立
	pea		(1).w
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
	move.w	#1,$174(a2)
	pea		($13A646).l
	pea		($1E).w			; 半秒主循環
	jsr		$100EA4
	addq.l	#8,sp
; 擊斃左慈
	pea		($136).w		; 「此賊欺師罔上，擾亂於外，伯公何尚不知？」
	jsr		($15EC62).l		; 第一順位角色
	movea.l	d0,a0
	movea.l	$58(a0),a1
	move.b	1(a1),d0
	andi.l	#$FF,d0
	move.l	d0,-(sp)		; 我方說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	pea		(word_23B76C).l	; 五雷轟頂
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	addq.l	#8,sp
	pea		($13A646).l
	pea		($F0).w			; 四秒主循環
	jsr		($100EA4).L
	addq.l	#8,sp
; 退場動作
	pea		($137).w		; 「逆徒已死，汝輩好自為之。」
	pea		($24).w			; 真呂布說
	jsr		$1343D6			; 對話
	addq.l	#8,sp
	pea		(6).w			; 升空動作
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
; 完成離開
	bra.s	loc_1AF594
loc_1AF58E:
	jsr		$13A646			; 主循環
loc_1AF594:
	move.w	$24(a2),d0
	ext.l	d0
	cmpi.l	#$FFFFFF10,d0
	bgt.s	loc_1AF58E
	moveq	#0,d0
	move.w	$E(a2),d0
	move.l	d0,-(sp)
	jsr		$109D38			; 關閉敵方OBJ
	addq.l	#4,sp
	jsr		$1578DA			; 我方可行動
	pea		(1).w
	jsr		$14B73E
	addq.l	#4,sp
	addq.b	#1,($81B108).l	; 下一進度
	bra.w	loc_1AFD8C
; 卷軸進度[結束]
loc_1AFD50:
	jsr		$12E5FC			; 清除路線指示與計時
	jsr		$12EEF6			; 關閉退兵計時器
	pea		($13A646).l
	pea		($B4).w			; 主循環三秒
	jsr		$100EA4
	addq.l	#8,sp
	moveq	#4,d0			; 結束終章
	bra.s	loc_1AFD8E
loc_1AFD8C:
	moveq	#0,d0		
loc_1AFD8E:
	movem.l	(sp)+,d2/a2-a3
	rts

word_1C0FB0:	; 出招頻率表
	dc.w	$28,  $46,  $6E,  $AA	; 難度[1]
	dc.w	$32,  $64,  $96,  $BE	; 難度[2|3]
	dc.w	$3C,  $AA,  $C8,  $FA	; 難度[4|5]
	dc.w	$46,  $E6,  $118,$168	; 難度[6|7]
	dc.w	$50,  $1CC, $2F8,$398	; 難度[8]

word_23B76C:	; 雷擊左慈
	dc.w	$010F
	dc.l	dword_23B76C,$01002840,0,0
dword_23B76C:
	dc.l	$F0540A00
	dc.l	$F0020200,$006C0000
	dc.l	$F00BFF00,$01960000
	dc.l	$F0020200,$006D0000
	dc.l	$F0070000,sub_16CD94	; 雷擊左慈墜落
	dc.l	$F0280200
	dc.l	$F0020200,$006E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0290000
	dc.l	$80000000

sub_16CD94:
	link	a6,#0
	movem.l	d2/a2-a3,-(sp)
; 五雷轟頂
	moveq	#5-1,d2
loc_16CD94:
	jsr		$14DF94			; 分配機關OBJ
	movea.l	d0,a2
	clr.l	-(sp)			; 面右
	clr.l	-(sp)			; 豎坐標
	pea		($CB).w			; 縱坐標
; 五雷轟頂|分散雷電
	move.l	d2,-(sp)
	jsr		($1024B0).l		; 小隨機
	addq.l	#4,sp
	lsl.l	#3,d0			; 橫坐標偏移
	move.w	($D0A000).l,d1
	addi.w	#$D0,d1			; 居中E0
	add.l	d1,d0
	move.l	d0,-(sp)		; 橫坐標
	pea		($23CE60).l		; 閃電
	move.l	a2,-(sp)
	jsr		$14E076			; 設定機關
	clr.w	$6C(a2)			; 判定敵方
	lea		$18(sp),sp
	pea		($13A646).l		; 主循環
	pea		($10).w			; 延時
	jsr		($100EA4).L
	addq.l	#8,sp
	dbf		d2,loc_16CD94
; 左慈墜落
	jsr		$14DF94			; 分配機關OBJ
	movea.l	d0,a3
	pea		(1).w			; 面左
	pea		($FF20).w		; 豎坐標
	pea		($CB).w			; 縱坐標
	move.w	($D0A000).l,d0
	addi.w	#$80,d0			; 屏幕偏左
	ext.l	d0
	move.l	d0,-(sp)		; 橫坐標
	pea		(unk_23CE60).l	; 左慈
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	lea		$18(sp),sp
	movem.l	-$C(a6),d2/a2-a3
	unlk	a6
	rts

unk_23CE60:	; 左慈墜落
	dc.l	dword_23CE60	; 白鶴墜落
	dc.l	$002477FC,$00247800,$00247802,$0035BF94
	dc.l	$00448865,$07020424,$00000000,$00000A00
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000035
	dc.l	$BFAE0000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
dword_23CE60:
	dc.l	$F05A0000,$0035B6F4	; 0802|左慈色盤
	dc.l	$F0280400,$0020FF00,$00200100,$F0290000
	dc.l	$F0020400,$001FF800
	dc.l	$F0020400,$00200000
	dc.l	$F00E0000	; 0805
	dc.l	$F015FF00,off_24B812,$000A0000
	dc.l	$F0020600,$00210101
	dc.l	$F0020600,$00220102
	dc.l	$F0030000,$00240103	; 落左
	dc.l	$F0282800,$00230000,$40230000,$F0290000
	dc.l	$80000000
off_24B812:
	dc.l	dword_24B7DA	; 左慈墜落
	dc.l	$002477FC,$00247800,$00247802,$0035BF94
	dc.l	$00448865,$07020424,$00000000,$00000A00
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000035
	dc.l	$BFAE0000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
dword_24B7DA:
	dc.l	$F00BEF00,$01B10000	; 慘叫
	dc.l	$0025A6D8
	dc.l	$F0020600,$0025FF02
	dc.l	$F0020600,$0026FF03
	dc.l	$F0030000,$0027FF03	; 收右
	dc.l	$F0282800,$00280000,$40280000,$F0290000
	dc.l	$80000000


sub_1AF41A:	; 進場動作
	link	a6,#0
	move.l	a2,-(sp)
	movea.l	8(a6),a2		; 角色OBJ
; 高空落地
	pea		($60).w
	jsr		$102480			; X偏移|隨機
	addi.w	#$150,d0
	move.w	d0,$20(a2)		; 橫坐標
	pea		($20).w
	jsr		$102480			; Y偏移|隨機
	addi.w	#$C4,d0
	move.w	d0,$22(a2)		; 縱坐標
	move.w	#$FF20,$24(a2)	; 豎坐標
	pea		(2).w
	jsr		$102480			; 面向|隨機
	move.w	d0,$C8(a2)		; 角色朝向
	pea		(off_36F958).l	; 垂直高空落地
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	move.l	a2,-(sp)
	jsr		$15CBFE
; 慘叫音效
	movea.l	$54(a2),a0
	cmpi.w	#$29F,$68(a0)
	beq.s	loc_1AF41A
	jsr		$12D4B4
	tst.l	d0
	beq.w	locret_1AF41A
loc_1AF41A:
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_1AF41B
	subi.b	#$40,($81B4C4).l
loc_1AF41B:
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.w	locret_1AF41A
	jsr		$13A578
	pea		($1).w
	movea.l	$54(a2),a0
	move.w	$68(a0),d0		; 慘叫音效
	andi.l	#$FFFF,d0
	asr.l	#8,d0
	andi.l	#3,d0
	move.l	d0,-(sp)
	movea.l	$54(a2),a0
	move.w	$68(a0),d0
	andi.l	#$FFFF,d0
	lsl.l	#8,d0
	moveq	#0,d1
	move.b	($81B4C4).l,d1
	lsl.l	#2,d1
	or.l	d1,d0
	or.l	(sp)+,d0
	ori.l	#$6F0000,d0		; 音頻音量
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	lea		$C(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_1AF41C
	move.l	($81B4A8).l,($81B4B0).l
loc_1AF41C:
	jsr		$13A58E
locret_1AF41A:
	movea.l	-4(a6),a2
	unlk	a6
	rts

off_36F958:	; 垂直高空落地動作指針
	dc.w	$081D
	dc.l	dword_36F958,$02000001,0,0
dword_36F958:
	dc.l	$F0025000,$40000000
	dc.l	$F0030000,$002B0014
	dc.l	$F00B7F00,$02BA0000
	dc.l	$F01000FE
	dc.l	$F0140009,$00000400,$002CFCFA,$002CFCFB
	dc.l	$F0100002
	dc.l	$002CFCFC,$002CFCFD,$002CFCFE,$002CFCFF
	dc.l	$002CFC01,$002CFC02,$002CFC03,$002CFC04
	dc.l	$002CFC05,$002CFC06
	dc.l	$F0140009,$00000400
	dc.l	$F0110000,$001D1400
	dc.l	$F0040805	; 起身動作


off_2B09A2:	; 詞句表|姓名、對話、引首等
	dc.l	$002AF418,word_2AF438,word_2AF466,$002AF486
	dc.l	$002AF49A,$002AF4B4,$002AF4C6,$002AF4D0
	dc.l	$002AF4DA,$002AF4E4,$002AF502,$002AF514
	dc.l	$002AF528,$002AF53C,$002AF558,$002AF56A
	dc.l	$002AF57A,$002AF590,$002AF5A6,$002AF5BC
	dc.l	word_2AF5D6,$002AF618,$002AF646,$002AF668
	dc.l	$002AF686,$002AF6A0,$002AF6B0,$002AF6C0
	dc.l	$002AF6D0,$002AF6F0,$002AF710,$002AF730
	dc.l	$002AF742,$002AF764,$002AF788,$002AF7A2
	dc.l	$002AF7C4,$002AF7E0,$002AF7F6,word_2AF810
	dc.l	word_2AF832,$002AF846,$002AF84E,$002AF866
	dc.l	$002AF88E,$002AF89A,$002AF8B0,$002AF8C6
	dc.l	$002AF8E4,$002AF90C,$002AF936,$002AF95C
	dc.l	$002AF976,$002AF992,$002AF9A4,$002AF9B6
	dc.l	$002AF9C8,$002AF9E6,$002AF9F2,$002AFA08
	dc.l	$002AFA2E,$002AFA3E,$002AFA46,$002AFA5E
	dc.l	$002AFA7A,$002AFA9C,$002AFAC0,$002AFAF4
	dc.l	$002AFB1E,$002AFB40,$002AFB4C,$002AFB60
	dc.l	word_2AFB74,$002AFB90,$002AFBC6,$002AFBE8
	dc.l	$002AFC06,$002AFC16,$002AFC2C,$002AFC48
	dc.l	$002AFC68,$002AFC7A,$002AFC8E,$002AFCB0
	dc.l	$002AFCDA,$002AFCEA,$002AFD08,$002AFD26
	dc.l	$002AFD50,$002AFD6E,$002AFD7A,$002AFD90
	dc.l	$002AFDAA,$002AFDE0,$002AFE28,word_2AFE44
	dc.l	word_2AFE6E,$002AFE9E,$002AFEB8,$002AFEE6
	dc.l	$002AFF1A,$002AFF24,$002AFF4E,$002AFF5C
	dc.l	$002AFF7E,$002AFFA6,$002AFFD8,$002AFFF2
	dc.l	$002B000E,$002B002E,$002B0054,$002B0084
	dc.l	$002B00A0,$002B00CA,$002B00F0,$002B0128
	dc.l	$002B0156,$002B016E,$002B0190,$002B01A0
	dc.l	$002B01AE,$002B01BC,$002B01F4,$002B0228
	dc.l	$002B024E,$002B025E,$002B027A,$002B0294
	dc.l	$002B02B0,$002B02C8,$002B02CE,$002B02D4
	dc.l	$002B02DA,$002B02E0,$002B02E6,$002B02EE
	dc.l	$002B02F4,$002B02FA,$002B0300,$002B0308
	dc.l	$002B030E,$002B0314,$002B031A,word_2B0322
	dc.l	$002B0328,$002B032E,$002B0334,$002B033C
	dc.l	$002B0342,$002B0348,$002B034E,$002B0354
	dc.l	$002B035A,$002B0360,$002B0368,$002B036E
	dc.l	$002B0374,$002B037A,$002B0382,$002B0388
	dc.l	$002B038E,$002B0394,word_2B039E,word_2B03A8
	dc.l	$002B03AE,$002B03C0,$002B03D2,$002B03E0
	dc.l	$002B03EE,$002B03F4,$002B03FE,$002B0408
	dc.l	$002B0418,$002B0428,$002B0438,$002B0448
	dc.l	$002B0458,$002B0468,$002B0478,$002B0488
	dc.l	$002B0498,$002B04A8,$002B04B8,$002B04C8
	dc.l	$002B04D8,$002B04E8,$002B04F8,$002B0508
	dc.l	$002B0518,$002B0528,$002B0538,$002B0548
	dc.l	$002B0558,$002B0568,$002B0578,$002B0588
	dc.l	$002B0598,$002B05A8,$002B05B8,$002B05C8
	dc.l	$002B05D8,$002B05E8,$002B05F8,$002B0638
	dc.l	$002B0678,$002B06BA,$002B0700,$002B0740
	dc.l	$002B078C,$002B07C8,$002B0804,$002B0842
	dc.l	$002B0882,$002B08C2,$002B0910,$002B095E	; $D7
	dc.l	word_20FBEE_D8,word_20FBEE_D9,word_20FBEE_DA,word_20FBEE_DB
	dc.l	word_208DE0_DC,word_208DE0_DD,word_208DE0_DE,word_201F76_DF
	dc.l	word_201F76_E0,word_201F76_E1,word_21C0B4_E2,word_21C0B4_E3
	dc.l	word_21C0B4_E4,word_225922_E5,word_225922_E6,word_225922_E7
	dc.l	word_214024_E8,word_235782_E9,word_235782_EA,word_235782_EB
	dc.l	word_235782_EC,word_235782_ED,word_222A98_EE,word_222A98_EF
	dc.l	word_222A98_F0,word_222A98_F1,word_222A98_F2,word_20B7DC_F3
	dc.l	word_20B7DC_F4,word_20B7DC_F5,word_20B7DC_F6,word_20B7DC_F7
	dc.l	word_20B7DC_F8,word_2053FE_F9,word_2053FE_FA,word_2053FE_FB
	dc.l	word_2053FE_FC,word_1FD476_FD,word_1FD476_FE,word_1FD476_FF
	dc.l	word_1FD476_100,word_1FD476_101,word_1FD476_102,word_1FD476_103
	dc.l	word_1FD476_104,word_1FD476_105,word_22A694_106,word_22A694_107
	dc.l	word_22A694_108,word_22A694_109,word_232702_10A,word_232702_10B
	dc.l	word_232702_10C,word_232702_10D,word_23B38A_10E,word_23B38A_10F
	dc.l	word_23B38A_110,word_23B38A_111,word_23B38A_112,word_23B38A_113
	dc.l	word_23B38A_114,word_23B38A_115,word_23B38A_116,word_23B38A_117
	dc.l	word_247EB2_118,word_247EB2_119,word_247EB2_11A,word_245DA0_11B
	dc.l	word_23F080_11C,word_23F080_11D,word_217DF4_11E,word_217DF4_11F
	dc.l	word_217DF4_120,word_217DF4_121,word_22EDB4_122,word_22EDB4_123
	dc.l	word_22EDB4_124,word_22EDB4_125,word_27AB72_126,word_27AB72_127
	dc.l	word_27AB72_128,word_27AB72_129,word_27AB72_12A,word_27AB72_12B
	dc.l	word_23F080_12C,word_247EB2_12D,word_247EB2_12E,word_26A63A_12F
	dc.l	word_247EB2_130,word_26A63A_131,word_247EB2_132,word_247EB2_133
	dc.l	word_247EB2_134,word_23B38A_135,word_23B38A_136,word_23B38A_137
	dc.l	word_23B38A_138,word_23B38A_139

word_2AF438:	; 「只許敗不許勝，引誘敵將進博望坡，放火攻之。」
	dc.w	$000E,$000F,$0010,$0011,$000F,$0012,$0004
	dc.w	$0013,$0014,$0087,$002C,$0018,$0019,$001A,$001B,$0004
	dc.w	$001C,$001D,$001E,$001F,$000D,$FFFF

word_2AF466:	; 「天色已晚，來日再戰。」
	dc.w	$0022,$0023,$0024,$0025,$0004
	dc.w	$0026,$0027,$0028,$0029,$000D
	dc.w	$FFFF

word_2AF5D6:	; 「將軍義薄雲天，請接受老夫家傳寶器。」
	dc.w	$002C,$0000,$008C,$008D,$008E,$0022,$0004
	dc.w	$0077,$0078,$0079,$007A,$0057,$007B,$007C,$008F,$0090,$000D,$FFFF

word_2AF810:	; [27]「阿斗在我手中，汝等不可輕舉妄動。」
	dc.w	$00B4,$00B5,$00C9,$00E7,$002A,$0032,$0004
	dc.w	$00E8,$00E9,$0011,$004A,$00EA,$00EB,$00EC,$00ED,$000D,$FFFF

word_2AF832:	; 「撞擊敵將(張郃)以救少主。」
	dc.w	$00F2,$0067,$0087,$002C,$0101,$009B,$0084,$0070,$000D,$FFFF

word_2B03A8:	dc.w	$0210,$011A,$FFFF	; 真呂布

word_2AFB74:	; 「來者何人！竟敢擾本尊清淨！」
	dc.w	$0026,$013F,$0048,$004F,$0061
	dc.w	$0140,$00CC,$0155,$00DD,$0371,$0156,$0157,$0061,$FFFF

* 孫權
word_27AB72_126:	; 「何方豎子？」
	dc.w	$0048,$0129,$02FE,$0096,$0030,$FFFF
word_27AB72_127:	; 「何方妖孽？」
	dc.w	$0048,$0129,$034E,$0172,$0030,$FFFF
word_27AB72_128:	; 「冀州上將潘鳳！」
	dc.w	$034F,$019B,$006A,$002C,$0350,$01B7,$0061,$FFFF
word_27AB72_129:	; 「零陵上將邢道榮！」
	dc.w	$0351,$0126,$006A,$002C,$0352,$008B,$0353,$0061,$FFFF
word_27AB72_12A:	; 「戰！」
	dc.w	$0029,$0061,$FFFF
word_27AB72_12B:	; 「我是真的！」
	dc.w	$0134,$013E,$0201,$024C,$0061,$FFFF
* [5D] $002AFDE0: 「孤統領江南六郡八十一州，克成帝業指日可待，汝等何不順天意歸順共創大業！」
* [5E] $002AFE28: 「住口，逆賊還不快納命請罪！」
* [7E] $002B027A: 「不自量力，死有餘辜！殺！」

* 曹操
word_1FD476_FD:	; 「山不厭高，水不厭深，周公吐哺，天下歸心。」
	dc.w	$003B,$0011,$030B,$01BC,$0004,$006C,$0011,$030B,$00A6,$0004
	dc.w	$00F9,$0071,$0246,$030C,$0004,$0022,$002B,$003A,$00D5,$000D,$FFFF
word_1FD476_FE:	; 「雲長…也罷…也罷……」
	dc.w	$008E,$00A7,$02C8,$00DC,$030D,$02C8,$00DC,$030D,$02C8,$02C8,$FFFF
word_1FD476_FF:	; 「果真百萬軍中取吾首級如探囊取物耳……」
	dc.w	$0031,$0201,$0074,$01D1,$0000,$0032,$000A,$015C,$016F,$02C7,$004E,$02E1,$02E2,$000A,$012F,$02F4,$02C8,$02C8,$FFFF
word_1FD476_100:	; 「七進七出之力，將軍真神人也……」
	dc.w	$0228,$0018,$0228,$00AC,$001F,$015A,$0004
	dc.w	$002C,$0000,$0201,$014C,$004F,$00DC,$02C8,$02C8,$FFFF
word_1FD476_101:	; 「今何不報殺父之仇……」
	dc.w	$018B,$0048,$0011,$0091,$004B,$030E,$001F,$0164,$02C8,$02C8,$FFFF
word_1FD476_102:	; 「今日一見不敵臥龍，孟德無話可說……」
	dc.w	$018B,$0027,$00CE,$00FF,$0011,$0087,$01BB,$0097,$0004
	dc.w	$00BC,$00C8,$00D8,$030F,$004A,$02F0,$02C8,$02C8,$FFFF
word_1FD476_103:	; 「銅雀台鎖不住二喬，亦鎖不住你……」
	dc.w	$02C3,$0310,$0311,$0312,$0011,$01A3,$02E7,$0313,$0004
	dc.w	$0184,$0312,$0011,$01A3,$0130,$02C8,$02C8,$FFFF
word_1FD476_104:	; 「江水連環恨在心，落鳳幸存意難平……」
	dc.w	$00A1,$006C,$022F,$0230,$02AE,$00C9,$00D5,$0004
	dc.w	$0094,$01B7,$0314,$0315,$01A1,$023A,$00C2,$02C8,$02C8,$FFFF
word_1FD476_105:	; 「生子當如孫仲謀……」
	dc.w	$01A9,$0096,$0197,$004E,$0137,$0316,$0317,$02C8,$02C8,$FFFF
* [73] $002B0128: 「孤有何罪，天下無孤，不知有幾人稱帝，幾人稱王！」

* 司馬懿
word_201F76_DF:	; 「巾帼女衣，雕蟲小技。堅守不出，魂歸九天！」
	dc.w	$038E,$038F,$027B,$031E,$0004,$02CC,$02CD,$00B7,$004D,$000D
	dc.w	$02CE,$02CF,$0011,$00AC,$0004,$02D0,$003A,$02D1,$0022,$0061,$FFFF
word_201F76_E0:	; 「上方谷落荒而逃，而今苟活於世，實乃豚犬之風，我從未見過如此厚顏無恥之人！」
	dc.w	$006A,$0129,$02D2,$0094,$02D3,$01AB,$002F,$0004
	dc.w	$01AB,$018B,$02D4,$0265,$00FB,$00D0,$0004
	dc.w	$02D5,$01C7,$02D6,$0118,$001F,$01A8,$0004
	dc.w	$0134,$017B,$02D7,$00FF,$00B9,$004E,$00CA,$02D8,$02D9,$00D8,$018A,$001F,$004F,$0061,$FFFF
word_201F76_E1:	; 「肅清萬裏，總齊八荒！」
	dc.w	$02DA,$0156,$01D1,$02DB,$0004,$02DC,$00D4,$0199,$02D3,$0061,$FFFF

* 程昱
word_2053FE_F9:	; 「木人木人聽我令！千錘萬鑽力無邊！急急如律令！」
	dc.w	$0302,$004F,$0302,$004F,$0065,$0134,$0003,$0061
	dc.w	$01FF,$0303,$01D1,$0304,$015A,$00D8,$0305,$0061
	dc.w	$0306,$0306,$004E,$0307,$0003,$0061,$FFFF
word_2053FE_FA:	; 「主公無雙，在下拜服！」
	dc.w	$0070,$0071,$00D8,$00D9,$0004
	dc.w	$00C9,$002B,$01B6,$00DB,$0061,$FFFF
word_2053FE_FB:	; 「弟子願歸師傅門下，精修道法，發揚光大！」
	dc.w	$005E,$0096,$0051,$0001,$0308,$025A,$002B,$0004
	dc.w	$0300,$0309,$008B,$0181,$0004
	dc.w	$0244,$0284,$0285,$0055,$0061,$FFFF
word_2053FE_FC:	; 「在下願用一身道術助爾一臂之力！」
	dc.w	$00C9,$002B,$0051,$00EF,$00CE,$00B1,$008B,$0282,$00C0,$02C1,$00CE,$030A,$001F,$015A,$0061,$FFFF

* 曹仁
word_208DE0_DC:	; 「新野之敗不過詭計爾爾，區區白河之水怎能覆我？」
	dc.w	$0213,$0214,$001F,$0010,$0011,$00B9,$02C0,$0033,$02C1,$02C1,$0004
	dc.w	$02C2,$02C2,$0068,$0069,$001F,$006C,$0139,$0058,$00FC,$0134,$0030,$FFFF
word_208DE0_DD:	; 「鐵壁銅墻在此！爾等休要猖狂，看吾取汝首級！」
	dc.w	$0278,$0163,$02C3,$02C4,$00C9,$00CA,$0061
	dc.w	$02C1,$00E9,$02B4,$017E,$02C5,$02C6,$0004,$00F3,$015C,$000A,$00E8,$016F,$02C7,$0061,$FFFF
word_208DE0_DE:	; 「此地……鬼門關也！」
	dc.w	$00CA,$0098,$02C8,$02C8,$02C9,$025A,$01D3,$00DC,$0061,$FFFF

* 夏侯淵
word_20B7DC_F3:	; 「聽聞將軍刀功了得，特來賜教。」
	dc.w	$0065,$0083,$002C,$0000,$02F2,$0103,$018C,$016A,$0004
	dc.w	$00BE,$0026,$02FB,$025F,$000D,$FFFF
word_20B7DC_F4:	; 「有來無回！」
	dc.w	$0002,$0026,$00D8,$009C,$0061,$FFFF
word_20B7DC_F5:	; 「願隨主公征戰一世！」
	dc.w	$0051,$009E,$0070,$0071,$01FB,$0029,$00CE,$00D0,$0061,$FFFF
word_20B7DC_F6:	; 「刀弓無雙，妙才願降。」
	dc.w	$02F2,$02FC,$00D8,$00D9,$0004
	dc.w	$02FD,$011E,$0051,$0042,$000D,$FFFF
word_20B7DC_F7:	; 「豎子欺吾年老，吾手中寶刀不老。」
	dc.w	$02FE,$0096,$02FF,$015C,$01F9,$007A,$0004
	dc.w	$015C,$002A,$0032,$008F,$02F2,$0011,$007A,$000D,$FFFF
word_20B7DC_F8:	; 「將軍戰法精湛，末將願追隨將軍！」
	dc.w	$002C,$0000,$0029,$0181,$0300,$0301,$0004
	dc.w	$01F6,$002C,$0051,$0066,$009E,$002C,$0000,$0061,$FFFF
* [40] $002AFA7A: 「聽長兄忠言，何不歸順，共扶漢室！」
* [41] $002AFA9C: 「兄長所言甚是，兄弟同心，共扶漢室！」

* 夏侯惇
word_20FBEE_D8:	; 「故地重遊？必將功贖罪！」
	dc.w	$0289,$0098,$00AD,$02B8,$0030
	dc.w	$009A,$002C,$0103,$02B9,$01A5,$0061,$FFFF
word_20FBEE_D9:	; 「來者何人？吾刃不斬無名之輩。」
	dc.w	$0026,$013F,$0048,$004F,$0030
	dc.w	$015C,$02BA,$0011,$003C,$00D8,$016B,$001F,$02BB,$000D,$FFFF
word_20FBEE_DA:	; 「元讓必隨阿瞞征戰一世！」
	dc.w	$02BC,$02BD,$009A,$009E,$00B4,$02BE,$01FB,$0029,$00CE,$00D0,$0061,$FFFF
word_20FBEE_DB:	; 「兄弟同心，蜀漢再興！」
	dc.w	$005F,$005E,$010E,$00D5,$0004
	dc.w	$023F,$0111,$0028,$02BF,$0061,$FFFF
* [B] $002AF514: 「技不如人，某願降。」

* 牛金
word_214024_E8:	; 「區區螻蟻，也敢在此放肆？」
	dc.w	$02C2,$02C2,$02E3,$02E4,$0004
	dc.w	$00DC,$00CC,$00C9,$00CA,$001C,$02E5,$0030,$FFFF
* [32] $002AF936: 「將軍何須埋沒將才，不若歸順共展長才。」
* [33] $002AF95C: 「某必盡某所能，為漢效命！」

* 許褚
word_217DF4_11E:	; 「虎癡來也！誰敢與我大戰三百回合？」
	dc.w	$0039,$01A7,$0026,$00DC,$0061
	dc.w	$00CB,$00CC,$00CD,$0134,$0055,$0029,$01F8,$0074,$009C,$026B,$0030,$FFFF
word_217DF4_11F:	; 「此時不戰，更待何時！」
	dc.w	$00CA,$0298,$0011,$0029,$0004
	dc.w	$01AE,$0142,$0048,$0298,$0061,$FFFF
* [61] $002AFE9E: 「虎痴願隨本相再展雄風否？」
* [62] $002AFEB8: 「某平生只服一人，惟主公矣，而今得見死而無憾！」
word_217DF4_120:	; 「武藝在某之上，某必精進武藝，有朝一日定叫汝等俯首！」
	dc.w	$00F0,$032B,$00C9,$0050,$001F,$006A,$0004
	dc.w	$0050,$009A,$0300,$0018,$00F0,$032B,$0004
	dc.w	$0002,$029C,$00CE,$0027,$0035,$0349,$00E8,$00E9,$034A,$016F,$0061,$FFFF
word_217DF4_121:	; 「定當奉陪！」
	dc.w	$0035,$0197,$0166,$034B,$0061,$FFFF
word_2AFE6E:	; [60]「將軍何不歸降，一展虎痴雄風！」
	dc.w	$002C,$0000,$0048,$0011,$003A,$0042,$0004
	dc.w	$00CE,$011F,$0039,$01A7,$012C,$01A8,$0061,$FFFF
word_2AFE44:	; [5F]「某平生不曾有敵手，今見將軍威猛更勝一籌，某願降也！」
	dc.w	$0050,$00C2,$01A9,$0011,$01B1,$0002,$0087,$002A,$0004
	dc.w	$018B,$00FF,$002C,$0000,$014D,$01AD,$01AE,$0012,$00CE,$01AF,$0004
	dc.w	$0050,$0051,$0042,$00DC,$0061,$FFFF

* 張郃
word_21C0B4_E2:	; 「吾乃河間上將張郃是也，汝等速來受死！」
	dc.w	$015C,$01C7,$0069,$02DD,$006A,$002C,$00C6,$01DF,$013E,$00DC,$0004
	dc.w	$00E8,$00E9,$009D,$0026,$0079,$0053,$0061,$FFFF
word_21C0B4_E3:	; 「願為丞相以驅馳！」
	dc.w	$0051,$0047,$02A1,$00FE,$0101,$02DE,$0204,$0061,$FFFF
word_21C0B4_E4:	; 「趙將軍蓋世無雙，末將甘拜下風！」
	dc.w	$01D5,$002C,$0000,$01E9,$00D0,$00D8,$00D9,$0004
	dc.w	$01F6,$002C,$0116,$01B6,$002B,$01A8,$0061,$FFFF
* [23] $002AF7A2: 「將軍不需再戰，何不齊心共平亂世！」
* [24] $002AF7C4: 「果不枉為無雙國士，某服也！」

* 張遼
word_222A98_EE:	; 「文遠，今日乃國家之事，某不敢以私廢公。你我二人，當決一死戰，以報國恩。」
	dc.w	$025D,$0100,$0004
	dc.w	$018B,$0027,$01C7,$00DA,$007B,$001F,$01CA,$0004
	dc.w	$0050,$0011,$00CC,$0101,$0390,$012E,$0071,$000D
	dc.w	$0130,$0134,$02E7,$004F,$0004
	dc.w	$0197,$0034,$00CE,$0053,$0029,$0004
	dc.w	$0101,$0091,$00DA,$005D,$000D,$FFFF
word_222A98_EF:	; 「君候高義，人生在世，有死而已，吾不懼也！」
	dc.w	$0391,$02B7,$01BC,$008C,$0004
	dc.w	$004F,$01A9,$00C9,$00D0,$0004
	dc.w	$0002,$0053,$01AB,$0024,$0004
	dc.w	$015C,$0011,$0392,$00DC,$0061,$FFFF
word_222A98_F0:	; 「縱轡著鞭馳駿騎，逍遙津上玉龍飛。」
	dc.w	$0223,$0393,$0394,$0395,$0204,$0396,$0267,$0004
	dc.w	$0397,$0398,$0399,$006A,$02F5,$0097,$00CF,$000D,$FFFF
word_222A98_F1:	; 「大丈夫死則死耳。」
	dc.w	$0055,$0056,$0057,$0053,$02F3,$0053,$02F4,$000D,$FFFF
word_222A98_F2:	; 「玉可碎而不可改其白，竹可焚而不可毀其節。」
	dc.w	$02F5,$004A,$02F6,$01AB,$0011,$004A,$00FD,$0040,$0068,$0004
	dc.w	$02F7,$004A,$02F8,$01AB,$0011,$004A,$02F9,$0040,$02FA,$000D,$FFFF

* 甘寧
word_225922_E5:	; 「水軍聽令，隨我殺之！」
	dc.w	$006C,$0000,$0065,$0003,$0004
	dc.w	$009E,$0134,$004B,$001F,$0061,$FFFF
word_225922_E6:	; 「吾乃甘寧也！誰敢來與我決戰？」
	dc.w	$015C,$01C7,$0116,$01E3,$00DC,$0061
	dc.w	$00CB,$00CC,$0026,$00CD,$0134,$0034,$0029,$0030,$FFFF
word_225922_E7:	; 「閣下豪氣干雲，甘某願率水軍歸降！」
	dc.w	$005C,$002B,$0113,$0114,$0115,$008E,$0004
	dc.w	$0116,$0050,$0051,$024D,$006C,$0000,$003A,$0042,$0061,$FFFF
* [30] $002AF8E4: 「將軍身手不凡，不若一同效命，共扶漢室。」
* [31] $002AF90C: 「閣下豪氣干雲，甘某願為麾下，效犬馬之勞！」

* 周泰
word_22A694_106:	; 「主公願一戰否？」
	dc.w	$0070,$0071,$0051,$00CE,$0029,$014B,$0030,$FFFF
word_22A694_107:	; 「戰則必勝！」
	dc.w	$0029,$02F3,$009A,$0012,$0061,$FFFF
word_22A694_108:	; 「幼平在此，擺陣禦敵！」
	dc.w	$0318,$00C2,$00C9,$00CA,$0004,$0319,$0088,$031A,$0087,$0061,$FFFF
word_22A694_109:	; 「願為主公赴湯蹈火，再傷一眼也不惜！」
	dc.w	$0051,$0047,$0070,$0071,$031B,$031C,$031D,$001D,$0004
	dc.w	$0028,$00B2,$00CE,$0021,$00DC,$0011,$0149,$0061,$FFFF
* [43] $002AFAF4: 「汝軍兵敗勢危，本將惜才如金，將軍願降否？」
* [44] $002AFB1E: 「將軍英明神武，威不可擋，某服也！」

* 黃蓋
word_22EDB4_122:	; 「請主公賜教！」
	dc.w	$0077,$0070,$0071,$02FB,$025F,$0061,$FFFF
word_22EDB4_123:	; 「黃老將軍看槊！」
	dc.w	$01D6,$007A,$002C,$0000,$00F3,$034C,$0061,$FFFF
word_22EDB4_124:	; 「主公英明神武，某來世再報！」
	dc.w	$0070,$0071,$012B,$0095,$014C,$00F0,$0004
	dc.w	$0050,$0026,$00D0,$0028,$0091,$0061,$FFFF
word_22EDB4_125:	; 「定當保家眷周全！」
	dc.w	$0035,$0197,$00E4,$007B,$034D,$00F9,$025E,$0061,$FFFF

* 呂蒙
word_232702_10A:	; 「白衣渡江，荊州歸吳！」
	dc.w	$0068,$031E,$031F,$00A1,$0004
	dc.w	$0320,$019B,$003A,$0240,$0061,$FFFF
word_232702_10B:	; 「奸詐小人，親手戮之！」
	dc.w	$017C,$0321,$00B7,$004F,$0004
	dc.w	$0322,$002A,$0323,$001F,$0061,$FFFF
word_232702_10C:	; 「明者防禍於未萌，智者圖患於將來。」
	dc.w	$0095,$013F,$0324,$0325,$00FB,$02D7,$0326,$0004
	dc.w	$021A,$013F,$0327,$0106,$00FB,$002C,$0026,$000D,$FFFF
word_232702_10D:	; 「插標賣首耳！」
	dc.w	$0328,$0329,$032A,$016F,$02F4,$0061,$FFFF

* 徐晃
word_235782_E9:	; 「全軍聽令！若取得子龍首級者，重賞千金！」
	dc.w	$025E,$0000,$0065,$0003,$0061
	dc.w	$010D,$000A,$016A,$0096,$0097,$016F,$02C7,$013F,$0004
	dc.w	$00AD,$02E6,$01FF,$014A,$0061,$FFFF
word_235782_EA:	; 「巨斧開山！速速退散！」
	dc.w	$02E8,$02E9,$0287,$003B,$0061
	dc.w	$009D,$009D,$02EA,$02EB,$0061,$FFFF
word_235782_EB:	; 「巨斧在此，反賊安敢耀武揚威，速下馬受降！」
	dc.w	$02E8,$02E9,$00C9,$00CA,$0004
	dc.w	$0104,$0127,$01BA,$00CC,$039A,$00F0,$0284,$014D,$0004
	dc.w	$009D,$002B,$0119,$0079,$0042,$0061,$FFFF
word_235782_EC:	; 「公明願降！」
	dc.w	$0071,$0095,$0051,$0042,$0061,$FFFF
word_235782_ED:	; 「巨斧撼山易，撼子龍難。」
	dc.w	$02E8,$02E9,$02ED,$003B,$02EE,$0004
	dc.w	$02ED,$0096,$0097,$023A,$000D,$FFFF
* [7F] $002B0294: 「將軍何苦助紂為虐，願降否？」
* [80] $002B02B0: 「將軍威名遠播，某服也。」

* 呂布
word_23B38A_10E:	; 「本將必以十二分武藝拼死一戰！」
	dc.w	$00DD,$002C,$009A,$0101,$019A,$02E7,$02A3,$00F0,$032B,$032C,$0053,$00CE,$0029,$0061,$FFFF
word_23B38A_10F:	; 「七分武藝可敵！」
	dc.w	$0228,$02A3,$00F0,$032B,$004A,$0087,$0061,$FFFF
word_23B38A_110:	; 「三分武藝足矣！」
	dc.w	$01F8,$02A3,$00F0,$032B,$032D,$0188,$0061,$FFFF
word_23B38A_111:	; 「在天願作比翼鳥，從此不問世間事。」
	dc.w	$00C9,$0022,$0051,$02B2,$032E,$00C7,$032F,$0004
	dc.w	$017B,$00CA,$0011,$01C1,$00D0,$02DD,$01CA,$000D,$FFFF
word_23B38A_112:	; 「妾身願往，可歎雙雙兵戎相見，實乃不忍。」
	dc.w	$0330,$00B1,$0051,$00A0,$0004
	dc.w	$004A,$0331,$00D9,$00D9,$00A3,$0242,$00FE,$00FF,$0004
	dc.w	$02D5,$01C7,$0011,$0283,$000D,$FFFF
word_23B38A_113:	; 「大丈夫生居天地間，豈能郁郁久居人下！」
	dc.w	$0055,$0056,$0057,$01A9,$0183,$0022,$0098,$02DD,$0004
	dc.w	$0332,$0058,$0333,$0333,$0120,$0183,$004F,$002B,$0061,$FFFF
word_23B38A_114:	; 「布技不如前，今已服矣。」
	dc.w	$0169,$004D,$0011,$004E,$009F,$0004
	dc.w	$018B,$0024,$00DB,$0188,$000D,$FFFF
word_23B38A_115:	; 「比翼雙飛，共度餘生。」
	dc.w	$032E,$00C7,$00D9,$00CF,$0004
	dc.w	$00D6,$0334,$0177,$01A9,$000D,$FFFF
word_23B38A_116:	; 「甚好甚好。」
	dc.w	$013D,$0249,$013D,$0249,$000D,$FFFF
word_23B38A_117:	; 「汝為大將，布副之，天下不難定也。」
	dc.w	$00E8,$0047,$0055,$002C,$0004
	dc.w	$0169,$0167,$001F,$0004
	dc.w	$0022,$002B,$0011,$023A,$0035,$00DC,$000D,$FFFF
* [4E] $002AFC2C: 「奉先威名遠播，某求之不得！」

* 孟獲、孟優
word_23F080_11C:	; 「吾昔日誤中丞相詭計，如何肯服？今欲捨一死命，報六番之恨！」
	dc.w	$015C,$0193,$0027,$0355,$0032,$02A1,$00FE,$02C0,$0033,$0004
	dc.w	$004E,$0048,$0356,$00DB,$0030
	dc.w	$018B,$0357,$0358,$00CE,$0053,$0036,$0004
	dc.w	$0091,$0198,$0338,$001F,$02AE,$0061,$FFFF
word_23F080_12C:	; 「這番擒住，再若支吾，必不輕恕！」
	dc.w	$0261,$0338,$0161,$01A3,$0004
	dc.w	$0028,$010D,$0359,$015C,$0004
	dc.w	$009A,$0011,$00EA,$035A,$0061,$FFFF
word_23F080_11D:	; 「公，天威也，南人不復反矣！」
	dc.w	$0071,$0004,$0022,$014D,$00DC,$0004
	dc.w	$00BA,$004F,$0011,$0187,$0104,$0188,$0061,$FFFF

* 沙摩柯
word_245DA0_11B:	; 「五溪蠻王來矣，賊將休走，吃我一記！」
	dc.w	$0346,$0347,$00BB,$028E,$0026,$0188,$0004
	dc.w	$0127,$002C,$02B4,$00D1,$0004
	dc.w	$0275,$0134,$00CE,$0195,$0061,$FFFF

* 左慈
word_247EB2_118:	; 「道友請留步，何不來切磋論道一番？」
	dc.w	$008B,$0335,$0077,$00F5,$00F6,$0004
	dc.w	$0048,$0011,$0026,$0175,$0336,$0337,$008B,$00CE,$0338,$0030,$FFFF
word_247EB2_119:	; 「恭敬不如從命。」
	dc.w	$0339,$033A,$0011,$004E,$017B,$0036,$000D,$FFFF
word_247EB2_11A:	; 「冰錐刻骨，福桶入肉，紙符亂神，鶴爪斷首！」
	dc.w	$033B,$033C,$033D,$033E,$0004
	dc.w	$033F,$0340,$0086,$0341,$0004
	dc.w	$0342,$0343,$0063,$014C,$0004
	dc.w	$0344,$0345,$0108,$016F,$0061,$FFFF

* 其他
word_247EB2_12D:	; 「先生止步，貧道於西川嘉陵峨嵋山中，學道三十年，騰雲跨風，穿山透石，藏形變身，無所不能。」
	dc.w	$00F1,$01A9,$036F,$00F6,$0004
	dc.w	$027F,$008B,$00FB,$024E,$035B,$035C,$0126,$035D,$035E,$003B,$0032,$0004
	dc.w	$0266,$008B,$01F8,$019A,$01F9,$0004
	dc.w	$022D,$008E,$035F,$01A8,$0004
	dc.w	$0360,$003B,$0221,$0361,$0004
	dc.w	$0362,$0363,$0364,$00B1,$0004
	dc.w	$00D8,$0124,$0011,$0058,$000D,$FFFF
word_247EB2_12E:	; 「先生雖位極人臣，然大道為先，何不退步，隨貧道往峨嵋山中修行？當以仙術相授。」
	dc.w	$00F1,$01A9,$0182,$00E3,$004F,$0200,$0004
	dc.w	$0262,$0055,$008B,$0047,$00F1,$0004
	dc.w	$0048,$0011,$02EA,$00F6,$0004
	dc.w	$009E,$027F,$008B,$00A0,$035D,$035E,$003B,$0032,$0309,$008A,$0030
	dc.w	$0197,$0101,$0365,$0282,$00FE,$0366,$000D,$FFFF

word_26A63A_12F:	; 「亮本南陽一布衣，蒙受吾主三顧之恩，遂許以驅馳。今天下未定，安肯棄之而去乎？」
	dc.w	$01D9,$00DD,$00BA,$0367,$00CE,$0169,$031E,$0004
	dc.w	$01F3,$0079,$015C,$0070,$01F8,$0297,$001F,$005D,$0004
	dc.w	$0368,$000F,$0101,$02DE,$0204,$000D
	dc.w	$018B,$0022,$002B,$02D7,$0035,$0004
	dc.w	$01BA,$0356,$01C3,$001F,$01AB,$0174,$01C2,$0030,$FFFF

word_247EB2_130:	; 「汝不知天命，猶欲抗拒，須教你知我道法莫測。斗轉星旋，地轉星移。開！！！」
	dc.w	$00E8,$0011,$0180,$0022,$0036,$0004
	dc.w	$02E0,$0357,$0241,$0369,$0004
	dc.w	$011B,$025F,$0130,$0180,$0134,$008B,$0181,$00EE,$036A,$000D
	dc.w	$00B5,$036B,$0229,$036C,$0004
	dc.w	$0098,$036B,$0229,$036D,$0004
	dc.w	$0287,$0061,$0061,$0061,$FFFF

word_26A63A_131:	; 「狂妄妖道，汝邪法已破，還不束手就擒！」
	dc.w	$02C6,$00EC,$034E,$008B,$0004
	dc.w	$00E8,$038D,$0181,$0024,$006F,$0004
	dc.w	$015E,$0011,$015F,$002A,$0160,$0161,$0061,$FFFF
word_247EB2_132:	; 「神仙之術，豈會僅止於此呢…星旋斗轉，星移地轉。收！！！」
	dc.w	$014C,$0365,$001F,$0282,$0004
	dc.w	$0332,$00E1,$036E,$036F,$00FB,$00CA,$0370,$02C8
	dc.w	$039B,$039B,$039B,$039B,$039B	; 換行
	dc.w	$0229,$036C,$00B5,$036B,$0004
	dc.w	$0229,$036D,$0098,$036B,$0004
	dc.w	$0191,$0061,$0061,$0061,$FFFF

word_247EB2_133:	; 「祖師息怒！今天下分崩，九州幅裂，干戈日起，生靈塗炭。」
	dc.w	$0372,$0001,$0373,$0211,$0061
	dc.w	$018B,$0022,$002B,$02A3,$0374,$0004
	dc.w	$02D1,$019B,$0375,$0376,$0004
	dc.w	$0115,$026C,$0027,$01FC,$0004
	dc.w	$01A9,$0377,$0378,$0379,$000D,$FFFF
word_247EB2_134:	; 「元惡劉備，偽為亂階，群兇縱橫，殘剝海內。望祖師降罰，暴逆並殪，以漸冰消。」
	dc.w	$02BC,$037A,$0092,$028F,$0004
	dc.w	$037B,$0047,$0063,$037C,$0004
	dc.w	$037D,$037E,$0223,$037F,$0004
	dc.w	$0380,$0381,$0232,$0382,$000D
	dc.w	$001A,$0372,$0001,$0042,$0383,$0004
	dc.w	$0384,$00C4,$0385,$0386,$0004
	dc.w	$0101,$0387,$033B,$0388,$000D,$FFFF
word_23B38A_135:	; 「好不知死，敢為欺天之謀，汝等助惡，其罪當誅！」
	dc.w	$0249,$0011,$0180,$0053,$0004
	dc.w	$00CC,$0047,$02FF,$0022,$001F,$0317,$0004
	dc.w	$00E8,$00E9,$00C0,$037A,$0004
	dc.w	$0040,$01A5,$0197,$0389,$0061,$FFFF

word_23B38A_136:	; 「此賊欺師罔上，擾亂於外，伯公何尚不知？」
	dc.w	$00CA,$0127,$02FF,$0001,$038A,$006A,$0004
	dc.w	$0155,$0063,$00FB,$028B,$0004
	dc.w	$0210,$0071,$0048,$02A5,$0011,$0180,$0030,$FFFF
word_23B38A_137:	; 「逆徒已死，汝輩好自為之。」
	dc.w	$00C4,$015B,$0024,$0053,$0004
	dc.w	$00E8,$02BB,$0249,$0158,$0047,$001F,$000D,$FFFF

word_23B38A_138:	; 「不可輕敵，速退！整兵再戰！」
	dc.w	$0011,$004A,$00EA,$0087,$0004
	dc.w	$009D,$02EA,$0061
	dc.w	$038B,$00A3,$0028,$0029,$0061,$FFFF
word_23B38A_139:	; 「且讓貧道助爾等一臂之力。」
	dc.w	$038C,$02BD,$027F,$008B,$00C0,$02C1,$00E9,$00CE,$030A,$001F,$015A,$000D,$FFFF


word_31D4C2:	; [2*2]繁字貼圖組合表
	dc.w	$0000,$0001,$0002,$0003
	dc.w	$0004,$0005,$0006,$0007
	dc.w	$0008,$0009,$000A,$000B
	dc.w	$000C,$000D,$000E,$000F
	dc.w	$0010,$0011,$0012,$0013
	dc.w	$0014,$0015,$0016,$0017
	dc.w	$0018,$0019,$001A,$001B
	dc.w	$001C,$001D,$001E,$001F
	dc.w	$0020,$0021,$0022,$0023
	dc.w	$0024,$0025,$0026,$0027
	dc.w	$0028,$0029,$002A,$002B
	dc.w	$002C,$002D,$002E,$002F
	dc.w	$0030,$0031,$0032,$0033
	dc.w	$0034,$0035,$0036,$0037
	dc.w	$0038,$0039,$003A,$003B
	dc.w	$003C,$003D,$003E,$003F
	dc.w	$0040,$0041,$0042,$0043
	dc.w	$0044,$0045,$0046,$0047
	dc.w	$0048,$0049,$004A,$004B
	dc.w	$004C,$004D,$004E,$004F
	dc.w	$0050,$0051,$0052,$0053
	dc.w	$0054,$0055,$0056,$0057
	dc.w	$0058,$0059,$005A,$005B
	dc.w	$005C,$005D,$005E,$005F
	dc.w	$0060,$0061,$0062,$0063
	dc.w	$0064,$0065,$0066,$0067
	dc.w	$0068,$0069,$006A,$006B
	dc.w	$006C,$006D,$006E,$006F
	dc.w	$0070,$0071,$0072,$0073
	dc.w	$0074,$0075,$0076,$0077
	dc.w	$0078,$0079,$007A,$007B
	dc.w	$007C,$007D,$007E,$007F
	dc.w	$0080,$0081,$0082,$0083
	dc.w	$0084,$0085,$0086,$0087
	dc.w	$0088,$0089,$008A,$008B
	dc.w	$008C,$008D,$008E,$008F
	dc.w	$0090,$0091,$0092,$0093
	dc.w	$0094,$0095,$0096,$0097
	dc.w	$0098,$0099,$009A,$009B
	dc.w	$009C,$009D,$009E,$009F
	dc.w	$00A0,$00A1,$00A2,$00A3
	dc.w	$00A4,$00A5,$00A6,$00A7
	dc.w	$00A8,$00A9,$00AA,$00AB
	dc.w	$00AC,$00AD,$00AE,$00AF
	dc.w	$00B0,$00B1,$00B2,$00B3
	dc.w	$00B4,$00B5,$00B6,$00B7
	dc.w	$00B8,$00B9,$00BA,$00BB
	dc.w	$00BC,$00BD,$00BE,$00BF
	dc.w	$00C0,$00C1,$00C2,$00C3
	dc.w	$00C4,$00C5,$00C6,$00C7
	dc.w	$00C8,$00C9,$00CA,$00CB
	dc.w	$00CC,$00CD,$00CE,$00CF
	dc.w	$00D0,$00D1,$00D2,$00D3
	dc.w	$00D4,$00D5,$00D6,$00D7
	dc.w	$00D8,$00D9,$00DA,$00DB
	dc.w	$00DC,$00DD,$00DE,$00DF
	dc.w	$00E0,$00E1,$00E2,$00E3
	dc.w	$00E4,$00E5,$00E6,$00E7
	dc.w	$00E8,$00E9,$00EA,$00EB
	dc.w	$00EC,$00ED,$00EE,$00EF
	dc.w	$00F0,$00F1,$00F2,$00F3
	dc.w	$00F4,$00F5,$00F6,$00F7
	dc.w	$00F8,$00F9,$00FA,$00FB
	dc.w	$00FC,$00FD,$00FE,$00FF
	dc.w	$0100,$0101,$0102,$0103
	dc.w	$0104,$0105,$0106,$0107
	dc.w	$0108,$0109,$010A,$010B
	dc.w	$010C,$010D,$010E,$010F
	dc.w	$0110,$0111,$0112,$0113
	dc.w	$0114,$0115,$0116,$0117
	dc.w	$0118,$0119,$011A,$011B
	dc.w	$011C,$011D,$011E,$011F
	dc.w	$0120,$0121,$0122,$0123
	dc.w	$0124,$0125,$0126,$0127
	dc.w	$0128,$0129,$012A,$012B
	dc.w	$012C,$012D,$012E,$012F
	dc.w	$0130,$0131,$0132,$0133
	dc.w	$0134,$0135,$0136,$0137
	dc.w	$0138,$0139,$013A,$013B
	dc.w	$013C,$013D,$013E,$013F
	dc.w	$0140,$0141,$0142,$0143
	dc.w	$0144,$0145,$0146,$0147
	dc.w	$0148,$0149,$014A,$014B
	dc.w	$014C,$014D,$014E,$014F
	dc.w	$0150,$0151,$0152,$0153
	dc.w	$0154,$0155,$0156,$0157
	dc.w	$0158,$0159,$015A,$015B
	dc.w	$015C,$015D,$015E,$015F
	dc.w	$0160,$0161,$0162,$0163
	dc.w	$0164,$0165,$0166,$0167
	dc.w	$0168,$0169,$016A,$016B
	dc.w	$016C,$016D,$016E,$016F
	dc.w	$0170,$0171,$0172,$0173
	dc.w	$0174,$0175,$0176,$0177
	dc.w	$0178,$0179,$017A,$017B
	dc.w	$017C,$017D,$017E,$017F
	dc.w	$0180,$0181,$0182,$0183
	dc.w	$0184,$0185,$0186,$0187
	dc.w	$0188,$0189,$018A,$018B
	dc.w	$018C,$018D,$018E,$018F
	dc.w	$0190,$0191,$0192,$0193
	dc.w	$0194,$0195,$0196,$0197
	dc.w	$0198,$0199,$019A,$019B
	dc.w	$019C,$019D,$019E,$019F
	dc.w	$01A0,$01A1,$01A2,$01A3
	dc.w	$01A4,$01A5,$01A6,$01A7
	dc.w	$01A8,$01A9,$01AA,$01AB
	dc.w	$01AC,$01AD,$01AE,$01AF
	dc.w	$01B0,$01B1,$01B2,$01B3
	dc.w	$01B4,$01B5,$01B6,$01B7
	dc.w	$01B8,$01B9,$01BA,$01BB
	dc.w	$01BC,$01BD,$01BE,$01BF
	dc.w	$01C0,$01C1,$01C2,$01C3
	dc.w	$01C4,$01C5,$01C6,$01C7
	dc.w	$01C8,$01C9,$01CA,$01CB
	dc.w	$01CC,$01CD,$01CE,$01CF
	dc.w	$01D0,$01D1,$01D2,$01D3
	dc.w	$01D4,$01D5,$01D6,$01D7
	dc.w	$01D8,$01D9,$01DA,$01DB
	dc.w	$01DC,$01DD,$01DE,$01DF
	dc.w	$01E0,$01E1,$01E2,$01E3
	dc.w	$01E4,$01E5,$01E6,$01E7
	dc.w	$01E8,$01E9,$01EA,$01EB
	dc.w	$01EC,$01ED,$01EE,$01EF
	dc.w	$01F0,$01F1,$01F2,$01F3
	dc.w	$01F4,$01F5,$01F6,$01F7
	dc.w	$01F8,$01F9,$01FA,$01FB
	dc.w	$01FC,$01FD,$01FE,$01FF
	dc.w	$0200,$0201,$0202,$0203
	dc.w	$0204,$0205,$0206,$0207
	dc.w	$0208,$0209,$020A,$020B
	dc.w	$020C,$020D,$020E,$020F
	dc.w	$0210,$0211,$0212,$0213
	dc.w	$0214,$0215,$0216,$0217
	dc.w	$0218,$0219,$021A,$021B
	dc.w	$021C,$021D,$021E,$021F
	dc.w	$0220,$0221,$0222,$0223
	dc.w	$0224,$0225,$0226,$0227
	dc.w	$0228,$0229,$022A,$022B
	dc.w	$022C,$022D,$022E,$022F
	dc.w	$0230,$0231,$0232,$0233
	dc.w	$0234,$0235,$0236,$0237
	dc.w	$0238,$0239,$023A,$023B
	dc.w	$023C,$023D,$023E,$023F
	dc.w	$0240,$0241,$0242,$0243
	dc.w	$0244,$0245,$0246,$0247
	dc.w	$0248,$0249,$024A,$024B
	dc.w	$024C,$024D,$024E,$024F
	dc.w	$0250,$0251,$0252,$0253
	dc.w	$0254,$0255,$0256,$0257
	dc.w	$0258,$0259,$025A,$025B
	dc.w	$025C,$025D,$025E,$025F
	dc.w	$0260,$0261,$0262,$0263
	dc.w	$0264,$0265,$0266,$0267
	dc.w	$0268,$0269,$026A,$026B
	dc.w	$026C,$026D,$026E,$026F
	dc.w	$0270,$0271,$0272,$0273
	dc.w	$0274,$0275,$0276,$0277
	dc.w	$0278,$0279,$027A,$027B
	dc.w	$027C,$027D,$027E,$027F
	dc.w	$0280,$0281,$0282,$0283
	dc.w	$0284,$0285,$0286,$0287
	dc.w	$0288,$0289,$028A,$028B
	dc.w	$028C,$028D,$028E,$028F
	dc.w	$0290,$0291,$0292,$0293
	dc.w	$0294,$0295,$0296,$0297
	dc.w	$0298,$0299,$029A,$029B
	dc.w	$029C,$029D,$029E,$029F
	dc.w	$02A0,$02A1,$02A2,$02A3
	dc.w	$02A4,$02A5,$02A6,$02A7
	dc.w	$02A8,$02A9,$02AA,$02AB
	dc.w	$02AC,$02AD,$02AE,$02AF
	dc.w	$02B0,$02B1,$02B2,$02B3
	dc.w	$02B4,$02B5,$02B6,$02B7
	dc.w	$02B8,$02B9,$02BA,$02BB
	dc.w	$02BC,$02BD,$02BE,$02BF
	dc.w	$02C0,$02C1,$02C2,$02C3
	dc.w	$02C4,$02C5,$02C6,$02C7
	dc.w	$02C8,$02C9,$02CA,$02CB
	dc.w	$02CC,$02CD,$02CE,$02CF
	dc.w	$02D0,$02D1,$02D2,$02D3
	dc.w	$02D4,$02D5,$02D6,$02D7
	dc.w	$02D8,$02D9,$02DA,$02DB
	dc.w	$02DC,$02DD,$02DE,$02DF
	dc.w	$02E0,$02E1,$02E2,$02E3
	dc.w	$02E4,$02E5,$02E6,$02E7
	dc.w	$02E8,$02E9,$02EA,$02EB
	dc.w	$02EC,$02ED,$02EE,$02EF
	dc.w	$02F0,$02F1,$02F2,$02F3
	dc.w	$02F4,$02F5,$02F6,$02F7
	dc.w	$02F8,$02F9,$02FA,$02FB
	dc.w	$02FC,$02FD,$02FE,$02FF
	dc.w	$0300,$0301,$0302,$0303
	dc.w	$0304,$0305,$0306,$0307
	dc.w	$0308,$0309,$030A,$030B
	dc.w	$030C,$030D,$030E,$030F
	dc.w	$0310,$0311,$0312,$0313
	dc.w	$0314,$0315,$0316,$0317
	dc.w	$0318,$0319,$031A,$031B
	dc.w	$031C,$031D,$031E,$031F
	dc.w	$0320,$0321,$0322,$0323
	dc.w	$0324,$0325,$0326,$0327
	dc.w	$0328,$0329,$032A,$032B
	dc.w	$032C,$032D,$032E,$032F
	dc.w	$0330,$0331,$0332,$0333
	dc.w	$0334,$0335,$0336,$0337
	dc.w	$0338,$0339,$033A,$033B
	dc.w	$033C,$033D,$033E,$033F
	dc.w	$0340,$0341,$0342,$0343
	dc.w	$0344,$0345,$0346,$0347
	dc.w	$0348,$0349,$034A,$034B
	dc.w	$034C,$034D,$034E,$034F
	dc.w	$0350,$0351,$0352,$0353
	dc.w	$0354,$0355,$0356,$0357
	dc.w	$0358,$0359,$035A,$035B
	dc.w	$035C,$035D,$035E,$035F
	dc.w	$0360,$0361,$0362,$0363
	dc.w	$0364,$0365,$0366,$0367
	dc.w	$0368,$0369,$036A,$036B
	dc.w	$036C,$036D,$036E,$036F
	dc.w	$0370,$0371,$0372,$0373
	dc.w	$0374,$0375,$0376,$0377
	dc.w	$0378,$0379,$037A,$037B
	dc.w	$037C,$037D,$037E,$037F
	dc.w	$0380,$0381,$0382,$0383
	dc.w	$0384,$0385,$0386,$0387
	dc.w	$0388,$0389,$038A,$038B
	dc.w	$038C,$038D,$038E,$038F
	dc.w	$0390,$0391,$0392,$0393
	dc.w	$0394,$0395,$0396,$0397
	dc.w	$0398,$0399,$039A,$039B
	dc.w	$039C,$039D,$039E,$039F
	dc.w	$03A0,$03A1,$03A2,$03A3
	dc.w	$03A4,$03A5,$03A6,$03A7
	dc.w	$03A8,$03A9,$03AA,$03AB
	dc.w	$03AC,$03AD,$03AE,$03AF
	dc.w	$03B0,$03B1,$03B2,$03B3
	dc.w	$03B4,$03B5,$03B6,$03B7
	dc.w	$03B8,$03B9,$03BA,$03BB
	dc.w	$03BC,$03BD,$03BE,$03BF
	dc.w	$03C0,$03C1,$03C2,$03C3
	dc.w	$03C4,$03C5,$03C6,$03C7
	dc.w	$03C8,$03C9,$03CA,$03CB
	dc.w	$03CC,$03CD,$03CE,$03CF
	dc.w	$03D0,$03D1,$03D2,$03D3
	dc.w	$03D4,$03D5,$03D6,$03D7
	dc.w	$03D8,$03D9,$03DA,$03DB
	dc.w	$03DC,$03DD,$03DE,$03DF
	dc.w	$03E0,$03E1,$03E2,$03E3
	dc.w	$03E4,$03E5,$03E6,$03E7
	dc.w	$03E8,$03E9,$03EA,$03EB
	dc.w	$03EC,$03ED,$03EE,$03EF
	dc.w	$03F0,$03F1,$03F2,$03F3
	dc.w	$03F4,$03F5,$03F6,$03F7
	dc.w	$03F8,$03F9,$03FA,$03FB
	dc.w	$03FC,$03FD,$03FE,$03FF
	dc.w	$0400,$0401,$0402,$0403
	dc.w	$0404,$0405,$0406,$0407
	dc.w	$0408,$0409,$040A,$040B
	dc.w	$040C,$040D,$040E,$040F
	dc.w	$0410,$0411,$0412,$0413
	dc.w	$0414,$0415,$0416,$0417
	dc.w	$0418,$0419,$041A,$041B
	dc.w	$041C,$041D,$041E,$041F
	dc.w	$0420,$0421,$0422,$0423
	dc.w	$0424,$0425,$0426,$0427
	dc.w	$0428,$0429,$042A,$042B
	dc.w	$042C,$042D,$042E,$042F
	dc.w	$0430,$0431,$0432,$0433
	dc.w	$0434,$0435,$0436,$0437
	dc.w	$0438,$0439,$043A,$043B
	dc.w	$043C,$043D,$043E,$043F
	dc.w	$0440,$0441,$0442,$0443
	dc.w	$0444,$0445,$0446,$0447
	dc.w	$0448,$0449,$044A,$044B
	dc.w	$044C,$044D,$044E,$044F
	dc.w	$0450,$0451,$0452,$0453
	dc.w	$0454,$0455,$0456,$0457
	dc.w	$0458,$0459,$045A,$045B
	dc.w	$045C,$045D,$045E,$045F
	dc.w	$0460,$0461,$0462,$0463
	dc.w	$0464,$0465,$0466,$0467
	dc.w	$0468,$0469,$046A,$046B
	dc.w	$046C,$046D,$046E,$046F
	dc.w	$0470,$0471,$0472,$0473
	dc.w	$0474,$0475,$0476,$0477
	dc.w	$0478,$0479,$047A,$047B
	dc.w	$047C,$047D,$047E,$047F
	dc.w	$0480,$0481,$0482,$0483
	dc.w	$0484,$0485,$0486,$0487
	dc.w	$0488,$0489,$048A,$048B
	dc.w	$048C,$048D,$048E,$048F
	dc.w	$0490,$0491,$0492,$0493
	dc.w	$0494,$0495,$0496,$0497
	dc.w	$0498,$0499,$049A,$049B
	dc.w	$049C,$049D,$049E,$049F
	dc.w	$04A0,$04A1,$04A2,$04A3
	dc.w	$04A4,$04A5,$04A6,$04A7
	dc.w	$04A8,$04A9,$04AA,$04AB
	dc.w	$04AC,$04AD,$04AE,$04AF
	dc.w	$04B0,$04B1,$04B2,$04B3
	dc.w	$04B4,$04B5,$04B6,$04B7
	dc.w	$04B8,$04B9,$04BA,$04BB
	dc.w	$04BC,$04BD,$04BE,$04BF
	dc.w	$04C0,$04C1,$04C2,$04C3
	dc.w	$04C4,$04C5,$04C6,$04C7
	dc.w	$04C8,$04C9,$04CA,$04CB
	dc.w	$04CC,$04CD,$04CE,$04CF
	dc.w	$04D0,$04D1,$04D2,$04D3
	dc.w	$04D4,$04D5,$04D6,$04D7
	dc.w	$04D8,$04D9,$04DA,$04DB
	dc.w	$04DC,$04DD,$04DE,$04DF
	dc.w	$04E0,$04E1,$04E2,$04E3
	dc.w	$04E4,$04E5,$04E6,$04E7
	dc.w	$04E8,$04E9,$04EA,$04EB
	dc.w	$04EC,$04ED,$04EE,$04EF
	dc.w	$04F0,$04F1,$04F2,$04F3
	dc.w	$04F4,$04F5,$04F6,$04F7
	dc.w	$04F8,$04F9,$04FA,$04FB
	dc.w	$04FC,$04FD,$04FE,$04FF
	dc.w	$0500,$0501,$0502,$0503
	dc.w	$0504,$0505,$0506,$0507
	dc.w	$0508,$0509,$050A,$050B
	dc.w	$050C,$050D,$050E,$050F
	dc.w	$0510,$0511,$0512,$0513
	dc.w	$0514,$0515,$0516,$0517
	dc.w	$0518,$0519,$051A,$051B
	dc.w	$051C,$051D,$051E,$051F
	dc.w	$0520,$0521,$0522,$0523
	dc.w	$0524,$0525,$0526,$0527
	dc.w	$0528,$0529,$052A,$052B
	dc.w	$052C,$052D,$052E,$052F
	dc.w	$0530,$0531,$0532,$0533
	dc.w	$0534,$0535,$0536,$0537
	dc.w	$0538,$0539,$053A,$053B
	dc.w	$053C,$053D,$053E,$053F
	dc.w	$0540,$0541,$0542,$0543
	dc.w	$0544,$0545,$0546,$0547
	dc.w	$0548,$0549,$054A,$054B
	dc.w	$054C,$054D,$054E,$054F
	dc.w	$0550,$0551,$0552,$0553
	dc.w	$0554,$0555,$0556,$0557
	dc.w	$0558,$0559,$055A,$055B
	dc.w	$055C,$055D,$055E,$055F
	dc.w	$0560,$0561,$0562,$0563
	dc.w	$0564,$0565,$0566,$0567
	dc.w	$0568,$0569,$056A,$056B
	dc.w	$056C,$056D,$056E,$056F
	dc.w	$0570,$0571,$0572,$0573
	dc.w	$0574,$0575,$0576,$0577
	dc.w	$0578,$0579,$057A,$057B
	dc.w	$057C,$057D,$057E,$057F
	dc.w	$0580,$0581,$0582,$0583
	dc.w	$0584,$0585,$0586,$0587
	dc.w	$0588,$0589,$058A,$058B
	dc.w	$058C,$058D,$058E,$058F
	dc.w	$0590,$0591,$0592,$0593
	dc.w	$0594,$0595,$0596,$0597
	dc.w	$0598,$0599,$059A,$059B
	dc.w	$059C,$059D,$059E,$059F
	dc.w	$05A0,$05A1,$05A2,$05A3
	dc.w	$05A4,$05A5,$05A6,$05A7
	dc.w	$05A8,$05A9,$05AA,$05AB
	dc.w	$05AC,$05AD,$05AE,$05AF
	dc.w	$05B0,$05B1,$05B2,$05B3
	dc.w	$05B4,$05B5,$05B6,$05B7
	dc.w	$05B8,$05B9,$05BA,$05BB
	dc.w	$05BC,$05BD,$05BE,$05BF
	dc.w	$05C0,$05C1,$05C2,$05C3
	dc.w	$05C4,$05C5,$05C6,$05C7
	dc.w	$05C8,$05C9,$05CA,$05CB
	dc.w	$05CC,$05CD,$05CE,$05CF
	dc.w	$05D0,$05D1,$05D2,$05D3
	dc.w	$05D4,$05D5,$05D6,$05D7
	dc.w	$05D8,$05D9,$05DA,$05DB
	dc.w	$05DC,$05DD,$05DE,$05DF
	dc.w	$05E0,$05E1,$05E2,$05E3
	dc.w	$05E4,$05E5,$05E6,$05E7
	dc.w	$05E8,$05E9,$05EA,$05EB
	dc.w	$05EC,$05ED,$05EE,$05EF
	dc.w	$05F0,$05F1,$05F2,$05F3
	dc.w	$05F4,$05F5,$05F6,$05F7
	dc.w	$05F8,$05F9,$05FA,$05FB
	dc.w	$05FC,$05FD,$05FE,$05FF
	dc.w	$0600,$0601,$0602,$0603
	dc.w	$0604,$0605,$0606,$0607
	dc.w	$0608,$0609,$060A,$060B
	dc.w	$060C,$060D,$060E,$060F
	dc.w	$0610,$0611,$0612,$0613
	dc.w	$0614,$0615,$0616,$0617
	dc.w	$0618,$0619,$061A,$061B
	dc.w	$061C,$061D,$061E,$061F
	dc.w	$0620,$0621,$0622,$0623
	dc.w	$0624,$0625,$0626,$0627
	dc.w	$0628,$0629,$062A,$062B
	dc.w	$062C,$062D,$062E,$062F
	dc.w	$0630,$0631,$0632,$0633
	dc.w	$0634,$0635,$0636,$0637
	dc.w	$0638,$0639,$063A,$063B
	dc.w	$063C,$063D,$063E,$063F
	dc.w	$0640,$0641,$0642,$0643
	dc.w	$0644,$0645,$0646,$0647
	dc.w	$0648,$0649,$064A,$064B
	dc.w	$064C,$064D,$064E,$064F
	dc.w	$0650,$0651,$0652,$0653
	dc.w	$0654,$0655,$0656,$0657
	dc.w	$0658,$0659,$065A,$065B
	dc.w	$065C,$065D,$065E,$065F
	dc.w	$0660,$0661,$0662,$0663
	dc.w	$0664,$0665,$0666,$0667
	dc.w	$0668,$0669,$066A,$066B
	dc.w	$066C,$066D,$066E,$066F
	dc.w	$0670,$0671,$0672,$0673
	dc.w	$0674,$0675,$0676,$0677
	dc.w	$0678,$0679,$067A,$067B
	dc.w	$067C,$067D,$067E,$067F
	dc.w	$0680,$0681,$0682,$0683
	dc.w	$0684,$0685,$0686,$0687
	dc.w	$0688,$0689,$068A,$068B
	dc.w	$068C,$068D,$068E,$068F
	dc.w	$0690,$0691,$0692,$0693
	dc.w	$0694,$0695,$0696,$0697
	dc.w	$0698,$0699,$069A,$069B
	dc.w	$069C,$069D,$069E,$069F
	dc.w	$06A0,$06A1,$06A2,$06A3
	dc.w	$06A4,$06A5,$06A6,$06A7
	dc.w	$06A8,$06A9,$06AA,$06AB
	dc.w	$06AC,$06AD,$06AE,$06AF
	dc.w	$06B0,$06B1,$06B2,$06B3
	dc.w	$06B4,$06B5,$06B6,$06B7
	dc.w	$06B8,$06B9,$06BA,$06BB
	dc.w	$06BC,$06BD,$06BE,$06BF
	dc.w	$06C0,$06C1,$06C2,$06C3
	dc.w	$06C4,$06C5,$06C6,$06C7
	dc.w	$06C8,$06C9,$06CA,$06CB
	dc.w	$06CC,$06CD,$06CE,$06CF
	dc.w	$06D0,$06D1,$06D2,$06D3
	dc.w	$06D4,$06D5,$06D6,$06D7
	dc.w	$06D8,$06D9,$06DA,$06DB
	dc.w	$06DC,$06DD,$06DE,$06DF
	dc.w	$06E0,$06E1,$06E2,$06E3
	dc.w	$06E4,$06E5,$06E6,$06E7
	dc.w	$06E8,$06E9,$06EA,$06EB
	dc.w	$06EC,$06ED,$06EE,$06EF
	dc.w	$06F0,$06F1,$06F2,$06F3
	dc.w	$06F4,$06F5,$06F6,$06F7
	dc.w	$06F8,$06F9,$06FA,$06FB
	dc.w	$06FC,$06FD,$06FE,$06FF
	dc.w	$0700,$0701,$0702,$0703
	dc.w	$0704,$0705,$0706,$0707
	dc.w	$0708,$0709,$070A,$070B
	dc.w	$070C,$070D,$070E,$070F
	dc.w	$0710,$0711,$0712,$0713
	dc.w	$0714,$0715,$0716,$0717
	dc.w	$0718,$0719,$071A,$071B
	dc.w	$071C,$071D,$071E,$071F
	dc.w	$0720,$0721,$0722,$0723
	dc.w	$0724,$0725,$0726,$0727
	dc.w	$0728,$0729,$072A,$072B
	dc.w	$072C,$072D,$072E,$072F
	dc.w	$0730,$0731,$0732,$0733
	dc.w	$0734,$0735,$0736,$0737
	dc.w	$0738,$0739,$073A,$073B
	dc.w	$073C,$073D,$073E,$073F
	dc.w	$0740,$0741,$0742,$0743
	dc.w	$0744,$0745,$0746,$0747
	dc.w	$0748,$0749,$074A,$074B
	dc.w	$074C,$074D,$074E,$074F
	dc.w	$0750,$0751,$0752,$0753
	dc.w	$0754,$0755,$0756,$0757
	dc.w	$0758,$0759,$075A,$075B
	dc.w	$075C,$075D,$075E,$075F
	dc.w	$0760,$0761,$0762,$0763
	dc.w	$0764,$0765,$0766,$0767
	dc.w	$0768,$0769,$076A,$076B
	dc.w	$076C,$076D,$076E,$076F
	dc.w	$0770,$0771,$0772,$0773
	dc.w	$0774,$0775,$0776,$0777
	dc.w	$0778,$0779,$077A,$077B
	dc.w	$077C,$077D,$077E,$077F
	dc.w	$0780,$0781,$0782,$0783
	dc.w	$0784,$0785,$0786,$0787
	dc.w	$0788,$0789,$078A,$078B
	dc.w	$078C,$078D,$078E,$078F
	dc.w	$0790,$0791,$0792,$0793
	dc.w	$0794,$0795,$0796,$0797
	dc.w	$0798,$0799,$079A,$079B
	dc.w	$079C,$079D,$079E,$079F
	dc.w	$07A0,$07A1,$07A2,$07A3
	dc.w	$07A4,$07A5,$07A6,$07A7
	dc.w	$07A8,$07A9,$07AA,$07AB
	dc.w	$07AC,$07AD,$07AE,$07AF
	dc.w	$07B0,$07B1,$07B2,$07B3
	dc.w	$07B4,$07B5,$07B6,$07B7
	dc.w	$07B8,$07B9,$07BA,$07BB
	dc.w	$07BC,$07BD,$07BE,$07BF
	dc.w	$07C0,$07C1,$07C2,$07C3
	dc.w	$07C4,$07C5,$07C6,$07C7
	dc.w	$07C8,$07C9,$07CA,$07CB
	dc.w	$07CC,$07CD,$07CE,$07CF
	dc.w	$07D0,$07D1,$07D2,$07D3
	dc.w	$07D4,$07D5,$07D6,$07D7
	dc.w	$07D8,$07D9,$07DA,$07DB
	dc.w	$07DC,$07DD,$07DE,$07DF
	dc.w	$07E0,$07E1,$07E2,$07E3
	dc.w	$07E4,$07E5,$07E6,$07E7
	dc.w	$07E8,$07E9,$07EA,$07EB
	dc.w	$07EC,$07ED,$07EE,$07EF
	dc.w	$07F0,$07F1,$07F2,$07F3
	dc.w	$07F4,$07F5,$07F6,$07F7
	dc.w	$07F8,$07F9,$07FA,$07FB
	dc.w	$07FC,$07FD,$07FE,$07FF
	dc.w	$0800,$0801,$0802,$0803
	dc.w	$0804,$0805,$0806,$0807
	dc.w	$0808,$0809,$080A,$080B
	dc.w	$080C,$080D,$080E,$080F
	dc.w	$0810,$0811,$0812,$0813
	dc.w	$0814,$0815,$0816,$0817
	dc.w	$0818,$0819,$081A,$081B
	dc.w	$081C,$081D,$081E,$081F
	dc.w	$0820,$0821,$0822,$0823
	dc.w	$0824,$0825,$0826,$0827
	dc.w	$0828,$0829,$082A,$082B
	dc.w	$082C,$082D,$082E,$082F
	dc.w	$0830,$0831,$0832,$0833
	dc.w	$0834,$0835,$0836,$0837
	dc.w	$0838,$0839,$083A,$083B
	dc.w	$083C,$083D,$083E,$083F
	dc.w	$0840,$0841,$0842,$0843
	dc.w	$0844,$0845,$0846,$0847
	dc.w	$0848,$0849,$084A,$084B
	dc.w	$084C,$084D,$084E,$084F
	dc.w	$0850,$0851,$0852,$0853
	dc.w	$0854,$0855,$0856,$0857
	dc.w	$0858,$0859,$085A,$085B
	dc.w	$085C,$085D,$085E,$085F
	dc.w	$0860,$0861,$0862,$0863
	dc.w	$0864,$0865,$0866,$0867
	dc.w	$0868,$0869,$086A,$086B
	dc.w	$086C,$086D,$086E,$086F
	dc.w	$0870,$0871,$0872,$0873
	dc.w	$0874,$0875,$0876,$0877
	dc.w	$0878,$0879,$087A,$087B
	dc.w	$087C,$087D,$087E,$087F
	dc.w	$0880,$0881,$0882,$0883
	dc.w	$0884,$0885,$0886,$0887
	dc.w	$0888,$0889,$088A,$088B
	dc.w	$088C,$088D,$088E,$088F
	dc.w	$0890,$0891,$0892,$0893
	dc.w	$0894,$0895,$0896,$0897
	dc.w	$0898,$0899,$089A,$089B
	dc.w	$089C,$089D,$089E,$089F
	dc.w	$08A0,$08A1,$08A2,$08A3
	dc.w	$08A4,$08A5,$08A6,$08A7
	dc.w	$08A8,$08A9,$08AA,$08AB
	dc.w	$08AC,$08AD,$08AE,$08AF
	dc.w	$08B0,$08B1,$08B2,$08B3
	dc.w	$08B4,$08B5,$08B6,$08B7
	dc.w	$08B8,$08B9,$08BA,$08BB
	dc.w	$08BC,$08BD,$08BE,$08BF
	dc.w	$08C0,$08C1,$08C2,$08C3
	dc.w	$08C4,$08C5,$08C6,$08C7
	dc.w	$08C8,$08C9,$08CA,$08CB
	dc.w	$08CC,$08CD,$08CE,$08CF
	dc.w	$08D0,$08D1,$08D2,$08D3
	dc.w	$08D4,$08D5,$08D6,$08D7
	dc.w	$08D8,$08D9,$08DA,$08DB
	dc.w	$08DC,$08DD,$08DE,$08DF
	dc.w	$08E0,$08E1,$08E2,$08E3
	dc.w	$08E4,$08E5,$08E6,$08E7
	dc.w	$08E8,$08E9,$08EA,$08EB
	dc.w	$08EC,$08ED,$08EE,$08EF
	dc.w	$08F0,$08F1,$08F2,$08F3
	dc.w	$08F4,$08F5,$08F6,$08F7
	dc.w	$08F8,$08F9,$08FA,$08FB
	dc.w	$08FC,$08FD,$08FE,$08FF
	dc.w	$0900,$0901,$0902,$0903
	dc.w	$0904,$0905,$0906,$0907
	dc.w	$0908,$0909,$090A,$090B
	dc.w	$090C,$090D,$090E,$090F
	dc.w	$0910,$0911,$0912,$0913
	dc.w	$0914,$0915,$0916,$0917
	dc.w	$0918,$0919,$091A,$091B
	dc.w	$091C,$091D,$091E,$091F
	dc.w	$0920,$0921,$0922,$0923
	dc.w	$0924,$0925,$0926,$0927
	dc.w	$0928,$0929,$092A,$092B
	dc.w	$092C,$092D,$092E,$092F
	dc.w	$0930,$0931,$0932,$0933
	dc.w	$0934,$0935,$0936,$0937
	dc.w	$0938,$0939,$093A,$093B
	dc.w	$093C,$093D,$093E,$093F
	dc.w	$0940,$0941,$0942,$0943
	dc.w	$0944,$0945,$0946,$0947
	dc.w	$0948,$0949,$094A,$094B
	dc.w	$094C,$094D,$094E,$094F
	dc.w	$0950,$0951,$0952,$0953
	dc.w	$0954,$0955,$0956,$0957
	dc.w	$0958,$0959,$095A,$095B
	dc.w	$095C,$095D,$095E,$095F
	dc.w	$0960,$0961,$0962,$0963
	dc.w	$0964,$0965,$0966,$0967
	dc.w	$0968,$0969,$096A,$096B
	dc.w	$096C,$096D,$096E,$096F
	dc.w	$0970,$0971,$0972,$0973
	dc.w	$0974,$0975,$0976,$0977
	dc.w	$0978,$0979,$097A,$097B
	dc.w	$097C,$097D,$097E,$097F
	dc.w	$0980,$0981,$0982,$0983
	dc.w	$0984,$0985,$0986,$0987
	dc.w	$0988,$0989,$098A,$098B
	dc.w	$098C,$098D,$098E,$098F
	dc.w	$0990,$0991,$0992,$0993
	dc.w	$0994,$0995,$0996,$0997
	dc.w	$0998,$0999,$099A,$099B
	dc.w	$099C,$099D,$099E,$099F
	dc.w	$09A0,$09A1,$09A2,$09A3
	dc.w	$09A4,$09A5,$09A6,$09A7
	dc.w	$09A8,$09A9,$09AA,$09AB
	dc.w	$09AC,$09AD,$09AE,$09AF
	dc.w	$09B0,$09B1,$09B2,$09B3
	dc.w	$09B4,$09B5,$09B6,$09B7
	dc.w	$09B8,$09B9,$09BA,$09BB
	dc.w	$09BC,$09BD,$09BE,$09BF
	dc.w	$09C0,$09C1,$09C2,$09C3
	dc.w	$09C4,$09C5,$09C6,$09C7
	dc.w	$09C8,$09C9,$09CA,$09CB
	dc.w	$09CC,$09CD,$09CE,$09CF
	dc.w	$09D0,$09D1,$09D2,$09D3
	dc.w	$09D4,$09D5,$09D6,$09D7
	dc.w	$09D8,$09D9,$09DA,$09DB
	dc.w	$09DC,$09DD,$09DE,$09DF
	dc.w	$09E0,$09E1,$09E2,$09E3
	dc.w	$09E4,$09E5,$09E6,$09E7
	dc.w	$09E8,$09E9,$09EA,$09EB
	dc.w	$09EC,$09ED,$09EE,$09EF
	dc.w	$09F0,$09F1,$09F2,$09F3
	dc.w	$09F4,$09F5,$09F6,$09F7
	dc.w	$09F8,$09F9,$09FA,$09FB
	dc.w	$09FC,$09FD,$09FE,$09FF
	dc.w	$0A00,$0A01,$0A02,$0A03
	dc.w	$0A04,$0A05,$0A06,$0A07
	dc.w	$0A08,$0A09,$0A0A,$0A0B
	dc.w	$0A0C,$0A0D,$0A0E,$0A0F
	dc.w	$0A10,$0A11,$0A12,$0A13
	dc.w	$0A14,$0A15,$0A16,$0A17
	dc.w	$0A18,$0A19,$0A1A,$0A1B
	dc.w	$0A1C,$0A1D,$0A1E,$0A1F
	dc.w	$0A20,$0A21,$0A22,$0A23
	dc.w	$0A24,$0A25,$0A26,$0A27
	dc.w	$0A28,$0A29,$0A2A,$0A2B
	dc.w	$0A2C,$0A2D,$0A2E,$0A2F
	dc.w	$0A30,$0A31,$0A32,$0A33
	dc.w	$0A34,$0A35,$0A36,$0A37
	dc.w	$0A38,$0A39,$0A3A,$0A3B
	dc.w	$0A3C,$0A3D,$0A3E,$0A3F
	dc.w	$0A40,$0A41,$0A42,$0A43
	dc.w	$0A44,$0A45,$0A46,$0A47
	dc.w	$0A48,$0A49,$0A4A,$0A4B
	dc.w	$0A4C,$0A4D,$0A4E,$0A4F
	dc.w	$0A50,$0A51,$0A52,$0A53
	dc.w	$0A54,$0A55,$0A56,$0A57
	dc.w	$0A58,$0A59,$0A5A,$0A5B
	dc.w	$0A5C,$0A5D,$0A5E,$0A5F
	dc.w	$0A60,$0A61,$0A62,$0A63
	dc.w	$0A64,$0A65,$0A66,$0A67
	dc.w	$0A68,$0A69,$0A6A,$0A6B
	dc.w	$0A6C,$0A6D,$0A6E,$0A6F
	dc.w	$0A70,$0A71,$0A72,$0A73
	dc.w	$0A74,$0A75,$0A76,$0A77
	dc.w	$0A78,$0A79,$0A7A,$0A7B
	dc.w	$0A7C,$0A7D,$0A7E,$0A7F
	dc.w	$0A80,$0A81,$0A82,$0A83
	dc.w	$0A84,$0A85,$0A86,$0A87
	dc.w	$0A88,$0A89,$0A8A,$0A8B
	dc.w	$0A8C,$0A8D,$0A8E,$0A8F
	dc.w	$0A90,$0A91,$0A92,$0A93
	dc.w	$0A94,$0A95,$0A96,$0A97
	dc.w	$0A98,$0A99,$0A9A,$0A9B
	dc.w	$0A9C,$0A9D,$0A9E,$0A9F
	dc.w	$0AA0,$0AA1,$0AA2,$0AA3
	dc.w	$0AA4,$0AA5,$0AA6,$0AA7
	dc.w	$0AA8,$0AA9,$0AAA,$0AAB
	dc.w	$0AAC,$0AAD,$0AAE,$0AAF
	dc.w	$0AB0,$0AB1,$0AB2,$0AB3
	dc.w	$0AB4,$0AB5,$0AB6,$0AB7
	dc.w	$0AB8,$0AB9,$0ABA,$0ABB
	dc.w	$0ABC,$0ABD,$0ABE,$0ABF
	dc.w	$0AC0,$0AC1,$0AC2,$0AC3
	dc.w	$0AC4,$0AC5,$0AC6,$0AC7
	dc.w	$0AC8,$0AC9,$0ACA,$0ACB
	dc.w	$0ACC,$0ACD,$0ACE,$0ACF
	dc.w	$0AD0,$0AD1,$0AD2,$0AD3
	dc.w	$0AD4,$0AD5,$0AD6,$0AD7
	dc.w	$0AD8,$0AD9,$0ADA,$0ADB
	dc.w	$0ADC,$0ADD,$0ADE,$0ADF
	dc.w	$0AE0,$0AE1,$0AE2,$0AE3
	dc.w	$0AE4,$0AE5,$0AE6,$0AE7
	dc.w	$0AE8,$0AE9,$0AEA,$0AEB
	dc.w	$0AEC,$0AED,$0AEE,$0AEF
	dc.w	$0AF0,$0AF1,$0AF2,$0AF3
	dc.w	$0AF4,$0AF5,$0AF6,$0AF7
	dc.w	$0AF8,$0AF9,$0AFA,$0AFB
	dc.w	$0AFC,$0AFD,$0AFE,$0AFF
	dc.w	$0B00,$0B01,$0B02,$0B03
	dc.w	$0B04,$0B05,$0B06,$0B07
	dc.w	$0B08,$0B09,$0B0A,$0B0B
	dc.w	$0B0C,$0B0D,$0B0E,$0B0F
	dc.w	$0B10,$0B11,$0B12,$0B13
	dc.w	$0B14,$0B15,$0B16,$0B17
	dc.w	$0B18,$0B19,$0B1A,$0B1B
	dc.w	$0B1C,$0B1D,$0B1E,$0B1F
	dc.w	$0B20,$0B21,$0B22,$0B23
	dc.w	$0B24,$0B25,$0B26,$0B27
	dc.w	$0B28,$0B29,$0B2A,$0B2B
	dc.w	$0B2C,$0B2D,$0B2E,$0B2F
	dc.w	$0B30,$0B31,$0B32,$0B33
	dc.w	$0B34,$0B35,$0B36,$0B37
	dc.w	$0B38,$0B39,$0B3A,$0B3B
	dc.w	$0B3C,$0B3D,$0B3E,$0B3F
	dc.w	$0B40,$0B41,$0B42,$0B43
	dc.w	$0B44,$0B45,$0B46,$0B47
	dc.w	$0B48,$0B49,$0B4A,$0B4B
	dc.w	$0B4C,$0B4D,$0B4E,$0B4F
	dc.w	$0B50,$0B51,$0B52,$0B53
	dc.w	$0B54,$0B55,$0B56,$0B57
	dc.w	$0B58,$0B59,$0B5A,$0B5B
	dc.w	$0B5C,$0B5D,$0B5E,$0B5F
	dc.w	$0B60,$0B61,$0B62,$0B63
	dc.w	$0B64,$0B65,$0B66,$0B67
	dc.w	$0B68,$0B69,$0B6A,$0B6B
	dc.w	$0B6C,$0B6D,$0B6E,$0B6F
	dc.w	$0B70,$0B71,$0B72,$0B73
	dc.w	$0B74,$0B75,$0B76,$0B77
	dc.w	$0B78,$0B79,$0B7A,$0B7B
	dc.w	$0B7C,$0B7D,$0B7E,$0B7F
	dc.w	$0B80,$0B81,$0B82,$0B83
	dc.w	$0B84,$0B85,$0B86,$0B87
	dc.w	$0B88,$0B89,$0B8A,$0B8B
	dc.w	$0B8C,$0B8D,$0B8E,$0B8F
	dc.w	$0B90,$0B91,$0B92,$0B93
	dc.w	$0B94,$0B95,$0B96,$0B97
	dc.w	$0B98,$0B99,$0B9A,$0B9B
	dc.w	$0B9C,$0B9D,$0B9E,$0B9F
	dc.w	$0BA0,$0BA1,$0BA2,$0BA3
	dc.w	$0BA4,$0BA5,$0BA6,$0BA7
	dc.w	$0BA8,$0BA9,$0BAA,$0BAB
	dc.w	$0BAC,$0BAD,$0BAE,$0BAF
	dc.w	$0BB0,$0BB1,$0BB2,$0BB3
	dc.w	$0BB4,$0BB5,$0BB6,$0BB7
	dc.w	$0BB8,$0BB9,$0BBA,$0BBB
	dc.w	$0BBC,$0BBD,$0BBE,$0BBF
	dc.w	$0BC0,$0BC1,$0BC2,$0BC3
	dc.w	$0BC4,$0BC5,$0BC6,$0BC7
	dc.w	$0BC8,$0BC9,$0BCA,$0BCB
	dc.w	$0BCC,$0BCD,$0BCE,$0BCF
	dc.w	$0BD0,$0BD1,$0BD2,$0BD3
	dc.w	$0BD4,$0BD5,$0BD6,$0BD7
	dc.w	$0BD8,$0BD9,$0BDA,$0BDB
	dc.w	$0BDC,$0BDD,$0BDE,$0BDF
	dc.w	$0BE0,$0BE1,$0BE2,$0BE3
	dc.w	$0BE4,$0BE5,$0BE6,$0BE7
	dc.w	$0BE8,$0BE9,$0BEA,$0BEB
	dc.w	$0BEC,$0BED,$0BEE,$0BEF
	dc.w	$0BF0,$0BF1,$0BF2,$0BF3
	dc.w	$0BF4,$0BF5,$0BF6,$0BF7
	dc.w	$0BF8,$0BF9,$0BFA,$0BFB
	dc.w	$0BFC,$0BFD,$0BFE,$0BFF
	dc.w	$0C00,$0C01,$0C02,$0C03
	dc.w	$0C04,$0C05,$0C06,$0C07
	dc.w	$0C08,$0C09,$0C0A,$0C0B
	dc.w	$0C0C,$0C0D,$0C0E,$0C0F
	dc.w	$0C10,$0C11,$0C12,$0C13
	dc.w	$0C14,$0C15,$0C16,$0C17
	dc.w	$0C18,$0C19,$0C1A,$0C1B
	dc.w	$0C1C,$0C1D,$0C1E,$0C1F
	dc.w	$0C20,$0C21,$0C22,$0C23
	dc.w	$0C24,$0C25,$0C26,$0C27
	dc.w	$0C28,$0C29,$0C2A,$0C2B
	dc.w	$0C2C,$0C2D,$0C2E,$0C2F
	dc.w	$0C30,$0C31,$0C32,$0C33
	dc.w	$0C34,$0C35,$0C36,$0C37
	dc.w	$0C38,$0C39,$0C3A,$0C3B
	dc.w	$0C3C,$0C3D,$0C3E,$0C3F
	dc.w	$0C40,$0C41,$0C42,$0C43
	dc.w	$0C44,$0C45,$0C46,$0C47
	dc.w	$0C48,$0C49,$0C4A,$0C4B
	dc.w	$0C4C,$0C4D,$0C4E,$0C4F
	dc.w	$0C50,$0C51,$0C52,$0C53
	dc.w	$0C54,$0C55,$0C56,$0C57
	dc.w	$0C58,$0C59,$0C5A,$0C5B
	dc.w	$0C5C,$0C5D,$0C5E,$0C5F
	dc.w	$0C60,$0C61,$0C62,$0C63
	dc.w	$0C64,$0C65,$0C66,$0C67
	dc.w	$0C68,$0C69,$0C6A,$0C6B
	dc.w	$0C6C,$0C6D,$0C6E,$0C6F
	dc.w	$0C70,$0C71,$0C72,$0C73
	dc.w	$0C74,$0C75,$0C76,$0C77
	dc.w	$0C78,$0C79,$0C7A,$0C7B
	dc.w	$0C7C,$0C7D,$0C7E,$0C7F
	dc.w	$0C80,$0C81,$0C82,$0C83
	dc.w	$0C84,$0C85,$0C86,$0C87
	dc.w	$0C88,$0C89,$0C8A,$0C8B
	dc.w	$0C8C,$0C8D,$0C8E,$0C8F
	dc.w	$0C90,$0C91,$0C92,$0C93
	dc.w	$0C94,$0C95,$0C96,$0C97
	dc.w	$0C98,$0C99,$0C9A,$0C9B
	dc.w	$0C9C,$0C9D,$0C9E,$0C9F
	dc.w	$0CA0,$0CA1,$0CA2,$0CA3
	dc.w	$0CA4,$0CA5,$0CA6,$0CA7
	dc.w	$0CA8,$0CA9,$0CAA,$0CAB
	dc.w	$0CAC,$0CAD,$0CAE,$0CAF
	dc.w	$0CB0,$0CB1,$0CB2,$0CB3
	dc.w	$0CB4,$0CB5,$0CB6,$0CB7
	dc.w	$0CB8,$0CB9,$0CBA,$0CBB
	dc.w	$0CBC,$0CBD,$0CBE,$0CBF
	dc.w	$0CC0,$0CC1,$0CC2,$0CC3
	dc.w	$0CC4,$0CC5,$0CC6,$0CC7
	dc.w	$0CC8,$0CC9,$0CCA,$0CCB
	dc.w	$0CCC,$0CCD,$0CCE,$0CCF
	dc.w	$0CD0,$0CD1,$0CD2,$0CD3
	dc.w	$0CD4,$0CD5,$0CD6,$0CD7
	dc.w	$0CD8,$0CD9,$0CDA,$0CDB
	dc.w	$0CDC,$0CDD,$0CDE,$0CDF
	dc.w	$0CE0,$0CE1,$0CE2,$0CE3
	dc.w	$0CE4,$0CE5,$0CE6,$0CE7
	dc.w	$0CE8,$0CE9,$0CEA,$0CEB
	dc.w	$0CEC,$0CED,$0CEE,$0CEF
	dc.w	$0CF0,$0CF1,$0CF2,$0CF3
	dc.w	$0CF4,$0CF5,$0CF6,$0CF7
	dc.w	$0CF8,$0CF9,$0CFA,$0CFB
	dc.w	$0CFC,$0CFD,$0CFE,$0CFF
	dc.w	$0D00,$0D01,$0D02,$0D03
	dc.w	$0D04,$0D05,$0D06,$0D07
	dc.w	$0D08,$0D09,$0D0A,$0D0B
	dc.w	$0D0C,$0D0D,$0D0E,$0D0F
	dc.w	$0D10,$0D11,$0D12,$0D13
	dc.w	$0D14,$0D15,$0D16,$0D17
	dc.w	$0D18,$0D19,$0D1A,$0D1B
	dc.w	$0D1C,$0D1D,$0D1E,$0D1F
	dc.w	$0D20,$0D21,$0D22,$0D23
	dc.w	$0D24,$0D25,$0D26,$0D27
	dc.w	$0D28,$0D29,$0D2A,$0D2B
	dc.w	$0D2C,$0D2D,$0D2E,$0D2F
	dc.w	$0D30,$0D31,$0D32,$0D33
	dc.w	$0D34,$0D35,$0D36,$0D37
	dc.w	$0D38,$0D39,$0D3A,$0D3B
	dc.w	$0D3C,$0D3D,$0D3E,$0D3F
	dc.w	$0D40,$0D41,$0D42,$0D43
	dc.w	$0D44,$0D45,$0D46,$0D47
	dc.w	$0D48,$0D49,$0D4A,$0D4B
	dc.w	$0D4C,$0D4D,$0D4E,$0D4F
	dc.w	$0D50,$0D51,$0D52,$0D53
	dc.w	$0D54,$0D55,$0D56,$0D57
	dc.w	$0D58,$0D59,$0D5A,$0D5B
	dc.w	$0D5C,$0D5D,$0D5E,$0D5F
	dc.w	$0D60,$0D61,$0D62,$0D63
	dc.w	$0D64,$0D65,$0D66,$0D67
	dc.w	$0D68,$0D69,$0D6A,$0D6B
	dc.w	$0D6C,$0D6D,$0D6E,$0D6F
	dc.w	$0D70,$0D71,$0D72,$0D73
	dc.w	$0D74,$0D75,$0D76,$0D77
	dc.w	$0D78,$0D79,$0D7A,$0D7B
	dc.w	$0D7C,$0D7D,$0D7E,$0D7F
	dc.w	$0D80,$0D81,$0D82,$0D83
	dc.w	$0D84,$0D85,$0D86,$0D87
	dc.w	$0D88,$0D89,$0D8A,$0D8B
	dc.w	$0D8C,$0D8D,$0D8E,$0D8F
	dc.w	$0D90,$0D91,$0D92,$0D93
	dc.w	$0D94,$0D95,$0D96,$0D97
	dc.w	$0D98,$0D99,$0D9A,$0D9B
	dc.w	$0D9C,$0D9D,$0D9E,$0D9F
	dc.w	$0DA0,$0DA1,$0DA2,$0DA3
	dc.w	$0DA4,$0DA5,$0DA6,$0DA7
	dc.w	$0DA8,$0DA9,$0DAA,$0DAB
	dc.w	$0DAC,$0DAD,$0DAE,$0DAF
	dc.w	$0DB0,$0DB1,$0DB2,$0DB3
	dc.w	$0DB4,$0DB5,$0DB6,$0DB7
	dc.w	$0DB8,$0DB9,$0DBA,$0DBB
	dc.w	$0DBC,$0DBD,$0DBE,$0DBF
	dc.w	$0DC0,$0DC1,$0DC2,$0DC3
	dc.w	$0DC4,$0DC5,$0DC6,$0DC7
	dc.w	$0DC8,$0DC9,$0DCA,$0DCB
	dc.w	$0DCC,$0DCD,$0DCE,$0DCF
	dc.w	$0DD0,$0DD1,$0DD2,$0DD3
	dc.w	$0DD4,$0DD5,$0DD6,$0DD7
	dc.w	$0DD8,$0DD9,$0DDA,$0DDB
	dc.w	$0DDC,$0DDD,$0DDE,$0DDF
	dc.w	$0DE0,$0DE1,$0DE2,$0DE3
	dc.w	$0DE4,$0DE5,$0DE6,$0DE7
	dc.w	$0DE8,$0DE9,$0DEA,$0DEB
	dc.w	$0DEC,$0DED,$0DEE,$0DEF
	dc.w	$0DF0,$0DF1,$0DF2,$0DF3
	dc.w	$0DF4,$0DF5,$0DF6,$0DF7
	dc.w	$0DF8,$0DF9,$0DFA,$0DFB
	dc.w	$0DFC,$0DFD,$0DFE,$0DFF
	dc.w	$0E00,$0E01,$0E02,$0E03
	dc.w	$0E04,$0E05,$0E06,$0E07
	dc.w	$0E08,$0E09,$0E0A,$0E0B
	dc.w	$0E0C,$0E0D,$0E0E,$0E0F
	dc.w	$0E10,$0E11,$0E12,$0E13
	dc.w	$0E14,$0E15,$0E16,$0E17
	dc.w	$0E18,$0E19,$0E1A,$0E1B
	dc.w	$0E1C,$0E1D,$0E1E,$0E1F
	dc.w	$0E20,$0E21,$0E22,$0E23
	dc.w	$0E24,$0E25,$0E26,$0E27
	dc.w	$0E28,$0E29,$0E2A,$0E2B
	dc.w	$0E2C,$0E2D,$0E2E,$0E2F
	dc.w	$0E30,$0E31,$0E32,$0E33
	dc.w	$0E34,$0E35,$0E36,$0E37
	dc.w	$0E38,$0E39,$0E3A,$0E3B
	dc.w	$0E3C,$0E3D,$0E3E,$0E3F
	dc.w	$0E40,$0E41,$0E42,$0E43
	dc.w	$0E44,$0E45,$0E46,$0E47
	dc.w	$0E48,$0E49,$0E4A,$0E4B
	dc.w	$0E4C,$0E4D,$0E4E,$0E4F
	dc.w	$0E50,$0E51,$0E52,$0E53
	dc.w	$0E54,$0E55,$0E56,$0E57
	dc.w	$0E58,$0E59,$0E5A,$0E5B
	dc.w	$0E5C,$0E5D,$0E5E,$0E5F
	dc.w	$0E60,$0E61,$0E62,$0E63
	dc.w	$0E64,$0E65,$0E66,$0E67
	dc.w	$0E68,$0E69,$0E6A,$0E6B
	dc.w	$0E6C,$0E6D,$0E6E,$0E6F
	dc.w	$0E70,$0E71,$0E72,$0E73
	dc.w	$0E74,$0E75,$0E76,$0E77
	dc.w	$0E78,$0E79,$0E7A,$0E7B
	dc.w	$0E7C,$0E7D,$0E7E,$0E7F


sub_10FB7C:	; 敵將雙殺保護|生命值強制不清零
	moveq	#0,d0		; 原代码
	move.w	$6C(a2),d0
	cmp.l	d2,d0
	bgt.s	locret_10FB7C
	movea.l	$54(a2),a0
	cmpi.b	#2,(a0)		; 是否敵兵
	beq.s	locret_10FB7C
	move.l	d0,-(sp)	; 寄存敵人生命值
; 保險開關
	tst.b	(ram_0027).l
	bne.s	loc_10FB7F
; 是否雙殺[d1>0]
	movea.l	#$D07000,a0
	moveq	#7-1,d0		; 7個敵人OBJ
	moveq	#0,d1
loc_10FB7C:
	tst.w	$C(a0)		; 是否在場
	beq.s	loc_10FB7D
	movea.l	$58(a0),a1
	cmpi.b	#1,(a1)		; 是否敵將
	bne.s	loc_10FB7D
	tst.w	$6C(a0)		; 生命值是否為零
	bne.s	loc_10FB7D
	addq.l	#1,d1		; 計數
loc_10FB7D:
	lea		$400(a0),a0
	dbf		d0,loc_10FB7C
	tst.l	d1
	beq.s	loc_10FB7E
loc_10FB7F:
	move.l	(sp),d2
	subq.l	#1,d2		; 生命值保[1]
loc_10FB7E:
	move.l	(sp)+,d0
locret_10FB7C:
	rts


dword_209B76:	; 曹仁起身/死亡動作
	dc.l	$F0070000,sub_209B76
	dc.l	$F0061400	; 生命值為零則加14個單位的動作偏移
	dc.l	$F0130000
	dc.l	$F0020C00,$00350000
	dc.l	$F0130100
	dc.l	$F0070000,$00168C4C
	dc.l	$F0020200,$002F0000
	dc.l	$F00E0100
	dc.l	$F0020200,$00300000,$00311900,$00310000
	dc.l	$F0020200,$00320000
	dc.l	$F0020200,$00330000
	dc.l	$F0020200,$00340000
	dc.l	$80000000
	dc.l	$F00E0000	; F006跳至此處[$50(OBJ)=0A]
	dc.l	$F0282800
	dc.l	$002E0000,$40000000
	dc.l	$F0290000
	dc.l	$80000000
	dc.l	$F00E0000	; 死亡對話跳至此處
	dc.l	$002F0000,$40000000
	dc.l	$F0011E00	; 循環閃爍半起身

sub_209B76:	; 曹仁死亡對話
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	tst.w	$6C(a2)			; 生命值是否為零
	bne.s	locret_209B76
; 是否白河[0202]
	cmpi.b	#2,($8182F9).l
	bne.s	locret_209B76
	cmpi.b	#2,($8182FA).l
	bne.s	locret_209B76
; 死亡對話
	move.w	#$1D,$44(a2)	; 半起身動作
	move.w  #$A,$50(a2)		; 敵人瀕死狀態
	clr.b	($80C2B5).l		; 全局取消判定
	pea		(1).w			; 退場對話
	pea		(4).w			; 敵將編號
	move.l	a2,-(sp)		; 敵將OBJ
	jsr 	sub_1343D6		; 處理對話
	lea		$C(sp),sp
	move.b	#1,($80C2B5).l	; 全局判定恢復
	move.w	#$B,$50(a2)		; 閃爍尸體消失
locret_209B76:
	movea.l	(sp)+,a2
	rts


dword_22477E:	; 張遼起身/死亡動作
	dc.l	$F0070000,sub_22477E
	dc.l	$F0061200	; $6C(OBJ)=0則$44(OBJ)+=12
	dc.l	$F0130000
	dc.l	$F0020600,$00300000
	dc.l	$F0130100
	dc.l	$F0070000,$0016A824
	dc.l	$F0020200,$002B0000
	dc.l	$F00E0100
	dc.l	$F0020200,$002C0000
	dc.l	$F0020300,$002D0000
	dc.l	$F0020200,$002E0000
	dc.l	$F0020200,$002F0000
	dc.l	$80000000
	dc.l	$F00E0000	; F006跳至此處|$50(OBJ)=0A
	dc.l	$F0282800
	dc.l	$002A0000,$40000000
	dc.l	$F0290000
	dc.l	$80000000
	dc.l	$F00E0000	; 死亡對話跳至此處
	dc.l	$002B0000,$40000000
	dc.l	$F0011C00	; 循環閃爍半起身

sub_22477E:	; 張遼死亡對話
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	tst.w	$6C(a2)			; 生命值是否為零
	bne.s	locret_22477E
; 關羽是否在場
	clr.l	-(sp)
	jsr		sub_15EC88
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_22477E
; 死亡對話
	move.w	#$1B,$44(a2)	; 半起身動作
	move.w  #$A,$50(a2)		; 敵人瀕死狀態
	clr.b	($80C2B5).l		; 全局取消判定
	pea		(1).w			; 退場對話
	pea		($A).w			; 敵將編號
	move.l	a2,-(sp)		; 敵將OBJ
	jsr 	sub_1343D6		; 處理對話
	lea		$C(sp),sp
	move.b	#1,($80C2B5).l	; 全局判定恢復
	move.w	#$B,$50(a2)		; 閃爍尸體消失
locret_22477E:
	movea.l	(sp)+,a2
	rts

dword_2343AC:	; 呂蒙起身/死亡動作
	dc.l	$F0070000,sub_2343AC
	dc.l	$F0061200	; $6C(OBJ)=0則$44(OBJ)+=12
	dc.l	$F0130000
	dc.l	$F0020200,$00390000
	dc.l	$F0130100
	dc.l	$F0070000,$0016C068
	dc.l	$F0020200,$00340000
	dc.l	$F00E0100
	dc.l	$F0020200,$00350000
	dc.l	$F0020300,$00360000,$00373400,$00370000
	dc.l	$F0020200,$00380000,$80000000
	dc.l	$F00E0000	; F006跳至此處|$50(OBJ)=0A
	dc.l	$F0282800,$00330000,$40000000
	dc.l	$F0290000
	dc.l	$80000000
	dc.l	$F00E0000	; 死亡對話跳至此處
	dc.l	$00340000,$40000000
	dc.l	$F0011C00	; 循環閃爍半起身

sub_2343AC:	; 呂蒙死亡對話
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	tst.w	$6C(a2)			; 生命值是否為零
	bne.s	locret_2343AC
; 關羽是否在場
	clr.l	-(sp)
	jsr		sub_15EC88
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_2343AC
; 死亡對話
	move.w	#$1B,$44(a2)	; 半起身動作
	move.w  #$A,$50(a2)		; 敵人瀕死狀態
	clr.b	($80C2B5).l		; 全局取消判定
	pea		(1).w			; 退場對話
	pea		($E).w			; 敵將編號
	move.l	a2,-(sp)		; 敵將OBJ
	jsr 	sub_1343D6		; 處理對話
	lea		$C(sp),sp
	move.b	#1,($80C2B5).l	; 全局判定恢復
	move.w	#$B,$50(a2)		; 閃爍尸體消失
locret_2343AC:
	movea.l	(sp)+,a2
	rts

dword_231046:	; 黃蓋起身/死亡動作
	dc.l	$F0070000,sub_231046
	dc.l	$F0063900	; $6C(OBJ)=0則$44(OBJ)+=39
	dc.l	$F0130000
	dc.l	$F0330100
	dc.l	$F0280200
	dc.l	$F0020200
	dc.l	$F03400FF,$00520000,$00000000,$004D0000
	dc.l	$F0020200
	dc.l	$F03400FF,$00530000,$00000000,$004D0000
	dc.l	$F0020200
	dc.l	$F03400FF,$00540000,$00000000,$004D0000
	dc.l	$F0290000
	dc.l	$F0130100
	dc.l	$F0070000,$0016BD04
	dc.l	$F00E0100
	dc.l	$F0280200
	dc.l	$F03400FF,$00560000,$00000000,$00550000
	dc.l	$F0290000
	dc.l	$F0280200
	dc.l	$F03400FF,$00580000,$00000000,$00570000
	dc.l	$F0290000
	dc.l	$F0280200
	dc.l	$F03400FF,$005A0000,$00000000,$00590000
	dc.l	$F0290000
	dc.l	$F0280200
	dc.l	$F03400FF,$005C0000,$00000000,$005B0000
	dc.l	$F0290000
	dc.l	$F03400FF,$005E0000,$00210000,$005D2100
	dc.l	$F03400FF,$005E0000,$00000000,$005D0000
	dc.l	$F0330000
	dc.l	$80000000
	dc.l	$F00E0000	; F006跳至此處|$50(OBJ)=0A
	dc.l	$F0282800
	dc.l	$F03400FF,$00520000,$00000000,$004D0000
	dc.l	$F03400FF,$40520000,$00000000,$404D0000
	dc.l	$F0290000
	dc.l	$80000000
	dc.l	$F00E0000	; 死亡對話跳至此處
	dc.l	$F03400FF,$00520000,$00000000,$00550000
	dc.l	$F03400FF,$40520000,$00000000,$40550000
	dc.l	$F0014900	; 循環閃爍半起身

sub_231046:	; 黃蓋死亡對話
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	tst.w	$6C(a2)			; 生命值是否為零
	bne.s	locret_231046
; 孫權是否在場
	pea		(9).w
	jsr		sub_15EC88
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_231046
; 死亡對話
	move.w	#$48,$44(a2)	; 半起身動作
	move.w  #$A,$50(a2)		; 敵人瀕死狀態
	clr.b	($80C2B5).l		; 全局取消判定
	pea		(1).w			; 退場對話
	pea		($D).w			; 敵將編號
	move.l	a2,-(sp)		; 敵將OBJ
	jsr 	sub_1343D6		; 處理對話
	lea		$C(sp),sp
	move.b	#1,($80C2B5).l	; 全局判定恢復
	move.w	#$B,$50(a2)		; 閃爍尸體消失
locret_231046:
	movea.l	(sp)+,a2
	rts

dword_24E3A8:	; 孫權起身/死亡對話|向後動作
	dc.l	$F0070000,sub_24E3A8
	dc.l	$F0061200	; $6C(OBJ)=0則$44(OBJ)+=12
	dc.l	$F0130000
	dc.l	$F0020800,$00660000
	dc.l	$F0130100
	dc.l	$F0070000,$00173F12
	dc.l	$F0020200,$006C0000
	dc.l	$F00E0100
	dc.l	$F0020200,$006D0000
	dc.l	$F0020200,$006E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0020200,$00700000,$80000000
	dc.l	$F00E0000	; F006跳至此處|$50(OBJ)=0A
	dc.l	$F0282800,$00660000,$40660000
	dc.l	$F0290000
	dc.l	$80000000
	dc.l	$F00E0000	; 死亡對話跳至此處
	dc.l	$006C0000,$406C0000
	dc.l	$F0011C00	; 循環閃爍半起身

dword_24E40C:	; 孫權起身/死亡對話|向前動作
	dc.l	$F0070000,sub_24E3A8
	dc.l	$F0061200	; $6C(OBJ)=0則$44(OBJ)+=12
	dc.l	$F0130000
	dc.l	$F0020800,$006B0000
	dc.l	$F0130100
	dc.l	$F0070000,$00173F12
	dc.l	$F0020200,$00710000
	dc.l	$F00E0100
	dc.l	$F0020200,$00720000
	dc.l	$F00B3F00,$02B90000
	dc.l	$F0020200,$00470000
	dc.l	$F0020200,$00460000,$80000000
	dc.l	$F0280A00,$006B0000,$406B0000	; F006跳至此處|$50(OBJ)=0A
	dc.l	$F0290000
	dc.l	$80000000
	dc.l	$00000000
	dc.l	$F00E0000	; 死亡對話跳至此處
	dc.l	$00710000,$40710000
	dc.l	$F0011C00	; 循環閃爍半起身

sub_24E3A8:	; 孫權死亡對話
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	tst.w	$6C(a2)			; 生命值是否為零
	bne.s	locret_24E3A8
; 孫權是否在場
	pea		(9).w
	jsr		sub_15EC88
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_24E3A8
; 死亡對話
	move.w	#$1B,$44(a2)	; 半起身動作
	move.w  #$A,$50(a2)		; 敵人瀕死狀態
	clr.b	($80C2B5).l		; 全局取消判定
	pea		(1).w			; 退場對話
	clr.l	-(sp)			; 敵將編號
	move.l	a2,-(sp)		; 敵將OBJ
	jsr 	sub_1343D6		; 處理對話
	lea		$C(sp),sp
	move.b	#1,($80C2B5).l	; 全局判定恢復
	move.w	#$B,$50(a2)		; 閃爍尸體消失
locret_24E3A8:
	movea.l	(sp)+,a2
	rts


word_31CC6E:	; 敵孫權對話框頭像色盤
	dc.w	$8020,$FFFF,$A820,$BCA3,$D967,$F26D,$FF52,$8045
	dc.w	$90A8,$A10C,$B96F,$8444,$A14B,$C253,$D71B,$D123
	dc.w	$F622,$FF83,$8022,$8442,$9084,$9CC6,$AD49,$C1EE
	dc.w	$80A9,$812D,$B655,$E37D,$9824,$A846,$8215,$0000
word_2B039E:	; 「敵孫權」
	dc.w	$0087,$0137,$01DD,$FFFF


dword_23FEE6:	; 孟獲起身/死亡對話動作
	dc.l	$F0070000,sub_23FEE6
	dc.l	$F0130000
	dc.l	$F0020800,$00430000
	dc.l	$F0130100
	dc.l	$F0070000,$0016D06C
	dc.l	$F0020200,$003D0000
	dc.l	$F00E0100
	dc.l	$F0020200,$003E0000
	dc.l	$F0020300,$003F0000
	dc.l	$F0020200,$00400000
	dc.l	$F0020200,$00410000
	dc.l	$F0020200,$00420000
	dc.l	$80000000

sub_23FEE6:	; 孟獲、孟優死亡對話
	movem.l	d2/a2,-(sp)
	movea.l	$C(sp),a2
	tst.w	$6C(a2)			; 生命值是否為零
	bne.w	locret_23FEE6
; 是否對話
	pea		(5).w
	jsr		sub_15EC88		; 孔明在場否
	addq.l	#4,sp
	tst.l	d0
	beq.w	loc_23FEE8
	cmpi.b	#2,(ram_0026).l	; 是否二出場
	bcs.s	loc_23FEE8
; 起身動作
	clr.b	($81B93C).l		; 敵方取消攻擊
	clr.b	($80C2B5).l		; 全局取消判定
	moveq	#30,d2			; 孟優補充起身延時
loc_23FEE6:
	move.w	#1,$174(a2)		; 無敵容錯
	jsr		$13A646.l		; 主循環
	cmpi.w	#2,$50(a2)
	bne.s	loc_23FEE6
	dbf		d2,loc_23FEE6
; 死亡對話
	move.w  #$A,$50(a2)		; 瀕死狀態
	pea		(1).w			; 退場對話
	pea		($11).w			; 敵將編號
	move.l	a2,-(sp)		; 敵將OBJ
	jsr 	sub_1343D6		; 處理對話
	lea		$C(sp),sp
	move.b	#1,($81B93C).l	; 敵方開始攻擊
	move.b	#1,($80C2B5).l	; 全局判定恢復
; 退場動作
loc_23FEE8:
	pea		($D).w
	pea		(2).w
	move.l	a2,-(sp)
	jsr		($10EBDE).l		; 動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		($10EF18).l		; 寫入動作
	lea		$14(sp),sp
	move.w  #1,$A2(a2)		; 無視地形
	move.w	#1,$C2(a2)		; 屏外清除
	clr.w	$C4(a2)
; 完成退場
loc_23FEE9:
	jsr		$13A646.l		; 主循環
	tst.w	$C(a2)			; OBJ是否關閉
	bne.s	loc_23FEE9
	move.w  #$B,$50(a2)		; 開始爆物
locret_23FEE6:
	movem.l	(sp)+,d2/a2
	rts

word_2B0322:	; 「孟獲、孟優」
	dc.w	$00BC,$00BD,$039B,$00BC,$0354,$FFFF	; [038E]空白

dword_24523E:	; 孟優起身/死亡對話動作
	dc.l	$F0070000,sub_23FEE6
	dc.l	$00080000
	dc.l	$80000000


dword_36F6CC:	; 曹操起身/死亡對話|向後動作
	dc.l	$001DFC00
	dc.l	$F01000FE
	dc.l	$F0140009,$00000400,$001EFCFA,$001EFCFB
	dc.l	$F0100002,$001EFCFC,$001EFCFD,$001EFCFE,$001EFCFF
	dc.l	$001EFC01,$001EFC02,$001EFC03,$001EFC04,$001EFC05,$001EFC06
	dc.l	$F0140009,$00000400,$001E0000
	dc.l	$F0070000,sub_19F928	; 是否自刎
	dc.l	$F0040805

dword_36FC2C:	; 曹操起身/死亡對話|向前動作
	dc.l	$00290400
	dc.l	$F01000FE
	dc.l	$F0140009,$00000400,$002904FA,$002904FB
	dc.l	$F0100002,$002904FC,$002904FD,$002904FE,$002904FF
	dc.l	$00290401,$00290402,$00290403,$00290404,$00290405,$00290406
	dc.l	$F0140009,$00000400,$00290000
	dc.l	$F0070000,sub_19F928	; 是否自刎
	dc.l	$F004080F

sub_19F928:		; 曹操自刎
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	tst.w	$6C(a2)			; 生命值是否為零
	bne.w	locret_19F928
; 掩面自語[動作]
	pea		(4).w
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
; 掩面自語[停止]
	jsr		sub_175EB8		; 暫停速殺計時
	clr.b	($80C2B5).l		; 取消全局判定
	move.b	#1,(ram_0027).l	; 打開敵將生命保險
	jsr		$15FD62			; 角色死亡主循環
	move.w  #$A,$50(a2)		; 曹操瀕死狀態
	clr.l	-(sp)
	jsr		($10FEAC).l		; 等待敵方[0201]動作
	addq.l	#4,sp
	jsr		$15FD62			; 角色死亡主循環
	jsr		($15E7F4).l		; 等待我方[0201]動作
; 掩面自語[對話]
	pea		($13A646).l		; 主循環
	pea		(90).w
	jsr		$100EA4			; 設定時間
	addq.l	#8,sp
	pea		($73).w			; 「孤有何罪，天下無孤，不知有幾人稱帝，幾人稱王！」
	pea		($1C).w
	jsr		$1343D6			; 對話框
	addq.l	#8,sp
; 骈指向天
	pea		(5).w
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
	pea		($13A646).l		; 主循環
	pea		(120).w
	jsr		$100EA4			; 設定時間
	addq.l	#8,sp
	pea		($74).w			; 「天為何亡孤？為何亡孤！」
	pea		($1C).w
	jsr		$1343D6			; 對話框
	addq.l	#8,sp
; 自殺劍落[1]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$64,d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		(5).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 自殺劍落[2]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	addi.l	#$23,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$47,d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		(5).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 自殺劍落[3]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	addi.l	#$32,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		(5).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 引頸就戮
	pea		(6).w
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
; 自殺劍落[4]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	addi.l	#$23,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$47,d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		(5).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 自殺劍落[5]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$64,d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		(5).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 自殺劍落[6]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	subi.l	#$23,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$47,d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		(5).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 自殺劍落[7]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	subi.l	#$32,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		(5).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 自殺劍落[8]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	subi.l	#$23,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$47,d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		(5).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 自殺劍落[9]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$64,d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		($A).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 自殺劍落[A]
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	pea		($FF38).w
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	pea		($1FF320).l		; 退場自殺劍
	jsr		$1517D4			; 佈置機關
	pea		($13A646).l		; 主循環
	pea		($1E).w
	jsr		$100EA4			; 設定時間
	lea		$1C(sp),sp
; 擊倒在地
	clr.w	$6C(a2)
	pea		(7).w
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$10EBDE			; 動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
	pea		(30).w
	jsr		$1090FC			; 全局慢動作
	addq.l	#4,sp
; 恢復狀態
	move.b	#1,($80C2B5).l	; 全局恢復判定
	move.b	#1,($81A1F8).l	; 我方恢復行動
	move.b	#1,($81B5E0).l	; 敵方恢復行動
	move.b	#1,($81B93C).l	; 敵方開始攻擊
	clr.b	(ram_0027).l	; 敵將生命保險關
	jsr		(sub_175EB9).l	; 繼續速殺計時器
locret_19F928:
	movea.l	(sp)+,a2
	rts


; --------------- 敵將調整 --------------------------------------------------

sub_111330:
	tst.l	$1EC(a3)	; 是否被攻擊
	beq.s	loc_111330
; 欺人者人恆欺之
	move.l	$1EC(a3),$114(a3)
	rts
; 攻擊生命最低者
loc_111330:
	moveq	#0,d3
	move.b	d4,d3
	move.l	#140,d2		; 最大生命值#140
	moveq	#0,d1
    bra.s   loc_111331
loc_111332:
    move.l  d3,d0
	lsl.w	#2,d0
	move.l  -$10(a6,d0.w),a2
	move.w	$6C(a2),d1	; 角色生命值
	cmp.l	d1,d2
	bls.s	loc_111331
	move.l	d1,d2		; 保存較小生命值
loc_111331:
	dbf 	d3,loc_111332
	move.l  -$10(a6,d0.w),$114(a3)	; 攻擊對象
	rts


sub_110556:	; 雙王模式停定按照實際玩家數目調整
	jsr		sub_15E72C	; 正常停定
	cmpi.b	#3,(ram_0003).l
	beq.s	locret_110556
	jsr		$15E72C		; 加強停定
locret_110556:
	rts


sub_167236:	; 敵人倒地起身後動作
; 原代碼
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10F796
	addq.l	#8,sp
; 屬性起身
	move.l	$244(a2),d0		; 敵將身體屬性
	tst.b	(ram_0005).l	; 是否100版本
	beq.s	locret_174496
sub_174474:
; 107版本設定|暈毒無屬性起身
	btst	#7,$244(a2)		; 暈屬性
	bne.s	loc_174490
	btst	#1,$244(a2)		; 毒屬性
	bne.s	loc_174490
	btst	#0,$244(a2)		; 無屬性?
	beq.s	loc_174494
loc_174490:
	moveq	#1,d0
	bra.s	locret_174496
loc_174494:
	moveq	#0,d0
locret_174496:
	rts


sub_16C20C:
	movem.l	a2-a3,-(sp)
	movea.l	$C(sp),a2
	tst.b	$13(sp)			; F0070X00
	beq.s	loc_16C266
	movea.l	#seg_17592E,a3	; 坐標表
	move.w	(ram_0013).l,d0	; 場景序號
	mulu.w	#$C,d0			; 運算結果覆蓋高位
	adda.l	d0,a3			; 坐標信息
	tst.w	8(a3)			; 終點橫坐標是否固定值
	beq.s	loc_16C218
	move.w	8(a3),d0		; 固定終點橫坐標
	ext.l	d0
	move.w	$20(a2),d1
	ext.l	d1
	sub.l	d1,d0
	bra.s	loc_16C22E
loc_16C218:
	move.w	($D0A000).l,d0
	ext.l	d0
	move.w	$20(a2),d1
	ext.l	d1
	sub.l	d1,d0
	addi.l	#$E0,d0			; 終點橫坐標屏幕居中
loc_16C22E:
	moveq	#0,d1
	move.b	$13(sp),d1		; 平均數
	jsr		$1BEC0E
	move.w	d0,($81A93E).l	; 每次移動的橫坐標
	move.w	$A(a3),d0		; 終點縱坐標
	ext.l	d0
	move.w	$22(a2),d1
	ext.l	d1
	sub.l	d1,d0
	moveq	#0,d1
	move.b	$13(sp),d1		; 平均數
	jsr		$1BEC0E
	move.w	d0,($81A940).l	; 每次移動的縱坐標
	clr.w	$1C8(a2)
	bra.s	locret_16C27A
loc_16C266:
	move.w	($81A93E).l,d0
	add.w	d0,$20(a2)
	move.w	($81A940).l,d0
	add.w	d0,$22(a2)
locret_16C27A:
	movem.l	(sp)+,a2-a3
	rts


sub_10A476:
	moveq	#0,d0
	move.b	$78(a3),d0
	move.w	d3,$286(a2)	; 敵方初始高度
	rts


off_24D3E8:
	dc.l	$F007000C,sub_16C20C	; #13計算水平位移平均值|確定最終坐標XY
	dc.l	$F01C0100	; 無視地形
	dc.l	$F00E0000	; 速度最快
	dc.l	$F00BFF00,$002E0000
	dc.l	$F05D0800
	dc.l	$F0380800,$015000EB
	dc.l	$F0070000,sub_16C20C
	dc.l	$F02A030A	; 招式影子
	dc.l	$F05D1400
	dc.l	$F0381400,$015000F6
	dc.l	$F0070000,sub_16C20C
	dc.l	$F05D1F00
	dc.l	$F0381F00,$015000FC
	dc.l	$F0070000,sub_16C20C
	dc.l	$F05D1500
	dc.l	$F0381500,$015000FE
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0110000
	dc.l	$F05D0B00
	dc.l	$F0380B00,$015100F8
	dc.l	$F0070000,sub_16C20C
	dc.l	$F05D0000
	dc.l	$F0380000,$015100FD
	dc.l	$F0070000,sub_16C20C,$015100FE
	dc.l	$F0070000,sub_16C20C
	dc.l	$F05D0800
	dc.l	$F0380800,$015200FE
	dc.l	$F0070000,sub_16C20C
	dc.l	$F05D1000
	dc.l	$F0381000,$015200FF
	dc.l	$F0070000,sub_16C20C
	dc.l	$F05D1800
	dc.l	$F0381800,$015200FF
	dc.l	$F0070000,sub_16C20C
	dc.l	$F05D1F00
	dc.l	$F0381F00,$015200FF
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0070000,$0016EC72
	dc.l	$F0391F00,$01520000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F02A0000
	dc.l	$F01C0000
	dc.l	$F0200100
	dc.l	$F0030000	
	dc.l	$F00BFA00,$001D03E8
	dc.l	$F01000F9,$01520014
	dc.l	$F00BFA00,$001C03E8
	dc.l	$F010000D,$01530000
	dc.l	$F0381F00
	dc.l	$F00BFA00,$001DFC18
	dc.l	$F01000F4
	dc.l	$F0020500,$01530000
	dc.l	$F00BFA00,$001CFC18
	dc.l	$F010000B
	dc.l	$F0020500,$01540000
	dc.l	$F01000F6
	dc.l	$F0020500,$01550000,$01530000
	dc.l	$F0100009
	dc.l	$F0391D00,$01530000,$01530000
	dc.l	$F01000F8
	dc.l	$F0391B00,$01530000,$01530000
	dc.l	$F0100007
	dc.l	$F0391900,$01540000,$01540000
	dc.l	$F01000FA
	dc.l	$F0391700,$01540000,$01540000
	dc.l	$F0100005
	dc.l	$F0391500,$01540000,$01550000
	dc.l	$F01000FC
	dc.l	$F0391300,$01550000,$01550000
	dc.l	$F0100003
	dc.l	$F0391100,$01550000,$01550000
	dc.l	$F01000FE
	dc.l	$F0390F00,$01530000,$01530000
	dc.l	$F0100001
	dc.l	$F0390D00,$01530000,$01530000
	dc.l	$F0140009,$00000100	; 灰塵效果
	dc.l	$F0390B00,$01530000,$01540000
	dc.l	$F0390900,$01540000,$01540000
	dc.l	$F0390700,$01540000,$01540000
	dc.l	$F0390500,$01550000,$01550000
	dc.l	$F0390300,$01550000,$01550000
	dc.l	$F0390100,$01550000,$01530000
	dc.l	$F0390000,$01530000
	dc.l	$F00E0800
	dc.l	$F0280200,$01530000,$01540000,$01550000
	dc.l	$F0290000
	dc.l	$F05D0000	; 恢復背景建築物反色[相對於動作者]
	dc.l	$F004030A	; 孫權更換盤龍三節棍
	dc.l	$80000000


off_1FD6F8:
	dc.l	$F0070010,sub_16C20C	; #16計算水平位移平均值
	dc.l	$F01C0100	; 無視地形
	dc.l	$F04F2E00
	dc.l	$F0450300
	dc.l	$F0020500,$003C0000
	dc.l	$F00BFF00,$01090000
	dc.l	$F00B4F00,$00B50000
	dc.l	$F0020500,$00720000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0330100
	dc.l	$F0280300
	dc.l	$F0340004,$001C0000,$000E0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F0340004,$001D0000,$000E0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F0340004,$00190000,$000E0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F0340004,$001A0000,$000E0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280300
	dc.l	$F0340004,$001B0000,$000E0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F014011D,$005000CE
	dc.l	$F00BFF00,$01040000
	dc.l	$F0020500,$00720000
	dc.l	$F0280300
	dc.l	$F0340004,$001D0000,$000C0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F0340004,$00190000,$000C0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280300
	dc.l	$F0340004,$001A0000,$000C0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F014011D,$005000CE
	dc.l	$F00BFF00,$01040000
	dc.l	$F0020600,$00720000
	dc.l	$F0280300
	dc.l	$F0340004,$001C0000,$000A0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F0340004,$001D0000,$000A0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280300
	dc.l	$F0340004,$00190000,$000A0000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F014011D,$005000CE
	dc.l	$F00BFF00,$01040000
	dc.l	$F0020700,$00720000
	dc.l	$F0280300
	dc.l	$F0340004,$001B0000,$00080000,$20720000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0330000
	dc.l	$F00BFF00,$01090000	; 台詞「殺！」
	dc.l	$F0020300,$00720000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$00720000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$00720000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01C0000
	dc.l	$F0040103
	dc.l	$80000000

dword_1FE0B6:
	dc.l	$F0020700,$00110500
	dc.l	$F0020700,$00120500
	dc.l	$F0020700,$00130600
	dc.l	$F0020700,$00140600
	dc.l	$F0020700,$00150600
	dc.l	$F0020700,$00160600
	dc.l	$F0020700,$00170500
	dc.l	$F0020700,$00180500
	dc.l	$F0010000


dword_203426:
	dc.l	$F0020600,$00100600
	dc.l	$F0020600,$00110600
	dc.l	$F0020600,$00120600
	dc.l	$F0020600,$00130600
	dc.l	$F0020600,$00140600
	dc.l	$F0010000


sub_1681E2:	; 程昱出場隨機坐標
	movem.l	d2-d4/a2-a3,-(sp)
	movea.l	$18(sp),a3
; 隨機坐標
	clr.l	$20(a3)			; 重置橫縱坐標
	clr.l	-(sp)			; 豎坐標為零
	move.l	a3,-(sp)
	jsr		sub_1705E2		; 隨機坐標
; 原代碼
	move.w	#1,$92(a3)
	pea		($7F).w
	jsr		$1024B0
	lea		$C(sp),sp
	addi.w	#$78,d0
	move.w	d0,$258(a3)
	moveq	#0,d2
; 影分身
loc_16822C:
	pea		($1FF).w
	jsr		$1024B0
	move.w	$D0A000.l,d1	; 以屏幕橫坐標[左]為基礎值
	add.w	d1,d0
	move.l	d0,d3
	pea		($3F).w
	jsr		$1024B0
	addi.l	#$A0,d0
	move.l	d0,d4
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#1,d0
	and.l	d3,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.l	d4,-(sp)
	move.l	d3,-(sp)
	pea		($2058BC).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$20(sp),sp
	btst	#0,d4
	beq.s	loc_168290
	move.l	#$205840,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
loc_168290:
	move.w	$60(a3),$50(a2)
	move.w	$60(a3),$8A(a2)
	clr.l	$78(a2)
	move.w	#2,$6C(a2)
	move.w	d2,d0
	lsl.w	#5,d0
	move.w	d0,$EA(a2)
	move.w	#1,$6E(a2)
	addq.l	#1,d2
	moveq	#8,d0
	cmp.l	d2,d0
	bgt.w	loc_16822C
	movem.l	(sp)+,d2-d4/a2-a3
	rts


dword_209728:
	dc.l	$F00B9F00,$02BD0000
	dc.l	$F0020400,$00420000
	dc.l	$F0140003,$FFE200F8
	dc.l	$F0020200,$00210300
	dc.l	$F0020200,$00220400,$40230500,$00230500
	dc.l	$F0020300,$40233500,$00230500,$40230500,$00230500
	dc.l	$40230500,$00230500,$40230500,$00230500,$00230500
	dc.l	$F0020400,$00220400
	dc.l	$F0020400,$00210300
	dc.l	$F0020200,$00420000
	dc.l	$F0020500,$00420000
	dc.l	$F0010000


sub_1696F6:
	movem.l	d2/a2-a3,-(sp)
	movea.l	$10(sp),a2
	*move.w	#$F7,$22(a2)	; Y坐標固定最大
	move.w	$C8(a2),d2
	eori.w	#1,d2			; 方向相反
	ext.l	d2
	move.l	d2,-(sp)		; 面向
	clr.l	-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	tst.w	$C8(a2)
	beq.s	loc_169716
	subi.l	#$320,d0
	bra.s	loc_16971C
loc_169716:
	addi.l	#$320,d0
loc_16971C:
	move.l	d0,-(sp)
	pea		($385114).l
	jsr		$1517D4
	movea.l	d0,a3
	clr.w	$D2(a3)
	move.l	d2,-(sp)		; 面向
	clr.l	-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	tst.w	$C8(a2)
	beq.s	loc_169742
	subi.l	#$2BC,d0
	bra.s	loc_169748
loc_169742:
	addi.l	#$2BC,d0
loc_169748:
	move.l	d0,-(sp)
	pea		($385370).l
	jsr		$1517D4
	lea		$28(sp),sp
	movea.l	d0,a3
	clr.w	$D2(a3)
	movem.l	(sp)+,d2/a2-a3
	rts


off_20BDD6:
	dc.l	$F0070005,sub_16C20C	; #5計算水平位移平均值
	dc.l	$F01C0100	; 無視地形
	dc.l	$F02A020A	; 招式影子
	dc.l	$F0020500,$00200000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020500,$00210000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020500,$00220000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020500,$00230000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020500,$001C0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F02A0000	; 影子結束
	dc.l	$F01C0000
	dc.l	$F00E0100
	dc.l	$F0540400
	dc.l	$F04F2711
	dc.l	$F0450300
	dc.l	$F00B4F00,$00C10000
	dc.l	$F0330100
	dc.l	$F0340004,$008E0000,$00000000,$208D0000
	dc.l	$F0340004,$008E0000,$00000000,$008D0000
	dc.l	$F0340004,$00900000,$00000000,$208F0000
	dc.l	$F0340004,$00900000,$00000000,$008F0000
	dc.l	$F0340004,$00920000,$00000000,$20910000
	dc.l	$F0340004,$00920000,$00000000,$00910000
	dc.l	$F0340004,$00940000,$00000000,$20930000
	dc.l	$F0340004,$00940000,$00000000,$00930000
	dc.l	$F0340004,$00960000,$00000000,$20950000
	dc.l	$F0340004,$00960000,$00000000,$00950000
	dc.l	$F0340004,$00980000,$00000000,$009E0000
	dc.l	$F0340004,$00990000,$00000000,$009E0000
	dc.l	$F0340004,$009A0000,$00000000,$009F0000
	dc.l	$F0340004,$009B0000,$00000000,$009F0000
	dc.l	$F0330000
	dc.l	$F0040308
	dc.l	$80000000


off_2166A4:
	dc.l	$F0070022,sub_16C20C	; #34計算水平位移平均值
	dc.l	$F01C0100	; 無視地形
	dc.l	$F00E0000
	dc.l	$F02B0100
	dc.l	$F0540400
	dc.l	$F04F1100
	dc.l	$F0450200
	dc.l	$F00BFA00,$014A0000
	dc.l	$F0020C00,$00730000,$007400F6
	dc.l	$F0070000,sub_16C20C,$007400FA
	dc.l	$F0070000,sub_16C20C,$007400FA
	dc.l	$F0070000,sub_16C20C,$007400FA
	dc.l	$F0070000,sub_16C20C,$007400FB
	dc.l	$F0070000,sub_16C20C,$007400FB
	dc.l	$F0070000,sub_16C20C,$007400FB
	dc.l	$F0070000,sub_16C20C,$007500FC
	dc.l	$F0070000,sub_16C20C,$007500FC
	dc.l	$F0070000,sub_16C20C,$007500FC
	dc.l	$F0070000,sub_16C20C,$007500FD
	dc.l	$F0070000,sub_16C20C,$007500FD
	dc.l	$F0070000,sub_16C20C,$007500FD
	dc.l	$F0070000,sub_16C20C,$007500FE
	dc.l	$F0070000,sub_16C20C,$007500FE
	dc.l	$F0070000,sub_16C20C,$007500FE
	dc.l	$F0070000,sub_16C20C,$007500FF
	dc.l	$F0070000,sub_16C20C,$007500FF
	dc.l	$F0070000,sub_16C20C,$007500FF
	dc.l	$F00BFA00,$02C20000
	dc.l	$F0330100
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$00770000,$00060100,$00760001
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$00770000,$00060100,$00760001
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$00770000,$00060100,$00760001
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$00790000,$00060200,$00780002
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$00790000,$00060200,$00780002
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$00790000,$00060200,$00780002
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$007B0000,$00060300,$007A0003
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$007B0000,$00060300,$007A0003
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$007C0000,$00060300,$007A0003
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$007C0000,$00060400,$007A0004
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$007D0000,$00060500,$007A0005
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0340004,$007D0000,$00060500,$007A0005
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0330000,$007A0007
	dc.l	$F0070000,sub_16C20C,$007A0008
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0030000,$007E000A
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0140009,$00000100
	dc.l	$F0020A00,$00730000
	dc.l	$F01C0000	; 取消穿景
	dc.l	$F00E0300
	dc.l	$F02B0000	; 恢復地面動作
	dc.l	$F0540400
	dc.l	$F04F1200
	dc.l	$F00BFF00,$01430000,$00360000
	dc.l	$F0020200,$003B0000
	dc.l	$F015FE00,$00214BBC,$00000000,$003C0000,$003D0000
	dc.l	$F0070000,$00194436
	dc.l	$F00B9F00,$02850000
	dc.l	$F015FE00,$00214D04,$00000000,$003E0000
	dc.l	$F0020400,$003F0000,$00400000,$00360000
	dc.l	$F00E0500,$00000000
	dc.l	$F00BFA00,$014B0000,$00010000,$00020000
	dc.l	$F00E0100
	dc.l	$F02B0000
	dc.l	$F0540600
	dc.l	$F04F1200
	dc.l	$F0450300
	dc.l	$F0020100,$00690000
	dc.l	$F0020100,$006A0000
	dc.l	$F0020200,$006B0000
	dc.l	$F00E0000
	dc.l	$F015FF00,$002155A4,$001E1E00,$206C0A00,$006C0A00,$206C0A00
	dc.l	$F015FF00,$002155A4,$0032E200,$006C0800,$206C0800,$006C0800
	dc.l	$F015FF00,$002155A4,$001EF600,$206C0600,$006C0600,$206C0600
	dc.l	$F015FF00,$002155A4,$003C1900,$006C0400,$206C0400,$006C0400
	dc.l	$F015FF00,$002155A4,$0046EC00,$206C0200,$006C0200,$206C0200
	dc.l	$F015FF00,$002155A4,$00580700,$006C0000,$206C0000,$006C0000
	dc.l	$F015FF00,$002155A4,$006E0000,$006C5000
	dc.l	$F0020400,$006D0000
	dc.l	$00000000,$00010000,$00020000,$00030000
	dc.l	$00040000,$00050000,$00060000,$00070000,$00080000,$00090000
	dc.l	$80000000


off_222CF2:
	dc.l	$F0020000,$0000DE00	; 出場坐標后移
	dc.l	$F061FF00,$00222C7E,$0000FF00,$F0040102	; 張遼的白馬
	dc.l	$80000000


off_21A6F0:
	dc.l	$F0070000,sub_21A6F0	; 橫坐標偏移$E8
	dc.l	$F01C0100
	dc.l	$F0540600
	dc.l	$F04F1C02
	dc.l	$F0450900
	dc.l	$F0020C00,$00220000,$00230300
	dc.l	$002303FA,$002303FA,$002303FA,$002303FA
	dc.l	$002303FB,$002303FB,$002303FB,$002303FB
	dc.l	$002303FC,$002303FC,$002303FC,$002303FC
	dc.l	$002303FD,$002303FD,$002303FD
	dc.l	$F00BFF00,$014F0000
	dc.l	$002403FD,$002403FE,$002403FE,$002403FE
	dc.l	$002403FE,$002403FF,$002403FF,$002403FF,$002403FF
	dc.l	$F00BFF00,$01520000
	dc.l	$F0330100
	dc.l	$F0280200
	dc.l	$F0340004,$00750000,$00030200,$20740302
	dc.l	$F04B0000
	dc.l	$F0340004,$00750000,$00030300,$20740303
	dc.l	$F04B0000
	dc.l	$F0340004,$00750000,$00030300,$20740303
	dc.l	$F04B0000
	dc.l	$F0340004,$00760000,$00030400,$20740304
	dc.l	$F04B0000
	dc.l	$F0340004,$00760000,$00030400,$20740304
	dc.l	$F04B0000
	dc.l	$F0340004,$00760000,$00030500,$20740305
	dc.l	$F04B0000
	dc.l	$F0340004,$00770000,$00030600,$20780306
	dc.l	$F04B0000
	dc.l	$F0340004,$00770000,$00030700,$20780307
	dc.l	$F04B0000
	dc.l	$F0340004,$00770000,$00030700,$20780307
	dc.l	$F04B0000
	dc.l	$F0340004,$00750000,$00030700,$20780307
	dc.l	$F04B0000
	dc.l	$F0340004,$00750000,$00030700,$20780307
	dc.l	$F04B0000
	dc.l	$F0340004,$00750000,$00030800,$20780308
	dc.l	$F04B0000
	dc.l	$F0340004,$00760000,$00030800,$20780308
	dc.l	$F04B0000
	dc.l	$F0340004,$00760000,$00030800,$20780308
	dc.l	$F04B0000
	dc.l	$F0340004,$00760000,$00030800,$20780308
	dc.l	$F04B0000
	dc.l	$F0340004,$00770000,$00030800,$20780308
	dc.l	$F04B0000
	dc.l	$F0340004,$00770000,$00030800,$20780308
	dc.l	$F04B0000
	dc.l	$F0340004,$00770000,$00030900,$20780309
	dc.l	$F04B0000
	dc.l	$F0290000
	dc.l	$F0030000,$00780008
	dc.l	$F00BEF00,$00C70000
	dc.l	$F01000FC
	dc.l	$F0340004,$00790000,$00000000,$00780000
	dc.l	$F0340004,$00790000,$00000000,$00780000
	dc.l	$F0100004
	dc.l	$F0340004,$007A0000,$00000000,$00780000
	dc.l	$F0340004,$007A0000,$00000000,$00780000
	dc.l	$F0340004,$007B0000,$00000000,$00780000
	dc.l	$F0340004,$007B0000,$00000000,$00780000
	dc.l	$F0340004,$007C0000,$00000000,$00780000
	dc.l	$F0340004,$007C0000,$00000000,$00780000
	dc.l	$F0340004,$007D0000,$00000000,$00780000
	dc.l	$F0340004,$007D0000,$00000000,$00780000
	dc.l	$F0340004,$007E0000,$00000000,$00780000
	dc.l	$F0340004,$007E0000,$00000000,$00780000
	dc.l	$F0330000
	dc.l	$F01000FE,$007803FA,$007803FA
	dc.l	$F0100002,$007803FA,$007803FB,$007803FC,$007803FD
	dc.l	$007803FE,$007803FF,$00780301
	dc.l	$F04B0000,$00780302
	dc.l	$F04B0000,$00780303
	dc.l	$F04B0000,$00780304
	dc.l	$F04B0000,$00780305
	dc.l	$F04B0000
	dc.l	$F0030000,$00780306
	dc.l	$F0140009,$00000100
	dc.l	$F0030000,$007F0008
	dc.l	$F0020600,$007F0000,$00110000
	dc.l	$F0310000,$00110000
	dc.l	$F00E0300
	dc.l	$F0020200,$000C0000
	dc.l	$F0280200
	dc.l	$F00BFF00,$01530000
	dc.l	$F0020200,$000D0000
	dc.l	$F0020200,$000E0000
	dc.l	$F0020200,$000F0000
	dc.l	$F0020200,$00100000
	dc.l	$F0020200,$000D0000
	dc.l	$F0020200,$000E0000
	dc.l	$F0020200,$000F0000
	dc.l	$F0020200,$00100000
	dc.l	$F0290000
	dc.l	$F0020200,$00110000
	dc.l	$F01C0000
	dc.l	$80000000

sub_21A6F0:
	move.l	A2, -(A7)
	movea.l	8(sp),a2
	tst.w	$C8(a2)			; 是否面右
	beq.s	loc_21A6F0
	addi.w	#$E8,$20(a2)	; 橫坐標右移$E8
	bra.s	locret_21A6F0
loc_21A6F0:
	subi.w	#$E8,$20(a2)	; 橫坐標左移$E8
locret_21A6F0:
	movea.l	(A7)+, A2
	rts


off_22C720:
	dc.l	$F0070019,sub_16C20C	; #25計算水平位移平均值
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0540600
	dc.l	$F04F1200
	dc.l	$F0450300
	dc.l	$F00E0000	; 速度最快
	dc.l	$F00BFF00,$01770000
	dc.l	$F0020300,$00470000
	dc.l	$F0020300,$00480000
	dc.l	$F00B9F00,$00CC0000,$20490000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$20490000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F061FE00,$002B5AFC,$001001EA
	dc.l	$F061FE00,$0022A92A,$001001EA
	dc.l	$F061FE00,$0022AA12,$0010FFEA
	dc.l	$F0410100
	dc.l	$F0020300,$204A0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$204B0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$204C0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$204D0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0450200
	dc.l	$F0410100
	dc.l	$F0020300,$204A0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$204B0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$204C0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020300,$204D0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0410100,$204E00FC
	dc.l	$F0070000,sub_16C20C,$204E00FA
	dc.l	$F0070000,sub_16C20C,$204E00F8
	dc.l	$F0070000,sub_16C20C,$204E00F6
	dc.l	$F0070000,sub_16C20C,$204F00F6
	dc.l	$F0070000,sub_16C20C,$204F00F8
	dc.l	$F0070000,sub_16C20C,$204F00FA
	dc.l	$F0070000,sub_16C20C,$204F00FC
	dc.l	$F00E0100
	dc.l	$F0070000,sub_16C20C,$205000FE
	dc.l	$F0070000,sub_16C20C,$205000FF
	dc.l	$F0070000,sub_16C20C,$20500001
	dc.l	$F0070000,sub_16C20C,$20500002
	dc.l	$F0070000,sub_16C20C,$00510004
	dc.l	$F0070000,sub_16C20C,$00510006
	dc.l	$F0070000,sub_16C20C,$00510008
	dc.l	$F0030000,$0051000A
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0140009,$00000100
	dc.l	$F01C0000	; 取消穿景
	dc.l	$F0020600,$00520000
	dc.l	$F0140303,$00000000
	dc.l	$F0020500,$00000000
	dc.l	$F0540800
	dc.l	$F04F2E00
	dc.l	$F0020300,$00760000
	dc.l	$F0021200,$00390000
	dc.l	$F00BFF00,$01700000
	dc.l	$F0330100
	dc.l	$F00B9F00,$02C50000
	dc.l	$F03400FF,$003D0000,$00000000,$003C0000
	dc.l	$F03400FF,$003D0000,$00000000,$003C0000
	dc.l	$F03400FF,$003D0000,$00000000,$003C0000
	dc.l	$F0450300
	dc.l	$F03400FF,$003F0000,$00000000,$203E0000
	dc.l	$F0451D00
	dc.l	$F03400FF,$00410000,$00000000,$20400000
	dc.l	$F03400FF,$00430000,$00000000,$00420000
	dc.l	$F03400FF,$00440000,$00000000,$00420000
	dc.l	$F03400FF,$00450000,$00000000,$00420000
	dc.l	$F0330000
	dc.l	$F0020600,$00420000
	dc.l	$F0020300,$00460000
	dc.l	$80000000


off_23163C:
	dc.l	$F0070009,sub_16C20C	; #12計算水平位移平均值
	dc.l	$F0540800
	dc.l	$F04F1115
	dc.l	$F05C0500
	dc.l	$F0450200
	dc.l	$F01C0100	; 無視地形
	dc.l	$F00BEF00,$017B0000
	dc.l	$F0330100
	dc.l	$F0280600
	dc.l	$F03400FF,$002B0000,$00050000,$202A0000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280600
	dc.l	$F03400FF,$002D0000,$00050000,$202C0000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280600
	dc.l	$F03400FF,$002F0000,$00050000,$202E0000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280600
	dc.l	$F03400FF,$00310000,$00050000,$20300000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280600
	dc.l	$F03400FF,$00330000,$00050000,$20320000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280600
	dc.l	$F03400FF,$00350000,$00050000,$20340000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280600
	dc.l	$F03400FF,$00370000,$00050000,$20360000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280600
	dc.l	$F03400FF,$00390000,$00050000,$20380000
	dc.l	$F0290000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0280600
	dc.l	$F03400FF,$002B0000,$00050000,$202A0000
	dc.l	$F0290000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0330000
	dc.l	$F01C0000	; 結束穿景
	dc.l	$F0040103	; 踢出炸彈並釋放火團動作


dword_23B906:
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0020D00,$407A1000
	dc.l	$F0010000


off_23678C:
	dc.l	$F0070000,sub_23678C	; 群雄色盤
	dc.l	$F0200000
	dc.l	$F01C0100
	dc.l	$F00BFF00,$01930000	; 台詞「誰敢阻擋！」
	dc.l	$F0021400,$002A0000
	dc.l	$F0070000,$0016CCF6	; 參考呂布$23678C
	dc.l	$F0070000,$0016CD76
	dc.l	$F0020600,$002AFBF9	; 坐標後移
	dc.l	$F01C0000	; 取消穿景
	dc.l	$F0450900
	dc.l	$F05C0900,$006F0204,$006F0205,$006F0206,$006F0207
	dc.l	$006F0208,$006F0209,$006F020A,$006F020B
	dc.l	$006F020C,$006F020D,$006F020E,$006F020F
	dc.l	$F0030000,$2070046C
	dc.l	$F00BFF00,$02CD0000
	dc.l	$F00E0200
	dc.l	$F0610400,$00235A18,$007500EE
	dc.l	$F0610400,$00235C2C,$00650122
	dc.l	$F0610600,$00235DA0,$00700123
	dc.l	$F0100004,$20700000
	dc.l	$F0610400,$00235CE4,$00700521
	dc.l	$F0150400,$00235ACC,$006902FC
	dc.l	$F00BEF00,$02CE0000
	dc.l	$F01000FC,$00700000
	dc.l	$F01504FF,$00235ACC,$00790309
	dc.l	$F00BCF00,$02CE0000
	dc.l	$F0100003
	dc.l	$F0020300,$00700000
	dc.l	$F01000FD
	dc.l	$F00BDF00,$02CE0000
	dc.l	$F0150400,$00235ACC,$00540410
	dc.l	$F0020700,$00700000
	dc.l	$F0020100,$00710000
	dc.l	$F0040301	; 向前劈柴移動坐標以免卡地形
	dc.l	$80000000

sub_23678C:
	movem.l	a2-a3,-(sp)
	movea.l	$C(sp),a2
	movea.l	#(word_38B9EC),a3
	move.l	a3,$64(a2)	; 更新色盤指針
	pea		(1).w
	move.l	a3,-(sp)	; 群雄色盤
	moveq	#0,d0
	move.w	$122(a2),d0
	move.l	d0,-(sp)
	jsr		$10391E		; 計算色表地址
	addq.l	#4,sp
	move.l	d0,-(sp)
	jsr		$100AF6		; 刷新色盘
	lea		$C(sp),sp
	movem.l	(sp)+,a2-a3
	rts

word_38B9EC:	; 群雄徐晃色盤
	dc.w	$0420,$7FFE,$2000,$34A3,$4D46,$5DC9,$726E,$41C8
	dc.w	$5AB0,$7398,$0CA6,$194D,$2A14,$3AFC,$3129,$4A2F
	dc.w	$6335,$7FFB,$08A0,$1D42,$3249,$4F8D,$1442,$2905
	dc.w	$398E,$4E17,$1C00,$4107,$660E,$7F51,$03E0,$0000


off_23F2A6:
	dc.l	$F0280200	; 循環兩次|兩倍路程
	dc.l	$F00BBF00,$00D30000	; 聲音
	dc.l	$F01000FE,$00090A00	; 地震
	dc.l	$F0100002	; 地震
	dc.l	$F0021000,$00090000,$000A0400
	dc.l	$F0020C00,$000A0000,$000B0900
	dc.l	$F0020800,$000B0000,$000C1600
	dc.l	$F0020C00,$000C0000
	dc.l	$F00BBF00,$00D30000	; 聲音
	dc.l	$F01000FE,$000D1900	; 地震
	dc.l	$F0100002	; 地震
	dc.l	$F0021000,$000D0000,$000E0900
	dc.l	$F0020C00,$000E0000,$000F1400
	dc.l	$F0020800,$000F0000,$00101200
	dc.l	$F0020C00,$00100000
	dc.l	$F00BBF00,$00D30000	; 聲音
	dc.l	$F01000FE,$00091000	; 地震
	dc.l	$F0100002	; 地震
	dc.l	$F0021000,$00090000,$000A0400
	dc.l	$F0020C00,$000A0000,$000B0900
	dc.l	$F0020800,$000B0000,$000C1600
	dc.l	$F0020C00,$000C0000
	dc.l	$F00BBF00,$00D30000	; 聲音
	dc.l	$F01000FE,$000D1900	; 地震
	dc.l	$F0100002	; 地震
	dc.l	$F0021000,$000D0000,$000E0900
	dc.l	$F0020C00,$000E0000,$000F1400
	dc.l	$F0020800,$000F0000
	dc.l	$F0290000	; 循環結束
	dc.l	$F00BBF00,$00D30000	; 聲音
	dc.l	$F01000FE,$008D0200	; 地震
	dc.l	$F0100002	; 地震
	dc.l	$F00BFF00,$00D20000	; 聲音
	dc.l	$F0020400,$008D0000
	dc.l	$F0020600,$008E0000
	dc.l	$F0020800,$008F0000
	dc.l	$F0020A00,$00900000
	dc.l	$F0020C00,$00910000
	dc.l	$F0020800,$00920000
	dc.l	$F0020600,$00930000
	dc.l	$F0020400,$20940000
	dc.l	$F0020200,$20950000
	dc.l	$F00BFF00,$00D30000	; 聲音
	dc.l	$F01000FE,$00960000	; 地震
	dc.l	$F0100002	; 地震
	dc.l	$F0020C00,$00960000
	dc.l	$F0020800,$00970000
	dc.l	$F0020800,$00980000
	dc.l	$F0020A00,$00080000
	dc.l	$F0070004,sub_16D156,$00080000,$00842300	; 刷新孟獲動作$23F566|走路踩地|準備下象
	dc.l	$F0020800,$00840000
	dc.l	$F0280400,$20851800	; 循環定義
	dc.l	$F0020600,$00850000
	dc.l	$F00BDF00,$00D30000	; 聲音
	dc.l	$F01000FE,$20861C00	; 地震
	dc.l	$F0100002	; 地震
	dc.l	$F0410100	; 招式Hit
	dc.l	$F0020400,$00860000,$20871500
	dc.l	$F0020600,$00870000,$20882500
	dc.l	$F0020800,$00880000,$20891300
	dc.l	$F0410100	; 招式Hit
	dc.l	$F0020600,$00890000
	dc.l	$F00BDF00,$00D30000	; 聲音
	dc.l	$F01000FE,$208A1700	; 地震
	dc.l	$F0100002	; 地震
	dc.l	$F0020400,$008A0000,$208B2000
	dc.l	$F0410100	; 招式Hit
	dc.l	$F0020600,$008B0000,$20841800
	dc.l	$F0020800,$00840000
	dc.l	$F0290000	; 循環結束
	dc.l	$80000000

dword_243D34:	; 孟優出場動作
	dc.l	$F01C0100
	dc.l	$F00BFF00,$00D20000
	dc.l	$0000D000	; 出場坐標后移$60
	dc.l	$F00BFF00,$00D20000
	dc.l	$F0027800,$00090000
	dc.l	$F0280200
	dc.l	$F00BFF00,$00D30000
	dc.l	$F01000FE,$00091000
	dc.l	$F0100002
	dc.l	$F0021000,$00090000,$000A0400
	dc.l	$F0020C00,$000A0000,$000B0900
	dc.l	$F0020800,$000B0000,$000C1600
	dc.l	$F0020C00,$000C0000
	dc.l	$F00BFF00,$00D30000
	dc.l	$F01000FE,$000D1900
	dc.l	$F0100002
	dc.l	$F0021000,$000D0000,$000E0900
	dc.l	$F0020C00,$000E0000,$000F1400
	dc.l	$F0020800,$000F0000,$00101200
	dc.l	$F0020C00,$00100000
	dc.l	$F0290000
	dc.l	$F01C0000
	dc.l	$F00BFF00,$00D30000
	dc.l	$F01000FE,$008D0200
	dc.l	$F0100002
	dc.l	$F00BFF00,$00D20000
	dc.l	$F0020400,$008D0000
	dc.l	$F0020600,$008E0000
	dc.l	$F0020800,$008F0000
	dc.l	$F0020A00,$00900000
	dc.l	$F0020C00,$00910000
	dc.l	$F0020800,$00920000
	dc.l	$F0020600,$00930000
	dc.l	$F0020400,$00940000
	dc.l	$F0020200,$00950000
	dc.l	$F00BFF00,$00D30000
	dc.l	$F01000FE,$00960200
	dc.l	$F0100002
	dc.l	$F0020C00,$00960000
	dc.l	$F0020800,$00970000
	dc.l	$F0020800,$00980000
	dc.l	$F0070000,sub_243D34
	dc.l	$80000000

sub_243D34:	; 記錄南蠻（孟獲、孟優）出現次數
	addq.b	#1,(ram_0026).l
	rts


sub_16D156:
	movea.l	4(sp),a0	
	movea.l	$78(a0),a1	
	move.b	$B(sp),d0	
	ext.w	d0	
	move.w	d0,$44(a1)			; 原代碼
	move.w	$20(a0),$20(a1)		; 孟獲X坐標=大象X坐標
	move.w	$22(a0),$22(a1)		; Y
	addq.b	#1,(ram_0026).l		; 記錄出現次數
	rts


lword_24626E:
	dc.l	$F01C0100
	dc.l	$F0020300,$00000000,$00010000,$00020000,$00030000
	dc.l	$00040000,$00050000,$00060000,$00070000,$00080000
	dc.l	$F00BFF00,$01A90000	; 聲音
	dc.l	$F0020200,$005E0000
	dc.l	$F0280500	; 循環次數：5
	dc.l	$F0020200,$005F0000
	dc.l	$F0020200,$00600000
	dc.l	$F0290000	; 循環結束
	dc.l	$F0020500,$00610000
	dc.l	$F0020200,$00620000
	dc.l	$F0070000,$0016DD0C	; 火焰洞落石
	dc.l	$F00BFF00,$01A90000	; 聲音
	dc.l	$F0020200,$005E0000
	dc.l	$F0280500	; 循環次數：5
	dc.l	$F0020200,$005F0000
	dc.l	$F0020200,$00600000
	dc.l	$F0290000	; 循環結束
	dc.l	$F0020500,$00610000
	dc.l	$F0020200,$00620000,$00000000,$00010000,$00020000
	dc.l	$00030000,$00040000,$00050000,$00060000,$00070000,$00080000
	dc.l	$F0020200,$00300000
	dc.l	$F00BFF00,$01A50000	; 聲音
	dc.l	$F0020400,$00310000
	dc.l	$F0020200,$00320000
	dc.l	$F0020400,$00340000
	dc.l	$F0020100,$00360000
	dc.l	$F0020200,$00380000
	dc.l	$F00BBF00,$02C90000	; 聲音
	dc.l	$F0070000,$0016DDA6	; 火輪
	dc.l	$F061FE00,$0024A75E,$003C0000	; 超必殺閃光
	dc.l	$F061FE00,$00246CE2,$008800CC	; 超必殺閃光
	dc.l	$F0020200,$003A0000
	dc.l	$F0020600,$003C0000,$003E0000,$00000000,$00010000
	dc.l	$00020000,$00030000,$00040000,$00050000,$00060000,$00070000,$00080000
	dc.l	$F00E0000	; 速度最快
	dc.l	$F0070010,sub_16C20C	; #16計算水平位移平均值
	dc.l	$F0020800,$000B0000	; 走下坐壇
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000C0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000D0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000E0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000F0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$00100000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$00110000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$00120000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000B0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000C0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000D0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000E0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$000F0000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$00100000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$00110000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020800,$00120000
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01C0000	; 取消穿景
	dc.l	$F00BFF00,$01A40000	; 聲音
	dc.l	$F0020200,$005E0000
	dc.l	$F061FE01,$00214DAC,$0000FFBD	; 超必殺閃光
	dc.l	$F061FE01,$00214DAC,$0034FFB5	; 超必殺閃光
	dc.l	$F0020200,$005F0000
	dc.l	$F0020200,$00600000
	dc.l	$F0020200,$00610000
	dc.l	$F0020200,$00620000
	dc.l	$80000000

dword_246638:
	dc.l	$F0020800,$000B0500
	dc.l	$F0020800,$000C0500
	dc.l	$F0020800,$000D0500
	dc.l	$F0020800,$000E0500
	dc.l	$F0020800,$000F0500
	dc.l	$F0020800,$00100500
	dc.l	$F0020800,$00110500
	dc.l	$F0020800,$00120500
	dc.l	$F0010000


off_24CBBC:
	dc.l	$F0540300	; 打擊節奏
	dc.l	$F0450200
	dc.l	$F01C0100
	dc.l	$F00BFF00,$01B20000		; 台詞「諸位久等了！」
	dc.l	$F02A030A	; 分身影子|三重
	dc.l	$F0070015,sub_16C20C	; #21計算水平位移平均值
	dc.l	$F0020A00,$00410001
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00	; 下落動作
	dc.l	$F0020400,$00420001
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00	; 下落動作
	dc.l	$F0020400,$00430003
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00	; 下落動作
	dc.l	$F0070000,$0016E5CE,$20440002
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00,$20440002	; 下落動作
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00,$20440002	; 下落動作
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00,$20440002	; 下落動作
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00,$20440001	; 下落動作
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00,$20440001	; 下落動作
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00,$20440001	; 下落動作
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00,$20440001	; 下落動作
	dc.l	$F0070000,sub_16C20C
	dc.l	$F01B1C00,$204400FF
	dc.l	$F0070000,sub_16C20C,$204400FF
	dc.l	$F0070000,sub_16C20C,$204400FF
	dc.l	$F0070000,sub_16C20C,$204400FF
	dc.l	$F0070000,sub_16C20C,$204400FE
	dc.l	$F0070000,sub_16C20C,$204400FE
	dc.l	$F0070000,sub_16C20C,$204400FE
	dc.l	$F0070000,sub_16C20C,$204400FE	; 下落動作
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020400,$004300FD
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020400,$004200FF
	dc.l	$F0070000,sub_16C20C
	dc.l	$F0020A00,$004100FF
	dc.l	$F02A0000	; 影子結束
	dc.l	$F01C0000	; 取消穿景
	dc.l	$F0070000,sub_1B06C0	; 左慈分身符篆
	dc.l	$F0040305	; 調用下一招[0305追蹤球]

sub_1B06C0:	; 左慈分身符篆
	movem.l	a2-a3,-(sp)
	movea.l	$C(sp),a2
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a3
	clr.l	-(sp)			; 面向右
	clr.l	-(sp)			; 待同步Z
	clr.l	-(sp)			; 待同步Y
	clr.l	-(sp)			; 待同步X
	pea		(off_2055C4).l	; 分身符篆
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	move.l	a2,$78(a3)		; 寄存左慈OBJ
	move.l	a3,-(sp)
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10AC96			; 符篆附身
	lea		$24(sp),sp
	movem.l	(sp)+,a2-a3
	rts

off_2055C4:	; 左慈分身符篆
	dc.l	dword_2055B4
	dc.l	$001EC420,$00000000,$00000000,$003509E4
	dc.l	$0023AE5E,$000200D0,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
dword_2055B4:
	dc.l	$F05A0000,$003500E4
	dc.l	$F0070000,sub_2055B4
	dc.l	$006E0000,$F0010200
	dc.l	$80000000
sub_2055B4:	; 同步坐標
	movea.l	4(sp),a0		; 分身符篆OBJ
	movea.l	$78(a0),a1		; 分身左慈OBJ
	move.l	$D4(a1),d0		; 是否附身機關
	beq.s	loc_2055B4
	cmpa.l	d0,a0			; 是否符篆附身
	bne.s	locret_2055B4
loc_2055B4:
	move.l	a0,$D4(a1)		; 重新附身
	move.w	$20(a1),$20(a0)
	addi.w	#-$32,$20(a0)	; X
	move.w	$22(a1),$22(a0)
	addq.w	#5,$22(a0)		; Y
	move.w	$24(a1),$24(a0)	; Z
locret_2055B4:
	rts


off_2287B6:
	dc.l	$F0540100,$F04F1113,$F0451300
	dc.l	$F0020A00,$00810000
	dc.l	$F0070000,$0016B3BC,$002800F7
	dc.l	$F0070000,$0016B464,$002800F7
	dc.l	$F0070000,$0016B464,$002800F7
	dc.l	$F0070000,$0016B464,$002800F8
	dc.l	$F0070000,$0016B464,$002800F8
	dc.l	$F0070000,$0016B464,$002800F8
	dc.l	$F0070000,$0016B464,$002800F9
	dc.l	$F0070000,$0016B464,$002800F9
	dc.l	$F0070000,$0016B464,$002800F9
	dc.l	$F0070000,$0016B464,$002800FA
	dc.l	$F0070000,$0016B464,$002800FA
	dc.l	$F0070000,$0016B464,$002800FA
	dc.l	$F0070000,$0016B464,$002800FB
	dc.l	$F0070000,$0016B464,$002800FB
	dc.l	$F0070000,$0016B464,$002900FB
	dc.l	$F0070000,$0016B464,$002900FB
	dc.l	$F0070000,$0016B464,$002900FC
	dc.l	$F0070000,$0016B464,$002900FC
	dc.l	$F0070000,$0016B464,$002900FC
	dc.l	$F0070000,$0016B464,$002900FD
	dc.l	$F0070000,$0016B464,$002A00FD
	dc.l	$F0070000,$0016B464,$002A00FD
	dc.l	$F0070000,$0016B464,$002A00FD
	dc.l	$F0070000,$0016B464,$002A0000
	dc.l	$F0070000,$0016B464,$002A0000
	dc.l	$F0070001,$0016B464
	dc.l	$F05E0100	; 敵將甘寧[上天下地]硬漢
	dc.l	$F0020A00,$002A0000
	dc.l	$F0030000,$2078000F
	dc.l	$F061FE00,$00228742,$00000100
	dc.l	$F061FE00,$0022B756,$00000100
	dc.l	$F0020200,$00780000
	dc.l	$F0020700,$002C0000
	dc.l	$80000000


off_215618:
	dc.l	$F0540600,$F04F1200,$F0450300
	dc.l	$F0020100,$00690000
	dc.l	$F0020100,$006A0000
	dc.l	$F0020200,$006B0000
	dc.l	$F00E0000,$F05E0100	; 怒濤洶湧(硬漢)(敵將)
	dc.l	$F015FF00,$002155A4,$001E1E00,$206C0A00,$006C0A00,$206C0A00
	dc.l	$F015FF00,$002155A4,$0032E200,$006C0800,$206C0800,$006C0800
	dc.l	$F015FF00,$002155A4,$001EF600,$206C0600,$006C0600,$206C0600
	dc.l	$F015FF00,$002155A4,$003C1900,$006C0400,$206C0400,$006C0400
	dc.l	$F015FF00,$002155A4,$0046EC00,$206C0200,$006C0200,$206C0200
	dc.l	$F015FF00,$002155A4,$00580700,$006C0000,$206C0000,$006C0000
	dc.l	$F015FF00,$002155A4,$006E0000,$006C5000
	dc.l	$F0020400,$006D0000
	dc.l	$80000000


off_2020CE:	; 司馬懿召喚分身
; 蓄力動作
	dc.l	$F0020200,$00730000
	dc.l	$F0020C00,$00740000
	dc.l	$F0130100
; 召喚分身
	dc.l	$F0070005,sub_167802
	dc.l	$F0020300,$00750000
	dc.l	$F0020C00,$00780000
	dc.l	$80000000
; 電能量罩
	dc.l	$F0330100
	dc.l	$F0340004,$00760000,$00000000,$00750000
	dc.l	$F0340004,$00770000,$00000000,$00750000
	dc.l	$F0330000
	dc.l	$F00BFF00,$011A0000
	dc.l	$F0150400,$00203804,$00000000
	dc.l	$F0150400,$002038AC,$00000000
	dc.l	$F0020200,$00780000
	dc.l	$F0130000
	dc.l	$F0020C00,$00780000
	dc.l	$F0020200,$00780000
	dc.l	$80000000

sub_167802:	; 司馬懿召喚分身
	link	a6,#0
	move.l	a2,-(sp)
	movea.l	8(a6),a2
; 是否召喚
	jsr		$10F30A			; 場上敵人數目[sp]
	move.l	d0,-(sp)
	tst.b	($8182F9).l		; 青龍密室[0004]
	beq.s	loc_167802
	cmpi.b	#5,($8182F9).l	; 江陵道[0505]
	bne.s	loc_167803
	cmpi.b	#5,($8182FA).l
	bne.s	loc_167803
loc_167802:	; 特殊場景
	moveq	#3,d0			; 場上最大敵目[d0=03]
	bra.s	loc_167804
loc_167803:	; 一般情況
	jsr		$15E72C			; 玩家數目難度
	lsl.l	#1,d0
	subq.l	#3,d0			; 場上最大敵目[d0=01/03/05]
loc_167804:
	cmp.l	(sp)+,d0		; 場上敵目比最大敵目
	ble.s	loc_167805
; 執行分身
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$16784A			; 假司馬懿
	addq.l	#8,sp
	bra.s	locret_167802
; 電能量罩
loc_167805:
	move.l	$C(a6),d0
	add.w	d0,$44(a2)		; 切換動作
locret_167802:
	movea.l	-4(a6),a2
	unlk	a6
	rts


off_23BF48:	; 司馬懿地板電波
	dc.l	$F0540400
	dc.l	$F0450800
	dc.l	$F04F0E00
	dc.l	$F0020200,$00690000
	dc.l	$F0020200,$006A0000
	dc.l	$F0020200,$006B0000
	dc.l	$F0130100
	dc.l	$F0020200,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F0121F00,$206E0000
	dc.l	$F012FF00,$206E0000
	dc.l	$F0121F00,$206E0000
	dc.l	$F012FF00,$206E0000
	dc.l	$F0121F00,$206E0000
	dc.l	$F012FF00,$206E0000
	dc.l	$F0130000
	dc.l	$F00BFF00,$01190000
	dc.l	$F00E0000
	dc.l	$F0070000,sub_17C6A4,$206F0000
	dc.l	$F0070001,sub_17C6A4,$206F0000
	dc.l	$F0070002,sub_17C6A4,$206F0000
	dc.l	$F0070003,sub_17C6A4,$206F0000
	dc.l	$F0070004,sub_17C6A4,$206F0000
	dc.l	$F0070005,sub_17C6A4,$206F0000
	dc.l	$F0070006,sub_17C6A4,$206F0000
	dc.l	$F0070007,sub_17C6A4,$206F0000
	dc.l	$F0070008,sub_17C6A4,$206F0000
	dc.l	$F00E0200
	dc.l	$F0020200,$20700000
	dc.l	$F0020200,$00710000
	dc.l	$F0020200,$00720000
	dc.l	$80000000

sub_17C6A4:	; 地板電波
	link	a6,#0
	movem.l	a2-a3,-(sp)
	movea.l	8(a6),a3
	jsr		$14DF94
	movea.l	d0,a2
	move.b	$F(a6),d0
	ext.w	d0
	ext.l	d0
	moveq	#8,d1
	cmp.l	d1,d0
	bhi.w	loc_17C82C
	add.l	d0,d0
	move.w	jpt_17C6D2(pc,d0.l),d0
	jmp		jpt_17C6D2(pc,d0.w)
jpt_17C6D2:
	dc.w	loc_17C6E4-jpt_17C6D2
	dc.w	loc_17C788-jpt_17C6D2
	dc.w	loc_17C82C-jpt_17C6D2
	dc.w	loc_17C8B8-jpt_17C6D2
	dc.w	loc_17C950-jpt_17C6D2
	dc.w	loc_17CA00-jpt_17C6D2
	dc.w	loc_17CAB0-jpt_17C6D2
	dc.w	loc_17CB60-jpt_17C6D2
	dc.w	loc_17CC10-jpt_17C6D2
loc_17C6E4:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$5F,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	move.l	#off_23BEB8,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17C73A
	move.l	$58(a3),$7C(a2)
loc_17C73A:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$5F,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$30(sp),sp
	move.l	#off_23BEB8,$2C(a2)
	bra.w	loc_17CCBC
loc_17C788:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$91,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	move.l	#off_23BE9C,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17C7DE
	move.l	$58(a3),$7C(a2)
loc_17C7DE:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$91,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$30(sp),sp
	move.l	#off_23BE9C,$2C(a2)
	bra.w	loc_17CCBC
loc_17C82C:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$104,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$18(sp),sp
	move.l	#off_23BE80,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17C886
	move.l	$58(a3),$7C(a2)
loc_17C886:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$104,d0
	bra.w	loc_17CCA4
loc_17C8B8:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	subi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$73,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$18(sp),sp
	move.l	#off_23BE80,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17C918
	move.l	$58(a3),$7C(a2)
loc_17C918:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	addi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$73,d0
	bra.w	loc_17CCA4
loc_17C950:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	subi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$D2,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	move.l	#off_23BE9C,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17C9AC
	move.l	$58(a3),$7C(a2)
loc_17C9AC:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	addi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$D2,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$30(sp),sp
	move.l	#off_23BE9C,$2C(a2)
	bra.w	loc_17CCBC
loc_17CA00:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	subi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$104,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	move.l	#off_23BEB8,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17CA5C
	move.l	$58(a3),$7C(a2)
loc_17CA5C:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	addi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$104,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$30(sp),sp
	move.l	#off_23BEB8,$2C(a2)
	bra.w	loc_17CCBC
loc_17CAB0:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	addi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$5F,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	move.l	#off_23BE9C,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17CB0C
	move.l	$58(a3),$7C(a2)
loc_17CB0C:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	subi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$5F,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$30(sp),sp
	move.l	#off_23BE9C,$2C(a2)
	bra.w	loc_17CCBC
loc_17CB60:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	addi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$91,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	move.l	#off_23BEB8,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17CBBC
	move.l	$58(a3),$7C(a2)
loc_17CBBC:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	subi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$91,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$30(sp),sp
	move.l	#off_23BEB8,$2C(a2)
	bra.w	loc_17CCBC
loc_17CC10:
	moveq	#0,d0
	move.w	$C8(a3),d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	addi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	addi.l	#$E1,d0
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	lea		$18(sp),sp
	move.l	#off_23BE80,$2C(a2)
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17CC70
	move.l	$58(a3),$7C(a2)
loc_17CC70:
	clr.w	$D2(a2)
	jsr		$14DF94
	movea.l	d0,a2
	moveq	#0,d0
	move.w	$C8(a3),d0
	moveq	#1,d1
	eor.l	d1,d0
	move.l	d0,-(sp)
	clr.l	-(sp)
	move.w	$22(a3),d0
	ext.l	d0
	subi.l	#$19,d0
	move.l	d0,-(sp)
	move.w	$20(a3),d0
	ext.l	d0
	subi.l	#$E1,d0
loc_17CCA4:
	move.l	d0,-(sp)
	pea		(off_23BED4).l
	move.l	a2,-(sp)
	jsr		$14E076
	move.l	#off_23BE80,$2C(a2)
loc_17CCBC:
	clr.w	$3C(a2)
	clr.w	$54(a2)
	clr.w	$68(a2)
	move.l	a3,$78(a2)
	move.w	#2,$6C(a2)
	move.l	a3,d0
	beq.s	loc_17CCDC
	move.l	$58(a3),$7C(a2)
loc_17CCDC:
	clr.w	$D2(a2)
	movem.l	-8(a6),a2-a3
	unlk	a6
	rts

off_23BE80:
	dc.l	$00100000,$20110000,$20120000,$20130000
	dc.l	$00140000,$00150000
	dc.l	$80000000

off_23BE9C:
	dc.l	$00160000,$20170000,$20180000,$20190000
	dc.l	$001A0000,$001B0000
	dc.l	$80000000

off_23BEB8:
	dc.l	$001B0000,$201C0000,$201D0000,$201E0000
	dc.l	$001F0000,$00200000
	dc.l	$80000000

off_23BED4:
	dc.l	off_23BE80,$001C96C0,$001CA3E2,$001CAA74
	dc.l	$00319CE8,$00587F33,$09090020,$00000000
	dc.l	$00000A00,$00000000,$00000000,$00000000	; 機關傷害$0A
	dc.l	$00000000,$00000000,$00000000,$00000309	; 加成0309
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00004000,$00000000,$00000000,$00000000,0


sub_11D4DC:	; 張遼衝兵陣調整縱坐標
; 原代碼
	move.b	$F(a6),d0		; 長兵序號
	ext.w	d0
	lsl.w	#2,d0
	movea.l	#$2ABC5A,a0		; 縱坐標表
	move.l	(a0,d0.w),d0
; 0701前庭
	cmpi.b	#7,($8182F9).l
	bne.s	locret_11D4DC
	cmpi.b	#1,($8182FA).l
	bne.s	locret_11D4DC
	subi.w	#$C0,d0			; 中間值
	add.w	$22(a3),d0		; 張遼縱坐標
locret_11D4DC:
	rts


sub_1684CA:
	link	a6,#0
	jsr		sub_1684F8	; 木人數目
	tst.l	d0
	ble.s	loc_1684EC
; 召喚動作
	movea.l	8(a6),a0
	addq.w	#1,$44(a0)
loc_1684EC:
	unlk	a6
	rts

sub_1684F8:	; 木人數目
	jsr		$10F30A		; 場上敵人數目[sp]
	move.l	d0,-(sp)
	tst.b	($8182F9).l		; 青龍密室[0004]
	beq.s	loc_1684F8
	cmpi.b	#5,($8182F9).l	; 江陵道[0505]
	bne.s	loc_1684F9
	cmpi.b	#5,($8182FA).l
	bne.s	loc_1684F9
loc_1684F8:	; 特殊場景
	moveq	#3,d0		; 場上最大敵目[d0=03]
	bra.s	loc_1684FA
loc_1684F9:	; 一般情況
	jsr		$15E72C		; 玩家數目難度
	subq.l	#1,d0
	lsl.l	#1,d0		; 場上最大敵目[d0=02/04/06]
loc_1684FA:
	sub.l	(sp)+,d0	; 尚可召換的木人數目
	rts


off_23EF8E: ; 程昱紙人舞
	dc.l	$F00BFF00,$01250000
	dc.l	$F00B9F00,$00BD0000
	dc.l	$F0330100
	dc.l	$F03400FF,$00710000,$00000000,$00700000
	dc.l	$F03400FF,$00720000,$00000000,$00700000
	dc.l	$F03400FF,$00730000,$00000000,$00700000
	dc.l	$F03400FF,$00710000,$00000000,$00700000
	dc.l	$F03400FF,$00720000,$00000000,$00700000
	dc.l	$F0070000,sub_17D6C4
	dc.l	$F03400FF,$00730000,$00000000,$00700000
	dc.l	$F0330000
	dc.l	$80000000

sub_17D6C4: ; 紙人舞
	movem.l	d2/a2-a3,-(sp)
	movea.l	$10(sp),a2
	tst.w	$C8(a2)
	bne.s	loc_17D6D6
	moveq	#$1C,d2
	bra.s	loc_17D6D8
loc_17D6D6:
	moveq	#$FFFFFFE4,d2
loc_17D6D8:
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a3
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	subq.l	#8,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	add.l	d2,d0
	move.l	d0,-(sp)
	pea		(off_2084A8).l
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	move.w	#2,$6C(a3)
	move.l	a2,d0
	beq.s	loc_17D732
	move.l	$58(a2),$7C(a3)
loc_17D732:
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a3
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	subq.l	#8,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	add.l	d2,d0
	addi.l	#$A,d0
	move.l	d0,-(sp)
	pea		(off_2084A8).l
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	lea		$30(sp),sp
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	move.w	#2,$6C(a3)
	move.l	a2,d0
	beq.s	loc_17D796
	move.l	$58(a2),$7C(a3)
loc_17D796:
	move.w	#$A,$EA(a3)
	move.w	#1,$6E(a3)
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a3
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	subq.l	#8,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	add.l	d2,d0
	subi.l	#$1E,d0
	move.l	d0,-(sp)
	pea		(off_2084A8).l
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	move.w	#2,$6C(a3)
	move.l	a2,d0
	beq.s	loc_17D802
	move.l	$58(a2),$7C(a3)
loc_17D802:
	move.w	#$14,$EA(a3)
	move.w	#1,$6E(a3)
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a3
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	subq.l	#8,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	add.l	d2,d0
	addi.l	#$A,d0
	move.l	d0,-(sp)
	pea		(off_2084A8).l
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	lea		$30(sp),sp
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	move.w	#2,$6C(a3)
	move.l	a2,d0
	beq.s	loc_17D872
	move.l	$58(a2),$7C(a3)
loc_17D872:
	move.w	#$1E,$EA(a3)
	move.w	#1,$6E(a3)
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a3
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	subq.l	#8,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	add.l	d2,d0
	addi.l	#$A,d0
	move.l	d0,-(sp)
	pea		(off_2084A8).l
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	move.w	#2,$6C(a3)
	move.l	a2,d0
	beq.s	loc_17D8DE
	move.l	$58(a2),$7C(a3)
loc_17D8DE:
	move.w	#$32,$EA(a3)
	move.w	#1,$6E(a3)
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a3
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	subq.l	#8,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	add.l	d2,d0
	subi.l	#$A,d0
	move.l	d0,-(sp)
	pea		(off_2084A8).l
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	lea		$30(sp),sp
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	move.w	#2,$6C(a3)
	move.l	a2,d0
	beq.s	loc_17D94E
	move.l	$58(a2),$7C(a3)
loc_17D94E:
	move.w	#$3C,$EA(a3)
	move.w	#1,$6E(a3)
	movem.l	(sp)+,d2/a2-a3
	rts

off_2084A8: ; 紙人
	dc.l	$002083B2,$00204D08,$00204D0C,$00204D0E
	dc.l	$003509E4,$0023AE5E,$05020464,$00000000
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000309 ; 攻擊力編號
	dc.l	$00000035,$09FE0012,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00001100,$00000000,0


off_26BDB0:	; 黃蓋分身體轉
	dc.l	$F00E0000
	dc.l	$F04F2000
	dc.l	$F05C0500
	dc.l	$F0330100
	dc.l	$F03400FF,$00190000,$00000000
	dc.l	$F0020500,$00180000
	dc.l	$F03400FF,$00610000,$00000000
	dc.l	$F0020500,$00600000
	dc.l	$F03400FF,$00630000,$00000000
	dc.l	$F0020500,$00620000
	dc.l	$F00BFF00,$017F0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F0280800
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00000000,$20930000
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F03400FF,$00940000,$00000000,$20930000
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F03400FF,$00960000,$00000000,$20950000
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$00000000,$20970000
	dc.l	$F03400FF,$00980000,$00000000,$00970000
	dc.l	$F03400FF,$00980000,$00000000,$20970000
	dc.l	$F015FF00,off_26BD3C,$FFC40000
	dc.l	$F03400FF,$009A0000,$00000000,$00990000
	dc.l	$F03400FF,$009A0000,$00000000,$20990000
	dc.l	$F03400FF,$009A0000,$00000000,$00990000
	dc.l	$F0290000
	dc.l	$F00E0200
	dc.l	$F0280300
	dc.l	$F03400FF,$009C0000,$00000000,$009B0000
	dc.l	$F03400FF,$009D0000,$00000000,$009B0000
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$80000000

off_26BD3C:	; 分身定義
	dc.l	off_26BBB8,$0022E6BE,$0022E6C2,$0022E6C4
	dc.l	$003580CC,$00361EDB,$07010420,$00000000	; $361EDB圖片
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$40000000,$00000000,$00000000,$00000305	; 傷害值循0305動作
	dc.l	$00000035,$80E60000,$00000000,$00000000	; $3580E6
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00002000,$00000000,$00000000

off_26BBB8:	; 分身動作圖
	dc.l	$209301FD,$009301FD,$209502FD,$009502FE
	dc.l	$209702FE,$009703FD,$209903FE,$009904FE
	dc.l	$209304FE,$009305FE,$209505FE,$009505FE
	dc.l	$209706FE,$009706FE,$209907FF,$009907FF
	dc.l	$209307FF,$009307FF,$209507FF,$009507FF
	dc.l	$209708FF,$00970800,$20990800,$00990800
	dc.l	$20930800,$00930800,$20950801,$00950801
	dc.l	$20970701,$00970701,$20990701,$00990701
	dc.l	$20930701,$00930601,$20950602,$00950602
	dc.l	$20970502,$00970502,$20990402,$00990402
	dc.l	$20930302,$00930302,$20950202,$00950203
	dc.l	$20970203,$00970103,$20990103,$00990003
	dc.l	$2093FF02,$0093FF02,$2095FE03,$0095FE03
	dc.l	$2097FE03,$0097FD03,$2099FD02,$0099FC02
	dc.l	$2093FC02,$0093FB02,$2095FB02,$0095FB02
	dc.l	$2097FA02,$0097FA02,$2099F901,$0099F901
	dc.l	$2093F901,$0093F901,$2095F901,$0095F801
	dc.l	$2097F801,$0097F800,$2099F800,$0099F800
	dc.l	$2093F800,$0093F800,$2095F8FF,$0095F9FF
	dc.l	$2097F9FF,$0097F9FF,$2099F9FF,$0099F9FF
	dc.l	$2093F9FF,$0093FAFF,$2095FAFE,$0095FAFE
	dc.l	$2097FBFE,$0097FBFE,$2099FCFE,$0099FCFE
	dc.l	$2093FDFE,$0093FDFD,$2095FEFE,$0095FEFE
	dc.l	$2097FEFD,$0097FFFD,$2099FFFD,$009900FD
	dc.l	$80000000

off_26BF24:	; 黃蓋分身體轉原地爆
	dc.l	$F00E0000
	dc.l	$F04F2000
	dc.l	$F05C0500
	dc.l	$F0330100
	dc.l	$F03400FF,$00190000,$00000000
	dc.l	$F0020500,$00180000
	dc.l	$F03400FF,$00610000,$00000000
	dc.l	$F0020500,$00600000
	dc.l	$F03400FF,$00630000,$00000000
	dc.l	$F0020500,$00620000
	dc.l	$F00BFF00,$017F0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F0280800
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00020000,$20930200
	dc.l	$F03400FF,$00940000,$00020000,$00930200
	dc.l	$F03400FF,$00940000,$00020000,$20930200
	dc.l	$F03400FF,$00960000,$00020000,$00950200
	dc.l	$F03400FF,$00960000,$00020000,$20950200
	dc.l	$F03400FF,$00960000,$00020000,$00950200
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$00020000,$20970200
	dc.l	$F03400FF,$00980000,$00020000,$00970200
	dc.l	$F03400FF,$00980000,$00020000,$20970200
	dc.l	$F015FF00,off_26BD3C,$FFC40000
	dc.l	$F03400FF,$009A0000,$00020000,$00990200
	dc.l	$F03400FF,$009A0000,$00020000,$20990200
	dc.l	$F03400FF,$009A0000,$00020000,$00990200
	dc.l	$F0290000
	dc.l	$F0130100
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$0023040A,$000000D8
	dc.l	$F015FE01,$0023040A,$000000D8
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$002304CE,$000000D8
	dc.l	$F015FE01,$002304CE,$000000D8
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$00230592,$000000D8
	dc.l	$F015FE01,$00230592,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F015FE00,$00230656,$000000D8
	dc.l	$F015FE01,$00230656,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F015FE00,$0023071A,$000000D8
	dc.l	$F015FE01,$0023071A,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F012FF00
	dc.l	$F0130000
	dc.l	$F00E0200
	dc.l	$F0280300
	dc.l	$F03400FF,$009C0000,$00000000,$009B0000
	dc.l	$F03400FF,$009D0000,$00000000,$009B0000
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$80000000

off_26B050:
	* dc.l	$F0620200
	dc.l	$F00E0000
	dc.l	$F04F2000
	dc.l	$F05C0500
	dc.l	$F0330100
	dc.l	$F03400FF,$00190000,$00000000
	dc.l	$F0020500,$00180000
	dc.l	$F03400FF,$00610000,$00000000
	dc.l	$F0020500,$00600000
	dc.l	$F03400FF,$00630000,$00000000
	dc.l	$F0020500,$00620000
	dc.l	$F0110000
	dc.l	$F00BFF00,$017F0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00000200,$00930002
	dc.l	$F03400FF,$00940000,$FFFF0200,$0093FF02
	dc.l	$F03400FF,$00940000,$FFFF0200,$0093FF02
	dc.l	$F03400FF,$00960000,$FFFF0300,$0095FF03
	dc.l	$F03400FF,$00960000,$FFFE0300,$2095FE03
	dc.l	$F03400FF,$00960000,$FFFE0300,$0095FE03
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$FFFE0300,$2097FE03
	dc.l	$F03400FF,$00980000,$FFFE0300,$0097FE03
	dc.l	$F03400FF,$00980000,$FFFD0300,$2097FD03
	dc.l	$F03400FF,$009A0000,$FFFD0300,$0099FD03
	dc.l	$F03400FF,$009A0000,$FFFD0200,$2099FD02
	dc.l	$F03400FF,$009A0000,$FFFC0200,$0099FC02
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$FFFC0200,$2093FC02
	dc.l	$F03400FF,$00940000,$FFFC0200,$0093FC02
	dc.l	$F03400FF,$00940000,$FFFB0200,$2093FB02
	dc.l	$F03400FF,$00960000,$FFFB0200,$0095FB02
	dc.l	$F03400FF,$00960000,$FFFB0200,$2095FB02
	dc.l	$F03400FF,$00960000,$FFFB0200,$0095FB02
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$FFFA0200,$2097FA02
	dc.l	$F03400FF,$00980000,$FFFA0200,$0097FA02
	dc.l	$F03400FF,$00980000,$FFFA0200,$2097FA02
	dc.l	$F03400FF,$009A0000,$FFFA0100,$0099FA01
	dc.l	$F03400FF,$009A0000,$FFF90100,$2099F901
	dc.l	$F03400FF,$009A0000,$FFF90100,$0099F901
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$FFF90100,$2093F901
	dc.l	$F03400FF,$00940000,$FFF90100,$0093F901
	dc.l	$F03400FF,$00940000,$FFF90100,$2093F901
	dc.l	$F03400FF,$00960000,$FFF90100,$0095F901
	dc.l	$F03400FF,$00960000,$FFF90100,$2095F901
	dc.l	$F03400FF,$00960000,$FFF80100,$0095F801
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$FFF80100,$2097F801
	dc.l	$F03400FF,$00980000,$FFF80100,$0097F801
	dc.l	$F03400FF,$00980000,$FFF80000,$2097F800
	dc.l	$F03400FF,$009A0000,$FFF80000,$0099F800
	dc.l	$F03400FF,$009A0000,$FFF80000,$2099F800
	dc.l	$F03400FF,$009A0000,$FFF80000,$0099F800
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$FFF80000,$2093F800
	dc.l	$F03400FF,$00940000,$FFF80000,$0093F800
	dc.l	$F03400FF,$00940000,$FFF80000,$2093F800
	dc.l	$F03400FF,$00960000,$FFF80000,$0095F800
	dc.l	$F03400FF,$00960000,$FFF8FF00,$2095F8FF
	dc.l	$F03400FF,$00960000,$FFF9FF00,$0095F9FF
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$FFF9FF00,$2097F9FF
	dc.l	$F03400FF,$00980000,$FFF9FF00,$0097F9FF
	dc.l	$F03400FF,$00980000,$FFF9FF00,$2097F9FF
	dc.l	$F03400FF,$009A0000,$FFF9FF00,$0099F9FF
	dc.l	$F03400FF,$009A0000,$FFF9FF00,$2099F9FF
	dc.l	$F03400FF,$009A0000,$FFF9FF00,$0099F9FF
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$FFF9FF00,$2093F9FF
	dc.l	$F03400FF,$00940000,$FFF9FF00,$0093F9FF
	dc.l	$F03400FF,$00940000,$FFFAFF00,$2093FAFF
	dc.l	$F03400FF,$00960000,$FFFAFE00,$0095FAFE
	dc.l	$F03400FF,$00960000,$FFFAFE00,$2095FAFE
	dc.l	$F03400FF,$00960000,$FFFAFE00,$0095FAFE
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$FFFAFE00,$2097FAFE
	dc.l	$F03400FF,$00980000,$FFFBFE00,$0097FBFE
	dc.l	$F03400FF,$00980000,$FFFBFE00,$2097FBFE
	dc.l	$F03400FF,$009A0000,$FFFBFE00,$0099FBFE
	dc.l	$F03400FF,$009A0000,$FFFCFE00,$2099FCFE
	dc.l	$F03400FF,$009A0000,$FFFCFE00,$0099FCFE
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$FFFCFE00,$2093FCFE
	dc.l	$F03400FF,$00940000,$FFFDFE00,$0093FDFE
	dc.l	$F03400FF,$00940000,$FFFDFD00,$2093FDFD
	dc.l	$F03400FF,$00960000,$FFFDFD00,$0095FDFD
	dc.l	$F03400FF,$00960000,$FFFEFE00,$2095FEFE
	dc.l	$F03400FF,$00960000,$FFFEFE00,$0095FEFE
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$FFFEFE00,$2097FEFE
	dc.l	$F03400FF,$00980000,$FFFEFD00,$0097FEFD
	dc.l	$F03400FF,$00980000,$FFFFFD00,$2097FFFD
	dc.l	$F03400FF,$009A0000,$FFFFFD00,$0099FFFD
	dc.l	$F03400FF,$009A0000,$FFFFFD00,$2099FFFD
	dc.l	$F03400FF,$009A0000,$0000FD00,$009900FD
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$0000FD00,$209300FD
	dc.l	$F03400FF,$00940000,$0001FD00,$009301FD
	dc.l	$F03400FF,$00940000,$0001FD00,$209301FD
	dc.l	$F03400FF,$00960000,$0001FD00,$009501FD
	dc.l	$F03400FF,$00960000,$0002FD00,$209502FD
	dc.l	$F03400FF,$00960000,$0002FE00,$009502FE
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F00BFF00,$00CD0000
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$0002FE00,$209702FE
	dc.l	$F03400FF,$00980000,$0002FE00,$009702FE
	dc.l	$F03400FF,$00980000,$0003FD00,$209703FD
	dc.l	$F03400FF,$009A0000,$0003FD00,$009903FD
	dc.l	$F03400FF,$009A0000,$0003FE00,$209903FE
	dc.l	$F03400FF,$009A0000,$0004FE00,$009904FE
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$0004FE00,$209304FE
	dc.l	$F03400FF,$00940000,$0004FE00,$009304FE
	dc.l	$F03400FF,$00940000,$0005FE00,$209305FE
	dc.l	$F03400FF,$00960000,$0005FE00,$009505FE
	dc.l	$F03400FF,$00960000,$0005FE00,$209505FE
	dc.l	$F03400FF,$00960000,$0005FE00,$009505FE
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$0006FE00,$209706FE
	dc.l	$F03400FF,$00980000,$0006FE00,$009706FE
	dc.l	$F03400FF,$00980000,$0006FE00,$209706FE
	dc.l	$F03400FF,$009A0000,$0006FF00,$009906FF
	dc.l	$F03400FF,$009A0000,$0007FF00,$209907FF
	dc.l	$F03400FF,$009A0000,$0007FF00,$009907FF
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$0007FF00,$209307FF
	dc.l	$F03400FF,$00940000,$0007FF00,$009307FF
	dc.l	$F03400FF,$00940000,$0007FF00,$209307FF
	dc.l	$F03400FF,$00960000,$0007FF00,$009507FF
	dc.l	$F03400FF,$00960000,$0007FF00,$209507FF
	dc.l	$F03400FF,$00960000,$0007FF00,$009507FF
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$0007FF00,$209707FF
	dc.l	$F03400FF,$00980000,$0008FF00,$009708FF
	dc.l	$F03400FF,$00980000,$00080000,$20970800
	dc.l	$F03400FF,$009A0000,$00080000,$00990800
	dc.l	$F03400FF,$009A0000,$00080000,$20990800
	dc.l	$F03400FF,$009A0000,$00080000,$00990800
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00080000,$20930800
	dc.l	$F03400FF,$00940000,$00080000,$00930800
	dc.l	$F03400FF,$00940000,$00080000,$20930800
	dc.l	$F03400FF,$00960000,$00080000,$00950800
	dc.l	$F03400FF,$00960000,$00080100,$20950801
	dc.l	$F03400FF,$00960000,$00080100,$00950801
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$00070100,$20970701
	dc.l	$F03400FF,$00980000,$00070100,$00970701
	dc.l	$F03400FF,$00980000,$00070100,$20970701
	dc.l	$F03400FF,$009A0000,$00070100,$00990701
	dc.l	$F03400FF,$009A0000,$00070100,$20990701
	dc.l	$F03400FF,$009A0000,$00070100,$00990701
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00070100,$20930701
	dc.l	$F03400FF,$00940000,$00070100,$00930701
	dc.l	$F03400FF,$00940000,$00060100,$20930601
	dc.l	$F03400FF,$00960000,$00060200,$00950602
	dc.l	$F03400FF,$00960000,$00060200,$20950602
	dc.l	$F03400FF,$00960000,$00060200,$00950602
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$00050200,$20970502
	dc.l	$F03400FF,$00980000,$00050200,$00970502
	dc.l	$F03400FF,$00980000,$00050200,$20970502
	dc.l	$F03400FF,$009A0000,$00050200,$00990502
	dc.l	$F03400FF,$009A0000,$00040200,$20990402
	dc.l	$F03400FF,$009A0000,$00040200,$00990402
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00040200,$20930402
	dc.l	$F03400FF,$00940000,$00030200,$00930302
	dc.l	$F03400FF,$00940000,$00030200,$20930302
	dc.l	$F03400FF,$00960000,$00030200,$00950302
	dc.l	$F03400FF,$00960000,$00020200,$20950202
	dc.l	$F03400FF,$00960000,$00020300,$00950203
	dc.l	$F012FF00
	dc.l	$F03400FF,$00980000,$00020300,$20970203
	dc.l	$F03400FF,$00980000,$00020300,$00970203
	dc.l	$F03400FF,$00980000,$00010300,$20970103
	dc.l	$F03400FF,$009A0000,$00010300,$00990103
	dc.l	$F03400FF,$009A0000,$00010300,$20990103
	dc.l	$F03400FF,$009A0000,$00000300,$00990003
	dc.l	$F0120900
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$0023040A,$000000D8
	dc.l	$F015FE01,$0023040A,$000000D8
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$002304CE,$000000D8
	dc.l	$F015FE01,$002304CE,$000000D8
	dc.l	$F03400FF,$00940000,$00000000,$00930000
	dc.l	$F015FE00,$00230592,$000000D8
	dc.l	$F015FE01,$00230592,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F015FE00,$00230656,$000000D8
	dc.l	$F015FE01,$00230656,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F015FE00,$0023071A,$000000D8
	dc.l	$F015FE01,$0023071A,$000000D8
	dc.l	$F03400FF,$00960000,$00000000,$00950000
	dc.l	$F012FF00
	dc.l	$F00E0200
	dc.l	$F0280100
	dc.l	$F03400FF,$009C0000,$00000000,$009B0000
	dc.l	$F03400FF,$009D0000,$00000000,$009B0000
	dc.l	$F0290000
	dc.l	$F00E0000
	dc.l	$F00BDF00,$017C0000
	dc.l	$F03400FF,$003B0000,$00000000
	dc.l	$F0020800,$003A0000
	dc.l	$F0280100
	dc.l	$F03400FF,$003F0000,$00000000
	dc.l	$F0020800,$003C0000
	dc.l	$F03400FF,$00400000,$00000000
	dc.l	$F0020800,$003D0000
	dc.l	$F03400FF,$00410000,$00000000
	dc.l	$F0020800,$003E0000
	dc.l	$F0290000
	dc.l	$F03400FF,$003B0000,$00000000
	dc.l	$F0020800,$003A0000
	dc.l	$F0330000
	dc.l	$80000000

off_38B96C:	; 群雄黃蓋色盤
	dc.l	$00027FFF,$10062805,$488370E0,$7E000C48
	dc.l	$20ED460F,$6F3203E0,$006404C7,$0D2B15D2
	dc.l	$03E02D2B,$31EE56F3,$77B93905,$5987768C
	dc.l	$7F5203E0,$3C0060C0,$7E837BA2,$7FFE0000


off_23CED4:
	dc.l	$F0540A00
	dc.l	$F0020200,$006C0000
	dc.l	$F00BFF00,$01960000
	dc.l	$F0130100
	dc.l	$F0020200,$006D0000
	dc.l	$F0130000
	dc.l	$F0070000,$0016CD94	; 閃電
	dc.l	$F0280200
	dc.l	$F0020200,$006E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0290000
	dc.l	$F0040305	; 黑虎出洞
	dc.l	$80000000

dword_23B6B0:
	dc.l	$F0070000,sub_1AFC96
	dc.l	$F0020200,$006C0000
	dc.l	$F0020800,$006D0000
	dc.l	$F0070000,sub_16CAE0	; 召喚白虎
	dc.l	$F0280200
	dc.l	$F0020200,$006E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0290000
	dc.l	$80000000

sub_1AFC96:
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	jsr		sub_1AB0C2	; 是否召喚白虎
	bne.s	locret_1AFC96
	clr.l	-(sp)		; 踢腿動作0300
	pea		(3).w
	move.l	a2,-(sp)
	jsr		$10EBDE		; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18		; 寫入動作
	lea		$14(sp),sp
locret_1AFC96:
	movea.l	(sp)+,a2
	rts

sub_16CAE0:
	movem.l	d2/a2,-(sp)
	jsr		$109CC2		; 分配敵人OBJ序號
	move.l	d0,d2
	pea		(1).w		; 色盤|白虎
	clr.l	-(sp)		; 朝向
	clr.l	-(sp)
	clr.l	-(sp)		; 縱坐標
	clr.l	-(sp)		; 橫坐標
	pea		($39FB66).l	; 呂布召喚的白虎
	move.l	d2,-(sp)
	jsr		$10A1BA		; 敵方出場
	move.l	d2,-(sp)
	jsr		$10F2C2		; 計算敵人OBJ地址
	movea.l	d0,a2
	move.w	#4,$1DE(a2)
	clr.w	$216(a2)
	clr.w	$218(a2)
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$10FC92
	pea		(4).w		; 0104動作
	pea		(1).w
	move.l	a2,-(sp)
	jsr		$10EBDE		; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18		; 寫入動作
	lea		$3C(sp),sp
	movem.l	(sp)+,d2/a2
	rts


sub_110A08:	; 強制恢復鳥怪高度
	tst.w	$B6(a2)
	beq.s	loc_110A2A
	move.w	$24(a2),d0
	cmp.w	$286(a2),d0
	beq.s	loc_110A2A
	movea.l	$54(a2),a0
	cmpi.b	#$3A,1(a0)			; 是否老鷹
	beq.s	loc_110A24
	cmpi.b	#$21,1(a0)			; 是否左慈
	bne.s	loc_110A2A
	tst.b	(ram_0005).l		; 107版本否
	beq.s	loc_110A2A
	cmpi.b	#5,($8182F9).l		; 江陵道0505
	bne.s	loc_110A24
	cmpi.b	#5,($8182FA).l
	beq.s	loc_110A2A
loc_110A24:
	move.w	$286(a2),$24(a2)	; 恢復高度
loc_110A2A:	; 原代碼
	cmpi.w	#2,$C(a2)
	bne.s	loc_110A44
	cmpi.w	#$B,$50(a2)
	beq.s	loc_110A44
	move.l	a2,-(sp)
	jsr		$10B0D2
	addq.l	#4,sp
loc_110A44:
	rts


sub_1AB0C2:
; 江陵道不召喚敵兵
	cmpi.b	#5,($8182F9).l	; 江陵道0505
	bne.s	loc_1AB0C2
	cmpi.b	#5,($8182FA).l
	beq.s	loc_1AB0C3
loc_1AB0C2:
; 場上是否僅一敵將
	jsr		sub_109CC3	; 在場敵將數目
	cmpi.l	#2,d0
	bcc.s	loc_1AB0C3	; 雙王時不召喚敵兵
; 場上敵兵目
	jsr		$10F30A		; 場上敵人數目
	subq.l	#1,d0		; 減去敵將
	move.l	d0,-(sp)
; 召喚敵兵目
	jsr		$15E72C		; 玩家數目難度
	subq.l	#1,d0
	lsl.l	#1,d0		; 召喚兵上限|02/04/06
; 調整敵兵目
	move.w	$6C(a2),d1	; 根據生命值調整
	addi.w	#$15F,d1
	ext.l	d1
	divu.w	#$140,d1	; 當前敵將生命條數目
	ext.l	d1
	divu.w	d1,d0		; 召喚兵上限/生命條數目
	move.l	(sp)+,d1	; 場上敵兵數目
	sub.w	d1,d0		; 尚可召換數目
	ble.s	loc_1AB0C3
	moveq	#1,d0		; 可召喚
	bra.s	locret_1AB0C2
loc_1AB0C3:
	moveq	#0,d0		; 不可召喚
locret_1AB0C2:
	rts

sub_16E7CC:
	link	a6,#0
	move.l	a2,-(sp)
	movea.l	8(a6),a2
	cmpi.b	#1,$F(a6)
	bne.s	loc_16E7EC
; 是否升空
	move.w	$24(a2),d0
	ext.l	d0
	moveq	#$FFFFFFC2,d1
	cmp.l	d0,d1			; 低於FFC2則升空
	ble.s	loc_16E816
	bra.s	loc_16E7F8
loc_16E7EC:
; 是否降低
	move.w	$24(a2),d0
	ext.l	d0
	moveq	#$FFFFFFA0,d1
	cmp.l	d0,d1			; 高於FFA0則降低
	bge.s	loc_16E816
loc_16E7F8:
	tst.b	(ram_0005).l	; 107版本不召
	bne.s	loc_16E7F9
	jsr		sub_1AB0C2		; 是否召喚通怪
	tst.l	d0
	beq.s	loc_16E7F9
	pea		(4).w			; 0104
	pea		(1).w
	bra.s	loc_16E7FA
loc_16E7F9:
	pea		(1).w			; 0201
	pea		(2).w
loc_16E7FA:
	move.l	a2,-(sp)
	jsr		$10EBDE			; 計算動作指針
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18			; 寫入動作
	lea		$14(sp),sp
loc_16E816:
; 左慈升降[$18]
	movea.l	-4(a6),a2
	unlk	a6
	rts

; --------------- 敵兵調整 --------------------------------------------------

sub_109CC2:	; 場上敵人數目[d1]
	move.l	a2,-(sp)
	clr.l	d1
	movea.l	#$D07000,a2
	bra.s	loc_109D1A
loc_109CD0:
	tst.w	$C(a2)
	bne.s	loc_109D14
	moveq	#1,d0			; 可刷新敵人
	bra.s	loc_109D32
loc_109D14:
	addq.l	#1,d1
	lea		$400(a2),a2
loc_109D1A:
	cmpi.l	#7,d1
	bcs.s	loc_109CD0
	moveq	#0,d0			; 敵目達到上限
loc_109D32:
	movea.l	(sp)+,a2
	rts


sub_12F0CC:
	tst.l	4(a3)			; 敵兵指針是否爲零
	beq.s	loc_12F0E0
; 指定敵兵
	moveq	#0,d0			; [指定敵兵]
	move.b	2(a3),d0		; 動作類目
	move.w	d0,-$18(a6)
	move.b	3(a3),d0		; 動作編號
	move.w	d0,-$1A(a6)
	move.l	4(a3),-4(a6)	; 敵兵指針
	move.b	$A(a3),d0		; 第二動作的類目
	move.w	d0,-$1C(a6)
	move.b	$B(a3),d0		; 第二動作的編號
	move.w	d0,-$1E(a6)
	bra.s	loc_12F0E6
; 隨機敵兵
loc_12F0E0:
	moveq	#0,d0
	move.b	(ram_000C).l,d0	; 敵將總位目
	movea.l	#off_12F0E0,a0	; 隨機範圍表
	move.b	(a0,d0.l),d0
	move.l	d0,-(sp)		; 隨機範圍
	jsr		$102480			; 大隨機
	addq.l	#4,sp
	movea.l	#unk_12F0CC,a1	; 兵種概率表
	move.b	(a1,d0.l),d0
	movea.l	#seg_12EF80,a1	; 兵種表
	lsl.l	#3,d0
	adda.l	d0,a1			; 敵兵信息
	moveq	#0,d0
	move.b	4(a1),d0		; 動作類目
	move.w	d0,-$18(a6)
	move.b	5(a1),d0		; 動作編號
	move.w	d0,-$1A(a6)
	move.l	(a1),-4(a6)		; 敵兵指針
	move.b	$6(a1),d0		; 第二動作的類目
	move.w	d0,-$1C(a6)
	move.b	$7(a1),d0		; 第二動作的編號
	move.w	d0,-$1E(a6)
; 色盤坐標
loc_12F0E6:
	cmpi.w	#-1,8(a3)		; 是否兵陣色盤
	beq.s	loc_12F100
; 隨機色盤
	pea		(3).w			; [00-02]色盤編號
	jsr		$102480			; 大隨機
	addq.l	#4,sp
	move.w	d0,-$20(a6)		; 隨機色盤
loc_12F100:
	move.l	$C(a3),-$24(a6)	; 坐標等信息
	rts

off_12F0E0:	; 按敵將總位目分配隨機範圍
	dc.b	0,	$02,$04,$06,$0C,$12,$18,$1E,$24,$2A,$30,$36	; #11
	dc.b	$3C,$42,$48,$4E,$54,$5A,$60,$62,$62,$62,$62,$62	; #21

unk_12F0CC:	; 敵兵樣本容量#98
	dc.b	$0B,$0C	; #2
	dc.b	$06,$0A,$0B,$0C,$0E,$0C	; #6
	dc.b	$06,$08,$09,$0A,$0B,$0C,$0E,$15,$17,$0B	; #10
	dc.b	$03,$06,$07,$08,$09,$0A,$0B,$0C,$0E,$0F,$10,$15,$17,$19	; #14
	dc.b	$01,$02,$03,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$15,$16,$17,$19	; #18
	dc.b	$00,$01,$02,$03,$04,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$14,$15,$16,$17,$18,$19	; #22
	dc.b	$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19	; #26

seg_12EF80:	; [敵兵指針][出場動作][#26]
	dc.l	$00370D1A,$010A010A	; [00]男弓蠻兵$23
	dc.l	$003732FA,$01030103	; [01]男叉蠻兵$24
	dc.l	$00374DC2,$010B010B	; [02]女蠻兵$25
	dc.l	$00377194,$01050105	; [03]男矛越兵$26
	dc.l	$00378D98,$01060106	; [04]女越兵$27
	dc.l	$0037B04C,$01060106	; [05]鐵甲騎兵$28
	dc.l	$0037D090,$01080108	; [06]鐵甲步兵$29
	dc.l	$0037FF10,$01020102	; [07]輕騎兵$2A
	dc.l	$00381B98,$01040104	; [08]馴獸師$2B
	dc.l	$003837DE,$01070107	; [09]工兵$2C
	dc.l	$00385AF0,$01020102	; [0A]機械兵$2D
	dc.l	$003878C8,$010F010F	; [0B]長兵$2E
	dc.l	$0038AE68,$01030103	; [0C]短兵$2F
	dc.l	$0038D30E,$01070107	; [0D]弓兵$30
	dc.l	$00391D48,$010C010C	; [0E]炸彈兵$31
	dc.l	$00394464,$01020102	; [0F]山賊兵$32
	dc.l	$0039631C,$010B010B	; [10]水兵$33
	dc.l	$00398D3C,$01030103	; [11]木人$34
	dc.l	$0039AC7C,$01090109	; [12]桶怪$35
	dc.l	$0039C686,$01050105	; [13]蠻牛$36
	dc.l	$0039E19E,$01050105	; [14]熊$37
	dc.l	$0039FB66,$01040104	; [15]虎$38
	dc.l	$003A17B2,$01060106	; [16]黑豹$39
	dc.l	$003A36C6,$01020102	; [17]鷹$3A
	dc.l	$003A4E0E,$01050105	; [18]蠍$3B
	dc.l	$003A639E,$01040104	; [19]蛇$3C


sub_12F5E4:
	movem.l	d2/d3,-(sp)
	cmpi.b	#7,2(a3)
	bcs.s	loc_12F74E		; 原版刷兵
; 敵將之兵上限[d0]
	jsr		$15E72C
	move.l	d0,d1			; 2-2
	subi.l	#2,d1			; 3-4
	add.l	d1,d0			; 4-6
; 當前敵兵上限[d2]
	move.b	(ram_000C).l,d1	; 敵將位目
	andi.l	#$FF,d1
	lsr.l	#1,d1			; 每遞進兩個敵將
	moveq	#0,d2
loc_12F5E4:
	addq.l	#1,d2			; 增加一個敵兵上限
	cmp.l	d0,d2
	bcc.s	loc_12F5E5		; 兵目超過上限跳出
	dbf		d1,loc_12F5E4
; 場上敵人數目[d3]
loc_12F5E5:
	jsr		sub_109CC2		; 在場敵人數目[d1]
	move.l	d1,d3
	jsr		sub_15E72C		; 是否多玩家
	cmpi.l	#1,d0
	bhi.s	loc_12F5E7
	jsr		sub_109CC3		; 在場敵將數目
	cmpi.l	#2,d0
	bcs.s	loc_12F5E6
	addq.l	#2,d3			; 單打雙王三兵
loc_12F5E6:
	cmpi.b	#8,($81A326).l
	bcc.s	loc_12F5E7
	addq.l	#2,d3			; 難度8以下減兩兵
loc_12F5E7:
	cmp.l	d2,d3
	bls.s	loc_12F74E		; 未超上限則繼續刷兵
	movea.l #$12F612,a0		; 回到上一敵兵索引[INDEX][偏移四字節]
	bra.s	locret_12F5E4
loc_12F74E:
	movea.l #$12F74E,a0		; 原版敵兵表則持續刷兵
locret_12F5E4:
	movem.l	(sp)+,d2/d3
	rts


sub_12F648:	; 刷兵間隔
	moveq	#0,d0
	move.b	3(a3),d0	; 原版刷兵間隔
; 原版之間隔[11]
	btst	#1,2(a3)
	bne.s	locret_12F648
; 場景之敵兵[00]
	btst	#0,2(a3)
	bne.s	loc_12F648
	move.l	d0,-(sp)
	jsr		$102480		; 大隨機
	addq.l	#4,sp
	bra.s	locret_12F648
; 敵將之敵兵[01]
loc_12F648:
	jsr		sub_109CC3	; 場上敵將剩餘血目[d1]
	move.l	d1,d0
	mulu.w	#30,d0		; 每一血增加半秒
	move.l	d0,-(sp)
	jsr		$1024B0		; 小隨機
	addq.l	#4,sp
	addi.l	#180,d0		; 基礎三秒
locret_12F648:
	move.w	d0,($817E02).l
	rts


sub_12F526:
	tst.b	(ram_0005).l	; 107設定隊長原生命值
	bne.s	locret_12F526
	move.w	$6C(a2),d0
	lsl.w	#1,d0			; 隊長生命值翻2倍
	add.w	d0,$6C(a2)
locret_12F526:
	rts


sub_114746:
	tst.b	(ram_0005).l	; 107版本否
	beq.s	loc_114746
	movea.l	#byte_1C19AA,a0
	bra.s	locret_114746
loc_114746:
	movea.l	#byte_1C10D0,a0
locret_114746:
	rts

byte_1C10D0:	; 100版本小兵傷害追加
	dc.b	0, 0, 2, 3, 4, 4, 5, 6, 0
byte_1C19AA:	; 107版本小兵傷害追加
	dc.b	0, 0, 0, 1, 2, 2, 3, 4, 0


sub_1705E2:
	link	a6,#0
	movem.l	a2-a3,-(sp)
	movea.l	8(a6),a2			; 敵兵OBJ
	tst.l	$20(a2)				; 是否隨機兵[無坐標信息]
	bne.w	locret_1705E2
; 設定面向
	move.l	a2,-(sp)
	jsr		$110FE8
	addq.l	#4,sp
	movea.l	$114(a2),a3
	move.l	a3,d0
	beq.s	loc_17064C
	cmpi.w	#8,$50(a3)
	beq.s	loc_17064C
	tst.w	$174(a3)
	bne.s	loc_17064C
	move.w	$C8(a3),d0
	eori.w	#1,d0
	move.w	d0,	$C8(a2)			; 面向我方
; 設豎坐標
loc_17064C:
	moveq	#0,d0
	moveq	#0,d1
	move.b	$F(a6),d0
	sub.l	d0,d1
	move.w	d1,$24(a2)			; 豎坐標
; 橫縱坐標
	move.w	$D0A000.l,$20(a2)	; 記錄屏幕橫坐標
	move.w	$D0A002.l,$22(a2)	; 記錄屏幕縱坐標
; 特殊地形限定坐標
	moveq	#$0,d0
	move.w	(ram_0013).l,d0		; 場景序號
	lsl.l	#$2,d0
	move.l	#seg_81AAD6,a3		; 特殊地形限定屏幕坐標表
	adda.l	d0,a3
	tst.w	(a3)
	bmi.s	loc_1705E2
	move.w	(a3),$20(a2)		; 使用規定屏幕橫坐標
loc_1705E2:
	tst.w	2(a3)
	bmi.s	loc_1705E3
	move.w	2(a3),$22(a2)		; 使用規定屏幕縱坐標
; 計算隨機橫坐標
loc_1705E3:
	pea		$F.w				; 16個橫坐標
	jsr		$102480.l
	addq.l	#4,sp
	lsl.l	#3,d0				; 每個橫坐標相距$8
	add.w	d0,$20(a2)
	addi.w	#$A0,$20(a2)		; 根據屏幕橫坐標計算出場橫坐標
; 計算隨機縱坐標
	pea		$7.w				; 8個縱坐標
	jsr		$102480.l
	addq.l	#4,sp
	lsl.l	#3,d0				; 每個橫坐標相距$8
	add.w	d0,$22(a2)
	addi.w	#$A0,$22(a2)		; 根據屏幕橫坐標計算出場橫坐標
locret_1705E2:
	movem.l	-8(a6),a2-a3
	unlk	a6
	rts

sub_1674C4:	; 根據敵將生命值調整動作
	move.l	a2,-(sp)
	movea.l	8(sp),a2	; 敵兵OBJ
	jsr		sub_109CC3	; 在場敵將剩餘血目[d1]
	move.l	d1,-(sp)
	jsr		$102480		; 大隨機
	addq.l	#4,sp
	tst.l	d0
	beq.s	locret_1674C4
	move.b	$F(sp),d0	; 偏移量[F00700XX]
	ext.w	d0
	add.w	d0,$44(a2)
locret_1674C4:
	movea.l	(sp)+,a2
	rts


off_38B5EE:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0030000,$003B0006
	dc.l	$F0140008,$00000000		; 落地灰塵
	dc.l	$F0020300,$00320000
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_388858:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F02B0300
	dc.l	$F0030000,$001C0006	; [1C]落地圖片[0][0]X[0]Y[0]Z
	dc.l	$F0140008,$00000000	; 落地灰塵
	dc.l	$F01C0000
	dc.l	$F0020300,$001B0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_38E61C:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F02B0300
	dc.l	$F0020300,$00170001,$00170002
	dc.l	$F0020300,$00170002
	dc.l	$F0020300,$00160003
	dc.l	$F0020300,$00160004
	dc.l	$F0020300,$00150005
	dc.l	$F0030000,$00150006,$00150000
	dc.l	$F0020700,$00130000
	dc.l	$F0140008,$00000000	; 落地灰塵
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040301	; 下一招調用0301
	dc.l	$80000000


off_37E002:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100,$00210001,$00210001,$00210001,$001F0002,$001F0002,$001F0002,$001F0002,$001F0003,$001F0003,$001F0003,$001F0004,$001F0004,$001F0004,$001F0005,$001F0005,$001F0005,$001F0006,$001F0006
	dc.l	$F0030000,$001F0006,$001F0000,$001E0000
	dc.l	$F0020A00,$001E0000
	dc.l	$F0140009,$00000000	; 落地灰塵[大]
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040301	; 下一招調用0301
	dc.l	$80000000


off_39666A:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0030000,$001A0006
	dc.l	$F0140008,$00000000	; 落地灰塵
	dc.l	$F0020300,$00190000
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


sub_170642:	; 吊繩山賊兵出場高度
	move.w	#$FF10,$24(a2)
	move.b	$F(a6),d0
	ext.w	d0
	rts


off_381E06:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100,$00190001,$00180001,$00180002,$00180003,$00180004,$00180005,$00180006
	dc.l	$F0030000,$00180006,$00170000,$00170000
	dc.l	$F0020A00,$00160000
	dc.l	$F0140008,$00000000	; 落地灰塵
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_392926:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F02B0300
	dc.l	$F0020200,$0047000A,$0047000A,$0047000A,$0047000B
	dc.l	$F0030000,$0047000C
	dc.l	$F0140009,$00000000	; 落地灰塵[大]
	dc.l	$F0020200,$00440000
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_385CFA:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0020300,$00580000
	dc.l	$F0020300,$00580001
	dc.l	$F0020300,$00590002
	dc.l	$F0020300,$00590003
	dc.l	$F0030000,$00250005
	dc.l	$F0140009,$00000000	; 落地灰塵[大]
	dc.l	$F0020500,$00260000
	dc.l	$F0020F00,$00270000
	dc.l	$F0030A00,$00280000
	dc.l	$F0020A00,$00290000
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_398F02:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0540400
	dc.l	$F04F0B00
	dc.l	$F0450500
	dc.l	$F0030000,$2029000A
	dc.l	$F0140009,$00000000	; 落地灰塵[大]
	dc.l	$F0020600,$002A0000
	dc.l	$F0021600,$002B0000
	dc.l	$F0020800,$002C0000
	dc.l	$F0020C00,$002D0000
	dc.l	$F0021000,$002E0000
	dc.l	$F01C0000
	dc.l	$80000000


off_39AEE2:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0410100
	dc.l	$F0030000,$20120107
	dc.l	$F01C0000
	dc.l	$F0280200
	dc.l	$F0410100
	dc.l	$F0020300,$200F03FE
	dc.l	$F0020300,$201003FF
	dc.l	$F0020300,$20110301
	dc.l	$F0030000,$20120302
	dc.l	$F0290000
	dc.l	$F0020A00,$00190000
	dc.l	$80000000


off_3774DE:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0030000,$001B0006
	dc.l	$F0140008,$00000000	; 落地灰塵
	dc.l	$F0020300,$001A0000
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_37379C:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0021400,$003D000A
	dc.l	$F0030000,$00420004
	dc.l	$F0140009,$00000000	; 落地灰塵[大]
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_375218:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0280800	; 重複8次
	dc.l	$F02B0300,$20420000
	dc.l	$20430002,$20430002,$20430002,$20430002
	dc.l	$20440002,$20440002,$20440002,$20440002
	dc.l	$20450002,$20450002,$20450002,$20450002
	dc.l	$F0290000	; 每次降落高度$1A
	dc.l	$20420002,$20420002,$20420002,$20420002
	dc.l	$20430002,$20430002,$20430002,$20430002
	dc.l	$F00E0200,$F02B0100
	dc.l	$F0030000,$00450108,$00300300,$00300000
	dc.l	$F01C0000
	dc.l	$80000000


off_379502:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0540300
	dc.l	$F04F0800
	dc.l	$F0450800
	dc.l	$F0020600,$00090000
	dc.l	$F0020300,$00330000
	dc.l	$F0020300,$00340000
	dc.l	$F0280600	; 重複6次
	dc.l	$00340002,$00340002,$00340002,$00350002
	dc.l	$00350002,$00350002,$00350002,$00360002
	dc.l	$00360002,$00360002,$00360002,$00370002
	dc.l	$00370002,$00370002,$00370002
	dc.l	$F0290000	; 每次降落高度$1E
	dc.l	$F0020900,$00380001
	dc.l	$F00BDF00,$02570000
	dc.l	$F0330100
	dc.l	$F03400FF,$003A0000,$00040004,$20390004
	dc.l	$F03400FF,$003C0000,$00040004,$203B0004
	dc.l	$F03400FF,$003C0000,$00040004,$203B0004
	dc.l	$F03400FF,$003C0000,$00040004,$203B0004
	dc.l	$F03400FF,$003D0000,$00040004,$203B0004
	dc.l	$F03400FF,$003D0000,$00040004,$203B0004
	dc.l	$F0330000
	dc.l	$F0020500,$003B0004
	dc.l	$F0030000,$000B0004
	dc.l	$F0140009,$00000000	; 落地灰塵[大]
	dc.l	$F0020300,$00090500
	dc.l	$F01C0000
	dc.l	$80000000


off_3A6850:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0030000,$001D0006	; 圖片$1D|落地速度
	dc.l	$F0140008,$00000000	; 落地灰塵
	dc.l	$F0020300,$000E0000
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_3A521C:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0030000,$001D0006	; 圖片$1D|落地速度
	dc.l	$F0140008,$00000000	; 落地灰塵
	dc.l	$F0020300,$00150000
	dc.l	$F01C0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040600	; 下一招調用0600[蠍子咬臉]
	dc.l	$80000000


off_3A3874:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F01C0100	; 無視地形
	dc.l	$F0280300	; 重複3次降落$69
	dc.l	$F0020500,$00010001
	dc.l	$F0020500,$00020001
	dc.l	$F0020500,$00030001
	dc.l	$F0020500,$00040001
	dc.l	$F0020500,$00050001
	dc.l	$F0020500,$00060001
	dc.l	$F0020500,$00070001
	dc.l	$F0290000	; 每次降落高度$23
	dc.l	$F0020400,$00010001
	dc.l	$F0020400,$00020001
	dc.l	$F0020400,$00030001
	dc.l	$F0020400,$00040001
	dc.l	$F0020400,$00050001
	dc.l	$F0020400,$00060001
	dc.l	$F0020400,$00070001
	dc.l	$F0020000,$00070001	; 再降落到高度FFA6
	dc.l	$F01C0000
	dc.l	$F0070000,sub_3A3874	; 記錄出場高度
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000

sub_3A3874:	; 記錄出場高度
	movea.l	4(sp),a0
	move.w	$24(a0),$286(a0)
	rts


off_3A1BD0:
	dc.l	$F00700E0,sub_1705E2	; 隨機坐標[高度FF20]
	dc.l	$F0030000,$00080005
	dc.l	$F0020400,$00090000
	dc.l	$F0020300,$000A0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_3843D0:
	dc.l	$F0070000,sub_1705E2	; 隨機坐標[高度0000]
	dc.l	$00130000,$40130000,$00140000,$40140000	; 隱身|40XX
	dc.l	$F0140302,$0000E000	; 地板閃電
	dc.l	$F00BDF00,$02680000
	dc.l	$F0280300
	dc.l	$F0020300,$00130000
	dc.l	$F0020300,$00140000
	dc.l	$F0020300,$00150000
	dc.l	$F0020300,$00140000
	dc.l	$F0290000
	dc.l	$F00E0400	; 速度減慢
	dc.l	$F0020100,$00140000
	dc.l	$F0130100,$F0070000,$0016BB20,$00140000,$F0530000,$F0130000	; 雷電色盤
	dc.l	$F0020100,$00140000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_380412:
	dc.l	$F0070000,sub_1705E2	; 隨機坐標[高度0000]
	dc.l	$000F0000,$400F0000,$00120000,$40120000	; 隱身|40XX
	dc.l	$F0140302,$0000E000	; 地板閃電
	dc.l	$F0330100
	dc.l	$F0280300
	dc.l	$F03400FF,$00140000,$00000000,$20100000
	dc.l	$F03400FF,$00150000,$00000000,$20110000
	dc.l	$F03400FF,$00160000,$00000000,$20100000
	dc.l	$F03400FF,$00170000,$00000000,$20110000
	dc.l	$F03400FF,$00180000,$00000000,$20100000
	dc.l	$F03400FF,$00190000,$00000000,$20110000
	dc.l	$F0290000
	dc.l	$F0330000,$00120000
	dc.l	$F00E0400	; 速度減慢
	dc.l	$F0020200,$00130000
	dc.l	$F0130100,$F0070000,$0016BB20,$00130000,$F0530000,$F0130000	; 雷電色盤
	dc.l	$F0020300,$00130000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040301	; 下一招調用0301
	dc.l	$80000000


off_37BD98:
	dc.l	$F0070000,sub_1705E2	; 隨機坐標[高度0000]
	dc.l	$00110000,$40110000,$0010000,$40100000	; 隱身|40XX
	dc.l	$F0140302,$0000E000	; 地板閃電
	dc.l	$F0020300,$00110000
	dc.l	$F0020300,$00100000
	dc.l	$F0020300,$000F0000
	dc.l	$F0020300,$00100000
	dc.l	$F0020300,$00110000
	dc.l	$F0020300,$00100000
	dc.l	$F0020A00,$000F0000
	dc.l	$F00E0400	; 速度減慢
	dc.l	$F0020100,$00100000
	dc.l	$F0130100,$F0070000,$0016BB20,$00110000,$F0530000,$F0130000	; 雷電色盤
	dc.l	$F0020100,$00110000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_3722EE:
	dc.l	$F0070000,sub_1705E2	; 隨機坐標[高度0000]
	dc.l	$000B0000,$400B0000,$000B0000,$400B0000,$000B0000	; 隱身|40XX
	dc.l	$F0140302,$0000E000	; 地板閃電
	dc.l	$F00BDF00,$024F0000
	dc.l	$F0020300,$000C0000
	dc.l	$F0020300,$000C0000
	dc.l	$F0020200,$000C0000
	dc.l	$F0020100,$000D0000
	dc.l	$F0020300,$000B0000
	dc.l	$F0020200,$000B0000
	dc.l	$F00E0400	; 速度減慢
	dc.l	$F0020C00,$000C0000
	dc.l	$F0130100,$F0070000,$0016BB20,$000D0000,$F0530000,$F0130000	; 雷電色盤
	dc.l	$F0020100,$000D0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040302	; 下一招調用0302
	dc.l	$80000000


off_3A0716:
	dc.l	$F0070000,sub_1705E2	; 隨機坐標[高度0000]
	dc.l	$00100000,$40100000	; 隱身|40XX
	dc.l	$F0140302,$0000E000	; 地板閃電
	dc.l	$F00E0500	; 速度減慢
	dc.l	$00110000,$40110000
	dc.l	$F0130100,$F0070000,$0016BB20,$00120000,$F0530000,$F0130000	; 雷電色盤
	dc.l	$F0020500,$00120000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_39EBCA:
	dc.l	$F0070000,sub_1705E2	; 隨機坐標[高度0000]
	dc.l	$001A0000,$401A0000,$001B0000,$401B0000	; 隱身|40XX
	dc.l	$F0140302,$0000E000	; 地板閃電
	dc.l	$F0020200,$001A0000
	dc.l	$F0020200,$001B0000
	dc.l	$F0020200,$001C0000
	dc.l	$F0020200,$001D0000
	dc.l	$F0020200,$001E0000
	dc.l	$F0020200,$001F0000
	dc.l	$F00E0500	; 速度減慢
	dc.l	$F0020200,$001E0000
	dc.l	$F0130100,$F0070000,$0016BB20,$001A0000,$F0530000,$F0130000	; 雷電色盤
	dc.l	$F0020200,$001A0000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_39D1F2:
	dc.l	$F0070000,sub_1705E2	; 隨機坐標[高度0000]
	dc.l	$00100000,$40100000,$00110000,$40110000	; 隱身|40XX
	dc.l	$F0140302,$0000E000	; 地板閃電
	dc.l	$F0280300
	dc.l	$F0020200,$00100000
	dc.l	$F0020200,$00110000
	dc.l	$F0140000,$00000500
	dc.l	$F0020200,$00120000
	dc.l	$F0020200,$000F0000
	dc.l	$F0290000
	dc.l	$F00E0500	; 速度減慢
	dc.l	$F0020200,$00100000
	dc.l	$F0130100,$F0070000,$0016BB20,$00110000,$F0530000,$F0130000	; 雷電色盤
	dc.l	$F0020200,$00110000
	dc.l	$F0070001,sub_1674C4	; 場上敵將生命值低於一血則出場必攻擊
	dc.l	$F0040300	; 下一招調用0300
	dc.l	$80000000


off_3A7094:	; 毒蛇08類動作表
	dc.w	$0800
	dc.l	$0036F500,$01001001,0,0
	dc.w	$0801
	dc.l	$0036F52C,$01001001,0,0
	dc.w	$0802	; 毒蛇死亡向後動作
	dc.l	off_36FF8C,$02000001,0,0
	dc.w	$0803
	dc.l	off_36FF8C,$02000001,0,0
	dc.w	$0804
	dc.l	off_36FF8C,$02000001,0,0
	dc.w	$0805
	dc.l	$003A7060,$01003000,0,0
	dc.w	$0806
	dc.l	off_36FF8C,$02000001,0,0
	dc.w	$0807
	dc.l	off_36FF8C,$02000001,0,0
	dc.w	$0808
	dc.l	off_36FF8C,$02000001,0,0
	dc.w	$0809
	dc.l	off_36FF8C,$02000001,0,0
	dc.w	$080A
	dc.l	$0036FA60,$01001001,0,0
	dc.w	$080B
	dc.l	$0036FA8C,$01001001,0,0
	dc.w	$080C	; 毒蛇死亡向前動作
	dc.l	off_36FFFC,$02000001,0,0
	dc.w	$080D
	dc.l	off_36FFFC,$02000001,0,0
	dc.w	$080E
	dc.l	off_36FFFC,$02000001,0,0
	dc.w	$080F
	dc.l	$003A7060,$01003000,0,0
	dc.w	$0810
	dc.l	off_36FFFC,$02000001,0,0
	dc.w	$0811
	dc.l	off_36FFFC,$02000001,0,0
	dc.w	$0812
	dc.l	off_36FFFC,$02000001,0,0
	dc.w	$0813
	dc.l	off_36FFFC,$02000001,0,0
	dc.w	$0814
	dc.l	$0036F720,$02000800,0,0
	dc.w	$0815
	dc.l	$0036F500,$01005000,0,0
	dc.w	$0816
	dc.l	$0036F500,$01005000,0,0
	dc.w	$0817
	dc.l	$00000000,$00000000,0,0
	dc.w	$0818
	dc.l	$0036F558,$01001001,0,0
	dc.w	$0819
	dc.l	$00000000,$00000000,0,0
	dc.w	$081A
	dc.l	$0036F78C,$01000001,0,0
	dc.w	$081B
	dc.l	$0036FC80,$01000001,0,0
	dc.w	$081C
	dc.l	$0036FAB8,$01001001,0,0
	dc.w	$081D
	dc.l	off_36FF8C,$02000001,0,0
	dc.w	$081E
	dc.l	off_36FFFC,$02000001,0,0

off_36FF8C:	; 毒蛇死亡向後浮空動作
	dc.l	$F03C01DF
	dc.l	$F0280300,$0018FD00,$00180300
	dc.l	$F0290000
	dc.l	$F00E0000
	dc.l	$001AFCFA,$001AFAFA,$001AFAFD,$001AFA00
	dc.l	$001BFA03,$001BFE02,$001CFC04,$001CFC06
	dc.l	$F0030000,$001DFE06
	dc.l	$F0040805
off_36FFFC:	; 毒蛇死亡向前浮空動作
	dc.l	$F03C01DF
	dc.l	$F0280300,$00230300,$0023FD00
	dc.l	$F0290000
	dc.l	$F00E0000
	dc.l	$002504FA,$002506FA,$002506FD,$00250600
	dc.l	$00260603,$00260202,$00270404,$00270406
	dc.l	$F0030000,$00280206
	dc.l	$F0040805


sub_1134AE:
; 豹子投技判定完成後設定
	movea.l	$58(a3),a0
	cmpi.b	#$39,1(a0)	; 是否豹子
	bne.s	loc_1134AE
	move.w	#1,$174(a3)	; 豹子無敵
; 原代碼
loc_1134AE:
	move.l	a2,-(sp)
	move.l	a3,-(sp)
	jsr		$10AEF4
	addq.l	#8,sp
	rts


off_34677C:	; [金甲鐵騎]色盤0003
	dc.w	$0002,$7FFF,$2482,$3D01,$5961,$7A60,$7F60,$1C05
	dc.w	$3403,$5045,$70E7,$03E0,$2460,$3CE2,$5566,$6E2A
	dc.w	$7F10,$54E0,$6DA0,$7EE4,$0065,$04CA,$052E,$05B3
	dc.w	$2460,$38C1,$5145,$6E09,$7F10,$03E0,$03E0,$0000

off_348BD0:	; [長兵]色盤0003
	dc.w	$8040,$FFFF,$A004,$B94C,$D2D7,$EBFC,$83E0,$9006
	dc.w	$9C6E,$8D56,$823F,$83E0,$8009,$994F,$B29B,$CBBF
	dc.w	$83E0,$C400,$EC00,$FE20,$FF80,$AC40,$D124,$E9E6
	dc.w	$FECD,$83E0,$83E0,$83E0,$83E0,$83E0,$83E0,$0000

off_349484:	; [短兵]色盤0003
	dc.w	$8040,$FFFF,$AC82,$C8C1,$E900,$FD60,$83E0,$88AC
	dc.w	$A191,$BE97,$DB9D,$EBDF,$8821,$A8C5,$CD69,$F22D
	dc.w	$FF76,$8404,$B10C,$DA34,$FF78,$B8A2,$DDA7,$F68C
	dc.w	$FF32,$83E0,$83E0,$83E0,$83E0,$83E0,$83E0,$0000

off_349C08:	; [弓兵]色盤0003
	dc.w	$8040,$FFFF,$B460,$D940,$FE85,$FF48,$FFFB,$8080
	dc.w	$8144,$83E0,$A9EC,$CECC,$A400,$B800,$DCE1,$FDC3
	dc.w	$FF00,$AC00,$C8A3,$E5A6,$FF11,$9C61,$B4E3,$D5C6
	dc.w	$EEF0,$83E0,$83E0,$83E0,$83E0,$83E0,$83E0,$0000

off_34B474:	; [水兵]色盤0003
	dc.w	$8040,$FFFF,$A862,$BCC3,$DD87,$F66A,$FF52,$90E0
	dc.w	$B182,$CE41,$EB00,$FFE0,$A547,$CE6F,$FFDB,$F7DE
	dc.w	$83E0,$8CE0,$C5A1,$FE82,$83E0,$83E0,$83E0,$83E0
	dc.w	$83E0,$83E0,$83E0,$83E0,$83E0,$83E0,$83E0,$0000

off_347E08:	; [工兵]色盤0003
	dc.w	$8040,$FFDF,$B0A2,$C506,$E1A8,$FAAD,$FF94,$9480
	dc.w	$A903,$C185,$83E0,$83E0,$9842,$A986,$BEEB,$E7EF
	dc.w	$83E0,$8C86,$94CA,$A96F,$CA98,$A10A,$BDD0,$E2D7
	dc.w	$F79C,$83E0,$83E0,$83E0,$83E0,$83E0,$83E0,$0000

off_34C13C:	; [桶怪]色盤0003
	dc.w	$0000,$7FFF,$0C00,$2060,$30C1,$4565,$664B,$24E4
	dc.w	$3D88,$5E8E,$7FB5,$03E0,$1466,$20C9,$250C,$2D6F
	dc.w	$3A12,$3CC3,$5505,$7167,$24C4,$3105,$4588,$5A0B
	dc.w	$03E0,$0424,$0CCC,$0D90,$1A74,$53DC,$03E0,$0000

* off_30FBF4:	; [火豹]色盤0004
* 	dc.w	$0002,$7FFF,$04A5,$D000,$ECC0,$FE23,$FEC1,$FFA8
* 	dc.w	$03E0,$03E0,$5B56,$77FD,$03E0,$03E0,$03E0,$03E0
* 	dc.w	$31CC,$1907,$3A72,$4AF5,$5B99,$2549,$31CC,$3A72
* 	dc.w	$4AF5,$03E0,$03E0,$03E0,$03E0,$03E0,$03E0,$0000

off_34DF70:	; [老鷹]色盤0003
	dc.w	$0002,$7FFF,$256C,$31D0,$4ED5,$6358,$7BFE,$03E0
	dc.w	$03E0,$03E0,$03E0,$03E0,$1860,$3102,$49A6,$7B54
	dc.w	$7BDE,$03E0,$03E0,$03E0,$03E0,$03E0,$03E0,$03E0
	dc.w	$03E0,$03E0,$03E0,$03E0,$03E0,$03E0,$03E0,$0000


off_2A01BE:	; 山寨場景末[女越兵/木人/通怪]三陣型
	dc.l	$FF0F0101,$FF100204,$025800B4
	dc.l	$FF060106,$00378D98,$FFFF0106,unk_2A01BE
	dc.l	$FF050106,$00378D98,$FFFF0106,unk_2A01BF
	dc.l	$FF050106,$00378D98,$FFFF0106,unk_2A01BF
	dc.l	$FF050106,$00378D98,$FFFF0106,unk_2A01BF
	dc.l	$FF050106,$00378D98,$FFFF0106,unk_2A01BF
	dc.l	$FF050106,$00378D98,$FFFF0106,unk_2A01BF,$FF0A0600,$FF070000,$001841E0
	dc.l	$FF050106,$00378D98,$FFFF0106,unk_2A01BF,$FF011B00,$FF090000,$FF0A0000,$FF0F0101,$FF100204,$025800B4
	dc.l	$FF060103,$00398D3C,$FFFF0103,unk_2A01C0
	dc.l	$FF050103,$00398D3C,$FFFF0103,unk_2A01C1
	dc.l	$FF050103,$00398D3C,$FFFF0103,unk_2A01C1
	dc.l	$FF050103,$00398D3C,$FFFF0103,unk_2A01C1
	dc.l	$FF050103,$00398D3C,$FFFF0103,unk_2A01C1
	dc.l	$FF050103,$00398D3C,$FFFF0103,unk_2A01C1,$FF0A0600,$FF070000,$001841E0
	dc.l	$FF050103,$00398D3C,$FFFF0103,unk_2A01C1,$FF014000,$FF090000,$FF0A0000,$FF0F0101,$FF100204,$025800B4
	dc.l	$FF060109,$0039AC7C,$FFFF0109,unk_2A01C2
	dc.l	$FF050109,$0039AC7C,$FFFF0109,unk_2A01C3
	dc.l	$FF050109,$0039AC7C,$FFFF0109,unk_2A01C3
	dc.l	$FF050109,$0039AC7C,$FFFF0109,unk_2A01C3
	dc.l	$FF050109,$0039AC7C,$FFFF0109,unk_2A01C3
	dc.l	$FF050109,$0039AC7C,$FFFF0109,unk_2A01C3,$FF0A0600,$FF070000,$001841E0
	dc.l	$FF050109,$0039AC7C,$FFFF0109,unk_2A01C3,$FF016500,$FF090000,$FF0A0000,$FF130000
unk_2A01BE:
	dc.l	$00000000,$00000000,$00000012
unk_2A01BF:
	dc.l	$00000000,$00000000,$00100000
unk_2A01C0:
	dc.l	$00000000,$00000000,$00000049	; 蠻王藤甲
unk_2A01C1:
	dc.l	$00000000,$00000000,$00100000
unk_2A01C2:
	dc.l	$00000000,$00000000,$00000005
unk_2A01C3:
	dc.l	$00000000,$00000000,$00100000


sub_1B1654:
	moveq	#0,d0
	move.b	($817DF9).l,d0	; 當前敵兵數目
	move.l	d0,($81B5B0).l	; 記錄隊長藍牛OBJ序號
	rts

unk_1B1654:	; 隊長藍牛出場坐標
	dc.l	$012700C8,$00000004,$00100000

; --------------- 我方調整 --------------------------------------------------

sub_114D3C:
; 鎖子太平|靈識
	cmpi.w	#$555E,$22A(a2)
	beq.s	loc_114D3C
; 是否107版本
	tst.b	(ram_0005).l
	beq.s	loc_11516C
	cmpi.w	#2,$176(a2)		; 是否超過3次被擊
	bls.s	loc_11516C
	clr.w	$176(a2)
loc_114D3C:; 被擊保護
	move.l	a2,-(sp)
	jsr		$10973C			; 2秒無敵|$1E2(OBJ)
	addq.l	#4,sp
loc_11516C:
	moveq	#0,d0			; 原代碼
	move.b	($8182F9).l,d0
	rts


loc_26DEA4:	; 107版本向前跌倒起身保護
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	move.b	(ram_0005).l,d0	; 107版本無敵
	ext.w	d0
	move.w	d0,$174(a2)
	movea.l	(sp)+,a2
	rts

off_2525C8:	; [關羽]向前跌倒起身動作
	dc.l	$F0060E00	; 死亡則跳過起身動作
	dc.l	$F0070000,loc_26DEA4
	dc.l	$F0020800,$00820000
	dc.l	$F0130100
	dc.l	$F0020200,$00860000
	dc.l	$F0020200,$00870000
	dc.l	$F00B3F00,$02B90000
	dc.l	$F0020200,$00530000
	dc.l	$80000000
	dc.l	$F0280A00,$00820000,$40820000	; 死亡動作
	dc.l	$F0290000
	dc.l	$80000000

off_257A62:	; [張飛]向前跌倒起身動作
	dc.l	$F0060E00	; 死亡則跳過起身動作
	dc.l	$F0070000,loc_26DEA4
	dc.l	$F0020800,$007D0000
	dc.l	$F0130100
	dc.l	$F0020200,$00830000
	dc.l	$F0020200,$00840000
	dc.l	$F00B3F00,$02B90000
	dc.l	$F0020200,$00850000
	dc.l	$80000000
	dc.l	$F0280A00,$007D0000,$407D0000	; 死亡動作
	dc.l	$F0290000
	dc.l	$80000000

off_25CE92:	; [趙雲]向前跌倒起身動作
	dc.l	$F0060E00	; 死亡則跳過起身動作
	dc.l	$F0070000,loc_26DEA4
	dc.l	$F0020800,$00890000
	dc.l	$F0130100
	dc.l	$F0020200,$008F0000
	dc.l	$F0020200,$00900000
	dc.l	$F00B3F00,$02B90000
	dc.l	$F0020200,$00910000
	dc.l	$80000000
	dc.l	$F0280A00,$00890000,$40890000	; 死亡動作
	dc.l	$F0290000
	dc.l	$80000000

off_26268C:	; [黃忠]向前跌倒起身動作
	dc.l	$F0060E00	; 死亡則跳過起身動作
	dc.l	$F0070000,loc_26DEA4
	dc.l	$F0020800,$00780000
	dc.l	$F0130100
	dc.l	$F0020200,$007D0000
	dc.l	$F0020200,$007E0000
	dc.l	$F00B3F00,$02B90000
	dc.l	$F0020200,$007F0000
	dc.l	$80000000
	dc.l	$F0280A00,$00780000,$40780000	; 死亡動作
	dc.l	$F0290000
	dc.l	$80000000

off_2685D0:	; [馬超]向前跌倒起身動作
	dc.l	$F0060E00	; 死亡則跳過起身動作
	dc.l	$F0070000,loc_26DEA4
	dc.l	$F0020800,$007B0000
	dc.l	$F0130100
	dc.l	$F0020200,$00810000
	dc.l	$F0020200,$00820000
	dc.l	$F00B3F00,$02B90000
	dc.l	$F0020200,$00830000
	dc.l	$80000000
	dc.l	$F0280A00,$007B0000,$407B0000	; 死亡動作
	dc.l	$F0290000
	dc.l	$80000000

off_26DEA4:	; [孔明]向前跌倒起身動作
	dc.l	$00CC0000
	dc.l	$F0060B00	; 死亡則跳過起身動作
	dc.l	$F0070000,loc_26DEA4
	dc.l	$F0020800,$00CC0000
	dc.l	$F0130100,$00CD0000,$00CE0000
	dc.l	$F00B3F00,$02B90000,$00CFEA00
	dc.l	$80000000
	dc.l	$F0280F00,$00CC0000,$40CC0000	; 死亡動作
	dc.l	$F0290000
	dc.l	$80000000

off_27809C:	; [龐統]向前跌倒起身動作
	dc.l	$F0061000	; 死亡則跳過起身動作
	dc.l	$F0070000,loc_26DEA4
	dc.l	$F0020800,$008B0000
	dc.l	$F0130100
	dc.l	$F0020200,$00900000
	dc.l	$F0020200,$00910000
	dc.l	$F00B3F00,$02B90000
	dc.l	$F0020200,$00920000
	dc.l	$F0020200,$00930000
	dc.l	$80000000
	dc.l	$F0280A00,$008B0000,$408B0000	; 死亡動作
	dc.l	$F0290000
	dc.l	$80000000

off_27DBB8:	; [孫權]向前跌倒起身動作
	dc.l	$F0061000	; 死亡則跳過起身動作
	dc.l	$F0070000,loc_26DEA4
	dc.l	$F0020800,$006B0000
	dc.l	$F0130100
	dc.l	$F0020200,$00710000
	dc.l	$F0020200,$00720000
	dc.l	$F00B3F00,$02B90000
	dc.l	$F0020200,$00470000
	dc.l	$F0020200,$00460000
	dc.l	$80000000
	dc.l	$F0280A00,$006B0000,$406B0000	; 死亡動作
	dc.l	$F0290000
	dc.l	$80000000


sub_15EC88:	; 判斷角色是否在場以及同角色數目
	move.l	4(sp),d1		; 判斷的角色
	moveq	#0,d0
	move.l	#$D09000,a0
loc_15EC92:
	cmpi.w	#2,$C(a0)		; OBJ是否占用
	bne.s	loc_15ECA2
	movea.l	$54(a0),a1
	cmp.b	1(a1),d1		; 是否重複角色
	bne.s	loc_15ECA2
	addq.b	#1,d0
loc_15ECA2:
	cmpa.l	#$D09C00,a0
	beq.s	locret_15ECAC
	lea		$400(a0),a0
	bra.s	loc_15EC92
locret_15ECAC:
	rts


sub_123BAA:
	movem.l	D2-D3/A2, -(A7)
	movea.l #unk_123BAA, A2		; 複數武器對角色表
loc_123BAA:
	tst.w	(A2)+
	beq.s	locret_123BAA
	cmp.b	(A2), D2			; 對比掉落的道具
	bne.s	loc_123BAA
	moveq	#$0, D3
	move.b	$1(A2), D3			; 掉落武器對應的角色
	move.l	D3, -(A7)
	jsr		sub_15EC88			; 判斷同角色的數目
	addq.l	#4, A7
	move.b	D0, (ram_001F).l	; 記錄掉落的武器數目
locret_123BAA:
	movem.l	(A7)+, D2-D3/A2
	rts
	
unk_123BAA:
	dc.w	1,$1A01,$1E03,$1F03,$2204,$2304,$2404,$2505,$2605,$2806,$2B08,$2C08,$2E09,0


sub_123AA2:	; 判斷是否多把武器
	move.b	#1, $D(a2)
	tst.b	(ram_0021).l		; 是否不掉落多把武器
	beq.s	loc_123AA2
	subq.b	#1,(ram_0021).l		; 減少一次不掉落
	clr.b	(ram_001F).l		; 清零本次掉落數
	bra.s	locret_123AA2
loc_123AA2:
	tst.b	(ram_001F).l		; 掉落武器數目的記錄
	beq.s	locret_123AA2
	move.b	(ram_001F).l, $D(a2)
	clr.b	(ram_001F).l
locret_123AA2:
	rts


sub_15C82C:
	tst.b	$803B85				; 是否 2 PLAYERS 模式
	beq.s	loc_15C82C
	move.b	$8186C2,d0			; 1P的角色編號
	move.b	$818AC8,d1			; 2P的角色編號
	cmp.b	d0,d1				; 是否相同
	beq.s	loc_15C82C
	pea		(4).w				; [00-03]隨機色盤
	jsr		$102480.l			; 大隨機
	addq.l	#4,sp
	bra.s	locret_15C82C
loc_15C82C:
	moveq	#$0, d0
	movea.l	$F8(a2),a0			; 8186C0(1P例)
	move.b	$1(a0),d0			; 玩家位置(P目0-3)
locret_15C82C:
	mulu.w	#$10,d0
	move.w	$6E(a2),d1			; 所持武器
	movea.l	#unk_15C82C,a0
	move.b	(a0,d1.l),d1		; 判斷武器等級
	mulu.w	#$4,d1
	add.l	d1,d0				; 計算當前玩家色盤的相對位置
	rts
unk_15C82C:
	dc.b	$0,$0,$1,$2,$0,$1,$0,$1,$0,$1,$2,$3,$0
	dc.b	$1,$2,$3,$1,$2,$0,$1,$2,$0,$1,$2,$0,$1

word_32C982:	; 關羽1
	dc.w	$0C42,$7FFF,$3400,$4884,$5D66,$724B,$7F34,$1124	; 方天畫戟(青龍偃月刀)色盤
	dc.w	$1DC6,$2E88,$4B2A,$2C21,$4821,$60E3,$7DEA,$312A
	dc.w	$4A2F,$6335,$7FFB,$3886,$50E6,$7208,$7709,$1000
	dc.w	$3820,$5100,$00C4,$0169,$51F5,$7A92,$7FD8,$0000
word_24F270:	; 關羽2
	dc.w	$0C42,$7FFF,$3400,$4884,$5D66,$724B,$7F34,$4080
	dc.w	$6DE1,$7F08,$7FAE,$2C21,$4821,$60E3,$7DEA,$14EA
	dc.w	$2DD0,$4697,$679E,$1424,$312A,$4A2F,$6335,$0089
	dc.w	$052F,$15D4,$114C,$2A12,$4719,$6FFF,$7FD8,$0000
word_24F274:
	dc.w	$0C42,$7FFF,$3400,$4884,$5D66,$724B,$7F34,$4080
	dc.w	$6DE1,$7F08,$7FAE,$2C21,$4821,$60E3,$7DEA,$14EA
	dc.w	$2DD0,$4697,$679E,$1424,$312A,$4A2F,$6335,$1000
	dc.w	$3800,$5100,$00C4,$0149,$51F5,$7A92,$7FD8,$0000
word_24F278:
	dc.w	$0C42,$7FFF,$3400,$4884,$5D66,$724B,$7F34,$4080
	dc.w	$6DE1,$7F08,$7FAE,$2C21,$4821,$60E3,$7DEA,$14EA
	dc.w	$2DD0,$4697,$679E,$1424,$312A,$4A2F,$6335,$1000
	dc.w	$3820,$5100,$00C4,$0169,$51F5,$7A92,$7FD8,$0000

word_24F280:	; 關羽3
	dc.w	$0C42,$7FFF,$3400,$4884,$5D66,$724B,$7F34,$312A
	dc.w	$4A2F,$6335,$7FFB,$2C21,$4821,$60E3,$7DEA,$0C41
	dc.w	$152B,$1A14,$231E,$2840,$4524,$6249,$7F6E,$0089
	dc.w	$052F,$15D4,$114C,$2A12,$4719,$6FFF,$7FFA,$0000
word_24F284:
	dc.w	$0C42,$7FFF,$3400,$4884,$5D66,$724B,$7F34,$312A
	dc.w	$4A2F,$6335,$7FFB,$2C21,$4821,$60E3,$7DEA,$0C41
	dc.w	$152B,$1A14,$231E,$2840,$4524,$6249,$7F6E,$1000
	dc.w	$3800,$5100,$00C4,$0169,$51F5,$7A92,$7FD8,$0000
word_24F288:
	dc.w	$0C42,$7FFF,$3400,$4884,$5D66,$724B,$7F34,$312A
	dc.w	$4A2F,$6335,$7FFB,$2C21,$4821,$60E3,$7DEA,$0C41
	dc.w	$152B,$1A14,$231E,$2840,$4524,$6249,$7F6E,$1000
	dc.w	$3820,$5100,$00C4,$0169,$51F5,$7A92,$7FD8,$0000

word_24F290:	; 關羽4
	dc.w	$8C42,$FFFF,$B400,$C884,$DD66,$F24B,$FF34,$804E
	dc.w	$90F4,$AA1C,$BEFF,$AC21,$C821,$E0E3,$FDEA,$ACA8
	dc.w	$B98F,$C696,$D39D,$B107,$B9CE,$CAD4,$FFFE,$8089
	dc.w	$852F,$95D4,$914C,$AA12,$C719,$EFFF,$FFD8,$8000
word_24F294:
	dc.w	$8C42,$FFFF,$B400,$C884,$DD66,$F24B,$FF34,$804E
	dc.w	$90F4,$AA1C,$BEFF,$AC21,$C821,$E0E3,$FDEA,$ACA8
	dc.w	$B98F,$C696,$D39D,$B107,$B9CE,$CAD4,$FFFE,$1000
	dc.w	$3800,$5100,$00C4,$0149,$51F5,$7A92,$7FD8,$0000
word_24F298:
	dc.w	$8C42,$FFFF,$B400,$C884,$DD66,$F24B,$FF34,$804E
	dc.w	$90F4,$AA1C,$BEFF,$AC21,$C821,$E0E3,$FDEA,$ACA8
	dc.w	$B98F,$C696,$D39D,$B107,$B9CE,$CAD4,$FFFE,$1000
	dc.w	$3820,$5100,$00C4,$0169,$51F5,$7A92,$7FD8,$0000

word_32FAFA:	; 張飛1
	dc.w	$0461,$7FFF,$3060,$48E3,$65E8,$72AA,$7753,$1CE5	; 方天畫戟(丈八蛇矛)色盤
	dc.w	$31AA,$4E8E,$6F53,$03E0,$34A0,$5540,$7661,$7F6A
	dc.w	$1A30,$10A8,$1D2D,$29B4,$3A5A,$1064,$20CE,$1D71
	dc.w	$45D5,$30EB,$50ED,$7645,$4339,$052B,$08A9,$0000
word_25461A:	; 張飛2
	dc.w	$0461,$7FFF,$3060,$48E3,$65E8,$72AA,$7753,$1883
	dc.w	$252A,$31D1,$3E78,$03E0,$34A0,$5540,$7661,$7F6A
	dc.w	$03E0,$0C67,$1167,$1E6A,$2B8C,$3800,$5442,$7462
	dc.w	$7980,$258B,$3E51,$5738,$6FDF,$03E0,$03E0,$0000
word_25461E:
	dc.w	$0461,$7FFF,$3060,$48E3,$65E8,$72AA,$7753,$1883
	dc.w	$252A,$31D1,$3E78,$03E0,$34A0,$5540,$7661,$7F6A
	dc.w	$03E0,$0C67,$1167,$1E6A,$2B8C,$1064,$20CE,$1171
	dc.w	$45D5,$30EB,$50ED,$7645,$7F60,$03E0,$03E0,$0000
word_254622:
	dc.w	$0461,$7FFF,$3060,$48E3,$65E8,$72AA,$7753,$1883
	dc.w	$252A,$31D1,$3E78,$36F2,$34A0,$5540,$7661,$7F6A
	dc.w	$1A30,$0C67,$1167,$1E6A,$2B8C,$1064,$20CE,$1D71
	dc.w	$45D5,$30EB,$50ED,$7645,$4339,$052B,$08A9,$0000

word_25462A:	; 張飛3
	dc.w	$0461,$7FFF,$2882,$38A2,$4945,$6609,$7EEF,$2400
	dc.w	$48E4,$698A,$7A8F,$03E0,$1002,$34C7,$59CE,$7ED4
	dc.w	$03E0,$50E0,$6600,$7F20,$7FE0,$3800,$5442,$7462
	dc.w	$7980,$258B,$3E51,$5738,$6FDF,$03E0,$03E0,$0000
word_25462E:
	dc.w	$0461,$7FFF,$2882,$38A2,$4945,$6609,$7EEF,$2400
	dc.w	$48E4,$698A,$7A8F,$03E0,$1002,$34C7,$59CE,$7ED4
	dc.w	$03E0,$50E0,$6600,$7F20,$7FE0,$1064,$20CE,$1D71
	dc.w	$45D5,$30EB,$50ED,$7645,$7F60,$03E0,$03E0,$0000
word_254632:
	dc.w	$0461,$7FFF,$2882,$38A2,$4945,$6609,$7EEF,$2400
	dc.w	$48E4,$698A,$7A8F,$36F2,$1002,$34C7,$59CE,$7ED4
	dc.w	$1A30,$50E0,$6600,$7F20,$7FE0,$1064,$20CE,$1D71
	dc.w	$45D5,$30EB,$50ED,$7645,$4339,$052B,$08A9,$0000

word_25463A:	; 張飛4
	dc.w	$8461,$FFFF,$B060,$B4E3,$B0A1,$D5A6,$EE48,$9C65
	dc.w	$B12B,$C612,$DAD9,$83E0,$B4A0,$D540,$F661,$FF6A
	dc.w	$83E0,$94EB,$B9F0,$DEF5,$FFFB,$B800,$D442,$F462
	dc.w	$F980,$A58B,$BE51,$D738,$EFDF,$83E0,$83E0,$8000
word_25463E:
	dc.w	$8461,$FFFF,$B060,$B4E3,$B0A1,$D5A6,$EE48,$9C65
	dc.w	$B12B,$C612,$DAD9,$83E0,$B4A0,$D540,$F661,$FF6A
	dc.w	$83E0,$94EB,$B9F0,$DEF5,$FFFB,$1064,$20CE,$1D71
	dc.w	$45D5,$30EB,$50ED,$7645,$7F60,$03E0,$03E0,$0000
word_254642:
	dc.w	$8461,$FFFF,$B060,$B4E3,$B0A1,$D5A6,$EE48,$9C65
	dc.w	$B12B,$C612,$DAD9,$83E0,$B4A0,$D540,$F661,$FF6A
	dc.w	$1A30,$94EB,$B9F0,$DEF5,$FFFB,$1064,$20CE,$1D71
	dc.w	$45D5,$30EB,$50ED,$7645,$4339,$052B,$08A9,$0000

word_3328A2:	; 趙雲1
	dc.w	$0C42,$7FFF,$2000,$3481,$4D46,$6A4D,$7B33,$20A7	; 方天畫戟(紅纓梨花槍)色盤
	dc.w	$398B,$5ED4,$7FFB,$0C69,$10EE,$1DB3,$2A56,$2C20
	dc.w	$5000,$7C00,$36F2,$090F,$1212,$1F16,$4FB8,$2C43
	dc.w	$44A2,$5CC2,$1A10,$050B,$48AE,$7167,$7F4B,$0000
word_259AF2:	; 趙雲2
	dc.w	$0C42,$7FFF,$2000,$3481,$4D46,$6A4D,$7B33,$20A7
	dc.w	$398B,$5ED4,$7FFB,$10E0,$1D80,$3243,$4707,$1884
	dc.w	$24A5,$3D06,$36F2,$1CE4,$3E26,$6349,$7FF2,$2C43
	dc.w	$44A2,$5CC2,$1A10,$050B,$2150,$3257,$4339,$0000
word_259AF6:
	dc.w	$0C42,$7FFF,$2000,$3481,$4D46,$6A4D,$7B33,$20A7
	dc.w	$398B,$5ED4,$7FFB,$10E0,$1D80,$3243,$4707,$2C20
	dc.w	$5000,$7C00,$36F2,$1CE4,$3E26,$6349,$7FF2,$2C43
	dc.w	$44A2,$5CC2,$1A10,$050B,$48AE,$7167,$7F4B,$0000
word_259AFA:
	dc.w	$0C42,$7FFF,$2000,$3481,$4D46,$6A4D,$7B33,$20A7
	dc.w	$398B,$5ED4,$7FFB,$10E0,$1D80,$3243,$4707,$2C20
	dc.w	$5000,$7C00,$36F2,$1CE4,$3E26,$6349,$7FF2,$2C43
	dc.w	$44A2,$5CC2,$1A10,$050B,$48AE,$7167,$7F4B,$0000

word_259B02:	; 趙雲3
	dc.w	$0C42,$7FFF,$2000,$3481,$4D46,$6A4D,$7B33,$20A7
	dc.w	$398B,$5ED4,$7FFB,$2C00,$4460,$60E0,$7D60,$1884
	dc.w	$24A5,$3D06,$36F2,$5960,$6620,$7701,$7FA2,$2C43
	dc.w	$44A2,$5CC2,$1A10,$050B,$2150,$3257,$4339,$0000
word_259B06:
	dc.w	$0C42,$7FFF,$2000,$3481,$4D46,$6A4D,$7B33,$20A7
	dc.w	$398B,$5ED4,$7FFB,$2C00,$4460,$60E0,$7D60,$2C20
	dc.w	$5000,$7C00,$36F2,$5960,$6620,$7701,$7FA2,$2C43
	dc.w	$44A2,$5CC2,$1A10,$050B,$48AE,$7167,$7F4B,$0000
word_259B0A:
	dc.w	$0C42,$7FFF,$2000,$3481,$4D46,$6A4D,$7B33,$20A7
	dc.w	$398B,$5ED4,$7FFB,$2C00,$4460,$60E0,$7D60,$2C20
	dc.w	$5000,$7C00,$36F2,$5960,$6620,$7701,$7FA2,$2C43
	dc.w	$44A2,$5CC2,$1A10,$050B,$48AE,$7167,$7F4B,$0000

word_259B12:	; 趙雲4
	dc.w	$8C42,$FFFF,$A000,$B481,$CD46,$EA4D,$FB33,$B0A0
	dc.w	$D9C5,$FEE8,$FFF3,$8C69,$98AC,$A510,$B553,$9884
	dc.w	$A4A5,$BD06,$B6F2,$AD0C,$CDF1,$F6F5,$FFBC,$A0CA
	dc.w	$A134,$ADFD,$B6DF,$850B,$A150,$B257,$C339,$8000
word_259B16:
	dc.w	$8C42,$FFFF,$A000,$B481,$CD46,$EA4D,$FB33,$B0A0
	dc.w	$D9C5,$FEE8,$FFF3,$8C69,$98AC,$A510,$B553,$2C20
	dc.w	$5000,$7C00,$B6F2,$AD0C,$CDF1,$F6F5,$FFBC,$A0CA
	dc.w	$A134,$ADFD,$B6DF,$850B,$48AE,$7167,$7F4B,$0000
word_259B1A:
	dc.w	$8C42,$FFFF,$A000,$B481,$CD46,$EA4D,$FB33,$B0A0
	dc.w	$D9C5,$FEE8,$FFF3,$8C69,$98AC,$A510,$B553,$2C20
	dc.w	$5000,$7C00,$B6DF,$AD0C,$CDF1,$F6F5,$FFBC,$A0CA
	dc.w	$A134,$ADFD,$ADFD,$050B,$48AE,$7167,$7F4B,$0000

word_33520A:	; 黃忠1-4
	dc.w	$0040,$7FFF,$1067,$34CB,$51CA,$7B0E,$7FF4,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$0C66,$1CEC,$2DD3,$42FA
	dc.w	$03E0,$2461,$3C82,$6522,$7E27,$3060,$4D02,$65E9
	dc.w	$7AD0,$4500,$55C0,$6A60,$7F20,$7FE0,$03E0,$0000
word_25F1CE:	; 黃忠2
	dc.w	$0040,$7FFF,$1401,$38C7,$594C,$7ECF,$7FF9,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$2020,$3040,$4880,$64C0
	dc.w	$03E0,$3460,$5165,$7E6B,$7F60,$3060,$4D02,$65E9
	dc.w	$7AD0,$04A5,$1508,$25CE,$4AD6,$63BD,$03E0,$0000
word_25F1D2:
	dc.w	$0040,$7FFF,$1401,$38C7,$594C,$7ECF,$7FF9,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$2020,$3040,$4880,$64C0
	dc.w	$03E0,$3460,$5165,$7E6B,$7F60,$3060,$4D02,$65E9
	dc.w	$7AD0,$1C63,$3488,$4CB3,$5D99,$76BF,$03E0,$0000
word_25F1D6:
	dc.w	$0040,$7FFF,$1401,$38C7,$594C,$7ECF,$7FF9,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$2020,$3040,$4880,$64C0
	dc.w	$03E0,$3460,$5165,$7E6B,$7F60,$3060,$4D02,$65E9
	dc.w	$7AD0,$304A,$4C22,$7C00,$7DE0,$7FE0,$03E0,$0000
word_25F1DA:
	dc.w	$0040,$7FFF,$1401,$38C7,$594C,$7ECF,$7FF9,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$2020,$3040,$4880,$64C0
	dc.w	$03E0,$3460,$5165,$7E6B,$7F60,$3060,$4D02,$65E9
	dc.w	$7AD0,$4500,$55C0,$6A60,$7F20,$7FE0,$03E0,$0000

word_25F1DE:	; 黃忠3
	dc.w	$0040,$7FFF,$10A6,$318B,$5271,$7356,$7FDC,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$0064,$04C7,$0D2B,$15D2
	dc.w	$03E0,$0C48,$2D0B,$4DCE,$6E92,$3060,$4D02,$65E9
	dc.w	$7AD0,$04A5,$1508,$25CE,$4AD6,$63BD,$03E0,$0000
word_25F1E2:
	dc.w	$0040,$7FFF,$10A6,$318B,$5271,$7356,$7FDC,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$0064,$04C7,$0D2B,$15D2
	dc.w	$03E0,$0C48,$2D0B,$4DCE,$6E92,$3060,$4D02,$65E9
	dc.w	$7AD0,$1C63,$3488,$4CB3,$5D99,$76BF,$03E0,$0000
word_25F1E6:
	dc.w	$0040,$7FFF,$10A6,$318B,$5271,$7356,$7FDC,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$0064,$04C7,$0D2B,$15D2
	dc.w	$03E0,$0C48,$2D0B,$4DCE,$6E92,$3060,$4D02,$65E9
	dc.w	$7AD0,$304A,$4C27,$7C00,$7DE0,$7FE0,$03E0,$0000
word_25F1EA:
	dc.w	$0040,$7FFF,$10A6,$318B,$5271,$7356,$7FDC,$18A4
	dc.w	$2906,$49ED,$6715,$7BBB,$0064,$04C7,$0D2B,$15D2
	dc.w	$03E0,$0C48,$2D0B,$4DCE,$6E92,$3060,$4D02,$65E9
	dc.w	$7AD0,$4500,$55C0,$6A60,$7F20,$7FE0,$03E0,$0000

word_25F1EE:	; 黃忠4
	dc.w	$8040,$FFFF,$9067,$9CEE,$ADB5,$CEFB,$EFFF,$98A4
	dc.w	$A906,$C9ED,$E715,$FBBB,$8C66,$9CEC,$ADD3,$C2FA
	dc.w	$83E0,$A461,$A8EA,$B174,$B9FE,$B060,$CD02,$E5E9
	dc.w	$FAD0,$84A5,$9508,$A5CE,$CAD6,$E3BD,$83E0,$8000
word_25F1F2:
	dc.w	$8040,$FFFF,$9067,$9CEE,$ADB5,$CEFB,$EFFF,$98A4
	dc.w	$A906,$C9ED,$E715,$FBBB,$8C66,$9CEC,$ADD3,$C2FA
	dc.w	$83E0,$A461,$A8EA,$B174,$B9FE,$B060,$CD02,$E5E9
	dc.w	$FAD0,$1C63,$3488,$4CB3,$5D99,$76BF,$83E0,$8000
word_25F1F6:
	dc.w	$8040,$FFFF,$9067,$9CEE,$ADB5,$CEFB,$EFFF,$98A4
	dc.w	$A906,$C9ED,$E715,$FBBB,$8C66,$9CEC,$ADD3,$C2FA
	dc.w	$83E0,$A461,$A8EA,$B174,$B9FE,$B060,$CD02,$E5E9
	dc.w	$FAD0,$304A,$4C27,$7C00,$7DE0,$7FE0,$83E0,$8000
word_25F1FA:
	dc.w	$8040,$FFFF,$9067,$9CEE,$ADB5,$CEFB,$EFFF,$98A4
	dc.w	$A906,$C9ED,$E715,$FBBB,$8C66,$9CEC,$ADD3,$C2FA
	dc.w	$83E0,$A461,$A8EA,$B174,$B9FE,$B060,$CD02,$E5E9
	dc.w	$FAD0,$4500,$55C0,$6A60,$7F20,$7FE0,$03E0,$8000

word_264C38:	; 馬超2
	dc.w	$0C42,$7FFF,$2420,$38C2,$59A7,$72AD,$7F74,$03E0
	dc.w	$3129,$4A2F,$6335,$7FFB,$150E,$1592,$1A16,$431B
	dc.w	$5FF9,$7FFA,$3441,$4820,$6902,$20A9,$252F,$3E58
	dc.w	$4B7C,$03E0,$152B,$21EE,$36AE,$5F74,$03E0,$0000
word_264C3A:
	dc.w	$0C42,$7FFF,$2420,$38C2,$59A7,$72AD,$7F74,$1D0D
	dc.w	$3129,$4A2F,$6335,$7FFB,$150E,$1592,$1A16,$431B
	dc.w	$5FF9,$7FFA,$3441,$4820,$6902,$20A9,$252F,$3E58
	dc.w	$4B7C,$38C2,$59A1,$7F00,$1D0D,$2DF4,$479F,$0000
word_264C3E:
	dc.w	$0C42,$7FFF,$2420,$38C2,$59A7,$72AD,$7F74,$1D0D
	dc.w	$3129,$4A2F,$6335,$7FFB,$150E,$1592,$1A16,$431B
	dc.w	$5FF9,$7FFA,$3441,$4820,$6902,$20A9,$252F,$3E58
	dc.w	$4B7C,$2889,$4135,$5E36,$3802,$70EA,$7ABF,$0000
word_264C42:
	dc.w	$0C42,$7FFF,$2420,$38C2,$59A7,$72AD,$7F74,$4B7C
	dc.w	$3129,$4A2F,$6335,$7FFB,$150E,$1592,$1A16,$431B
	dc.w	$5FF9,$7FFA,$3441,$4820,$6902,$20A9,$252F,$3E58
	dc.w	$4B7C,$3E58,$152B,$21EE,$36AE,$5F74,$252F,$0000

word_264C48:	; 馬超3
	dc.w	$0C42,$7FFF,$2420,$38C2,$59A7,$72AD,$7F74,$03E0
	dc.w	$2867,$316E,$3E75,$4B7C,$0C20,$1086,$190C,$3948
	dc.w	$5984,$7DA0,$3D25,$5E6F,$7FBA,$1440,$2D69,$4692
	dc.w	$5FBB,$03E0,$152B,$21EE,$36AE,$5F74,$03E0,$0000
word_264C4A:
	dc.w	$0C42,$7FFF,$2420,$38C2,$59A7,$72AD,$7F74,$1D0D
	dc.w	$2867,$316E,$3E75,$4B7C,$0C20,$1086,$190C,$3948
	dc.w	$5984,$7DA0,$3D25,$5E6F,$7FBA,$1440,$2D69,$4692
	dc.w	$5FBB,$38C2,$59A1,$7F00,$1D0D,$2DF4,$477F,$0000
word_264C4E:
	dc.w	$0C42,$7FFF,$2420,$38C2,$59A7,$72AD,$7F74,$4B7C
	dc.w	$2867,$316E,$3E75,$4B7C,$0C20,$1086,$190C,$3948
	dc.w	$5984,$7DA0,$3D25,$5E6F,$7FBA,$1440,$2D69,$4692
	dc.w	$4B7C,$2889,$4135,$5E36,$3802,$70EA,$7ABF,$0000
word_264C52:
	dc.w	$0C42,$7FFF,$2420,$38C2,$59A7,$72AD,$7F74,$1D0D
	dc.w	$2867,$316E,$3E75,$4B7C,$0C20,$1086,$190C,$3948
	dc.w	$5984,$7DA0,$3D25,$5E6F,$7FBA,$1440,$2D69,$4692
	dc.w	$4B7C,$3E58,$152B,$21EE,$36AE,$5F74,$252F,$0000

word_264C58:	; 馬超4
	dc.w	$8C42,$FFFF,$A420,$B8C2,$D9A7,$F2AD,$FF74,$83E0
	dc.w	$A881,$BD4A,$CE34,$E2D9,$A068,$A90D,$B1B3,$B532
	dc.w	$B1B3,$FFFF,$B441,$59A1,$7F00,$A0A9,$A52F,$BE58
	dc.w	$CB7C,$83E0,$952B,$A1EE,$B6AE,$DF74,$83E0,$8000
word_264C5A:
	dc.w	$8C42,$FFFF,$A420,$B8C2,$D9A7,$F2AD,$FF74,$FFFF
	dc.w	$A881,$BD4A,$CE34,$E2D9,$A068,$A90D,$B1B3,$B532
	dc.w	$B1B3,$FFFF,$B441,$59A1,$7F00,$A0A9,$A52F,$BE58
	dc.w	$CB7C,$38C2,$59A1,$7F00,$1D0D,$2DF4,$479F,$0000
word_264C5E:
	dc.w	$8C42,$FFFF,$A420,$B8C2,$D9A7,$F2AD,$FF74,$FFFF
	dc.w	$A881,$BD4A,$CE34,$E2D9,$A068,$A90D,$B1B3,$B532
	dc.w	$B1B3,$FFFF,$B441,$59A1,$7F00,$A0A9,$A52F,$BE58
	dc.w	$CB7C,$2889,$4135,$5E36,$3802,$70EA,$7ABF,$0000
word_264C62:
	dc.w	$8C42,$FFFF,$A420,$B8C2,$D9A7,$F2AD,$FF74,$FFFF
	dc.w	$A881,$BD4A,$CE34,$E2D9,$A068,$A90D,$B1B3,$B532
	dc.w	$B1B3,$FFFF,$B441,$59A1,$7F00,$A0A9,$A52F,$BE58
	dc.w	$CB7C,$3E58,$152B,$21EE,$36AE,$5F74,$252F,$0000

word_26A514:	; 孔明2
	dc.w	$0421,$7FFF,$1881,$3D87,$62AE,$7FB3,$04C4,$198A
	dc.w	$2A30,$3B76,$2C20,$48C3,$6568,$7E6E,$2CA3,$4925
	dc.w	$6A49,$7F6E,$3CE5,$5969,$728E,$7F75,$258B,$3E51
	dc.w	$5738,$6FDF,$4821,$6445,$7DAD,$03E0,$03E0,$0000
word_26A518:
	dc.w	$0421,$7FFF,$1881,$3D87,$62AE,$7FB3,$04C4,$198A
	dc.w	$2A30,$3B76,$2C20,$48C3,$6568,$7E6E,$2CA3,$4925
	dc.w	$6A49,$7F6E,$3CE5,$5969,$728E,$7F75,$540E,$78FC
	dc.w	$7E9A,$7FC5,$4821,$6445,$7DAD,$03E0,$03E0,$0000
word_26A51C:
	dc.w	$0421,$7FFF,$1881,$3D87,$62AE,$7FB3,$04C4,$198A
	dc.w	$2A30,$3B76,$2C20,$48C3,$6568,$7E6E,$2CA3,$4925
	dc.w	$6A49,$7F6E,$3CE5,$5969,$728E,$7F75,$25B2,$3E1A
	dc.w	$571F,$63FF,$4821,$6445,$7DAD,$03E0,$03E0,$0000

word_26A524:	; 孔明3
	dc.w	$0421,$7FFF,$24A5,$41AB,$62D2,$7FB8,$3860,$5080
	dc.w	$6CA0,$7DC5,$2080,$3160,$4220,$5300,$2CA3,$4925
	dc.w	$6A49,$7F6E,$3CE5,$5969,$728E,$7F75,$25B2,$3E1A
	dc.w	$571F,$63FF,$4821,$6445,$7DAD,$03E0,$03E0,$0000
word_26A528:
	dc.w	$0421,$7FFF,$24A5,$41AB,$62D2,$7FB8,$3860,$5080
	dc.w	$6CA0,$7DC5,$2080,$3160,$4220,$5300,$2CA3,$4925
	dc.w	$6A49,$7F6E,$3CE5,$5969,$728E,$7F75,$540E,$78FC
	dc.w	$7E9A,$7FC5,$4821,$6445,$7DAD,$03E0,$03E0,$0000

word_26A534:	; 孔明4
	dc.w	$8421,$FFFF,$AD26,$C20D,$DEF4,$FBDC,$950B,$9990
	dc.w	$A256,$A739,$9CAB,$BD4B,$DDEB,$FE8C,$ACA3,$C925
	dc.w	$EA49,$FF6E,$BCE5,$D969,$F28E,$FF75,$A5B2,$BE1A
	dc.w	$D71F,$E3FF,$A9B4,$D71F,$E3FF,$83E0,$83E0,$8000
word_26A538:
	dc.w	$8421,$FFFF,$AD26,$C20D,$DEF4,$FBDC,$950B,$9990
	dc.w	$A256,$A739,$9CAB,$BD4B,$DDEB,$FE8C,$ACA3,$C925
	dc.w	$EA49,$FF6E,$BCE5,$D969,$F28E,$FF75,$540E,$78FC
	dc.w	$7E9A,$7FC5,$A9B4,$D71F,$E3FF,$83E0,$83E0,$8000

word_26F3A4:	; 貂蟬2
	dc.w	$0423,$7BDE,$48E0,$6DA0,$7EA0,$7F60,$03E0,$40E2
	dc.w	$5586,$6E0A,$7AF2,$7F99,$194D,$220E,$3EEF,$63D0
	dc.w	$59E5,$6AEB,$7FF2,$03E0,$18C4,$314A,$5252,$7358
	dc.w	$7FDC,$2531,$41D5,$4EFC,$639F,$7BFF,$03E0,$0000
word_26F3A8:
	dc.w	$0423,$7BDE,$48E0,$6DA0,$7EA0,$7F60,$03E0,$40E2
	dc.w	$5586,$6E0A,$7AF2,$7F99,$194D,$220E,$3EEF,$63D0
	dc.w	$59E5,$6AEB,$7FF2,$03E0,$3440,$5500,$7640,$7AEB
	dc.w	$7FDC,$2531,$41D5,$4EFC,$639F,$7BFF,$03E0,$0000

word_26F3B4:	; 貂蟬3
	dc.w	$0423,$7BDE,$30EC,$49EE,$62F1,$7FF4,$03E0,$40E2
	dc.w	$5586,$6E0A,$7AF2,$7F99,$2446,$312F,$2DF6,$32DF
	dc.w	$5060,$6540,$7E00,$03E0,$18C4,$314A,$5252,$7358
	dc.w	$7FDC,$2531,$41D5,$4EFC,$639F,$7BFF,$03E0,$0000
word_26F3B8:
	dc.w	$0423,$7BDE,$30EC,$49EE,$62F1,$7FF4,$03E0,$40E2
	dc.w	$5586,$6E0A,$7AF2,$7F99,$2446,$312F,$2DF6,$32DF
	dc.w	$5060,$6540,$7E00,$03E0,$3440,$5500,$7640,$7AEB
	dc.w	$7FDC,$2531,$41D5,$4EFC,$639F,$7BFF,$03E0,$0000

word_26F3C4:	; 貂蟬4
	dc.w	$8423,$FBDE,$8CC9,$A970,$C617,$E6FF,$83E0,$C0E2
	dc.w	$D586,$EE0A,$FAF2,$FF99,$A9C4,$98E2,$9D04,$BA87
	dc.w	$D9E5,$EAEB,$FFF2,$83E0,$98C4,$B14A,$D252,$F358
	dc.w	$FFDC,$A531,$C1D5,$CEFC,$E39F,$FBFF,$83E0,$8000
word_26F3C8:
	dc.w	$8423,$FBDE,$8CC9,$A970,$C617,$E6FF,$83E0,$C0E2
	dc.w	$D586,$EE0A,$FAF2,$FF99,$A9C4,$98E2,$9D04,$BA87
	dc.w	$D9E5,$EAEB,$FFF2,$83E0,$3440,$5500,$7640,$7AEB
	dc.w	$FFDC,$A531,$C1D5,$CEFC,$E39F,$FBFF,$83E0,$8000

word_274AE0:	; 龐統2
	dc.w	$0C42,$7FDF,$2CA2,$4545,$6A4B,$7F53,$2040,$3D07
	dc.w	$5DEF,$7ED3,$7FB7,$14C9,$2590,$3677,$475F,$0804
	dc.w	$20CB,$39B3,$4A99,$5B7F,$18CB,$2D90,$5B1F,$7FFF
	dc.w	$7226,$7F44,$03E0,$03E0,$03E0,$03E0,$03E0,$0000
word_274AE4:
	dc.w	$0C42,$7FDF,$2CA2,$4545,$6A4B,$7F53,$2040,$3D07
	dc.w	$5DEF,$7ED3,$7FB7,$14C9,$2590,$3677,$475F,$0804
	dc.w	$20CB,$39B3,$4A99,$5B7F,$0000,$4043,$6023,$7D00
	dc.w	$7226,$7F44,$03E0,$03E0,$03E0,$03E0,$03E0,$0000
word_274AE8:
	dc.w	$0C42,$7FDF,$2CA2,$4545,$6A4A,$7F53,$2040,$3D07
	dc.w	$5DEF,$7ED3,$7FB7,$14C9,$2590,$3677,$475F,$0804
	dc.w	$20CB,$39B3,$4A99,$5B7F,$2C03,$246D,$1970,$25BD
	dc.w	$7226,$7F44,$03E0,$03E0,$03E0,$03E0,$03E0,$0000

word_274AF0:	; 龐統3
	dc.w	$0C42,$7FDF,$2CA2,$4545,$6A4B,$7F53,$0005,$0C8B
	dc.w	$1932,$25D8,$329F,$04A2,$2188,$4291,$63BB,$20A6
	dc.w	$3129,$4A2F,$6335,$7FFB,$18CB,$2D90,$5B1F,$7FFF
	dc.w	$7226,$7F44,$03E0,$03E0,$03E0,$03E0,$03E0,$0000
word_274AF4:
	dc.w	$0C42,$7FDF,$2CA2,$4545,$6A4B,$7F53,$0005,$0C8B
	dc.w	$1932,$25D8,$329F,$04A2,$2188,$4291,$63BB,$20A6
	dc.w	$3129,$4A2F,$6335,$7FFB,$0000,$4048,$6023,$7D00
	dc.w	$7226,$7F44,$03E0,$03E0,$03E0,$03E0,$03E0,$0000
word_274AF8:
	dc.w	$0C42,$7FDF,$2CA2,$4545,$6A4B,$7F53,$0005,$0C8B
	dc.w	$1932,$25D8,$329F,$04A2,$2188,$4291,$63BB,$20A6
	dc.w	$3129,$4A2F,$6335,$7FFB,$2C03,$246D,$1970,$25BD
	dc.w	$7226,$7F44,$03E0,$03E0,$03E0,$03E0,$03E0,$0000

word_274B00:	; 龐統4
	dc.w	$8C42,$FFDF,$ACA2,$C545,$EA4B,$FF53,$A0A6,$B129
	dc.w	$CA2F,$E335,$FFFB,$94C9,$A94E,$D678,$F75F,$9425
	dc.w	$A489,$C9A6,$F2A6,$FFAC,$98CB,$AD90,$DB1F,$FFFF
	dc.w	$F226,$FF44,$83E0,$83E0,$83E0,$83E0,$83E0,$8000
word_274B04:
	dc.w	$8C42,$FFDF,$ACA2,$C545,$EA4B,$FF53,$A0A6,$B129
	dc.w	$CA2F,$E335,$FFFB,$94C9,$A94E,$D678,$F75F,$9425
	dc.w	$A489,$C9A6,$F2A6,$FFAC,$0000,$4048,$6023,$7D00
	dc.w	$F226,$FF44,$83E0,$83E0,$83E0,$83E0,$83E0,$8000
word_274B08:
	dc.w	$8C42,$FFDF,$ACA2,$C545,$EA4B,$FF53,$A0A6,$B129
	dc.w	$CA2F,$E335,$FFFB,$94C9,$A94E,$D678,$F75F,$9425
	dc.w	$A489,$C9A6,$F2A6,$FFAC,$2C03,$246D,$1970,$25BD
	dc.w	$F226,$FF44,$83E0,$83E0,$83E0,$83E0,$83E0,$8000

word_279F66:	; 孫權2
	dc.w	$8020,$FFFF,$A820,$BCA3,$D967,$F26D,$FF52,$A0A5
	dc.w	$B529,$D20D,$EB31,$A845,$C4C8,$E5E9,$FF24,$AC21
	dc.w	$C821,$F0E3,$8404,$9867,$B0AA,$C8E7,$F98A,$FF0C
	dc.w	$80A9,$812D,$B655,$E37D,$9824,$A846,$83E0,$8000
word_279F6A:
	dc.w	$8020,$FFFF,$A820,$BCA3,$D967,$F26D,$FF52,$A0A5
	dc.w	$B529,$D20D,$EB31,$A845,$C4C8,$E5E9,$FF24,$AC21
	dc.w	$C821,$F0E3,$8404,$9867,$B0AA,$C8E7,$F98A,$FF0C
	dc.w	$3865,$7400,$7E40,$7FA0,$9824,$A846,$83E0,$8000

word_279F76:	; 孫權3
	dc.w	$8020,$FFFF,$A820,$BCA3,$D967,$F26D,$FF52,$1488
	dc.w	$20ED,$31B1,$4676,$A845,$C4C8,$E5E9,$FF24,$AC21
	dc.w	$C821,$F0E3,$9802,$9C29,$9CAC,$A52F,$B234,$AF78
	dc.w	$80A9,$812D,$B655,$E37D,$9824,$A846,$83E0,$8000
word_279F7A:
	dc.w	$8020,$FFFF,$A820,$BCA3,$D967,$F26D,$FF52,$1488
	dc.w	$20ED,$31B1,$4676,$A845,$C4C8,$E5E9,$FF24,$AC21
	dc.w	$C821,$F0E3,$9802,$9C29,$9CAC,$A52F,$B234,$AF78
	dc.w	$3865,$7400,$7E40,$7FA0,$9824,$A846,$83E0,$8000

word_3411BC:	; 孫權4
	dc.w	$0020,$7FFF,$2820,$3CA3,$5967,$726D,$7F52,$1488
	dc.w	$20ED,$31B1,$4676,$2845,$44C8,$65E9,$7F24,$420E
	dc.w	$56D4,$6F79,$0400,$1CA4,$2D06,$49EB,$66F1,$7FDC
	dc.w	$80A9,$812D,$B655,$E37D,$1824,$2846,$03E0,$0000
word_3411FC:
	dc.w	$0020,$7FFF,$2820,$3CA3,$5967,$726D,$7F52,$1488
	dc.w	$20ED,$31B1,$4676,$2845,$44C8,$65E9,$7F24,$420E
	dc.w	$56D4,$6F79,$0400,$1CA4,$2D06,$49EB,$66F1,$7FDC
	dc.w	$3865,$7400,$7E40,$7FA0,$1824,$2846,$03E0,$0000


sub_100AF6:
	movem.l	D0-D1/A0-A1, -(A7)		; 重新編寫色盤刷新程序，加入(部分刷新)
	movea.l	$14(A7), A1				; A1 色盤寄存
	movea.l	$18(A7), A0				; A0 色盤地址
	move.l	$1C(A7), D0
	and.l	D0, D0
	beq.w	locret_100AF6
	subq.l	#1, D0
	moveq	#$0, D1					; 色盤偏移數
loc_100B0E:
	tst.w	(A0)
	beq.s	loc_100B0F
	move.w	(A0)+, (A1)+
	bra.s	loc_100B10
loc_100B0F:
	move.w	(A1)+, (A0)+			; 部分刷新(適合中毒刷新)
loc_100B10:
	addq.l	#1, D1
	cmpi.l	#$20, D1
	blt.s	loc_100B0E
loc_100B11:
	dbra	D0, loc_100B0E
locret_100AF6:
	movem.l	(A7)+, D0-D1/A0-A1
	rts


off_30FF34:	; 關羽/張飛/趙雲/馬超/孫權
	dc.w	$0,$0,$8CA8,$9CEE,$C194,$E635,$FED6,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
off_3102B4:	; 黃忠
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$9CEE,$C194,$E635
	dc.w	$FED6,$0,$0,$0,$0,$0,$0,$0
off_3105B4:	; 孔明
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$9CEE,$C194,$E635,$FED6,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
off_3106F4:	; 貂蟬
	dc.w	$0,$0,$0,$0,$0,$0,$0,$8CA8
	dc.w	$9CEE,$C194,$E635,$FED6,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
off_3107F4:	; 龐統
	dc.w	$0,$0,$9CEE,$C194,$E635,$FED6,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0
	dc.w	$0,$0,$0,$0,$0,$0,$0,$0


sub_12B1E2:
	move.w  ($10c,A2), D0	; 原代碼
	cmpi.w	#$3, D0			; 判断是否方天中毒状态
	bne.s	locret_12B1E2
	movea.l $54(A2), A4
	move.b  1(A4), D0		; 区分角色
	movea.l #seg_12B1E2, A4
locret_12B1E2:
	lsl.l   #2, D0			; 原代碼
	rts

seg_12B1E2:
	dc.l	unk_12B1E2,unk_12B1E3,unk_12B1E4

unk_12B1E2:	; 關羽方天畫戟(中毒狀態)色盤
	dc.w	$8C42,$FFFF,$8CA8,$9CEE,$C194,$E635,$FED6,$9124
	dc.w	$9DC6,$AE88,$CB2A,$AC21,$C821,$E0E3,$FDEA,$B12A
	dc.w	$CA2F,$E335,$FFFB,$B886,$D0E6,$F208,$F709,$9000
	dc.w	$B820,$D100,$80C4,$8169,$D1F5,$FA92,$FFD8,$0000
unk_12B1E3:	; 張飛方天畫戟(中毒狀態)色盤
	dc.w	$8461,$FFFF,$8CA8,$9CEE,$C194,$E635,$FED6,$9CE5
	dc.w	$B1AA,$CE8E,$EF53,$83E0,$B4A0,$D540,$F661,$FF6A
	dc.w	$1A30,$10A8,$1D2D,$29B4,$3A5A,$1064,$20CE,$1D71
	dc.w	$45D5,$30EB,$50ED,$7645,$4339,$052B,$08A9,$0000
unk_12B1E4:	; 趙雲方天畫戟(中毒狀態)色盤
	dc.w	$8C42,$FFFF,$8CA8,$9CEE,$C194,$E635,$FED6,$A0A7
	dc.w	$B98B,$DED4,$FFFB,$8C69,$90EE,$9DB3,$AA56,$AC20
	dc.w	$D000,$FC00,$B6F2,$890F,$9212,$9F16,$CFB8,$AC43
	dc.w	$C4A2,$DCC2,$9A10,$850B,$C8AE,$F167,$FF4B,$0000


sub_1581C4:
	move.l  a2,-(sp)
	tst.b	(ram_0006).l	; 動作移動[V10X/V20X]
	bne.s	loc_1581C4
	jsr		$1607CC			; 原版二代跑步
	bra.s 	locret_1581C4
loc_1581C4:
	jsr		sub_1739B0		; 群雄反身二次方向跑步
locret_1581C4:
	addq.l	#4,sp
	rts

sub_1739B0:	; 群雄反身二次方向跑步
	link	a6,#-4
	movem.l	d2-d6/a2-a3,-(sp)
	movea.l	($8,A6), A2
	clr.w	d2
	movea.l	$F8(a2),a3
	move.w	$50(a2),d6
	move.w	($52,A2), (-$2,A6)
	cmpi.w	#2,d6
	bne.w	loc_173C62
	move.l	a2,-(sp)
	jsr		$15E58E
	addq.l	#4,sp
	tst.l	d0
	beq.w	loc_173A9A
	move.l	$1C(a3),d0
	cmp.l	$280(a2),d0
	beq.w	loc_173C62
	tst.w	$C8(a2)
	bne.s	loc_1739FE
	btst	#3,$1C(a3)
	bne.s	loc_173A10
loc_1739FE:
	moveq	#0,d0
	move.w	$C8(a2),d0
	tst.l	d0
	beq.s	loc_173A3A
	btst	#4,$1C(a3)
	beq.s	loc_173A3A
loc_173A10:
	btst	#6,$1C(a3)
	beq.s	loc_173A20
	move.l	a2,-(sp)
	jsr		$16061E
	bra.s	loc_173A36
loc_173A20:
	btst	#5,$1C(a3)
	beq.s	loc_173A30
	move.l	a2,-(sp)
	jsr		$1606DE
	bra.s	loc_173A36
loc_173A30:
	move.l	a2,-(sp)
	jsr		$16067E
loc_173A36:
	addq.l	#4,sp
	bra.s	loc_173A8A
loc_173A3A:
	tst.w	$C8(a2)
	bne.s	loc_173A48
	btst	#4,$1C(a3)
	bne.s	loc_173A5A
loc_173A48:
	moveq	#0,d0
	move.w	$C8(a2),d0
	tst.l	d0
	beq.s	loc_173A6A
	btst	#3,$1C(a3)
	beq.s	loc_173A6A
loc_173A5A:
	move.w	#1,$C6(a2)
	move.l	a2,-(sp)
	jsr		$160770
	addq.l	#4,sp
	bra.s	loc_173A8A
loc_173A6A:
	pea		$13.w
	pea		$2.w
	move.l	a2,-(sp)
	jsr		$15E152
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA
	addq.l	#8,sp
loc_173A8A:
	moveq	#1,d2
	tst.w	d2
	beq.s	loc_173A9A
	move.l	$1C(a3),$280(a2)
	bra.w	loc_173C62
loc_173A9A:
	btst	#4,$1C(a3)
	bne.s	loc_173AAA
	btst	#3,$1C(a3)
	beq.s	loc_173AAE
loc_173AAA:
	moveq	#1,d4
	bra.s	loc_173AB0
loc_173AAE:
	clr.w	d4
loc_173AB0:
	clr.w	d3
	moveq	#0,d0
	move.w	$FC(a2),d0
	beq.s	loc_173AC2
	moveq	#1,d1
	cmp.w	d1,d0
	beq.s	loc_173AF4
	bra.s	loc_173B1E
loc_173AC2:
	btst	#1,$1C(a3)
	bne.s	loc_173B30
	btst	#3,$20(a3)
	bne.s	loc_173ADA
	btst	#4,$20(a3)
	beq.s	loc_173B30
loc_173ADA:
	move.l	$20(a3),$280(a2)
	move.l	8(a2),d0
	moveq	#$13,d1
	add.l	d1,d0
	move.l	d0,$100(a2)
	move.w	#1,$FC(a2)
	bra.s	loc_173B30
loc_173AF4:
	move.l	8(a2),d0
	cmp.l	$100(a2),d0
	bls.s	loc_173B04
	clr.w	$FC(a2)
	bra.s	loc_173B30
loc_173B04:
	move.l	$280(a2),d0
	cmp.l	$20(a3),d0
	bne.s	loc_173B30
	cmpi.w	#$10,$CA(a2)
	beq.s	loc_173B30
	moveq	#1,d3
	clr.w	$FC(a2)
	bra.s	loc_173B30
loc_173B1E:
	pea		$33.w
	pea		$3010BC.l
	jsr		$13A8F2
	addq.l	#8,sp
loc_173B30:
	tst.l	$144(a2)
	beq.s	loc_173B38
	clr.w	d3
loc_173B38:
	btst	#1,$20(a3)
	beq.s	loc_173B9E
	tst.w	$C6(a2)
	bne.w	loc_173C62
	tst.w	$BE(a2)
	bne.s	loc_173B90
	movea.l	$26E(a3),a0
	move.w	$1A(a0),d5
	btst	#5,$20(a3)
	bne.s	loc_173B7C
	tst.w	d5
	beq.s	loc_173B68
	cmpi.w	#$A,d5
	bcs.s	loc_173B7C
loc_173B68:
	cmpi.b	#$2, $81827F.l
	bne.s	loc_173B84
	cmpi.b	#$b, $818050.l
	bne.s	loc_173B84
loc_173B7C:
	move.l	a2,-(sp)
	jsr		$15FE5C
	bra.s	loc_173B96
loc_173B84:
	tst.w	d4
	beq.s	loc_173B90
	move.l	a2,-(sp)
	jsr		$160048
	bra.s	loc_173B96
loc_173B90:
	move.l	a2,-(sp)
	jsr		$16008C
loc_173B96:
	addq.l	#4,sp
	clr.w	$CC(a2)
	bra.s	loc_173C0A
loc_173B9E:
	tst.w	d4
	beq.s	loc_173BE2
	tst.w	d3
	beq.s	loc_173BB2
	clr.w	$CC(a2)
	move.l	a2,-(sp)
	jsr		$16067E
	bra.s	loc_173C08
loc_173BB2:
	tst.w	$C6(a2)
	bne.w	loc_173C62
	btst	#6,$1C(a3)
	beq.s	loc_173BCA
	move.l	a2,-(sp)
	jsr		$1601EA
	bra.s	loc_173C08
loc_173BCA:
	btst	#5,$1C(a3)
	beq.s	loc_173BDA
	move.l	a2,-(sp)
	jsr		$16041A
	bra.s	loc_173C08
loc_173BDA:
	move.l	a2,-(sp)
	jsr		$1602FE
	bra.s	loc_173C08
loc_173BE2:
	tst.w	$C6(a2)
	bne.w	loc_173C62
	btst	#6,$1C(a3)
	beq.s	loc_173BFA
	move.l	a2,-(sp)
	jsr		$160100
	bra.s	loc_173C08
loc_173BFA:
	btst	#5,$1C(a3)
	beq.s	loc_173C0A
	move.l	a2,-(sp)
	jsr		$16051A
loc_173C08:
	addq.l	#4,sp
loc_173C0A:
	tst.w	$C8(a2)
	bne.s	loc_173C38
	btst	#4,$1C(a3)
	beq.s	loc_173C38
	cmpi.w	#$10,$CA(a2)
	beq.s	loc_173C30
	move.w	#1,$C6(a2)
	move.l	a2,-(sp)
	jsr		$160770
	addq.l	#4,sp
	bra.s	loc_173C62
loc_173C30:
	move.w	#1,$C8(a2)
	bra.s	loc_173C62
loc_173C38:
	tst.w	$C8(a2)
	beq.s	loc_173C62
	btst	#3,$1C(a3)
	beq.s	loc_173C62
	cmpi.w	#$10,$CA(a2)
	beq.s	loc_173C5E
	move.w	#1,$C6(a2)
	move.l	a2,-(sp)
	jsr		$160770
	addq.l	#4,sp
	bra.s	loc_173C62
loc_173C5E:
	clr.w	$C8(a2)
loc_173C62:
	movem.l	(-$20,A6), D2-D6/A2-A3
	unlk	a6
	rts


off_2C42A0:
	dc.l	$004400FA,$004400FB,$004400FB,$004400FB
	dc.l	$004400FC,$004400FC,$004400FC,$004400FD
	dc.l	$004400FD,$004400FD,$004500FE,$004500FE
	dc.l	$004500FE,$004500FE,$004500FF,$004500FF
	dc.l	$004500FF,$00450000,$00460000,$00460000
	dc.l	$00460000,$00460000,$00470000,$00470001
	dc.l	$F04B0000,$00470001
	dc.l	$F04B0000,$00470001
	dc.l	$F04B0000,$00470002
	dc.l	$F04B0000,$00470002
	dc.l	$F04B0000,$00470002
	dc.l	$F04B0000,$00470002
	dc.l	$F04B0000,$00470003
	dc.l	$F04B0000,$00470003
	dc.l	$F04B0000,$00470003
	dc.l	$F04B0000,$00470004
	dc.l	$F04B0000,$00470004
	dc.l	$F04B0000,$00470004
	dc.l	$F04B0000,$00470005
	dc.l	$F04B0000,$00470005
	dc.l	$F04B0000,$00470005
	dc.l	$F04B0000
	dc.l	$F0030000,$00470006
	dc.l	$80000000
off_2C4478:
	dc.l	$004403FA,$004403FB,$004403FB,$004403FB
	dc.l	$004403FC,$004403FC,$004403FC,$004403FD
	dc.l	$004403FD,$004403FD,$004503FE,$004503FE
	dc.l	$004503FE,$004503FE,$004503FF,$004503FF
	dc.l	$004503FF,$00450300,$00460300,$00460300
	dc.l	$00460300,$00460300,$00470300,$00470301
	dc.l	$F04B0000,$00470301
	dc.l	$F04B0000,$00470301
	dc.l	$F04B0000,$00470302
	dc.l	$F04B0000,$00470302
	dc.l	$F04B0000,$00470302
	dc.l	$F04B0000,$00470302
	dc.l	$F04B0000,$00470303
	dc.l	$F04B0000,$00470303
	dc.l	$F04B0000,$00470303
	dc.l	$F04B0000,$00470304
	dc.l	$F04B0000,$00470304
	dc.l	$F04B0000,$00470304
	dc.l	$F04B0000,$00470305
	dc.l	$F04B0000,$00470305
	dc.l	$F04B0000,$00470305
	dc.l	$F04B0000
	dc.l	$F0030000,$00470306
	dc.l	$80000000
off_2C4560:
	dc.l	$0044FDFA,$0044FDFB,$0044FDFB,$0044FDFB
	dc.l	$0044FDFC,$0044FDFC,$0044FDFC,$0044FDFD
	dc.l	$0044FDFD,$0044FDFD,$0045FDFE,$0045FDFE
	dc.l	$0045FDFE,$0045FDFE,$0045FDFF,$0045FDFF
	dc.l	$0045FDFF,$0045FD00,$0046FD00,$0046FD00
	dc.l	$0046FD00,$0046FD00,$0047FD00,$0047FD01
	dc.l	$F04B0000,$0047FD01
	dc.l	$F04B0000,$0047FD01
	dc.l	$F04B0000,$0047FD02
	dc.l	$F04B0000,$0047FD02
	dc.l	$F04B0000,$0047FD02
	dc.l	$F04B0000,$0047FD02
	dc.l	$F04B0000,$0047FD03
	dc.l	$F04B0000,$0047FD03
	dc.l	$F04B0000,$0047FD03
	dc.l	$F04B0000,$0047FD04
	dc.l	$F04B0000,$0047FD04
	dc.l	$F04B0000,$0047FD04
	dc.l	$F04B0000,$0047FD05
	dc.l	$F04B0000,$0047FD05
	dc.l	$F04B0000,$0047FD05
	dc.l	$F04B0000
	dc.l	$F0030000,$0047FD06
	dc.l	$80000000

dword_2508C4:	; 關羽空中速降動作
	dc.l	$F0030000,$0047030A	; [030A]
	dc.l	$80000000

off_2C9756:
	dc.l	$004900FA,$004900FB,$004900FB,$004900FC
	dc.l	$004900FC,$004900FC,$004900FD,$004900FD
	dc.l	$004900FD,$004A00FE,$004A00FE,$004A00FE
	dc.l	$004A00FE,$004A00FF,$004A00FF,$004A00FF
	dc.l	$004B0000,$004B0000,$004B0000,$004B0000
	dc.l	$004B0000,$004B0000,$004A0001
	dc.l	$F04B0000,$004A0001
	dc.l	$F04B0000,$004A0001
	dc.l	$F04B0000,$004A0002
	dc.l	$F04B0000,$004A0002
	dc.l	$F04B0000,$004A0002
	dc.l	$F04B0000,$004A0002
	dc.l	$F04B0000,$004A0003
	dc.l	$F04B0000,$004A0003
	dc.l	$F04B0000,$004A0003
	dc.l	$F04B0000,$00490004
	dc.l	$F04B0000,$00490004
	dc.l	$F04B0000,$00490004
	dc.l	$F04B0000,$00490005
	dc.l	$F04B0000,$00490005
	dc.l	$F04B0000
	dc.l	$F0030000,$00490006
	dc.l	$80000000
off_2C9916:
	dc.l	$004903FA,$004903FB,$004903FB,$004903FC
	dc.l	$004903FC,$004903FC,$004A03FD,$004A03FD
	dc.l	$004A03FD,$004A03FE,$004B03FE,$004B03FE
	dc.l	$004B03FE,$004B03FF,$004B03FF,$004B03FF
	dc.l	$004B0300,$004B0300,$004B0300,$004B0300
	dc.l	$004B0300,$004B0300,$004A0301
	dc.l	$F04B0000,$004A0301
	dc.l	$F04B0000,$004A0301
	dc.l	$F04B0000,$004A0302
	dc.l	$F04B0000,$004A0302
	dc.l	$F04B0000,$004A0302
	dc.l	$F04B0000,$004A0302
	dc.l	$F04B0000,$004A0303
	dc.l	$F04B0000,$00490303
	dc.l	$F04B0000,$00490303
	dc.l	$F04B0000,$00490304
	dc.l	$F04B0000,$00490304
	dc.l	$F04B0000,$00490304
	dc.l	$F04B0000,$00490305
	dc.l	$F04B0000,$00490305
	dc.l	$F04B0000
	dc.l	$F0030000,$00490306
	dc.l	$80000000
off_2C99F2:
	dc.l	$0049FDFA,$0049FDFB,$0049FDFB,$0049FDFC
	dc.l	$0049FDFC,$0049FDFC,$004AFDFD,$004AFDFD
	dc.l	$004AFDFD,$004AFDFE,$004BFDFE,$004BFDFE
	dc.l	$004BFDFE,$004BFDFF,$004BFDFF,$004BFDFF
	dc.l	$004BFD00,$004BFD00,$004BFD00,$004BFD00
	dc.l	$004BFD00,$004BFD00,$004AFD01
	dc.l	$F04B0000,$004AFD01
	dc.l	$F04B0000,$004AFD01
	dc.l	$F04B0000,$004AFD02
	dc.l	$F04B0000,$004AFD02
	dc.l	$F04B0000,$004AFD02
	dc.l	$F04B0000,$004AFD02
	dc.l	$F04B0000,$004AFD03
	dc.l	$F04B0000,$0049FD03
	dc.l	$F04B0000,$0049FD03
	dc.l	$F04B0000,$0049FD04
	dc.l	$F04B0000,$0049FD04
	dc.l	$F04B0000,$0049FD04
	dc.l	$F04B0000,$0049FD05
	dc.l	$F04B0000,$0049FD05
	dc.l	$F04B0000
	dc.l	$F0030000,$0049FD06
	dc.l	$80000000

dword_255CBE:	; 張飛空中速降動作
	dc.l	$F0030000,$004A030A	; [030A]
	* dc.l	$F0020300,$00480000	; 避免張飛空中JUMP PATH ERROR
	dc.l	$80000000

off_2CEE4C:
	dc.l	$004C00F8,$004C00F9,$004C00F9,$004C00FA
	dc.l	$004C00FA,$004C00FA,$004C00FB,$004C00FB
	dc.l	$004C00FB,$004C00FC,$004D00FC,$004D00FC
	dc.l	$004D00FD,$004D00FD,$004D00FD,$004D00FE
	dc.l	$004D00FE,$004D00FF,$004E00FF,$004E00FF
	dc.l	$004E0001,$004E0001,$004E0001,$004E0002,$004F0002
	dc.l	$F04B0000,$004F0003
	dc.l	$F04B0000,$004F0003
	dc.l	$F04B0000,$004F0003
	dc.l	$F04B0000,$004F0004
	dc.l	$F04B0000,$004F0004
	dc.l	$F04B0000,$004F0004
	dc.l	$F04B0000,$00500005
	dc.l	$F04B0000,$00500005
	dc.l	$F04B0000,$00500005
	dc.l	$F04B0000,$00500006
	dc.l	$F04B0000,$00500006
	dc.l	$F04B0000,$00500006
	dc.l	$F04B0000,$00500007
	dc.l	$F04B0000,$00500007
	dc.l	$F04B0000
	dc.l	$F0030000,$0050000A
	dc.l	$80000000
off_2CF01C:
	dc.l	$004C03F8,$004C03F9,$004C03F9,$004C03FA
	dc.l	$004C03FA,$004C03FA,$004C03FB,$004C03FB
	dc.l	$004C03FB,$004C03FC,$004D03FC,$004D03FC
	dc.l	$004D03FD,$004D03FD,$004D03FD,$004D03FE
	dc.l	$004D03FE,$004D03FF,$004D03FF,$004E03FF
	dc.l	$004E0301,$004E0301,$004E0301,$004E0302,$004F0302
	dc.l	$F04B0000,$004F0303
	dc.l	$F04B0000,$004F0303
	dc.l	$F04B0000,$004F0303
	dc.l	$F04B0000,$004F0304
	dc.l	$F04B0000,$004F0304
	dc.l	$F04B0000,$004F0304
	dc.l	$F04B0000,$00500305
	dc.l	$F04B0000,$00500305
	dc.l	$F04B0000,$00500305
	dc.l	$F04B0000,$00500306
	dc.l	$F04B0000,$00500306
	dc.l	$F04B0000,$00500306
	dc.l	$F04B0000,$00500307
	dc.l	$F04B0000,$00500307
	dc.l	$F04B0000
	dc.l	$F0030000,$0050030A
	dc.l	$80000000
off_2CF100:
	dc.l	$004CFDF8,$004CFDF9,$004CFDF9,$004CFDFA
	dc.l	$004CFDFA,$004CFDFA,$004CFDFB,$004CFDFB
	dc.l	$004CFDFB,$004CFDFC,$004DFDFC,$004DFDFC
	dc.l	$004DFDFD,$004DFDFD,$004DFDFD,$004DFDFE
	dc.l	$004DFDFE,$004DFDFF,$004DFDFF,$004EFDFF
	dc.l	$004EFD01,$004EFD01,$004EFD01,$004EFD02,$004FFD02
	dc.l	$F04B0000,$004FFD03
	dc.l	$F04B0000,$004FFD03
	dc.l	$F04B0000,$004FFD03
	dc.l	$F04B0000,$004FFD04
	dc.l	$F04B0000,$004FFD04
	dc.l	$F04B0000,$004FFD04
	dc.l	$F04B0000,$0050FD05
	dc.l	$F04B0000,$0050FD05
	dc.l	$F04B0000,$0050FD05
	dc.l	$F04B0000,$0050FD06
	dc.l	$F04B0000,$0050FD06
	dc.l	$F04B0000,$0050FD06
	dc.l	$F04B0000,$0050FD07
	dc.l	$F04B0000,$0050FD07
	dc.l	$F04B0000
	dc.l	$F0030000,$0050030A
	dc.l	$80000000

dword_25B1C6:	; 趙雲/孔明/貂蟬空中速降動作
	dc.l	$F0030000,$0050030A	; [030A]
	dc.l	$80000000

off_2D47B4:
	dc.l	$004300FA,$004300FA,$004300FB,$004300FB
	dc.l	$004300FB,$004300FC,$004300FC,$004300FC
	dc.l	$004300FD,$004300FD,$004300FD,$004400FE
	dc.l	$004400FE,$004400FE,$004400FE,$004400FF
	dc.l	$004400FF,$004400FF,$00440000,$00450000
	dc.l	$00450000,$00450000,$00450000,$00440000,$00440001
	dc.l	$F04B0000,$00440001
	dc.l	$F04B0000,$00440001
	dc.l	$F04B0000,$00440002
	dc.l	$F04B0000,$00440002
	dc.l	$F04B0000,$00440002
	dc.l	$F04B0000,$00440002
	dc.l	$F04B0000,$00440003
	dc.l	$F04B0000,$00440003
	dc.l	$F04B0000,$00440003
	dc.l	$F04B0000,$00430004
	dc.l	$F04B0000,$00430004
	dc.l	$F04B0000,$00430004
	dc.l	$F04B0000,$00430005
	dc.l	$F04B0000,$00430005
	dc.l	$F04B0000,$00430005
	dc.l	$F04B0000,$00430006
	dc.l	$F04B0000
	dc.l	$F0030000,$00430006
	dc.l	$80000000

off_2D49A4:
	dc.l	$004303FA,$004303FA,$004303FB,$004303FB
	dc.l	$004303FB,$004303FC,$004303FC,$004303FC
	dc.l	$004303FD,$004303FD,$004303FD,$004403FE
	dc.l	$004403FE,$004403FE,$004403FE,$004403FF
	dc.l	$004403FF,$004403FF,$00450300,$00450300
	dc.l	$00450300,$00450300,$00450300,$00450300,$00440301
	dc.l	$F04B0000,$00440301
	dc.l	$F04B0000,$00440301
	dc.l	$F04B0000,$00440302
	dc.l	$F04B0000,$00440302
	dc.l	$F04B0000,$00440302
	dc.l	$F04B0000,$00440302
	dc.l	$F04B0000,$00440303
	dc.l	$F04B0000,$00440303
	dc.l	$F04B0000,$00440303
	dc.l	$F04B0000,$00430304
	dc.l	$F04B0000,$00430304
	dc.l	$F04B0000,$00430304
	dc.l	$F04B0000,$00430305
	dc.l	$F04B0000,$00430305
	dc.l	$F04B0000,$00430305
	dc.l	$F04B0000,$00430306
	dc.l	$F04B0000
	dc.l	$F0030000,$00430306
	dc.l	$80000000

off_2D4A98:
	dc.l	$0043FDFA,$0043FDFA,$0043FDFB,$0043FDFB
	dc.l	$0043FDFB,$0043FDFC,$0043FDFC,$0043FDFC
	dc.l	$0043FDFD,$0043FDFD,$0043FDFD,$0044FDFE
	dc.l	$0044FDFE,$0044FDFE,$0044FDFE,$0044FDFF
	dc.l	$0044FDFF,$0044FDFF,$0045FD00,$0045FD00
	dc.l	$0045FD00,$0045FD00,$0045FD00,$0045FD00,$0044FD01
	dc.l	$F04B0000,$0044FD01
	dc.l	$F04B0000,$0044FD01
	dc.l	$F04B0000,$0044FD02
	dc.l	$F04B0000,$0044FD02
	dc.l	$F04B0000,$0044FD02
	dc.l	$F04B0000,$0044FD02
	dc.l	$F04B0000,$0044FD03
	dc.l	$F04B0000,$0044FD03
	dc.l	$F04B0000,$0044FD03
	dc.l	$F04B0000,$0043FD04
	dc.l	$F04B0000,$0043FD04
	dc.l	$F04B0000,$0043FD04
	dc.l	$F04B0000,$0043FD05
	dc.l	$F04B0000,$0043FD05
	dc.l	$F04B0000,$0043FD05
	dc.l	$F04B0000,$0043FD06
	dc.l	$F04B0000
	dc.l	$F0030000,$0043FD06
	dc.l	$80000000

dword_2608AE:	; 黃忠/孫權空中速降動作
	dc.l	$F0030000,$0043030A	; [0A]
	dc.l	$80000000

dword_26666C:	; 馬超/龐統空中速降動作
	dc.l	$F0030000,$0046030A	; [030A]
	dc.l	$80000000

off_2DF7F8:
	dc.l	$004A00F8,$004A00F9,$004A00FA,$004A00FA
	dc.l	$004A00FB,$004A00FB,$004A00FC,$004A00FC
	dc.l	$004A00FD,$004A00FD,$004A00FE,$004A00FE
	dc.l	$004A00FE,$004A00FE,$004B00FF,$004B00FF
	dc.l	$004B00FF,$004C0000,$004C0000,$004C0000
	dc.l	$004C0000,$004C0000,$004C0000,$004D0001
	dc.l	$F04B0000,$004D0001
	dc.l	$F04B0000,$004D0001
	dc.l	$F04B0000,$004D0002
	dc.l	$F04B0000,$004D0002
	dc.l	$F04B0000,$004E0002
	dc.l	$F04B0000,$004E0002
	dc.l	$F04B0000,$004E0003
	dc.l	$F04B0000,$004E0003
	dc.l	$F04B0000,$004E0004
	dc.l	$F04B0000,$004F0004
	dc.l	$F04B0000,$004F0005
	dc.l	$F04B0000,$004F0005
	dc.l	$F04B0000,$004F0006
	dc.l	$F04B0000,$004F0006
	dc.l	$F04B0000,$004F0007
	dc.l	$F04B0000
	dc.l	$F0030000,$00500008
	dc.l	$80000000
off_2DF9D0:
	dc.l	$004A03F9,$004A03FA,$004A03FB,$004A03FB
	dc.l	$004A03FC,$004B03FC,$004B03FC,$004B03FD
	dc.l	$004B03FD,$004B03FD,$004B03FE,$004B03FE
	dc.l	$004B03FE,$004B03FE,$004B03FF,$004B03FF
	dc.l	$004B03FF,$004C0300,$004C0300,$004C0300
	dc.l	$004C0300,$004C0300,$004C0300,$004D0301
	dc.l	$F04B0000,$004D0301
	dc.l	$F04B0000,$004D0301
	dc.l	$F04B0000,$004D0302
	dc.l	$F04B0000,$004D0302
	dc.l	$F04B0000,$004E0302
	dc.l	$F04B0000,$004E0302
	dc.l	$F04B0000,$004E0303
	dc.l	$F04B0000,$004E0303
	dc.l	$F04B0000,$004E0303
	dc.l	$F04B0000,$004F0304
	dc.l	$F04B0000,$004F0304
	dc.l	$F04B0000,$004F0304
	dc.l	$F04B0000,$004F0305
	dc.l	$F04B0000,$004F0305
	dc.l	$F04B0000,$004F0306
	dc.l	$F04B0000
	dc.l	$F0030000,$00500307
	dc.l	$80000000
off_2DFAB8:
	dc.l	$004AFDF9,$004AFDFA,$004AFDFB,$004AFDFB
	dc.l	$004AFDFC,$004BFDFC,$004BFDFC,$004BFDFD
	dc.l	$004BFDFD,$004BFDFD,$004BFDFE,$004BFDFE
	dc.l	$004BFDFE,$004BFDFE,$004BFDFF,$004BFDFF
	dc.l	$004BFDFF,$004CFD00,$004CFD00,$004CFD00
	dc.l	$004CFD00,$004CFD00,$004CFD00,$004DFD01
	dc.l	$F04B0000,$004DFD01
	dc.l	$F04B0000,$004DFD01
	dc.l	$F04B0000,$004DFD02
	dc.l	$F04B0000,$004DFD02
	dc.l	$F04B0000,$004EFD02
	dc.l	$F04B0000,$004EFD02
	dc.l	$F04B0000,$004EFD03
	dc.l	$F04B0000,$004EFD03
	dc.l	$F04B0000,$004EFD03
	dc.l	$F04B0000,$004FFD04
	dc.l	$F04B0000,$004FFD04
	dc.l	$F04B0000,$004FFD04
	dc.l	$F04B0000,$004FFD05
	dc.l	$F04B0000,$004FFD05
	dc.l	$F04B0000,$004FFD06
	dc.l	$F04B0000
	dc.l	$F0030000,$0050FD07
	dc.l	$80000000

off_2E9F5C:
	dc.l	$004200FA,$004200FB,$004200FB,$004200FB
	dc.l	$004200FC,$004200FC,$004200FC,$004200FD
	dc.l	$004300FD,$004300FD,$004300FE,$004300FE
	dc.l	$004300FE,$004300FE,$004300FF,$004400FF
	dc.l	$004400FF,$00440000,$00440000,$00440000
	dc.l	$00440000,$00440000,$00440000,$00450001
	dc.l	$F04B0000,$00450001
	dc.l	$F04B0000,$00450001
	dc.l	$F04B0000,$00450002
	dc.l	$F04B0000,$00450002
	dc.l	$F04B0000,$00450002
	dc.l	$F04B0000,$00450002
	dc.l	$F04B0000,$00450003
	dc.l	$F04B0000,$00450003
	dc.l	$F04B0000,$00450003
	dc.l	$F04B0000,$00460004
	dc.l	$F04B0000,$00460004
	dc.l	$F04B0000,$00460004
	dc.l	$F04B0000,$00460005
	dc.l	$F04B0000,$00460005
	dc.l	$F04B0000,$00460005
	dc.l	$F04B0000
	dc.l	$F0030000,$00460006
	dc.l	$80000000
off_2EA134:
	dc.l	$004203FA,$004203FB,$004203FB,$004203FB
	dc.l	$004203FC,$004203FC,$004203FC,$004203FD
	dc.l	$004303FD,$004303FD,$004303FE,$004303FE
	dc.l	$004303FE,$004303FE,$004303FF,$004403FF
	dc.l	$004403FF,$00440300,$00440300,$00440300
	dc.l	$00440300,$00440300,$00440300,$00450301
	dc.l	$F04B0000,$00450301
	dc.l	$F04B0000,$00450301
	dc.l	$F04B0000,$00450302
	dc.l	$F04B0000,$00450302
	dc.l	$F04B0000,$00450302
	dc.l	$F04B0000,$00450302
	dc.l	$F04B0000,$00450303
	dc.l	$F04B0000,$00450303
	dc.l	$F04B0000,$00450303
	dc.l	$F04B0000,$00460304
	dc.l	$F04B0000,$00460304
	dc.l	$F04B0000,$00460304
	dc.l	$F04B0000,$00460305
	dc.l	$F04B0000,$00460305
	dc.l	$F04B0000,$00460305
	dc.l	$F04B0000
	dc.l	$F0030000,$00460306
	dc.l	$80000000
off_2EA21C:
	dc.l	$F0020400,$00410000,$0042FDFA,$0042FDFB
	dc.l	$0042FDFB,$0042FDFB,$0042FDFC,$0042FDFC
	dc.l	$0042FDFC,$0042FDFD,$0043FDFD,$0043FDFD
	dc.l	$0043FDFE,$0043FDFE,$0043FDFE,$0043FDFE
	dc.l	$0043FDFF,$0044FDFF,$0044FDFF,$0044FD00
	dc.l	$0044FD00,$0044FD00,$0044FD00,$0044FD00,$0044FD00,$0045FD01
	dc.l	$F04B0000,$0045FD01
	dc.l	$F04B0000,$0045FD01
	dc.l	$F04B0000,$0045FD02
	dc.l	$F04B0000,$0045FD02
	dc.l	$F04B0000,$0045FD02
	dc.l	$F04B0000,$0045FD02
	dc.l	$F04B0000,$0045FD03
	dc.l	$F04B0000,$0045FD03
	dc.l	$F04B0000,$0045FD03
	dc.l	$F04B0000,$0046FD04
	dc.l	$F04B0000,$0046FD04
	dc.l	$F04B0000,$0046FD04
	dc.l	$F04B0000,$0046FD05
	dc.l	$F04B0000,$0046FD05
	dc.l	$F04B0000,$0046FD05
	dc.l	$F04B0000
	dc.l	$F0030000,$0046FD06
	dc.l	$80000000

off_2EF17C:
	dc.l	$003F00FA,$003F00FB,$003F00FB,$003F00FC
	dc.l	$003F00FC,$003F00FC,$003F00FD,$003F00FD
	dc.l	$003F00FD,$004000FE,$004000FE,$004000FE
	dc.l	$004000FE,$004000FF,$004000FF,$004000FF
	dc.l	$00410000,$00410000,$00410000,$00410000
	dc.l	$00410000,$00410000,$00420001,$00420001,$00420001
	dc.l	$F04B0000,$00420002
	dc.l	$F04B0000,$00420002
	dc.l	$F04B0000,$00420002
	dc.l	$F04B0000,$00420002
	dc.l	$F04B0000,$00430003
	dc.l	$F04B0000,$00430003
	dc.l	$F04B0000,$00430003
	dc.l	$F04B0000,$00430004
	dc.l	$F04B0000,$00430004
	dc.l	$F04B0000,$00430004
	dc.l	$F04B0000,$00430005
	dc.l	$F04B0000,$00430005
	dc.l	$F04B0000
	dc.l	$F0030000,$0043000A
	dc.l	$80000000
off_2EF32C:
	dc.l	$003F03FA,$003F03FB,$003F03FB,$003F03FC
	dc.l	$003F03FC,$003F03FC,$003F03FD,$003F03FD
	dc.l	$003F03FD,$004003FE,$004003FE,$004003FE
	dc.l	$004003FE,$004003FF,$004003FF,$004003FF
	dc.l	$00410300,$00410300,$00410300,$00410300
	dc.l	$00410300,$00410300,$00420301,$00420301,$00420301
	dc.l	$F04B0000,$00420302
	dc.l	$F04B0000,$00420302
	dc.l	$F04B0000,$00420302
	dc.l	$F04B0000,$00420302
	dc.l	$F04B0000,$00430303
	dc.l	$F04B0000,$00430303
	dc.l	$F04B0000,$00430303
	dc.l	$F04B0000,$00430304
	dc.l	$F04B0000,$00430304
	dc.l	$F04B0000,$00430304
	dc.l	$F04B0000,$00430305
	dc.l	$F04B0000,$00430305
	dc.l	$F04B0000
	dc.l	$F0030000,$0043030A
	dc.l	$80000000
off_2EF400:
	dc.l	$003FFDFA,$003FFDFB,$003FFDFB,$003FFDFC
	dc.l	$003FFDFC,$003FFDFC,$003FFDFD,$003FFDFD
	dc.l	$003FFDFD,$0040FDFE,$0040FDFE,$0040FDFE
	dc.l	$0040FDFE,$0040FDFF,$0040FDFF,$0040FDFF
	dc.l	$0041FD00,$0041FD00,$0041FD00,$0041FD00
	dc.l	$0041FD00,$0041FD00,$0042FD01,$0042FD01,$0042FD01
	dc.l	$F04B0000,$0042FD02
	dc.l	$F04B0000,$0042FD02
	dc.l	$F04B0000,$0042FD02
	dc.l	$F04B0000,$0042FD02
	dc.l	$F04B0000,$0043FD03
	dc.l	$F04B0000,$0043FD03
	dc.l	$F04B0000,$0043FD03
	dc.l	$F04B0000,$0043FD04
	dc.l	$F04B0000,$0043FD04
	dc.l	$F04B0000,$0043FD04
	dc.l	$F04B0000,$0043FD05
	dc.l	$F04B0000,$0043FD05
	dc.l	$F04B0000
	dc.l	$F0030000,$0043FD0A
	dc.l	$80000000


sub_11B256:	; 普通四招一式|偽連四招一式
	move.l	a3,-(sp)	; 我方OBJ
	move.l	a2,-(sp)	; 敵方OBJ
; 是否白虎神器中
	tst.b	(byte_810A06+3).l
	bne.s	loc_11B256
; 是否援軍夏侯淵
	movea.l	$54(a3),a0
	cmpi.b	#$11,1(a0)	; 夏侯淵[11]
	beq.s	loc_11B256
; 是否群雄模式
	tst.b	(ram_0006).l
	bne.s	loc_11B256
	jsr		$11A0BA		; 普通四招一式
	bra.s 	locret_11B256
loc_11B256:
	bsr.s	sub_121C1E	; 偽連四招一式
locret_11B256:
	addq.l	#8,sp
	rts

sub_121C1E:	; V205|偽連四招一式
	movem.l	d2-d7/a2-a4,-(sp)
	movea.l	$28(sp),a2
	movea.l	$2C(sp),a3
	moveq	#0,d7
	clr.w	d6
	tst.w	$6C(a2)
	beq.w	loc_121F92
	move.w	$C8(a2),d0
	cmp.w	$C8(a3),d0
	bne.s	loc_121C44
	moveq	#1,d3
	bra.s	loc_121C46
loc_121C44:
	clr.w	d3
loc_121C46:
	moveq	#2,d2
	moveq	#0,d4
	move.w	$52(a3),d4
	cmpi.w	#3,$50(a3)
	bne.w	loc_121E5A
	moveq	#8,d0
	cmp.l	d4,d0
	bne.w	loc_121CD8
	addq.w	#1,$176(a2)
	cmpi.w	#8,$50(a2)
	bne.s	loc_121C80
	cmpi.w	#5,$25A(a2)
	beq.s	loc_121C7C
	cmpi.w	#$F,$25A(a2)
	bne.s	loc_121C80
loc_121C7C:
	moveq	#$14,d2
	bra.s	loc_121C9E
loc_121C80:
	cmpi.w	#1,$CA(a2)
	bne.s	loc_121C94
	tst.w	d3
	beq.s	loc_121C90
	moveq	#$1B,d2
	bra.s	loc_121C9E
loc_121C90:
	moveq	#$1A,d2
	bra.s	loc_121C9E
loc_121C94:
	tst.w	d3
	beq.s	loc_121C9C
	moveq	#$C,d2
	bra.s	loc_121C9E
loc_121C9C:
	moveq	#2,d2
loc_121C9E:
	move.l	a2,-(sp)
	jsr		$12ED80
	addq.l	#4,sp
	movea.l	$54(a3),a0
	tst.b	$7A(a0)
	bne.w	loc_121EC4
	pea		($C).w
	pea		(3).w
	move.l	a3,-(sp)
	jsr		$15E152
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a3,-(sp)
	jsr		$15E2DA
	addq.l	#8,sp
	bra.w	loc_121EC4
loc_121CD8:
	moveq	#4,d0
	cmp.l	d4,d0
	bne.s	loc_121D2A
	addq.w	#1,$176(a2)
	cmpi.w	#8,$50(a2)
	bne.s	loc_121D00
	cmpi.w	#5,$25A(a2)
	beq.s	loc_121CFA
	cmpi.w	#$F,$25A(a2)
	bne.s	loc_121D00
loc_121CFA:
	moveq	#$14,d2
	bra.w	loc_121EC4
loc_121D00:
	cmpi.w	#1,$CA(a2)
	bne.s	loc_121D1E
	move.w	$C8(a2),d0
	cmp.w	$C8(a3),d0
	bne.s	loc_121D18
	moveq	#$1C,d2
	bra.w	loc_121EC4
loc_121D18:
	moveq	#$18,d2
	bra.w	loc_121EC4
loc_121D1E:
	tst.w	d3
	beq.w	loc_121EC2
	moveq	#$C,d2
	bra.w	loc_121EC4
loc_121D2A:
	move.l	a3,-(sp)
	jsr		$15E70E
	addq.l	#4,sp
	tst.l	d0
	beq.w	loc_121DCE
	addq.w	#1,$176(a2)
	moveq	#0,d0
	move.w	$46(a2),d0
	lsl.l	#3,d0
	movea.l	$5C(a2),a0
	add.l	4(a0),d0
	movea.l	d0,a4
	move.w	4(a4),d5
	andi.l	#$1FF,d5
	lsr.l	#1,d5
	cmpi.w	#8,$50(a2)
	bne.s	loc_121D7A
	cmpi.w	#5,$25A(a2)
	beq.s	loc_121D74
	cmpi.w	#$F,$25A(a2)
	bne.s	loc_121D7A
loc_121D74:
	moveq	#$14,d2
	bra.w	loc_121EC4
loc_121D7A:
	cmpi.w	#1,$CA(a2)
	bne.s	loc_121DC2
	tst.w	d3
	beq.s	loc_121DA4
	move.w	$106(a2),d0
	ext.l	d0
	move.w	$24(a2),d1
	ext.l	d1
	sub.l	d5,d1
	cmp.l	d1,d0
	bge.s	loc_121D9E
	moveq	#$A,d2
	bra.w	loc_121EC4
loc_121D9E:
	moveq	#$B,d2
	bra.w	loc_121EC4
loc_121DA4:
	move.w	$106(a2),d0
	ext.l	d0
	move.w	$24(a2),d1
	ext.l	d1
	sub.l	d5,d1
	cmp.l	d1,d0
	bge.s	loc_121DBC
	moveq	#0,d2
	bra.w	loc_121EC4
loc_121DBC:
	moveq	#1,d2
	bra.w	loc_121EC4
loc_121DC2:
	tst.w	d3
	beq.w	loc_121EC2
	moveq	#$C,d2
	bra.w	loc_121EC4
loc_121DCE:
	addq.w	#1,$176(a2)
	moveq	#0,d0
	move.w	$46(a2),d0
	lsl.l	#3,d0
	movea.l	$5C(a2),a0
	add.l	4(a0),d0
	movea.l	d0,a4
	move.w	4(a4),d5
	andi.l	#$1FF,d5
	lsr.l	#1,d5
	cmpi.w	#8,$50(a2)
	bne.s	loc_121E0E
	cmpi.w	#5,$25A(a2)
	beq.s	loc_121E08
	cmpi.w	#$F,$25A(a2)
	bne.s	loc_121E0E
loc_121E08:
	moveq	#$14,d2
	bra.w	loc_121EC4
loc_121E0E:
	cmpi.w	#1,$CA(a2)
	bne.s	loc_121E52
	tst.w	d3
	beq.s	loc_121E38
	move.w	$106(a2),d0
	ext.l	d0
	move.w	$24(a2),d1
	ext.l	d1
	sub.l	d5,d1
	cmp.l	d1,d0
	bge.s	loc_121E32
	moveq	#$A,d2
	bra.w	loc_121EC4
loc_121E32:
	moveq	#$B,d2
	bra.w	loc_121EC4
loc_121E38:
	move.w	$106(a2),d0
	ext.l	d0
	move.w	$24(a2),d1
	ext.l	d1
	sub.l	d5,d1
	cmp.l	d1,d0
	bge.s	loc_121E4E
	moveq	#0,d2
	bra.s	loc_121EC4
loc_121E4E:
	moveq	#1,d2
	bra.s	loc_121EC4
loc_121E52:
	tst.w	d3
	beq.s	loc_121EC2
	moveq	#$C,d2
	bra.s	loc_121EC4
loc_121E5A:
	addq.w	#1,$176(a2)
	moveq	#0,d0
	move.w	$46(a2),d0
	lsl.l	#3,d0
	movea.l	$5C(a2),a0
	add.l	4(a0),d0
	movea.l	d0,a4
	move.w	4(a4),d5
	andi.l	#$1FF,d5
	lsr.l	#1,d5
	cmpi.w	#8,$50(a2)
	bne.s	loc_121E98
	cmpi.w	#5,$25A(a2)
	beq.s	loc_121E94
	cmpi.w	#$F,$25A(a2)
	bne.s	loc_121E98
loc_121E94:
	moveq	#$14,d2
	bra.s	loc_121EC4
loc_121E98:
	cmpi.w	#1,$CA(a2)
	bne.s	loc_121EBA
	move.w	$106(a2),d0
	ext.l	d0
	move.w	$24(a2),d1
	ext.l	d1
	sub.l	d5,d1
	cmp.l	d1,d0
	bge.s	loc_121EB6
	moveq	#0,d2
	bra.s	loc_121EC4
loc_121EB6:
	moveq	#1,d2
	bra.s	loc_121EC4
loc_121EBA:
	tst.w	d3
	beq.s	loc_121EC2
	moveq	#$C,d2
	bra.s	loc_121EC4
loc_121EC2:
	moveq	#2,d2
loc_121EC4:
	clr.w	$CC(a3)
	cmpi.w	#5,$1D2(a2)
	bcs.s	loc_121EE0
	clr.w	$1D2(a2)
	tst.w	d3
	beq.s	loc_121EDC
	moveq	#$C,d2
	bra.s	loc_121EDE
loc_121EDC:
	moveq	#2,d2
loc_121EDE:
	moveq	#1,d7
loc_121EE0:
	cmpi.w	#1,$176(a2)
	bne.s	loc_121EEE
	move.l	8(a2),$178(a2)
loc_121EEE:
	move.l	8(a2),d0
	sub.l	$178(a2),d0
	moveq	#$78,d1
	cmp.l	d0,d1
	bhi.s	loc_121F06
	move.l	8(a2),$178(a2)
	clr.w	$176(a2)
loc_121F06:
	moveq	#8,d0
	cmp.l	d4,d0
	beq.s	loc_121F16
	moveq	#4,d0
	cmp.l	d4,d0
	beq.s	loc_121F16
	tst.l	d4
	bne.s	loc_121F1E
loc_121F16:
	cmpi.w	#3,$176(a2)
	bcc.s	loc_121F2C
loc_121F1E:
	cmpi.w	#9,$1A0(a3)
	bcs.s	loc_121F38
	moveq	#2,d0
	cmp.l	d4,d0
	blt.s	loc_121F38
loc_121F2C:
	tst.w	d3
	beq.s	loc_121F34
	moveq	#$C,d2
	bra.s	loc_121F48
loc_121F34:
	moveq	#2,d2
	bra.s	loc_121F48
loc_121F38:
	moveq	#8,d0
	cmp.l	d4,d0
	beq.s	loc_121F4C
	moveq	#4,d0
	cmp.l	d4,d0
	beq.s	loc_121F4C
	tst.l	d4
	beq.s	loc_121F4C
loc_121F48:
	clr.w	$176(a2)
loc_121F4C:
	tst.w	$C6(a2)
	beq.s	loc_121F6C
	move.w	$C8(a2),d0
	cmp.w	$C8(a3),d0
	bne.s	loc_121F6C
	moveq	#0,d0
	move.w	$C8(a2),d0
	subq.l	#1,d0
	moveq	#0,d0
	addx.l	d0,d0
	move.w	d0,$C8(a2)
loc_121F6C:
	move.w	d2,d0
	move.l	d0,-(sp)
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$10EBDE
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$10EF18
	addq.l	#8,sp
	move.w	d7,$174(a2)
	moveq	#1,d6
loc_121F92:
	move.w	d6,d0
	movem.l	(sp)+,d2-d7/a2-a4
	rts


dword_268038:	; 馬超普攻四式|重砍
	dc.l	$F00E0000	; 加速
	dc.l	$F0540900
	dc.l	$F04F1501
	dc.l	$F0450300
	dc.l	$F0580100
	dc.l	$F0020200,$009A0000
	dc.l	$F0020500,$009C0000
	dc.l	$F00BEF00,$01F30000
	dc.l	$F00BFF00,$02C3F830,$009D0000,$209E0000
	dc.l	$F00E0100	; 減速
	dc.l	$F0020100,$209F0000
	dc.l	$F0020100,$00A00000
	dc.l	$F0020100,$00A10000
	dc.l	$F0020400,$00A20000
	dc.l	$F0020100,$00A30000,$00A40000
	dc.l	$F0020100,$00A40000
	dc.l	$80000000


sub_157A4C:
	move.w	($D00012).l,d7	; 是否動作指令技
	tst.w	d7
	beq.w	loc_157B26
	move.l	$200(a2),a0		; 道具欄基址
	tst.b	(a0)			; 是否打開
	bne.w	loc_157B26
; 是否消耗技能
	tst.w	$BE(a2)			; 是否換將狀態
	bne.w	loc_157AE2
	movea.l	$58(a2),a0
	move.b	1(a0),d0		; 角色編號
	andi.l	#$FF,d0
	mulu.w	#$14,d0			; 每角色偏移$14
	add.w	$1B6(a2),d0
	subi.l	#$1E,d0			; [061E]開始
	movea.l	#byte_1F1776,a0	; 指令對應道具表
	move.b	(a0,d0.w),d6
	andi.l	#$FF,d6			; 消耗技能編號
	move.l	d6,d0
	moveq	#$16,d1
	cmp.l	d1,d0
	bhi.w	loc_157AE2
	add.l	d0,d0
	move.w	jpt_157A7E(pc,d0.l),d0
	jmp		jpt_157A7E(pc,d0.w)
jpt_157A7E:
	dc.w	loc_157A7E-jpt_157A7E	; A鍵
	dc.w	loc_157A7F-jpt_157A7E,loc_157A7F-jpt_157A7E,loc_157A7F-jpt_157A7E,loc_157A7F-jpt_157A7E,loc_157A7F-jpt_157A7E	; D鍵
	dc.w	loc_157A80-jpt_157A7E,loc_157A80-jpt_157A7E,loc_157A80-jpt_157A7E,loc_157A80-jpt_157A7E,loc_157A80-jpt_157A7E,loc_157A80-jpt_157A7E,loc_157A80-jpt_157A7E	; C鍵
	dc.w	loc_157A81-jpt_157A7E,loc_157A81-jpt_157A7E,loc_157A81-jpt_157A7E,loc_157A81-jpt_157A7E,loc_157A81-jpt_157A7E,loc_157A81-jpt_157A7E,loc_157A83-jpt_157A7E,loc_157A81-jpt_157A7E,loc_157A82-jpt_157A7E,loc_157A81-jpt_157A7E	; B鍵
loc_157A7E:	; 必殺技能
	cmpi.w	#$29,$1B6(a2)
	bcs.w	loc_157AE2
	btst	#0,(ram_0007).l	; 是否開啟A鍵指令
	beq.w	loc_157B26
	bra.w	loc_157AE2
loc_157A83:	; 策略計謀|水攻計$13
	cmpi.b	#7,($8182F9).l
	bne.s	loc_157A81
	cmpi.b	#1,($8182FA).l
	bne.s	loc_157A81
	bra.w	loc_157ACF
loc_157A82:	; 恐嚇計$15
	jsr		$12571C.l		; 敵將是否在場
	tst.l   d0
	beq.w 	loc_157ACF
loc_157A81:	; 策略計謀
	btst	#1,(ram_0007).l	; 是否開啟B鍵指令
	beq.w	loc_157B26
	btst	#3,$1C(a3)		; 避免[→B]串招
	bne.w	loc_157B26
	btst	#4,$1C(a3)		; 避免[←B]串招
	bne.w	loc_157B26
	bra.s	loc_157A88
loc_157A80:	; 魔法技能
	btst	#2,(ram_0007).l	; 是否開啟C鍵指令
	beq.w	loc_157B26
	tst.w	($80D03A).l		; 魔法是否冷卻
	bne.s 	loc_157ACF
	bset	#1,($80D03A).l	; 標記指令冷卻
	bra.s	loc_157A88
loc_157A7F:	; 超必殺技
	btst	#3,(ram_0007).l	; 是否開啟D鍵指令
	beq.w	loc_157B26
loc_157A88:
; 消耗道具士氣
	tst.w	($80D030).l
	beq.s	loc_157B04
	tst.b	(byte_810A06).l	; 青龍神器開關
	bne.s	loc_157A89
	pea		(1).w			; [1]
	move.l	d6,-(sp)
	move.l	a2,-(sp)
	jsr		$126674			; 消耗道具數目
	lea		$C(sp),sp
	tst.l	d0
	beq.s	loc_157ACE
loc_157A89:
	move.l	a2,-(sp)
	jsr		$11EA2E			; 是否士氣最大
	addq.l	#4,sp
	move.w	d0,($81A22C).l	; 士氣標記
	bra.s	loc_157AE2
loc_157ACE:
; 技能使用失敗
	bclr	#1,($80D03A).l	; 重置指令冷卻
loc_157ACF:
	move.l	a2,-(sp)
	jsr		$125784
	addq.l	#4,sp
	tst.w	$24(a2)
	bne.s	loc_157B04
	clr.l	-(sp)
	bra.s	loc_157AE8
loc_157AE2:
; 技能正常使用
	move.w	$1B6(a2),d0
	move.l	d0,-(sp)
loc_157AE8:
	pea		(6).w			; 06类动作
	move.l	a2,-(sp)
	jsr		$15E152			; 計算動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	addq.l	#8,sp
loc_157B04:
	moveq	#0,d0
	move.b	1(a3),d0
	move.w	d0,($D00002).l
	move.w	$1B6(a2),($D00004).l
	pea		($36).w
	jsr		$13A27E			; ARM 加密運算
	addq.l	#4,sp
	movea.l	#$1581CA,a0
	bra.w	locret_157B26
loc_157B26:
	movea.l	#$157B26,a0
locret_157B26:
	rts

byte_1F1776:
	*		061E|1F	|20	|21	|22	|23	|24	|25	|26	|27	|28	|29	|2A	|2B	|2C	|2D	|2E	|2F	|30
	dc.b	0,  0,  0,  0,  $01,$03,$02,0,  0,  0,  0,  0,  0,  $12,0,  0,  0,  0,  0,  0	; 關羽
	dc.b	0,  0,  0,  0,  $01,$03,$04,$02,$05,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0	; 張飛
	dc.b	0,  0,  0,  0,  $01,$02,0,  0,  $03,0,  0,  0,  $10,0,  0,  0,  0,  0,  0,  0	; 趙雲
	dc.b	0,  0,  0,  0,  $01,0,  $03,0,  $02,0,  0,  0,  0,  $11,0,  0,  0,  0,  0,  0	; 黃忠
	dc.b	0,  0,  0,  0,  0,  $01,$02,0,  0,  0,  0,  0,  $12,$0D,$0E,0,  0,  0,  0,  0	; 馬超
	dc.b	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $14,$16,$13,$0F,$0A,$06,0	; 孔明
	dc.b	0,  0,  0,  0,  $01,$03,$04,$02,0,  0,  $02,0,  $08,$0B,0,  0,  0,  0,  0,  0	; 貂蟬
	dcb.b	$14,0
	dc.b	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $15,$0E,$0A,$0B,$09,$0C,0	; 龐統
	dc.b	0,  0,  0,  0,  0,  0,  $02,$01,$03,0,  0,  0,  0,  0,  $10,0,  0,  0,  0,  0	; 孫權


sub_17193A:	; 區分滿氣策略魔法
	move.l  A2, -(A7)
	tst.w	($81A22C).l		; 是否滿氣
	beq.s	locret_171954
	movea.l $8(A7), A2
	move.l	$C(A7), D0		; 滿氣動作偏移量
	move.w	D0, ($44,A2)	; 滿氣則執行開始地址偏移(lsl #2, D0)的代碼
locret_171954:
	movea.l (A7)+, A2
	rts


sub_173694:
	movea.l	4(sp),a0
; 是否空中危險迴避技
    cmpi.w  #4,$50(a0)
    beq.s   loc_173694
; 高度過低則正常落地
	move.w	$24(a0),d0
	ext.l	d0
	moveq	#$FFFFFFCE,d1
	cmp.l	d0,d1
	bge.s	locret_1736AE
loc_173694:
	move.b	$B(sp),d0   ; 正常落地
	ext.w	d0
	move.w	d0,$44(a0)
locret_1736AE:
	rts

off_252CE2:	; 關羽空擊並速降
	dc.l	$F0540A00
	dc.l	$F04F1100
	dc.l	$F007001A,sub_173694	; 高度太低則正常落地
; 快速落地
	dc.l	$F00BEF00,$01B60000	; 口頭禪
	dc.l	$01190206,$F04B0000	; F04B|低於則恢復默認高度
	dc.l	$011A0206,$F04B0000
	dc.l	$F0410100,$F0550100,$F0450900	; 敵人被打動作|09
	dc.l	$F0280600,$211B0A06,$F04B0000,$F0290000	; 空中攻擊
	dc.l	$F0030000,$00400A0A	; 空擊速降
	dc.l	$F0140000,$FFFB0100	; 著陸
	dc.l	$F0020300,$00410200
	dc.l	$F0020800,$00420100
	dc.l	$80000000
; 正常落地
	dc.l	$F0030000,$011B0506
	dc.l	$F0140000,$FFFB0100
	dc.l	$F0020300,$00400300	; 著陸
	dc.l	$F0020300,$00410200
	dc.l	$F0020800,$00420100
	dc.l	$80000000

off_2C6BF2:	; 狂龍逆轉
	dc.l	$F0540500
	dc.l	$F04F2E01
	dc.l	$F0580100,$00EA0000
	dc.l	$F00BEF00,$01B60000
	dc.l	$F0410100,$20EB0000
	dc.l	$F0410100,$20ED1400
	dc.l	$F0540200
	dc.l	$F0410100,$00EF1400
	dc.l	$F0410100,$20F11400
	dc.l	$F0410100,$20F31400
	dc.l	$F0450200	; 擊打浮空
	dc.l	$F0410100,$20F51400
	dc.l	$F00BEF00,$02C00000
	dc.l	$F061FE00,$00252B56,$00000000	; 刀風
	dc.l	$00F90000,$00FB0000,$00FD0000
	dc.l	$F00E0100,$20FF0000,$01010000,$01030000
	dc.l	$F0020200,$21040000,$01050000,$01060000
	dc.l	$80000000

off_25325E:	; 關羽火獸陣
	dc.l	$F00E0000
	dc.l	$F04F0E00
	dc.l	$F0020200,$006B0000
	dc.l	$F0020500,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F0140336,$003C01C2
	dc.l	$F00B8F00,$02880000
	dc.l	$F0130100
	* dc.l	$F01A0000,$003500CE,$006E0000	; 取消調用當前選中道具 $F01A0000
	dc.l	$F007001F,sub_17193A,$006E0000	; 耗氣則跳到跳到滿氣地址
	dc.l	$F0070000,$0011FA98,$006E0000	; 火獸陣開關？
	dc.l	$F0070000,$0011F74C,$006E0000	; 火獸陣定義 $11F74C
	dc.l	$F007000F,$0011F74C
	dc.l	$F0020E00,$006E0000
	dc.l	$F0020100,$006F0000
	dc.l	$F0020200,$00700000
	dc.l	$80000000
	dc.l	$F0070000,$0011FA98,$006E0000
	dc.l	$F0070000,$0011F8EE,$006E0000	; 滿氣火獸陣
	dc.l	$F007000F,$0011F8EE,$006E0000	; 火獸2
	dc.l	$F0070016,$0011F8EE	; 火獸3
	dc.l	$F0020D00,$006E0000
	dc.l	$F0020100,$006F0000
	dc.l	$F0020200,$00700000
	dc.l	$80000000


dword_2544E6:	; 關羽狂龍旋舞
	dc.l	$F0540000
	dc.l	$F04F1C01
	dc.l	$F0450300
	dc.l	$F0020200,$00E10000
	dc.l	$F0130100
	dc.l	$F061FE00,$00253B5C,$0000FFA8
	dc.l	$F0020400,$00E20000
	dc.l	$F061FE00,$00254472,$00000000
	dc.l	$F0020100,$00E40000
	dc.l	$F00BEF00,$01B90000
	dc.l	$F0020100,$00E60000,$00E80000
	dc.l	$F00E0000
	dc.l	$F0280800
	dc.l	$F0070000,$00171C44,$00E20000,$20E20000	; 風眼
	dc.l	$F0070000,$00171C44,$00E20000,$20E40000	;
	dc.l	$F0070000,$00171C44,$00E40000,$20E40000	;
	dc.l	$F0070001,$00171C44,$00E60000,$20E60000	;
	dc.l	$F0070000,$00171C44,$00E60000,$20E80000	;
	dc.l	$F0070000,$00171C44,$00E80000,$20E80000	; 風眼
	dc.l	$F0290000
	dc.l	$F00E0200,$00E20000,$00E40000
	dc.l	$F0020100,$00E60000
	dc.l	$F0020100,$00E80000
	dc.l	$F0130000
	dc.l	$F0020400,$00E20000
	dc.l	$F0020200,$00E10000
	dc.l	$80000000


off_2CCFEC:
	dc.l	$F0540300	; F054 打擊節奏
	dc.l	$F04F2800,$00D60000
	dc.l	$F0070000,sub_18AFD8,$00D71100,$20D80200	; 餓虎撲羊的語音 $171FB0
	dc.l	$F0540200
	dc.l	$F0450800	; F045 浮空效果：浮空后倒地
	dc.l	$F0410100,$20D90200	; F041 招式最大連擊數
	dc.l	$F0410100,$20DA0200	; 20攻擊判定DA圖片地址
	dc.l	$F0580100	; F058 招式可取消
	dc.l	$F0410100,$20DB0200
	dc.l	$F00E0100	; F00E 出招快慢
	dc.l	$F0410100,$20DC0600
	dc.l	$F0410100,$20DC0800
	dc.l	$F00E0200
	dc.l	$F00B5F00,$02CF05DC	; F00B 聲音
	dc.l	$F01000FE
	dc.l	$F014000B,$00380100	; F014 附帶效果：灰塵等等
	dc.l	$F0410100,$20DD0A00
	dc.l	$F0100002,$00DE0000,$00DF0000,$00E00000,$00E00000,$00E00000,$00E00000,$00010000	; F010 地震效果(無判定)
	dc.l	$80000000

off_2CE0BC:
	dc.l	$F0540800
	dc.l	$F04F2001
	dc.l	$F0450700
	dc.l	$F0580100
	dc.l	$F00E0100,$010A0000
	dc.l	$F00E0200
	dc.l	$F0070000,sub_18AFD8,$010B0000
	dc.l	$F0020300,$010C0000,$010D0000
	dc.l	$F00E0000,$010E0000,$010E0000
	dc.l	$F0150400,off_25936A,$004B0100,$010E0000
	dc.l	$F0140317,$001E01F8
	dc.l	$F00E0100
	dc.l	$F0100001,$010F0000
	dc.l	$F01000FF,$210F0000
	dc.l	$F00E0200,$010F0000
	dc.l	$F0020200,$01100000,$010E0000
	dc.l	$80000000

sub_18AFD8:	; 龍擺尾|猛虎錘口頭禪音頻
	pea		($7F).w
	jsr		$1024B0
	addq.l	#4,sp
	moveq	#$33,d1
	cmp.l	d0,d1
	ble.w	locret_18B0BA
	jsr		$12D4B4
	tst.l	d0
	beq.w	locret_18B0BA
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_18B010
	subi.b	#$40,($81B4C4).l
loc_18B010:
	move.l	($81B4C0).l,d0
	addq.l	#1,d0
	cmp.l	($81B4BC).l,d0
	bge.w	locret_18B0BA
	jsr		$13A578
	pea		(1).w
	moveq	#0,d0
	move.b	($81B4C4).l,d0
	lsl.l	#2,d0
	ori.l	#$4EFC401,d0	; 音頻代碼
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_18B074
	move.l	($81B4A8).l,($81B4B0).l
loc_18B074:
	pea		(1).w
	clr.l	-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	lea		$18(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_18B0B4
	move.l	($81B4A8).l,($81B4B0).l
loc_18B0B4:
	jsr		$13A58E
locret_18B0BA:
	rts

off_25936A:
	dc.l	$00259332,$002545DA,$002545DE,$002545E0
	dc.l	$003327FA,$000505E9,$090E0420,$00000000
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$0000062A
	dc.l	$00000000,$00000000,$00000000,sub_17A0E8
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00002400,$00000000,$00000000

sub_17A0E8:
	link    A6, #$0
	movea.l $8(A6), A1
	movea.l $c(A6), A0
	move.w  $5c(A0), D0
	cmp.w   $c8(A1), D0
	beq.s   loc_17A104
	pea     $7.w	; 正面浮空
	bra.s   loc_17A108
loc_17A104:
	pea     $c.w	; 反身浮空
loc_17A108:
	pea     $8.w
	move.l  A1, -(A7)
	jsr     $15e152.l
	unlk    A6
	rts


off_2D1A26:
	dc.l	$F0020500,$00390600
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020500,$003A0600
	dc.l	$F00E0100
	dc.l	$F0541000
	dc.l	$F04F1301
	dc.l	$F0450C00	; 反向浮空
	dc.l	$F0580100	; F0580103 導致死機$13A3BC(A27:%04x,%04x,%x)
	dc.l	$F0020100,$00AB0000,$00AC0A00,$00AC0800,$00AC0600,$00AC0400
	dc.l	$F00BEF00,$01D70000
	dc.l	$F00BFF00,$02C3F830,$20AD0000,$00AE0000,$00AF0000,$00B00000
	dc.l	$F0020100,$00970000
	dc.l	$80000000

off_25E1F4:	; 趙雲長槍陣
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F0020200,$00760000
	dc.l	$F0140336,$006E00C8
	dc.l	$F00B8F00,$02880000
	dc.l	$F007001E,sub_17193A	; 是否耗氣
	dc.l	$F0070000,$0011EF78,$007A0000
	dc.l	$F0070000,$0011EBC2,$007A0000
	dc.l	$F0070000,$0011EBC2,$007A0000
	dc.l	$F0070000,$0011EBC2,$007B0000
	dc.l	$F0070000,$0011EBC2,$007B0000
	dc.l	$F0020200,$007C0000
	dc.l	$F0020100,$00760000
	dc.l	$80000000
	dc.l	$F0070000,$0011EF78,$007A0000
	dc.l	$F0070000,$0011ED2A,$007A0000	; 滿氣長槍陣
	dc.l	$F0070000,$0011ED2A,$007A0000
	dc.l	$F0070000,$0011ED2A,$007B0000,$007B0000
	dc.l	$F0020200,$007C0000
	dc.l	$F0020100,$00760000
	dc.l	$80000000


off_26307E:	; 黃忠空擊並速降
	dc.l	$F0540A00
	dc.l	$F04F1100
	dc.l	$F0070017,sub_173694	; 高度太低則正常落地
; 快速落地
	dc.l	$00460206,$F04B0000	; F04B|低於則恢復默認高度
	dc.l	$00470206,$F04B0000
	dc.l	$F0070000,$00172634	; 口頭禪
	dc.l	$F0550100,$F0450800	; 敵人被打動作|08
	dc.l	$F0280600,$20480A06,$F04B0000,$F0290000	; 空中攻擊
	dc.l	$F0030000,$20490A0A	; 快速落地
	dc.l	$F0140009,$00000100
	dc.l	$F0020300,$00420000	; 著陸
	dc.l	$80000000
; 正常落地
	dc.l	$F0030000,$0043020A
	dc.l	$F0140009,$00000100
	dc.l	$F0020300,$00420000	; 著陸
	dc.l	$80000000

off_2D857A:
	dc.l	$F0540800
	dc.l	$F04F1300
	dc.l	$F0580100
	dc.l	$F0450300
	dc.l	$F0020300,$00330A00
	dc.l	$F00B3F00,$02BE03E8
	dc.l	$F0140008,$00000100
	dc.l	$F0020300,$00340A00
	dc.l	$F0070000,$00172634
	dc.l	$00B20A00,$00B20800,$00B20700,$00B30600,$00B30400,$20B30300
	dc.l	$F0020300,$20B30200
	dc.l	$F04F1200
	dc.l	$F0410100,$20860100
	dc.l	$F0410100,$20870100
	dc.l	$20870100,$008A0000,$008A0000,$008A0000,$008A0000
	dc.l	$F0020C00,$008A0000
	dc.l	$F0020300,$008B0000
	dc.l	$F0020400,$008C0000
	dc.l	$80000000

off_26324E:	; 黃忠連弩陣
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F0020200,$005F0000
	dc.l	$F0020200,$00600000
	dc.l	$F0140336,$005A01D8
	dc.l	$F00B8F00,$02880000
	dc.l	$F0070020,sub_17193A
	dc.l	$F0070000,$0011F592,$00610000
	dc.l	$F0070000,$0011F128,$00610000
	dc.l	$F0070000,$0011F128,$00610000
	dc.l	$F0070000,$0011F128,$00610000
	dc.l	$F0070000,$0011F128,$00610000
	dc.l	$F0020100,$00620000
	dc.l	$F0020100,$00630000
	dc.l	$80000000
	dc.l	$F0070000,$0011F592,$00610000
	dc.l	$F0070000,$0011F2D4,$00610000	; 滿氣連弩陣
	dc.l	$F0070000,$0011F2D4,$00610000
	dc.l	$F0070000,$0011F2D4
	dc.l	$F0130100,$00610000,$00610000,$00620000,$00630000
	dc.l	$80000000


sub_18BBD0:	; $17315A|v100
	movea.l	4(sp),a0
	movea.l	$F8(a0),a1
	btst	#2,$1C(a1)	; 按A觸發下一動作
	beq.s	locret_18BBEA
	move.b	$B(sp),d0	; 偏移量[F00700XX]
	ext.w	d0
	add.w	d0,$44(a0)
locret_18BBEA:
	rts

off_2DCDAA:	; 躍馬蹬空騎射
	dc.l	$F0540400	; 硬直減半
	dc.l	$F04F2A01
	dc.l	$F0451100
	dc.l	$F0130100	; 小無敵
	dc.l	$F0030000,$20400B08	; 落地定義
	dc.l	$F0130000
	dc.l	$F0020200,$003D0800
	dc.l	$F0070013,sub_18BBD0	; 按A跳過
	dc.l	$F0580100	; 滑行撞擊
	dc.l	$F014000B,$004E0100	; 地上灰塵
	dc.l	$20401400,$20400800,$20400800,$20400800
	dc.l	$20400800,$20400800,$20400800,$20400800,$20400800
	dc.l	$F0020200,$003F0600
	dc.l	$F0020200,$003F0400
	dc.l	$F0020200,$003F0400
	dc.l	$80000000
	dc.l	$F0020300,$007F0000,$00B20A00,$00B20A00,$00B208F8	; 躍馬蹬
	dc.l	$F0070000,sub_18BBEC,$00B208FA,$00B208FB,$00B206FC,$00B206FD,$00B206FE,$00B206FF
	dc.l	$F0020300,$004304FF
	dc.l	$F0020300,$004402FF
	dc.l	$F0110000	; 轉身
	dc.l	$F0020300,$00BC0000	; 空騎射
	dc.l	$F0020100,$00BD0000
	dc.l	$F015FE00,$0026A0A0,$FFF500C2	; F015FE00[15定義氣功|00表示反向]
	dc.l	$F0020100,$00BD0000
	dc.l	$F0020100,$00BE0000
	dc.l	$F015FE00,$0026A0A0,$FFF500DB	; [0026A0A0]飛鏢圖
	dc.l	$F0020100,$00BF0000
	dc.l	$F0020100,$00BD0000
	dc.l	$F015FE00,$0026A0A0,$FFF500CC
	dc.l	$F0020100,$00BE0000
	dc.l	$F0020100,$00BF0000
	dc.l	$F015FE00,$0026A0A0,$FFF500E5
	dc.l	$F0020100,$00BD0000
	dc.l	$F0020100,$00BE0000
	dc.l	$F015FE00,$0026A0A0,$FFF500D6
	dc.l	$F0020100,$00BF0000
	dc.l	$F015FE00,$0026A0A0,$FFF500C7
	dc.l	$F0020300,$00BC0000,$00450001,$00450002,$00450003,$00450004,$00450004,$00460005,$00460005
	dc.l	$F0030000,$00460006
	dc.l	$F0140009,$00000100
	dc.l	$F0020300,$00470000
	dc.l	$F0020500,$00480000
	dc.l	$80000000

sub_18BBEC:	; 躍馬蹬口頭禪音頻
	pea		($7F).w
	jsr		$1024B0
	addq.l	#4,sp
	moveq	#$4C,d1
	cmp.l	d0,d1
	ble.w	locret_18BCCE
	jsr		$12D4B4
	tst.l	d0
	beq.w	locret_18BCCE
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_18BC24
	subi.b	#$40,($81B4C4).l
loc_18BC24:
	move.l	($81B4C0).l,d0
	addq.l	#1,d0
	cmp.l	($81B4BC).l,d0
	bge.w	locret_18BCCE
	jsr		$13A578
	pea		(1).w
	moveq	#0,d0
	move.b	($81B4C4).l,d0
	lsl.l	#2,d0
	ori.l	#$4EFF401,d0	; 音頻代碼
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_18BC88
	move.l	($81B4A8).l,($81B4B0).l
loc_18BC88:
	pea		(1).w
	clr.l	-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	lea		$18(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_18BCC8
	move.l	($81B4A8).l,($81B4B0).l
loc_18BCC8:
	jsr		$13A58E
locret_18BCCE:
	rts

off_121AC4:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F0070000,$00121AC4	; 落石陣
	dc.l	$F0020100,$00170000
	dc.l	$F0020200,$00180000
	dc.l	$F0140336,$006400C8
	dc.l	$F00B8F00,$02880000
	dc.l	$F0280100
	dc.l	$F0020200,$006B0000
	dc.l	$F0020200,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F0020200,$006E0000
	dc.l	$F0290000
	dc.l	$80000000

off_122992:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F0070000,$00122992	; 滾石陣
	dc.l	$F0020100,$00170000
	dc.l	$F0020200,$00180000
	dc.l	$F0140336,$006400C8
	dc.l	$F00B8F00,$02880000
	dc.l	$F0280100
	dc.l	$F0020200,$006B0000
	dc.l	$F0020200,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F0020200,$006E0000
	dc.l	$F0290000
	dc.l	$80000000

off_26932E:	; 馬超火獸陣
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F0020100,$00170000
	dc.l	$F0020200,$00180000
	dc.l	$F0140336,$006400C8
	dc.l	$F00B8F00,$02880000
	dc.l	$F007001C,sub_17193A	; 是否滿氣
	dc.l	$F0070000,$0011FA98,$006B0000
	dc.l	$F0070000,$0011F74C,$006B0000
	dc.l	$F007000F,$0011F74C,$006B0000
	dc.l	$F0020200,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F0020200,$006E0000
	dc.l	$80000000
	dc.l	$F0070000,$0011FA98,$006B0000
	dc.l	$F0070000,$0011F8EE,$006B0000
	dc.l	$F007000F,$0011F8EE,$006B0000
	dc.l	$F0070016,$0011F8EE
	dc.l	$F0020200,$006C0000
	dc.l	$F0020200,$006D0000
	dc.l	$F0020200,$006E0000
	dc.l	$80000000


off_26F320:	; 孔明空擊並速降
	dc.l	$F00E0000
	dc.l	$F0540300
	dc.l	$F04F2701
	dc.l	$F0070022,sub_173694	; 高度太低則正常落地
; 快速落地
	dc.l	$F0020300,$008C0000,$F04B0000	; F04B|低於則恢復默認高度
	dc.l	$F0020200,$008D0000,$F04B0000
	dc.l	$F00BAF00,$02C2F830	; 口頭禪
	dc.l	$F0550100,$F0451F00	; 敵人被打動作|1F
	dc.l	$F0020200,$208E0A06,$F04B0000	; 空中攻擊
	dc.l	$F0020200,$208F0A06,$F04B0000
	dc.l	$F0020200,$20900A06,$F04B0000
	dc.l	$F0020200,$20910A06,$F04B0000
	dc.l	$F0030000,$20920A0A	; 速降
	dc.l	$F0140009,$00000100
	dc.l	$F0020200,$00500000	; 著陸
	dc.l	$80000000
; 正常落地
	dc.l	$F0030000,$00500404
	dc.l	$F0140009,$00000100
	dc.l	$F0020200,$00500000	; 著陸
	dc.l	$80000000

off_2E38C2:	; 朝哥
	dc.l	$F0540600
	dc.l	$F0450700
	dc.l	$F04F2E00
	dc.l	$F0410100
	dc.l	$F0020400,$20AC0000
	dc.l	$F00BBF00,$02821388
	dc.l	$F0410100
	dc.l	$F0130100	; 無敵
	dc.l	$F0140314,$00000100,$20AD00FE
	dc.l	$F0020500,$20AD0000,$20AE00FE
	dc.l	$F0020500,$20AE0000
	dc.l	$F00BBF00,$02821388
	dc.l	$F0410100
	dc.l	$F0140314,$00000100,$20AF00FF
	dc.l	$F0020500,$20AF0000,$20B000FF
	dc.l	$F0020500,$20B00000
	dc.l	$F00BBF00,$02821388
	dc.l	$F0410100
	dc.l	$F0140314,$00000100,$20AD0001
	dc.l	$F0020500,$20AD0000,$20AE00FF
	dc.l	$F0020500,$20AE0000
	dc.l	$F0410100
	dc.l	$F0030000,$20AE0002
	dc.l	$F0020300,$20AC0000
	dc.l	$80000000


off_26E90A:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00
	dc.l	$F0070000,$00120E02	; 八陣圖
	dc.l	$F0020300,$00AC0000
	dc.l	$F0140337,$FFFD0099
	dc.l	$F00B8F00,$02890000
	dc.l	$F007004A,$00120D56,$00AD0000
	dc.l	$F0070048,$00120D56,$00AD0000
	dc.l	$F0070046,$00120D56,$00AE0000
	dc.l	$F0070044,$00120D56,$00AE0000
	dc.l	$F0070042,$00120D56,$00AF0000
	dc.l	$F0070040,$00120D56,$00AF0000
	dc.l	$F007003E,$00120D56,$00B00000
	dc.l	$F007003C,$00120D56,$00B00000
	dc.l	$F0020200,$00AD0000
	dc.l	$F0020200,$00AE0000
	dc.l	$F0020200,$00AF0000
	dc.l	$F0020200,$00B00000
	dc.l	$F0280400
	dc.l	$F0020200,$00AD0000
	dc.l	$F0020200,$00AE0000
	dc.l	$F0020200,$00AF0000
	dc.l	$F0020200,$00B00000
	dc.l	$F0290000
	dc.l	$80000000

off_26E8AE:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00
	dc.l	$F0020200,$00B10000
	dc.l	$F0140334,$001600AD
	dc.l	$F00B8F00,$02870000
	dc.l	$F0070000,$00122336	; 落雷術
	dc.l	$F0280200
	dc.l	$F0020200,$00B20000
	dc.l	$F0020200,$00B30000
	dc.l	$F0020200,$00B40000
	dc.l	$F0020200,$00B50000
	dc.l	$F0290000
	dc.l	$80000000

off_26E9E6:	; 孔明天燈陣
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00,$005F0000
	dc.l	$F0020300,$00600000
	dc.l	$F0020100,$00610000
	dc.l	$F0140336,$003C01CC
	dc.l	$F00B8F00,$02880000
	dc.l	$F0070000,$00122076,$005C0000	; 天燈陣
	dc.l	$F007000A,$00121F84,$005C0000
	dc.l	$F007000E,$00121F84,$005C0000
	dc.l	$F0070012,$00121F84,$005C0000
	dc.l	$F0070021,sub_17193A
	dc.l	$F0020700,$005C0000
	dc.l	$F0020100,$005D0000
	dc.l	$F0020100,$005E0000
	dc.l	$80000000
	dc.l	$F0070016,$00121F84,$005C0000
	dc.l	$F007001A,$00121F84
	dc.l	$F0020600,$005C0000
	dc.l	$F0020100,$005D0000
	dc.l	$F0020100,$005E0000
	dc.l	$80000000

off_26E67A:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00,$005F0000
	dc.l	$F0020300,$00600000
	dc.l	$F0020100,$00610000
	dc.l	$F0140336,$003C01CC
	dc.l	$F00B8F00,$02880000
	dc.l	$F0070000,$0011FD10	; 洪水術
	dc.l	$F0020A00,$005C0000
	dc.l	$F0020100,$005D0000
	dc.l	$F0020100,$005E0000
	dc.l	$80000000

off_11FE7A:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00,$005F0000
	dc.l	$F0020300,$00600000
	dc.l	$F0020100,$00610000
	dc.l	$F0140336,$003C01CC
	dc.l	$F00B8F00,$02890000
	dc.l	$F0070000,$0011FE7A	; 挑撥術
	dc.l	$F0130000
	dc.l	$F0020A00,$005C0000
	dc.l	$F0020100,$005D0000
	dc.l	$F0020100,$005E0000
	dc.l	$80000000

off_120074:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00,$005F0000
	dc.l	$F0020300,$00600000
	dc.l	$F0020100,$00610000
	dc.l	$F0140336,$003C01CC
	dc.l	$F00B8F00,$02890000
	dc.l	$F0070000,$00120074	; 混亂術
	dc.l	$F0130000
	dc.l	$F0020A00,$005C0000
	dc.l	$F0020100,$005D0000
	dc.l	$F0020100,$005E0000
	dc.l	$80000000


off_2E70D8:	; 魚潛
	dc.l	$F0020400,$00440900
	dc.l	$F00B3F00,$02BE0BB8
	dc.l	$F0140008,$00000100
	dc.l	$F0020400,$00450900
	dc.l	$F0540B00
	dc.l	$F04F0700,$006E0C00,$006E0A00,$006E0800,$006E0600
	dc.l	$F00B9F00,$02C21B58
	dc.l	$F0070000,sub_18C476,$206F0500,$206F0400	; 口頭禪
	dc.l	$F0540600
	dc.l	$F0410100
	dc.l	$F0450200,$20700300,$20700200
	dc.l	$F0020100,$00700200
	dc.l	$F0020100,$00710100
	dc.l	$F0020100,$00720000
	dc.l	$F0020100,$00730000
	dc.l	$F0020100,$00740000
	dc.l	$F0070001,sub_18BBD0	; 按A觸發鸳飞動作
	dc.l	$80000000
	dc.l	$F02B0100	; 鸳飞
	dc.l	$F0020400,$004F0000,$00BA0400
	dc.l	$F0020200,$00BA0000
	dc.l	$F0140002,$00000100
	dc.l	$F0410100,$00A103F6,$00A103F8
	dc.l	$F00B7F00,$02C21388
	dc.l	$F0330100
	dc.l	$F03400FF,$009A0000,$0003FA00,$209903FA
	dc.l	$F03400FF,$009A0000,$0003FC00,$209903FC
	dc.l	$F03400FF,$009C0000,$0002FE00,$009B02FE
	dc.l	$F03400FF,$009C0000,$0002FF00,$009B02FF
	dc.l	$F0330000,$009D0000,$009D0000,$009E0000,$009E0000
	dc.l	$F0020300,$00A10000
	dc.l	$F0030000,$00A1030A
	dc.l	$F0020300,$00980000
	dc.l	$80000000

sub_18C476:	; 魚潛口頭禪音頻
	pea		($7F).w
	jsr		$1024B0
	addq.l	#4,sp
	moveq	#$4C,d1
	cmp.l	d0,d1
	ble.w	locret_18C558
	jsr		$12D4B4
	tst.l	d0
	beq.w	locret_18C558
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_18C4AE
	subi.b	#$40,($81B4C4).l
loc_18C4AE:
	move.l	($81B4C0).l,d0
	addq.l	#1,d0
	cmp.l	($81B4BC).l,d0
	bge.w	locret_18C558
	jsr		$13A578
	pea		(1).w
	moveq	#0,d0
	move.b	($81B4C4).l,d0
	lsl.l	#2,d0
	ori.l	#$4EF0E02,d0	; 音頻代碼
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_18C512
	move.l	($81B4A8).l,($81B4B0).l
loc_18C512:
	pea		(1).w
	clr.l	-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	lea		$18(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_18C552
	move.l	($81B4A8).l,($81B4B0).l
loc_18C552:
	jsr		$13A58E
locret_18C558:
	rts

off_2733F2:
	dc.l	$F0130100
	dc.l	$F00E0200
	dc.l	$F0140335,$000400A3
	dc.l	$F00B8F00,$02880000
	dc.l	$F0070000,$001221E4	; 恢覆術
	dc.l	$F0280300,$010B0000,$010C0000,$010D0000
	dc.l	$F0290000,$010E0000
	dc.l	$80000000

off_273432:	; 貂蟬雪暴術
	dc.l	$F0130100
	dc.l	$F00E0000
	dc.l	$F0140338,$000400A3
	dc.l	$F00B8F00,$028A0000
	dc.l	$F0070000,$0011E4A4,$010B0000	; 雪暴術
	dc.l	$F007003B,$0011E16A,$010B0000
	dc.l	$F0070039,$0011E22A,$010B0000
	dc.l	$F0070037,$0011E16A,$010B0000
	dc.l	$F0070035,$0011E22A,$010B0000
	dc.l	$F0070033,$0011E16A,$010B0000
	dc.l	$F0070031,$0011E22A,$010C0000
	dc.l	$F007002F,$0011E16A,$010C0000
	dc.l	$F007002D,$0011E22A,$010C0000
	dc.l	$F007005C,sub_17193A,$010D0000	; 滿氣偏移
	dc.l	$F007002D,$0011DE84,$010D0000
	dc.l	$F0070035,$0011DE84,$010D0000
	dc.l	$F007003D,$0011DE84,$010B0000
	dc.l	$F0070045,$0011DE84,$010B0000
	dc.l	$F007004D,$0011DE84,$010B0000
	dc.l	$F0070055,$0011DE84,$010C0000
	dc.l	$F007005D,$0011DE84,$010C0000
	dc.l	$F0070065,$0011DE84,$010C0000
	dc.l	$F007006D,$0011DE84,$010D0000
	dc.l	$F0070075,$0011DE84,$010D0000
	dc.l	$F007002D,$0011DF6E,$010D0000
	dc.l	$F007003D,$0011DF6E,$010B0000
	dc.l	$F007004D,$0011DF6E,$010B0000
	dc.l	$F007005D,$0011DF6E,$010B0000
	dc.l	$F007006D,$0011DF6E,$010C0000
	dc.l	$F007007D,$0011DF6E
	dc.l	$F0020200,$010C0000
	dc.l	$F0020300,$010D0000
	dc.l	$F0020300,$010E0000
	dc.l	$80000000
	dc.l	$F007002D,$0011DF6E,$010D0000	; 滿氣魔法
	dc.l	$F007003D,$0011DF6E,$010D0000
	dc.l	$F007004D,$0011DF6E,$010D0000
	dc.l	$F007005D,$0011DF6E,$010B0000
	dc.l	$F007006D,$0011DF6E,$010B0000
	dc.l	$F007002D,$0011E06C,$010B0000
	dc.l	$F0070035,$0011E06C,$010C0000
	dc.l	$F007003D,$0011E06C,$010C0000
	dc.l	$F0070045,$0011E06C,$010C0000
	dc.l	$F007004D,$0011E06C,$010D0000
	dc.l	$F0070055,$0011E06C,$010D0000
	dc.l	$F007005D,$0011E06C,$010D0000
	dc.l	$F0070065,$0011E06C,$010B0000
	dc.l	$F007006D,$0011E06C,$010B0000
	dc.l	$F0070075,$0011E06C,$010B0000
	dc.l	$F0020300,$010C0000
	dc.l	$F0020300,$010D0000
	dc.l	$F0020300,$010E0000
	dc.l	$80000000


off_279EEA:	; 龐統空中速降
	dc.l	$F0540800
	dc.l	$F04F2A01
	dc.l	$F0451100
	dc.l	$F00BEF00,$02220000
	dc.l	$F0020200,$006F0000
	dc.l	$F0020200,$00E20000
	dc.l	$F0020200,$00E30000
	dc.l	$F0020200,$00E40000
	dc.l	$F0030000,$40E40B08	; 隱身速降
	dc.l	$F0020200,$00E40000
	dc.l	$F0020200,$00E30000
	dc.l	$F0020200,$00E20000
	dc.l	$F0020200,$006F0000
	dc.l	$80000000

off_2EE080:
	dc.l	$F0020D00,$00600000
	dc.l	$F0140302,$000800E2
	dc.l	$F00B7F00,$02D007D0
	dc.l	$F00B7F00,$02DB0000
	dc.l	$F0070000,sub_18CCE6,$00610000
	dc.l	$F0070001,sub_18CCE6,$00610000
	dc.l	$F0130100
	dc.l	$F0121F00
	dc.l	$F0070002,sub_18CCE6,$00610000,$00610000
	dc.l	$F0130000
	dc.l	$F012FF00
	dc.l	$F0020800,$00610000
	dc.l	$F0020800,$00600000
	dc.l	$80000000

sub_18CCE6:
	link	A6, #$0
	movem.l	D2/A2-A3, -(A7)
	movea.l	($8,A6), A3
	jsr		$14DF94				; 分配機關OBJ/D02000到D0
	movea.l	D0, A2
	move.b	($f,A6), D0
	ext.w	D0
	ext.l	D0
	tst.w	D0
	beq.s	loc_18CD18
	moveq	#$1, D1
	cmp.w	D1, D0
	beq.s	loc_18CD6C
	moveq	#$2, D1
	cmp.w	D1, D0
	beq.w	loc_18CDBE
	bra.w	loc_18CDBE
loc_18CD18:
	tst.w	$c8(A3)
	bne.s	loc_18CD2C
	move.w	($20,A3), D2
	ext.l	D2
	addi.l	#$4b, D2
	bra.s	loc_18CD38
loc_18CD2C:
	move.w	($20,A3), D2
	ext.l	D2
	subi.l	#$4b, D2
loc_18CD38:
	moveq	#$0, D0
	move.w	$c8(A3), D0
	move.l	D0, -(A7)
	pea		$ffe0.w
	move.w	($22,A3), D0
	ext.l	D0
	move.l	D0, -(A7)
	move.l	D2, -(A7)
	pea		off_2EE00C
	move.l	A2, -(A7)
	jsr		$14E076.l			; 設定 機關
	lea		($18,A7), A7
	move.l	#off_2EDFF4, ($2c,A2)
	bra.w	loc_18CE0E
loc_18CD6C:
	tst.w	$c8(A3)
	bne.s	loc_18CD80
	move.w	($20,A3), D2
	ext.l	D2
	addi.l	#$74, D2
	bra.s	loc_18CD8C
loc_18CD80:
	move.w	($20,A3), D2
	ext.l	D2
	subi.l	#$74, D2
loc_18CD8C:
	moveq	#$0, D0
	move.w	$c8(A3), D0
	move.l	D0, -(A7)
	pea		$ffe4.w
	move.w	($22,A3), D0
	ext.l	D0
	move.l	D0, -(A7)
	move.l	D2, -(A7)
	pea		off_2EE00C
	move.l	A2, -(A7)
	jsr		$14E076.l
	lea		($18,A7), A7
	move.l	#off_2EDFDC, ($2c,A2)
	bra.w	loc_18CE0E
loc_18CDBE:
	tst.w	$c8(A3)
	bne.s	loc_18CDD2
	move.w	($20,A3), D2
	ext.l	D2
	addi.l	#$c8, D2
	bra.s	loc_18CDDE
loc_18CDD2:
	move.w	($20,A3), D2
	ext.l	D2
	subi.l	#$c8, D2
loc_18CDDE:
	moveq	#$0, D0
	move.w	$c8(A3), D0
	moveq	#$1, D1
	eor.l	D1, D0
	move.l	D0, -(A7)
	pea		$ffe2.w
	move.w	($22,A3), D0
	ext.l	D0
	move.l	D0, -(A7)
	move.l	D2, -(A7)
	pea		off_2EE00C
	move.l	A2, -(A7)
	jsr		$14E076.l
	move.l	#off_2EDFC4, ($2c,A2)
loc_18CE0E:
	clr.w	($3c,A2)
	clr.w	($54,A2)
	clr.w	($68,A2)
	move.l	A3, ($78,A2)
	clr.w	($6c,A2)
	move.l	A3, D0
	beq.s	loc_18CE2C
	move.l	($58,A3), ($7c,A2)
loc_18CE2C:
	clr.w	($d2,A2)
	movem.l	(-$c,A6), D2/A2-A3
	unlk	A6
	rts
off_2EDFC4:
	dc.l	$00100000,$20110000,$20120000,$20130000,$00140000,$80000000
off_2EDFDC:
	dc.l	$00160000,$20170000,$20180000,$20190000,$001A0000,$80000000
off_2EDFF4:
	dc.l	$001B0000,$201C0000,$201D0000,$201E0000,$001F0000,$80000000
off_2EE00C:
	dc.l	off_2EDFC4,$001C96BE,$001CA3E2,$001CAA74
	dc.l	$00319CE8,$00587F33,$09090020,$00000000
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000627	; 傷害編號062A
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00004000,$00000000,$00000000,$00000000

off_278942:	; 龐統暴風術
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00
	dc.l	$F0020200,$006F0000
	dc.l	$F0140335,$000800B9
	dc.l	$F00B8F00,$02890000
	dc.l	$F0070000,$0011DD18	; 暴風術
	dc.l	$F007002D,$0011DABE,$00700000
	dc.l	$F0070069,$0011DABE
	dc.l	$F0070047,sub_17193A
	dc.l	$F007002D,$0011D520,$00700000
	dc.l	$F007002D,$0011D60A,$00700000
	dc.l	$F007002D,$0011D706,$00710000
	dc.l	$F0070035,$0011D520,$00710000
	dc.l	$F0070035,$0011D60A,$00720000
	dc.l	$F007003D,$0011D706,$00720000
	dc.l	$F007003D,$0011D520,$00700000
	dc.l	$F007003D,$0011D60A,$00700000
	dc.l	$F007004D,$0011D706,$00710000
	dc.l	$F0070045,$0011D520,$00710000
	dc.l	$F0070045,$0011D60A,$00720000
	dc.l	$F007005D,$0011D706,$00720000
	dc.l	$F007004D,$0011D520,$00700000
	dc.l	$F0070055,$0011D520,$00700000
	dc.l	$F007005D,$0011D520,$00710000
	dc.l	$F0070065,$0011D520,$00710000
	dc.l	$F0020200,$00720000
	dc.l	$80000000
	dc.l	$F007002D,$0011D60A,$00700000	; 滿氣偏移
	dc.l	$F0070035,$0011D60A,$00700000
	dc.l	$F007003D,$0011D60A,$00710000
	dc.l	$F007002D,$0011D706,$00710000
	dc.l	$F007003D,$0011D706,$00720000
	dc.l	$F0070035,$0011D804,$00720000
	dc.l	$F007003D,$0011D804,$00700000
	dc.l	$F0070045,$0011D804,$00700000
	dc.l	$F007002D,$0011D902,$00710000
	dc.l	$F007003D,$0011D902,$00710000
	dc.l	$F007004D,$0011D804,$00720000
	dc.l	$F0070055,$0011D804,$00720000
	dc.l	$F007005D,$0011D804,$00700000
	dc.l	$F0070065,$0011D804,$00700000
	dc.l	$F007002D,$0011D804,$00710000
	dc.l	$F007003C,$0011DA00,$00710000
	dc.l	$F007004C,$0011DA00,$00720000
	dc.l	$F007005C,$0011DA00,$00720000
	dc.l	$F007006C,$0011DA00,$00700000
	dc.l	$F007007C,$0011DA00,$00700000
	dc.l	$F0020200,$00710000
	dc.l	$F0020200,$00720000
	dc.l	$80000000

off_27889A:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00
	dc.l	$F0020200,$006F0000
	dc.l	$F0140335,$000800B9
	dc.l	$F00B8F00,$02890000
	dc.l	$F0070000,$00122336	; 落雷術
	dc.l	$F0280300
	dc.l	$F0020200,$00700000
	dc.l	$F0020200,$00710000
	dc.l	$F0020200,$00720000
	dc.l	$F0290000
	dc.l	$80000000

off_123586:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00
	dc.l	$F0020200,$006F0000
	dc.l	$F0140335,$000800B9
	dc.l	$F00B8F00,$02890000
	dc.l	$F0070000,$00123586	; 神將術
	dc.l	$F0280300
	dc.l	$F0020200,$00700000
	dc.l	$F0020200,$00710000
	dc.l	$F0020200,$00720000
	dc.l	$F0290000
	dc.l	$80000000

off_278B66:	; 龐統雪暴術
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F04F0E00
	dc.l	$F0020200,$006F0000
	dc.l	$F0140335,$000800B9
	dc.l	$F00B8F00,$02890000
	dc.l	$F0070000,$0011E4A4,$010B0000	; 雪暴術
	dc.l	$F0070040,$0011E16A,$00700000
	dc.l	$F007003E,$0011E22A,$00700000
	dc.l	$F007003C,$0011E16A,$00710000
	dc.l	$F007003A,$0011E22A,$00710000
	dc.l	$F0070038,$0011E16A,$00720000
	dc.l	$F0070036,$0011E22A,$00720000
	dc.l	$F0070034,$0011E16A,$00700000
	dc.l	$F0070032,$0011E22A,$00700000
	dc.l	$F0070059,sub_17193A
	dc.l	$F0070032,$0011DE84,$00710000
	dc.l	$F007003A,$0011DE84,$00710000
	dc.l	$F0070042,$0011DE84,$00720000
	dc.l	$F007004A,$0011DE84,$00720000
	dc.l	$F0070052,$0011DE84,$00700000
	dc.l	$F007005A,$0011DE84,$00700000
	dc.l	$F0070062,$0011DE84,$00710000
	dc.l	$F007006A,$0011DE84,$00710000
	dc.l	$F0070072,$0011DE84,$00720000
	dc.l	$F007007A,$0011DE84,$00720000
	dc.l	$F0070032,$0011DF6E,$00700000
	dc.l	$F0070042,$0011DF6E,$00700000
	dc.l	$F0070052,$0011DF6E,$00710000
	dc.l	$F0070062,$0011DF6E,$00710000
	dc.l	$F0070072,$0011DF6E,$00720000
	dc.l	$F0070082,$0011DF6E,$00720000
	dc.l	$80000000
	dc.l	$F0070032,$0011DF6E,$00710000
	dc.l	$F007003E,$0011DF6E,$00710000
	dc.l	$F007004A,$0011DF6E,$00720000
	dc.l	$F0070056,$0011DF6E,$00720000
	dc.l	$F0070062,$0011DF6E,$00700000
	dc.l	$F0070032,$0011E06C,$00700000
	dc.l	$F007003A,$0011E06C,$00710000
	dc.l	$F0070042,$0011E06C,$00710000
	dc.l	$F007004A,$0011E06C,$00720000
	dc.l	$F0070052,$0011E06C,$00720000
	dc.l	$F007005A,$0011E06C,$00700000
	dc.l	$F0070062,$0011E06C,$00700000
	dc.l	$F007006A,$0011E06C,$00710000
	dc.l	$F0070072,$0011E06C,$00710000
	dc.l	$F007007A,$0011E06C
	dc.l	$F0020200,$00720000
	dc.l	$80000000

off_2788EE:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F0020200,$006F0000
	dc.l	$F0140338,$003600D1
	dc.l	$F00B8F00,$028A0000
	dc.l	$F0070000,$00122992	; 滾石陣
	dc.l	$F0280300
	dc.l	$F0020200,$00D90000
	dc.l	$F0020200,$00DA0000
	dc.l	$F0020200,$00DB0000
	dc.l	$F0290000
	dc.l	$80000000

off_120002:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F0020200,$006F0000
	dc.l	$F0140338,$003600D1
	dc.l	$F00B8F00,$028A0000
	dc.l	$F0070000,$00120002	; 恐嚇計
	dc.l	$F0130000
	dc.l	$F0280300
	dc.l	$F0020200,$00D90000
	dc.l	$F0020200,$00DA0000
	dc.l	$F0020200,$00DB0000
	dc.l	$F0290000
	dc.l	$80000000


off_27FD64:	; 孫權空擊並速降
	dc.l	$F0540A00
	dc.l	$F04F1100
	dc.l	$F0070032,sub_173694	; 高度太低則正常落地
; 快速落地
	dc.l	$F00BEF00,$02350000	; 口頭禪
	dc.l	$00410206,$F04B0000	; F04B|低於則恢復默認高度
	dc.l	$003B0206,$F04B0000
	dc.l	$F05E0100	; 霸體狀態
	dc.l	$F0410100,$F0550100,$F0450700	; 敵人被打動作|07
	dc.l	$F0280600,$203C0A06,$F04B0000,$F0290000	; 空中攻擊
	dc.l	$F0030000,$203C0A0A	; 速降震地
	dc.l	$F00E0100
	dc.l	$F00B9F00,$02DC0000,$F00B9F00,$0104F830	; 震地音效
	dc.l	$F014000C,$00000100	; 震地灰塵
	dc.l	$F01000FE,$003C0000,$F0100002,$003C0000	; 地震效果
	dc.l	$F014000E,$0024F600	; 震地灰塵
	dc.l	$F01000FF,$003D0000,$F0100001,$003E0000
	dc.l	$F014000F,$FFDC0000	; 震地灰塵
	dc.l	$F05E0000	; 取消霸體
	dc.l	$003F03FA,$003F03FB,$004003FC,$004003FD,$004103FE,$004103FF	; 彈起
	dc.l	$00420301,$00420302,$00430303,$00430304,$00440305,$00440306
	dc.l	$F0140009,$00000100
	dc.l	$80000000
; 正常落地
	dc.l	$F0030000,$00430506
	dc.l	$F0140000,$FFFB0100
	dc.l	$F00B5F00,$02DD0000	; 著陸
	dc.l	$F0020200,$00440000
	dc.l	$80000000

off_2F29A4:
	dc.l	$F00E0000
	dc.l	$F0540A00
	dc.l	$F04F0B00
	dc.l	$F0580100	; 招式取消類[00][普攻]
	dc.l	$F05E0100
	dc.l	$F0020400,$00330600
	dc.l	$F00B1F00,$02DD0000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020400,$00340600
	dc.l	$F00BEF00,$02360000
	dc.l	$F0020400,$00350600
	dc.l	$F0020400,$002E0600
	dc.l	$F00B1F00,$02DD0000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020200,$00C10500
	dc.l	$F0020200,$00B70500
	dc.l	$F0020200,$00C20400
	dc.l	$F0020100,$20B80100,$20BC0100
	dc.l	$F0020400,$00BE0000
	dc.l	$F0410100
	dc.l	$F0540700
	dc.l	$F0450300,$20BF0000,$20C00400
	dc.l	$F0020100,$00C10100
	dc.l	$F0020400,$00C20000
	dc.l	$80000000

off_27E42A:	; 孫權長槍陣
	dc.l	$F00E0100
	dc.l	$F04F0E00
	dc.l	$F0020200,$00ED0000
	dc.l	$F0140335,$000800B9
	dc.l	$F00B8F00,$02890000
	dc.l	$F0130100
	dc.l	$F0070000,$0011EF78
	dc.l	$F0070024,sub_17193A
	dc.l	$F0070000,$0011EBC2,$00EE0000
	dc.l	$F0070000,$0011EBC2,$00EE0000
	dc.l	$F0070000,$0011EBC2,$00EF0000
	dc.l	$F0070000,$0011EBC2,$00EF0000
	dc.l	$F0020200,$00F00000
	dc.l	$F0280200
	dc.l	$F0020200,$00EE0000
	dc.l	$F0020200,$00EF0000
	dc.l	$F0020200,$00F00000
	dc.l	$F0290000
	dc.l	$80000000
	dc.l	$F0070000,$0011ED2A,$00EE0000
	dc.l	$F0070000,$0011ED2A,$00EE0000
	dc.l	$F0070000,$0011ED2A
	dc.l	$F0020200,$00EF0000
	dc.l	$F0020200,$00F00000
	dc.l	$F0280200
	dc.l	$F0020200,$00EE0000
	dc.l	$F0020200,$00EF0000
	dc.l	$F0020200,$00F00000
	dc.l	$F0290000
	dc.l	$80000000


off_252388:	; 關羽危險迴避技
	dc.l	$F0540800	; 硬直[08]
	dc.l	$F04F1606
	dc.l	$F0450200
	dc.l	$F0130100
	dc.l	$F00BEF00,$01BB0000
	dc.l	$F00BBF00,$02C3E4A8
	dc.l	$F0020100,$20AA0000,$20AB0000,$20AC0000,$20AD0000,$20AE0000,$20AF0000,$20B00000
	dc.l	$F0140006,$00000100,$20B10000,$20B20000,$20B30000	; 增加判定[20XX]
	dc.l	$F0020100,$00B40000
	dc.l	$F0020100,$00B50000
	dc.l	$80000000


off_25777E:	; 張飛危險迴避技
	dc.l	$F0540800	; 硬直[08]
	dc.l	$F04F2701
	dc.l	$F0450200
	dc.l	$F0130100
	dc.l	$F00BEF00,$01C40000
	dc.l	$F0020200,$20A70000
	dc.l	$F0020100,$20A80000
	dc.l	$F0260200
	dc.l	$F00BFF00,$00D60000
	dc.l	$F0280300
	dc.l	$F02700FF,$00AD0000,$00000000
	dc.l	$F02701FF,$00B30000,$00000000,$20A90000
	dc.l	$F02700FF,$00AE0000,$00000000
	dc.l	$F02701FF,$00B40000,$00000000,$20AA0000
	dc.l	$F02700FF,$00AF0000,$00000000
	dc.l	$F02701FF,$00B50000,$00000000,$20A90000
	dc.l	$F02700FF,$00B00000,$00000000
	dc.l	$F02701FF,$00B60000,$00000000,$20AA0000
	dc.l	$F02700FF,$00B10000,$00000000
	dc.l	$F02701FF,$00B70000,$00000000,$20A90000
	dc.l	$F02700FF,$00B20000,$00000000
	dc.l	$F02701FF,$00B80000,$00000000,$20AA0000
	dc.l	$F0290000
	dc.l	$F0260000
	dc.l	$F0020200,$00AB0000
	dc.l	$F0020400,$00AC0000
	dc.l	$F0130000,$80000000


off_2623F6:	; 黃忠危險迴避技
	dc.l	$F0130100
	dc.l	$F0540800	; 硬直[08]
	dc.l	$F04F2709
	dc.l	$F0450200
	dc.l	$F00BEF00,$01E70000,$20980000
	dc.l	$F0020200,$20990000
	dc.l	$F00BAF00,$02C2EE6C,$209A0000
	dc.l	$F0330100
	dc.l	$F03400FF,$009C0000,$00000000,$209B0000
	dc.l	$F0330000,$209D0000,$209E0000,$209F0000,$20A00000,$20A10000,$20A20000
	dc.l	$F0020100,$00A30000
	dc.l	$F0130000
	dc.l	$80000000


off_26839C:	; 馬超危險迴避技
	dc.l	$F0540800	; 硬直[08]
	dc.l	$F04F1606
	dc.l	$F0450200
	dc.l	$F0130100
	dc.l	$F015FE00,$00268328,$000001EC
	dc.l	$F0020300,$20B30000
	dc.l	$F00BBF00,$02C3E4A8
	dc.l	$F0020300,$20B40500
	dc.l	$F0020300,$20B50500
	dc.l	$F0020300,$20B60500
	dc.l	$F0020300,$20B70500
	dc.l	$F0020300,$20B80500
	dc.l	$F0020300,$20B90500
	dc.l	$F0140006,$00000100
	dc.l	$F0020300,$20BA0500,$20BA0000
	dc.l	$F0020800,$20BB0000
	dc.l	$80000000


off_26D8C8:	; 孔明危險迴避技
	dc.l	$F0130100
	dc.l	$F0540800	; 硬直[08]
	dc.l	$F04F1E01
	dc.l	$F0450200
	dc.l	$F00BEF00,$02000000
	dc.l	$F0280200
	dc.l	$F00B0F00,$00DE0000
	dc.l	$20830000,$20840000,$20850000,$20860000,$20870000,$20880000	; 增加判定[20XX]
	dc.l	$F0290000
	dc.l	$F0130000
	dc.l	$80000000


off_272980:	; 貂蟬危險迴避技
	dc.l	$F0130100
	dc.l	$F0540800	; 硬直[08]
	dc.l	$F04F0100
	dc.l	$F0450200
	dc.l	$F0140000,$00000100
	dc.l	$F014000B,$00000100
	dc.l	$F00BEF00,$020F0000
	dc.l	$F00BAF00,$02C20000,$20A40000,$20A60000,$20A80000,$20AA0000
	dc.l	$F0130000
	dc.l	$80000000


off_27D9BC:	; 孫權危險迴避技
	dc.l	$F00E0200
	dc.l	$F0540800
	dc.l	$F04F1C06
	dc.l	$F0450700
	dc.l	$F0130100
	dc.l	$F00BEF00,$02360000
	dc.l	$F0020200,$20EA0000
	dc.l	$F0020200,$20390000
	dc.l	$F0020300,$20910000
	dc.l	$F015FE00,$0027D8D4,$00000000
	dc.l	$F0280400,$20920000,$20930000,$20940000
	dc.l	$F0290000
	dc.l	$80000000


sub_16184A:
	btst	#2,$20(a3)		; 是否AB指令
	beq.s	loc_16184A
	btst	#1,$20(a3)
	beq.s	loc_16184A
	moveq	#0,d0
	bra.s	locret_16184A	; 取消判斷中毒
loc_16184A:
	btst	#0,$244(a2)		; 原代碼
locret_16184A:
	rts


sub_1618E8:
	btst	#2,$20(a3)		; 是否AB指令
	beq.s	loc_161958
	btst	#1,$20(a3)
	beq.s	loc_161958
	cmpi.w	#8,$6C(a2)
	bls.s	loc_161958
	cmpi.b	#1,($818280).l
	beq.s	loc_161958
	tst.w	$BE(a2)			; 是否換將
	beq.s	loc_16191A
	pea		($D).w			; 危險迴避技|換將
	bra.s	loc_16191E
loc_16191A:
	pea		(9).w			; 危險迴避技|本角
loc_16191E:
	pea		(3).w
	move.l	a2,-(sp)
	jsr		$15E152			; 計算動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	subq.w	#8,$6C(a2)
	pea		($FFFFF8).w		; 生命值減8
	move.l	a3,-(sp)
	jsr		$14CF6A			; 生命條變動
	lea		$10(sp),sp
	clr.w	$FC(a2)
	clr.w	$CC(a2)
	moveq	#1,d0
	movea.l	#$161990,a0
	bra.s	locret_1618E8
loc_161958:
	movea.l	#$161958,a0
locret_1618E8:
	rts


off_2556F6:	; 張飛空中突行技
	dc.l	$004A0600,$004B0600,$004B0600,$004B0600,$004B0600,$004A0600,$004A0601
	dc.l	$F04B0000,$004A0601
	dc.l	$F04B0000,$004A0601
	dc.l	$F04B0000,$00490604
	dc.l	$F04B0000,$00490604
	dc.l	$F04B0000
	dc.l	$F0030000,$00490609
	dc.l	$80000000

off_265DB8:	; 馬超空中突行技
	dc.l	$F0140000,$00000000
	dc.l	$00440500,$00440500,$00440500,$00440500,$00440500,$00440500,$00450501
	dc.l	$F04B0000,$00450501
	dc.l	$F04B0000,$00450501
	dc.l	$F04B0000,$00460504
	dc.l	$F04B0000,$00460504
	dc.l	$F04B0000
	dc.l	$F0030000,$00460509
	dc.l	$80000000

off_2705E8:	; 貂蟬空中突行技
	dc.l	$F0140000,$00000000
	dc.l	$00520500,$00520500,$00520500,$00520500,$00520500,$00520500,$00510501
	dc.l	$F04B0000,$00510501
	dc.l	$F04B0000,$00510501
	dc.l	$F04B0000,$00500504
	dc.l	$F04B0000,$00500504
	dc.l	$F04B0000
	dc.l	$F0030000,$00500509
	dc.l	$80000000


byte_1E63D8:	; 03類動作傷害值表|普通攻擊|每個角色佔位$64
	*		0300|01	|02	|03	|04	|05	|06	|07	|08	|09	|0A	|0B	|0C	|0D	|0E	|030F
	dc.b	$A, $10,$18,$20,$A, $A, 0,  $C, $14,$24,$A, 0,  $A, $18,0,  0	; 關羽
	dcb.b	$54,0
	dc.b	$C, $12,$18,$24,$C, $10,$C, $10,$16,$2A,$C, 0,  $A, $18,0,  0	; 張飛
	dcb.b	$54,0
	dc.b	$8, $E, $12,$26,$A, $A, $C, 0,  $12,$24,$A, 0,  $A, $18,0,  0	; 趙雲
	dcb.b	$54,0
	dc.b	$A, $C, $14,$22,$A, $E, $C, $C, $12,$24,$E, 0,  $A, $18,0,  0	; 黃忠
	dcb.b	$54,0
	dc.b	$C, $E, $8, $26,$8, $E, $8, $E, $10,$24,$A, 0,  $A, $18,0,  0	; 馬超
	dcb.b	$54,0
	dc.b	$14,$10,$14,$14,$C, $E, 0,  $E, $10,$24,$E, 0,  $A, $18,0,  0	; 孔明
	dcb.b	$54,0
	dc.b	$6, $10,$14,$1C,$A, $E, $A, $8, $E, $30,$E, 0,  $A, $18,0,  0	; 貂蟬
	dcb.b	$54,0
	dcb.b	$64,0
	dc.b	$A, $10,$12,$1E,$A, $8, 0,  $8, $E, $18,$8, 0,  $A, $18,0,  0	; 龐統
	dcb.b	$54,0
	dc.b	$A, $14,$1E,$26,$A, $14,0,  $14,$1C,$26,$12,0,  $A, $1E,0,  0	; 孫權
	dcb.b	$54,0
	dcb.b	$64,0

byte_1E6824:	; 06類動作傷害值表|必殺技、超必殺技、投擲道具|每個角色佔位$64
	*		0600|01	|02	|03	|04	|05	|06	|07	|08	|09	|0A	|0B	|0C	|0D	|0E	|0F	|10	|11	|12	|13	|14	|15	|16	|17	|18	|19	|1A	|1B	|1C	|1D	|1E	|1F	|20	|21	|22	|23	|24	|25	|26	|27	|28	|29	|2A	|2B	|2C	|2D	|2E	|2F
	dc.b	0,  $1C,$44,$1E,$42,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $3C,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $10,$12,0,  0,  $14,$12,$18,0,  0,  0,  0,  $14,$16,0,  0,  0,  0,  0
	dcb.b	$34,0	; 關羽
	dc.b	0,  $24,$44,$1E,$4C,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $1A,$1E,0,  0,  $3C,$50,$22,$3C,$44,$1A,0,  $10,0,  0,  0,  0,  0,  0
	dcb.b	$34,0	; 張飛
	dc.b	0,  $1C,$44,$1E,$42,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $1A,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $10,$18,$C, 0,  $A, $E, 0,  0,  $32,$10,0,  $20,0,  0,  0,  0,  0,  0
	dcb.b	$34,0	; 趙雲
	dc.b	0,  $1C,$44,$1E,$42,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $16,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $A, $20,$1C,$1C,$1C,0,  $16,0,  $22,0,  0,  $12,$14,0,  0,  0,  0,  0
	dcb.b	$34,0	; 黃忠|火弓陣$12減傷|焚心箭$26減傷
	dc.b	0,  $1C,$44,$1E,$42,0,  0,  0,  0,  0,  0,  0,  0,  0,  $32,$28,0,  0,  0,  $32,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $A, $18,$C, 0,  0,  $A, $24,0,  0,  $C, 0,  $12,0,  0,  0,  0,  0,  0
	dcb.b	$34,0	; 馬超
	dc.b	0,  $18,$30,$1A,$2E,0,  0,  0,  0,  0,  0,  $50,0,  0,  0,  0,  $32,0,  0,  0,  $28,0,  0,  0,  0,  0,  0,  0,  0,  0,  $A, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $10,$14,0,  0,  0,  0,  0
	dcb.b	$34,0	; 孔明
	dc.b	0,  $1C,$44,$1E,$4C,0,  0,  0,  0,  0,  0,  0,  $42,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $C, $E, $A, 0,  0,  $18,$18,$18,0,  $E, $20,$12,0,  0,  0,  0,  0,  0
	dcb.b	$34,0	; 貂蟬|蜂鳴0625空中0628減傷
	dcb.b	$64,0
	dc.b	0,  $1C,$3A,$1E,$42,0,  0,  0,  0,  0,  $4A,$46,$4A,$63,0,  $1E,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $E, $28,$2C,0,  0,  0,  0,  0,  0,  $C, 0,  0,  $D, 0,  0,  0,  0,  0
	dcb.b	$34,0	; 龐統
	dc.b	0,  $24,$4C,$1E,$4C,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $1E,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $28,$28,0,  0,  0,  0,  $1A,$50,$63,0,  0,  $32,$24,$1E,0,  0,  0,  0
	dcb.b	$34,0	; 孫權
	dcb.b	$64,0

byte_1E4612:	; 06類攻擊對各敵人的加成
	dcb.b	$384,0
	*			01|-投擲道具-|04		07|--------魔法--------|0D	0E|--------策略--------|14										1E|-必殺技-|21	22|-------超必殺-------|28	29|--------新增技能--------|30
	*	06	00|	01|	02|	03|	04|	05|	06|	07|	08|	09|	0A|	0B|	0C|	0D|	0E|	0F|	10|	11|	12|	13|	14|	15|	16|	17|	18|	19|	1A|	1B|	1C|	1D|	1E|	1F|	20|	21|	22|	23|	24|	25|	26|	27|	28|	29|	2A|	2B|	2C|	2D|	2E|	2F|	30
	dc.b	0, $28,$1C,$20,$20,  0,  0,  0,  0,  0,$20,$20,$20,$40,$20,$20,$24,$1C,$24,$1E,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$24,$24,$20,$24,$32,$2A,$2A,$40,$50,$2A,$2A,$24,$24,$24,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 孫權09
	dc.b	0, $20,$20,$12,$14,  0,  0,  0,  0,  0, $C,$20, $C,$40,$20,$12,$28,$18,$2A,$20,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$1C,$1C,$18,$1C,$24,$24,$24,$30,$30,$1C,$24,$1C,$1C,$1C,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 真呂布0A
	dc.b	0, $30,$1C,$20,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$20,$20,$28,$20,$28,$24,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$28,$28,$2E,$28,$32,$2E,$2C,$40,$50,$28,$2E,$28,$28,$28,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 曹操0B
	dc.b	0, $36,$20,$20,$1C,  0,  0,  0,  0,  0,  4,  4,  4,$40,$24,$28,$40,$20,$34,$40,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$2A,$28,$36,$32,$30,$40,$58,$2A,$2C,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 司馬懿0C
	dc.b	0, $36,$20,$20,$1C,  0,  0,  0,  0,  0,$18,$18,$18,$40,$20,$1C,$24,$20,$24,$28,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$28,$28,$34,$2E,$28,$40,$50,$2A,$28,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 程昱0D
	dcb.b	$64,0
	dc.b	0, $30,$20,$1C,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$28,$1C,$26,$20,$2C,$30,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$28,$28,$38,$32,$2E,$3A,$48,$2A,$32,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 曹仁0F
	dcb.b	$64,0
	dc.b	0, $30,$20,$20,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$30,$20,$28,$20,$2A,$32,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$28,$28,$38,$34,$30,$40,$50,$2A,$34,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 夏侯淵11
	dc.b	0, $30,$1C,$18,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$20,$18,$20,$1C,$20,$30,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$20,$20,$1C,$20,$28,$22,$22,$32,$38,$20,$22,$20,$20,  0,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 夏侯惇12
	dc.b	0, $28,$1C,$1C,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$24,$1E,$28,$20,$2C,$30,$18,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$26,$24,$32,$28,$28,$36,$40,$2A,$28,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 牛金13
	dc.b	0, $30,$20,$26,$20,  0,  0,  0,  0,  0,$20,$20,$20,$40,$24,$1E,$2C,$20,$30,$34,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$24,$24,$20,$28,$32,$2E,$2E,$34,$40,$24,$2E,$24,$24,  0,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 許褚14
	dc.b	0, $30,$1C,$20,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$24,$1E,$28,$20,$2C,$30,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$28,$28,$34,$30,$30,$40,$40,$2A,$30,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 張郃15
	dc.b	0, $30,$20,$20,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$2A,$28,$28,$20,$2C,$30,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$26,$28,$34,$30,$30,$40,$48,$2A,$30,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 張遼16
	dcb.b	$64,0
	dc.b	0, $30,$20,$18,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$28,$24,$28,$20,$2C,$30,$18,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$24,$28,$34,$32,$30,$40,$50,$2A,$32,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 甘寧18
	dc.b	0, $30,$20,$20,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$30,$24,$28,$20,$28,$32,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$24,$28,$34,$30,$30,$40,$48,$2A,$30,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 周泰19
	dc.b	0, $30,$20,$20,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$30,$26,$20,$20,$20,$28,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$26,$28,$34,$30,$30,$40,$40,$2A,$30,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 黃蓋1A
	dc.b	0, $30,$20,$18,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$30,$20,$28,$20,$28,$32,$18,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$26,$28,$34,$30,$30,$40,$40,$2A,$30,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 呂蒙1B
	dc.b	0, $30,$20,$20,$1C,  0,  0,  0,  0,  0,$20,$20,$20,$40,$30,$28,$28,$20,$30,$32,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$26,$26,$20,$28,$30,$2A,$2A,$40,$38,$26,$2A,$26,$26,$26,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 徐晃1C
	dc.b	0, $20,$20,$12,$14,  0,  0,  0,  0,  0, $C,$20, $C,$40,$20,$12,$28,$18,$2A,$20,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$1C,$1C,$18,$1C,$24,$24,$24,$30,$30,$1C,$24,$1C,$1C,$1C,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 呂布1D
	dc.b	0, $30,$20,$18,$1C,  0,  0,  0,  0,  0,$18,$20,$20,$40,$24,$20,$20,$20,$28,$32,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$2A,$28,$30,$2C,$2C,$40,$38,$2A,$2C,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 孟獲1E
	dc.b	0, $18, $C,$34,$18,  0,  0,  0,  0,  0,$12,$12,$12,$40,$12,$14,$14,$12,$10,$24,$18,  0,  0,  0,  0,  0,  0,  0,  0,  0,$14,$14,$12,$14,$18,$18,$18,$2A,$26,$14,$18,$14,$14,$14,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 孟優1F
	dc.b	0, $30,$18,$20,$1C,  0,  0,  0,  0,  0,$1C,$20,$28,$40,$32,$18,$1C,$20,$1C,$20,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$2A,$30,$30,$2E,$2E,$44,$40,$2A,$2E,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 沙摩柯20
	dc.b	0, $30,$32,$20,$20,  0,  0,  0,  0,  0,$12,$30,$12,$40,$28,$18,$30,$20,$30,$32,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$30,$30,$32,$30,$36,$30,$30,$40,$40,$30,$30,$30,$30,$30,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 左慈21
	dc.b	0, $30,$20,$20,$1C,  0,  0,  0,  0,  0,$18,$20,$1C,$40,$28,$20,$20,$20,$20,$32,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2A,$2A,$2A,$28,$2A,$28,$2A,$38,$38,$2A,$38,$2A,$2A,$2A,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$30,$20,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$32,$32,$2E,$60,$80,$80,$80,$A0,$A0,$30,$A0,$32,$32,$32,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$30,$20,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$32,$32,$2C,$60,$80,$80,$80,$A0,$A0,$30,$A0,$32,$32,$32,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$30,$20,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$32,$32,$2E,$60,$80,$80,$80,$A0,$A0,$30,$A0,$32,$32,$32,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$50,$20,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$34,$34,$2E,$60,$80,$80,$80,$A0,$A0,$34,$A0,$34,$34,$34,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$60,$20,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$32,$32,$2E,$60,$80,$80,$80,$A0,$A0,$30,$A0,$32,$32,$32,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $20,$20,$20,$40,  0,  0,  0,  0,  0,$40,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$2E,$2E,$2E,$40,$80,$80,$80,$A0,$A0,$2E,$A0,$2E,$2E,$2E,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $20,$20,$20,$40,  0,  0,  0,  0,  0,$40,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$32,$32,$2E,$40,$80,$80,$80,$A0,$A0,$32,$A0,$32,$32,$32,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$20,$20,$40,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$34,$34,$2E,$60,$80,$80,$80,$A0,$A0,$34,$A0,$34,$34,$34,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$30,$20,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$32,$32,$2E,$60,$80,$80,$80,$A0,$A0,$32,$A0,$32,$32,$32,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$60,$20,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$34,$34,$2E,$60,$80,$80,$80,$A0,$A0,$34,$A0,$34,$34,$34,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $50,$60,$20,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$34,$34,$2E,$60,$80,$80,$80,$A0,$A0,$34,$A0,$34,$34,$34,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $58,$30,$60,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$38,$38,$32,$60,$80,$80,$80,$A0,$A0,$38,$A0,$38,$38,$38,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $58,$30,$40,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$38,$38,$32,$60,$80,$80,$80,$A0,$A0,$38,$A0,$38,$38,$38,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $58,$30,$40,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$38,$38,$32,$60,$80,$80,$80,$A0,$A0,$38,$A0,$38,$38,$38,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $50,$30,$20,$40,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$34,$34,$2E,$60,$80,$80,$80,$A0,$A0,$34,$A0,$34,$34,$34,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$30,$20,$40,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$30,$30,$2A,$60,$80,$80,$80,$A0,$A0,$30,$A0,$30,$30,$30,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$60,$20,$50,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$40,  0,  0,  0,  0,  0,  0,  0,  0,  0,$32,$32,$2A,$60,$80,$80,$80,$A0,$A0,$32,$A0,$32,$32,$32,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $14,$60,$14,$20,  0,  0,  0,  0,  0,$40,  8,$20,$80,$20,$20,$60,$20,$60,$60,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$20,$20,$20,$40,$80,$80,$80,$A0,$A0,$20,$A0,$20,$20,$20,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $20,$20,$40,$20,  0,  0,  0,  0,  0,$60,$60,$60,$80,$60,$60,$20,$20,$20,$40,$20,  0,  0,  0,  0,  0,  0,  0,  0,  0,$20,$20,$20,$40,$A0,$A0,$A0,$A0,$A0,$20,$A0,$20,$20,$20,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$30,$40,$40,  0,  0,  0,  0,  0,$50,$58,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$36,$36,$2E,$60,$FF,$FF,$FF,$A0,$A0,$34,$A0,$36,$36,$36,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$30,$30,$40,  0,  0,  0,  0,  0,$50,$58,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$36,$36,$2E,$60,$FF,$FF,$FF,$A0,$A0,$34,$A0,$36,$36,$36,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$30,$30,$40,  0,  0,  0,  0,  0,$50,$58,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$36,$36,$2E,$60,$FF,$FF,$FF,$A0,$A0,$34,$A0,$36,$36,$36,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $48,$60,$30,$60,  0,  0,  0,  0,  0,$50,$58,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$36,$36,$2E,$60,$FF,$FF,$FF,$A0,$A0,$34,$A0,$36,$36,$36,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $60,$60,$60,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$36,$36,$2E,$60,$80,$80,$80,$A0,$A0,$34,$A0,$36,$36,$36,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $60,$60,$60,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$36,$36,$2E,$60,$80,$80,$80,$A0,$A0,$34,$A0,$36,$36,$36,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dc.b	0, $60,$60,$60,$60,  0,  0,  0,  0,  0,$60,$60,$40,$80,$60,$60,$60,$60,$60,$60,$60,  0,  0,  0,  0,  0,  0,  0,  0,  0,$36,$36,$2E,$60,$80,$80,$80,$A0,$A0,$34,$A0,$36,$36,$36,  0,  0,  0,  0,  0,  0
	dcb.b	$32,0	; 
	dcb.b	$64,0


off_2D8914:	; 猛黃忠平射
	dc.l	$F0020200,$00AB0000
	dc.l	$F0020200,$00AC0000
	dc.l	$F0020200,$00AD0000
	dc.l	$F0020200,$00AE0000
	dc.l	$F00BBF00,$02CA07D0
	dc.l	$F0070000,sub_18B5A2	; 射單箭
	dc.l	$F0020200,$00AF0000
	dc.l	$F0070003,sub_18B70E	; 是否按住A鍵
	dc.l	$F0020200,$00B00000
	dc.l	$80000000
	dc.l	$F0020200,$00AE0000
	dc.l	$F00BBF00,$02CA07D0
	dc.l	$F0070001,sub_18B5A2	; 射雙箭
	dc.l	$F0020200,$00AF0000
	dc.l	$F0020200,$00B00000
	dc.l	$80000000

sub_18B5A2:	; 猛黃忠6A動作|射箭
	movem.l	d2-d5/a2-a3,-(sp)
	move.l	$20(sp),d5
	movea.l	$1C(sp),a2
	jsr		$14DF94			; 分配OBJ
	movea.l	d0,a3
	move.w	$20(a2),d2
	ext.l	d2
	tst.w	$C8(a2)
	bne.s	loc_18B5C8
	moveq	#$1E,d0
	add.l	d0,d2
	bra.s	loc_18B5CC
loc_18B5C8:
	moveq	#$1E,d0
	sub.l	d0,d2
loc_18B5CC:
	tst.b	d5
	beq.s	loc_18B5DA
	move.w	$24(a2),d3
	ext.l	d3
	subq.l	#2,d3
	bra.s	loc_18B5E2
loc_18B5DA:
	move.w	$24(a2),d3
	ext.l	d3
	addq.l	#2,d3
loc_18B5E2:
	moveq	#0,d4
	move.w	$10C(a2),d4		; 判斷武器
	addi.l	#$26,d4
	moveq	#$31,d0			; 天火雙煞弓5D|原猛虎劈山弓31
	cmp.l	d4,d0
	bne.s	loc_18B640
	tst.b	d5
	beq.s	loc_18B61C
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D87B8).l	; 火箭
	bra.w	loc_18B6D8
loc_18B61C:
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8744).l	; 冰箭
	bra.w	loc_18B6D8
loc_18B640:
	moveq	#$2F,d0			; 毒龍鐵胎弓
	cmp.l	d4,d0
	bne.s	loc_18B668
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D88A0).l	; 毒箭
	bra.s	loc_18B6D8
loc_18B668:
	moveq	#$30,d0			; 祝融神火弓
	cmp.l	d4,d0
	bne.s	loc_18B690
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D882C).l	; 爆箭
	bra.s	loc_18B6D8
loc_18B690:
	moveq	#$31,d0			; 猛虎劈山弓
	cmp.l	d4,d0
	bne.s	loc_18B6B8
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D882C).l	; 爆箭
	bra.s	loc_18B6D8
loc_18B6B8:
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D86D0).l	; 長弓
loc_18B6D8:
	move.l	a3,-(sp)
	jsr		$14E076			; 設定機關
	lea		$18(sp),sp
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	clr.w	$6C(a3)
	move.l	a2,d0
	beq.s	loc_18B702
	move.l	$58(a2),$7C(a3)
loc_18B702:
	move.w	#$E,$58(a3)
	movem.l	(sp)+,d2-d5/a2-a3
	rts

off_2D8744:	; 冰箭
	dc.l	unk_2D8690,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E010274,$00000000
	dc.l	$00001000,$00263E1C,$00000000,$00000000
	dc.l	$00000000,$00000026,$3E1C0000,$00000621
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00002000,$00000000,$00000500,$00000000,$00000000
off_2D87B8:	; 火箭
	dc.l	unk_2D8690,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E010274,$00000000
	dc.l	$00001000,$00263E1C,$00000000,$00000000
	dc.l	$40000000,$00000026,$3E1C0000,$00000621
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000500,$00000000,$00000000
off_2D88A0:	; 毒箭
	dc.l	unk_2D8690,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E010274,$00000000
	dc.l	$00001000,$00263E1C,$00000000,$00000000
	dc.l	$00000000,$00000026,$3E1C0000,$00000621
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00001000,$00000000,$00000500,$00000000,$00000000
off_2D882C:	; 爆箭
	dc.l	unk_2D8690,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E010274,$00000000
	dc.l	$00001000,$00263E1C,$00000000,$00000000
	dc.l	$00000000,$00000026,$3E1C0000,$00000621
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$40000000,$00000000,$00000000,$00000000
	dc.l	$00000100,$00000000,$00000500,$00000000,$00000000
off_2D86D0:	; 長弓
	dc.l	unk_2D8690,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E010274,$00000000
	dc.l	$00001000,$00263E1C,$00000000,$00000000
	dc.l	$00000000,$00000026,$3E1C0000,$00000621
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000500,$00000000,$00000000

unk_2D8690:
	dc.l	$20B10300,$00B10300,$20B10600,$00B10600,$20B11500,$00B11500,$20B12000,$00B12000
	dc.l	$F0010600
	dc.l	$F0280200	; 00263E1C
	dc.l	$F0020200,$00B10100
	dc.l	$F0020200,$40B10100
	dc.l	$F0290000
	dc.l	$80000000

sub_18B70E:
	movea.l	4(sp),a0
	movea.l	$F8(a0),a1
	btst	#2,$1C(a1)		; 是否按住A鍵
	beq.s	locret_18B728
	move.b	$B(sp),d0
	ext.w	d0
	add.w	d0,$44(a0)
locret_18B728:
	rts


off_2D8C10:	; 猛黃忠上射
	dc.l	$F0020200,$00A40000
	dc.l	$F0020200,$00A50000
	dc.l	$F0020200,$00A60000
	dc.l	$F0020200,$00A70000
	dc.l	$F00BBF00,$02CA07D0
	dc.l	$F0070000,sub_18B72A	; 射單箭
	dc.l	$F0020200,$00A80000
	dc.l	$F0020200,$00A90000
	dc.l	$F0070003,sub_18B70E	; 是否按住A鍵
	dc.l	$F0020200,$00A90000
	dc.l	$80000000
	dc.l	$F0020200,$00A70000
	dc.l	$F00BBF00,$02CA07D0
	dc.l	$F0070001,sub_18B72A	; 射單箭
	dc.l	$F0020200,$00A80000
	dc.l	$F0020200,$00A90000
	dc.l	$80000000


sub_18B72A:
	movem.l	d2-d5/a2-a3,-(sp)
	move.l	$20(sp),d5
	movea.l	$1C(sp),a2
	jsr		$14DF94		; 分配OBJ
	movea.l	d0,a3
	move.w	$20(a2),d2
	ext.l	d2
	tst.w	$C8(a2)
	bne.s	loc_18B750
	moveq	#$1E,d0
	add.l	d0,d2
	bra.s	loc_18B754
loc_18B750:
	moveq	#$1E,d0
	sub.l	d0,d2
loc_18B754:
	tst.b	d5
	beq.s	loc_18B762
	move.w	$24(a2),d3
	ext.l	d3
	addq.l	#2,d3
	bra.s	loc_18B76A
loc_18B762:
	move.w	$24(a2),d3
	ext.l	d3
	subq.l	#2,d3
loc_18B76A:
	moveq	#0,d4
	move.w	$10C(a2),d4		; 判斷武器
	addi.l	#$26,d4
	moveq	#$31,d0			; 天火雙煞弓5D|原猛虎劈山弓31
	cmp.l	d4,d0
	bne.s	loc_18B7C8
	tst.b	d5
	beq.s	loc_18B7A4
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8A40).l	; 冰箭
	bra.w	loc_18B860
loc_18B7A4:
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8B28).l	; 火箭
	bra.w	loc_18B860
loc_18B7C8:
	moveq	#$2F,d0			; 毒龍鐵胎弓
	cmp.l	d4,d0
	bne.s	loc_18B7F0
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8AB4).l	; 毒箭
	bra.s	loc_18B860
loc_18B7F0:
	moveq	#$30,d0			; 祝融神火弓
	cmp.l	d4,d0
	bne.s	loc_18B818
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8B9C).l	; 爆箭
	bra.s	loc_18B860
loc_18B818:
	moveq	#$31,d0			; 猛虎劈山弓
	cmp.l	d4,d0
	bne.s	loc_18B840
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8B9C).l	; 爆箭
	bra.s	loc_18B860
loc_18B840:
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$2B,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D89CC).l	; 長弓
loc_18B860:
	move.l	a3,-(sp)
	jsr		$14E076		 	; 設定機關
	lea		$18(sp),sp
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	clr.w	$6C(a3)
	move.l	a2,d0
	beq.s	loc_18B88A
	move.l	$58(a2),$7C(a3)
loc_18B88A:
	move.w	#$E,$58(a3)
	movem.l	(sp)+,d2-d5/a2-a3
	rts

off_2D8A40:	; 冰箭
	dc.l	unk_2D898C,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020270,$00000000
	dc.l	$00001000,$00264058,$00000000,$00000000
	dc.l	$00000000,$00000026,$40580000,$0000061F
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00002000,$00000000,$00000400,$00000000,$00000000

off_2D8B28:	; 火箭
	dc.l	unk_2D898C,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020270,$00000000
	dc.l	$00001000,$00264058,$00000000,$00000000
	dc.l	$40000000,$00000026,$40580000,$0000061F
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000400,$00000000,$00000000

off_2D8AB4:	; 毒箭
	dc.l	unk_2D898C,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020270,$00000000
	dc.l	$00001000,$00264058,$00000000,$00000000
	dc.l	$00000000,$00000026,$40580000,$0000061F
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00001000,$00000000,$00000400,$00000000,$00000000

off_2D8B9C:	; 爆箭
	dc.l	unk_2D898C,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020270,$00000000
	dc.l	$00001000,$00264058,$00000000,$00000000
	dc.l	$00000000,$00000026,$40580000,$0000061F
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$40000000,$00000000,$00000000,$00000000
	dc.l	$00000100,$00000000,$00000500,$00000000,$00000000

off_2D89CC:	; 長弓
	dc.l	unk_2D898C,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020270,$00000000
	dc.l	$00001000,$00264058,$00000000,$00000000
	dc.l	$00000000,$00000026,$40580000,$0000061F
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000400,$00000000,$00000000

unk_2D898C:	; 快箭
	dc.l	$20AA02FF,$00AA02FF,$20AA04FF,$00AA04FF,$20AA0CFB,$00AA0CFB,$20AA18F6,$00AA18F6
	dc.l	$F0010600
	dc.l	$F0280200	; 00264058
	dc.l	$F0020200,$00AA0100
	dc.l	$F0020200,$40AA0100
	dc.l	$F0290000
	dc.l	$80000000


off_2D8F44:	; 猛黃忠下射
	dc.l	$F0020300,$00BD00FF
	dc.l	$F0020300,$00BE00FF
	dc.l	$F0020300,$00BF00FF
	dc.l	$F0020500,$00C000FF
	dc.l	$F00BBF00,$02CA07D0
	dc.l	$F0070000,sub_18B896
	dc.l	$F0020200,$00C10000
	dc.l	$F0070009,sub_18B70E,$00C20001,$00C30001
	dc.l	$F0020200,$00430001
	dc.l	$F0030000,$00430006
	dc.l	$F0140009,$00000100
	dc.l	$80000000
	dc.l	$F0020500,$00C00000
	dc.l	$F00BBF00,$02CA07D0
	dc.l	$F0070001,sub_18B896
	dc.l	$F0020200,$00C10001,$00C20001,$00C30001
	dc.l	$F0020200,$00430001
	dc.l	$F0030000,$00430006
	dc.l	$F0140009,$00000100
	dc.l	$80000000

sub_18B896:
	movem.l	d2-d5/a2-a3,-(sp)
	move.l	$20(sp),d5
	movea.l	$1C(sp),a2
	jsr		$14DF94		; 分配OBJ
	movea.l	d0,a3
	move.w	$20(a2),d2
	ext.l	d2
	tst.w	$C8(a2)
	bne.s	loc_18B8BC
	moveq	#$12,d0
	add.l	d0,d2
	bra.s	loc_18B8C0
loc_18B8BC:
	moveq	#$12,d0
	sub.l	d0,d2
loc_18B8C0:
	tst.b	d5
	beq.s	loc_18B8CE
	move.w	$24(a2),d3
	ext.l	d3
	subq.l	#2,d3
	bra.s	loc_18B8D6
loc_18B8CE:
	move.w	$24(a2),d3
	ext.l	d3
	addq.l	#2,d3
loc_18B8D6:
	moveq	#0,d4
	move.w	$10C(a2),d4		; 判斷武器
	addi.l	#$26,d4
	moveq	#$31,d0			; 天火雙煞弓5D|原猛虎劈山弓31
	cmp.l	d4,d0
	bne.s	loc_18B934
	tst.b	d5
	beq.s	loc_18B910
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$1A,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8D74).l	; 冰箭
	bra.w	loc_18B9CC
loc_18B910:
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$1A,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8E5C).l	; 火箭
	bra.w	loc_18B9CC
loc_18B934:
	moveq	#$2F,d0			; 毒龍鐵胎弓
	cmp.l	d4,d0
	bne.s	loc_18B95C
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$1A,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8DE8).l	; 毒箭
	bra.s	loc_18B9CC
loc_18B95C:
	moveq	#$30,d0			; 祝融神火弓
	cmp.l	d4,d0
	bne.s	loc_18B984
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$1A,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8ED0).l	; 爆箭
	bra.s	loc_18B9CC
loc_18B984:
	moveq	#$31,d0			; 猛虎劈山弓
	cmp.l	d4,d0
	bne.s	loc_18B9AC
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$1A,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8ED0).l	; 爆箭
	bra.s	loc_18B9CC
loc_18B9AC:
	moveq	#0,d0
	move.w	$C8(a2),d0
	move.l	d0,-(sp)
	move.l	d3,d0
	moveq	#$1A,d1
	sub.l	d1,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.l	d2,-(sp)
	pea		(off_2D8D00).l	; 長弓
loc_18B9CC:
	move.l	a3,-(sp)
	jsr		$14E076		 	; 設定機關
	lea		$18(sp),sp
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	clr.w	$6C(a3)
	move.l	a2,d0
	beq.s	loc_18B9F6
	move.l	$58(a2),$7C(a3)
loc_18B9F6:
	move.w	#$E,$58(a3)
	movem.l	(sp)+,d2-d5/a2-a3
	rts

off_2D8D74:	; 冰箭
	dc.l	unk_2D8C90,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020274,$00000000
	dc.l	$00001000,$0026429C,$00000000,$00000000
	dc.l	$00000000,$00000026,$429C0000,$00000620
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00002000,$00000000,$00000400,$00000000,$00000000

off_2D8E5C:	; 火箭
	dc.l	unk_2D8C90,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020274,$00000000
	dc.l	$00001000,$0026429C,$00000000,$00000000
	dc.l	$40000000,$00000026,$429C0000,$00000620
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000400,$00000000,$00000000

off_2D8DE8:	; 毒箭
	dc.l	unk_2D8C90,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020274,$00000000
	dc.l	$00001000,$0026429C,$00000000,$00000000
	dc.l	$00000000,$00000026,$429C0000,$00000620
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00001000,$00000000,$00000400,$00000000,$00000000

off_2D8ED0:	; 爆箭
	dc.l	unk_2D8C90,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020274,$00000000
	dc.l	$00001000,$0026429C,$00000000,$00000000
	dc.l	$00000000,$00000026,$429C0000,$00000620
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$40000000,$00000000,$00000000,$00000000
	dc.l	$00000100,$00000000,$00000500,$00000000,$00000000

off_2D8D00:	; 長弓
	dc.l	unk_2D8C90,$0025F19E,$0025F1A2,$0025F1A4
	dc.l	$003379CA,$000CF2BB,$0E020274,$00000000
	dc.l	$00001000,$0026429C,$00000000,$00000000
	dc.l	$00000000,$00000026,$429C0000,$00000620
	dc.l	$00000033,$7A180000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000400,$00000000,$00000000

unk_2D8C90:
	dc.l	$20C40201,$F01B1100
	dc.l	$00C40201,$F01B1100
	dc.l	$20C40401,$F01B1100
	dc.l	$00C40401,$F01B1100
	dc.l	$20C40C05,$F01B1100
	dc.l	$00C40C05,$F01B1100
	dc.l	$20C4180A,$F01B1100
	dc.l	$00C4180A,$F01B1100
	dc.l	$F0010C00
	dc.l	$F0020200,$01330000	; 弓箭落地後|0026429C
	dc.l	$F0020200,$01340000
	dc.l	$F0280200
	dc.l	$F0020200,$01350000
	dc.l	$F0020200,$41350000
	dc.l	$F0290000
	dc.l	$80000000


sub_121B82:
	movea.l	$58(a2),a0
	cmpi.b	#1,(a0)		; 是否敵將
	beq.s	loc_12B37A
	tst.w	$220(a2)
	bne.s	loc_12B37E
loc_12B37A:
	movea.l	a2,a5
	bra.s	loc_12B3A2
loc_12B37E:
	move.w	$20(a2),d4
	sub.w	$20(a3),d4
	bpl.s	loc_12B38A
	neg.w	d4
loc_12B38A:
	movea.l	#$121B8E,a0
	bra.s	locret_121B82
loc_12B3A2:
	movea.l	#$121BA6,a0
locret_121B82:
	rts


byte_1E612A:	; 倚天劍普攻三式[1]
	dc.b	0,0,1,0

sub_157D8A:
	cmpi.w	#$D,$10C(a2)	; 是否倚天劍
	bne.s	loc_157D8A
	movea.l	#byte_1E612A,a0	; 普攻三式
	move.b	d4,d0			; 當前普攻段
	bra.s	locret_157D8A
loc_157D8A:
	movea.l	#$1E611A,a0		; 原代碼
locret_157D8A:
	rts

sub_15AA1E:	; 倚天劍普攻三式[2]
	cmpi.w	#$D,$10C(a4)	; 是否倚天劍
	bne.s	loc_15AA1E
	movea.l	#byte_1E612A,a0	; 普攻三式
	move.w	d7,d0			; 當前普攻段
	bra.s	locret_15AA1E
loc_15AA1E:
	movea.l	#$1E611A,a0		; 原代碼
locret_15AA1E:
	rts

sub_160E02:
	cmpi.w	#$D,$10C(a2)	; 是否倚天劍
	bne.s	loc_160E02
	movea.l	#byte_1E612A,a0	; 普攻三式
	move.b	d3,d0			; 當前普攻段
	bra.s	locret_160E02
loc_160E02:
	movea.l	#$1E611A,a0		; 原代碼
locret_160E02:
	rts


sub_122E82:
	moveq	#0,d3
	move.w	$1B0(a3),d3
	move.l	a2,-(sp)
	jsr		$10F2E2
	addq.l	#4,sp
	tst.l	d0
	beq.w	loc_122F14
	move.l	d3,d0
	subq.l	#3,d0
	moveq	#$1B,d1
	cmp.l	d1,d0
	bhi.w	loc_122F12
	add.l	d0,d0
	move.w	jpt_122EAE(pc,d0.l),d0
	jmp		jpt_122EAE(pc,d0.w)
jpt_122EAE:
	dc.w	loc_122EE6-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122EEA-jpt_122EAE
	dc.w	loc_122EEE-jpt_122EAE
	dc.w	loc_122EF2-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122EFA-jpt_122EAE
	dc.w	loc_122EFE-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F02-jpt_122EAE
	dc.w	loc_122F06-jpt_122EAE
	dc.w	loc_122F0A-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122F12-jpt_122EAE
	dc.w	loc_122EF6-jpt_122EAE
	dc.w	loc_122F0E-jpt_122EAE
loc_122EE6:
	moveq	#3,d3
	bra.s	loc_122F14
loc_122EEA:
	moveq	#7,d3
	bra.s	loc_122F14
loc_122EEE:
	moveq	#8,d3
	bra.s	loc_122F14
loc_122EF2:
	moveq	#9,d3
	bra.s	loc_122F14
loc_122EF6:
	moveq	#$1D,d3
	bra.s	loc_122F14
loc_122EFA:
	moveq	#$C,d3		; 反向擊飛
	bra.s	loc_122F14
loc_122EFE:
	moveq	#$D,d3
	bra.s	loc_122F14
loc_122F02:
	moveq	#$11,d3
	bra.s	loc_122F14
loc_122F06:
	moveq	#$12,d3
	bra.s	loc_122F14
loc_122F0A:
	moveq	#$13,d3
	bra.s	loc_122F14
loc_122F0E:
	moveq	#$1E,d3
	bra.s	loc_122F14
loc_122F12:
	moveq	#2,d3
loc_122F14:
	rts


sub_16A792:
	tst.b	$276(a3)		; 是否C键
	beq.w	loc_16A872
	btst	#4,$1C(a3)		; 是否按左
	beq.s	loc_16A7AA
	cmpi.w	#1,$C8(a2)
	beq.s	loc_16A7B8
loc_16A7AA:
	btst	#3,$1C(a3)		; 是否按右
	beq.s	loc_16A7EA
	tst.w	$C8(a2)
	bne.s	loc_16A7EA
loc_16A7B8:
	cmpi.b	#$3E,d2
	beq.s	loc_16A7EA
; 正面格擋動作
	pea		($3E).w			; 格擋動作
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$15E152			; 動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	addq.l	#8,sp
	clr.w	$FC(a2)
	clr.w	$CC(a2)
	bra.w	loc_16AE26
loc_16A7EA:
	cmpi.b	#$3E,d2
	beq.w	loc_16A872
	btst	#3,$1C(a3)
	beq.s	loc_16A832
	cmpi.w	#1,$C8(a2)
	bne.s	loc_16A832
; 面左反身格擋
	clr.w	$C8(a2)
	pea		($3E).w
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$15E152			; 動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	addq.l	#8,sp
	clr.w	$FC(a2)
	clr.w	$CC(a2)
	bra.w	loc_16AE26
loc_16A832:
; 面右反身格擋
	btst	#4,$1C(a3)
	beq.s	loc_16A872
	tst.w	$C8(a2)
	bne.s	loc_16A872
	move.w	#1,$C8(a2)
	pea		($3E).w
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$15E152			; 動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	addq.l	#8,sp
	clr.w	$FC(a2)
	clr.w	$CC(a2)
	bra.w	loc_16AE26
loc_16A872:
	movea.l	#$157CBC,a0
	rts
loc_16AE26:
	movea.l	#$1581CA,a0
	rts


; --------------- 換將調整 --------------------------------------------------

dword_1C2BC0:	; 援军进场退场动作对敌的受击动作
	dc.l	$F0070000,sub_1C2BC0	; 重置Hit累计
	dc.l	$F0040807	; 解除41限制|动作取消无敌

sub_1C2BC0:
	movea.l	4(sp),a0
	clr.w	$1A0(a0)
	rts


sub_15F93E:
	tst.w	($20a,A2)
	beq.s	locret_15F93E	; 換將時間0强制收回不扣血
	subq.w  #8, ($6c,A2)
	pea     $fff8.w			; 減8個生命值
	move.l  A3, -(A7)
	jsr     $14cf6a.l
	addq.l  #8, A7
locret_15F93E:
	rts

sub_15F952:
	clr.w	($20a,A2)
	clr.w	($be,A2)		; 取消換將狀態
	btst    #1,$244(a2)		; 是否中蠍子毒2
	beq.s   loc_15F953
	bclr    #1,$244(a2)		; 清除蠍子毒2
	clr.w   ($238,A2)		; 清除中毒色盤
	pea     $1.w
	move.l  ($64,A2), -(A7)
	moveq   #$0, D0
	move.w  ($122,A2), D0
	move.l  D0, -(A7)
	jsr     $10391e.l
	addq.l  #4, A7
	move.l  D0, -(A7)
	jsr     $100af6.l
	lea		$c(A7), A7
loc_15F953:
	btst    #7,$244(a2)		; 是否暈眩
	beq.s   loc_15F952
	bclr    #7,$244(a2)		; 清除暈眩狀態
loc_15F952:
	pea     $e.w			; 召回援軍動作
	pea     $1.w
	move.l  A2, -(A7)
	jsr     $15e152
	lea     $c(A7), A7
	move.l  D0, -(A7)
	move.l  A2, -(A7)
	jsr     $15e2da
	addq.l  #8, A7			; 原代碼
	rts


sub_157FCC:
; 是否換將狀態
	pea		($1C).w
	pea		($2).w
	move.l	a2,-(sp)
	jsr		$15E260			; 計算動作指針，無則傳出0
	lea		$C(sp),sp
	tst.l	d0				; 援軍無[021C]動作
	bne.s	loc_157FCC
	cmpi.w	#1,$50(a2)		; 換回角色[010E]動作中取消神行
	bne.s	loc_157FCC
	cmpi.w	#$E,$52(a2)
	beq.s	locret_157FCC
; 空中突行技
loc_157FCC:
	cmpi.w	#3,$50(a2)		; 是否本角危險迴避技
	bne.s	loc_157FCD
	cmpi.w	#9,$52(a2)
	bne.s	loc_157FCD
	tst.w	$24(a2)			; 高度是否為負|空中
	bge.s	loc_157FCD
	pea		($1A).w			; 021A空中速降
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$15E260			; 無動作指針則傳出零
	lea		$C(sp),sp
	movea.l	d0,a5
	move.l	a5,d0
	bne.s	locret_157FCC
; 地面突行技
loc_157FCD:
	pea		($15).w			; 0215地面突行技
	pea		(2).w
	move.l	a2,-(sp)
	jsr		$15E260			; 無動作指針則傳出零
	lea		$C(sp),sp
locret_157FCC:
	rts


sub_112FB4:	; 特殊情況暈眩屬性設定
	movem.l	a2-a4,-(sp)
	tst.b	(ram_0005).l
	bne.s	loc_112FB4			; 107版必定暈眩
	tst.l	$1EC(a2)
	beq.s	loc_112FB5
	movea.l	$1EC(a2),a3
	movea.l	$54(a3),a4			; 攻擊者
	cmpi.b	#4,1(a4)			; 馬超
	beq.s	loc_112FB6
	cmpi.b	#$D,1(a4)			; 程昱
	beq.s	loc_112FB7
	cmpi.b	#$19,1(a4)			; 周泰
	bne.s	loc_112FB5
; 程昱亂心符/周泰普攻第二擊|必暈
loc_112FB7:
	cmpi.l	#$00030001,$184(a2)	; 亂心符|普攻第二擊
	beq.s	loc_112FB4
	bne.s	loc_112FB5
; 玄鐵鴛鴦簡普攻第二擊必暈
loc_112FB6:
	cmpi.w	#$F, $10C(a3)		; 是否玄鐵鴛鴦簡
	bne.s	loc_112FB5
	cmpi.l	#$00030003,$184(a2)	; 普攻第二擊
	bne.s	loc_112FB5
; 暈眩設定
loc_112FB4:
	moveq	#1,d0				; 必定暈眩
loc_112FB5:
	andi.l	#1,d0				; [原代碼]隨機暈眩
	movem.l	(sp)+,a2-a4
	rts

			
sub_14B996:
	tst.w	$42(a2)
	beq.s	loc_14B996
	bset	#0,$1C(a5)
	btst	#2,$1C(a5)
	beq.s	loc_14B9FA
	btst	#1,$1C(a5)
	beq.s	loc_14B9FA
	move.b	#1,$278(a5)
loc_14B9FA:
	tst.b	$41(a2)
	beq.s	loc_14B996
	bset	#0,$20(a5)
	clr.b	$41(a2)
	move.b	#1,$276(a5)
	tst.b	$2D2(a5)
	beq.s	loc_14B996
	cmpi.b	#$A,$2D3(a5)
	bcc.s	loc_14B996
	move.b	#$A,(a3)
	move.l	$252(a5),2(a3)
	addq.b	#1,$2D3(a5)
loc_14B996:
	movea.l	$10(a5),a0
	tst.w	$BE(a0)
	beq.s	loc_14BA2C
	jsr		$1011AC
	moveq	#0,d1
	move.b	1(a5),d1
	lsl.l	#3,d1
	add.l	d1,d0
	addi.l	#$140,d0
	movea.l	d0,a2
	tst.w	2(a2)
	beq.w	locret_14B996
	tst.b	1(a2)
	beq.w	locret_14B996
	clr.b	1(a2)
	movea.l	$10(a5),a0
	clr.w	$20A(a0)
	bra.w	locret_14B996
loc_14BA2C:
	tst.w	2(a4)
	beq.s	locret_14B996
	move.b	#1,$279(a5)
	tst.b	1(a4)
	beq.s	locret_14B996
	clr.b	1(a4)
	move.b	#1,$277(a5)
	tst.b	$2D2(a5)
	beq.s	locret_14B996
	cmpi.b	#$A,$2D3(a5)
	bcc.s	locret_14B996
	move.b	#$B,(a3)
	move.l	$252(a5),2(a3)
	addq.b	#1,$2D3(a5)
locret_14B996:
	rts


sub_157CCE:
	moveq	#0,d0			; 動作是否
	tst.b	$276(a3)		; 是否C键
	beq.s	loc_157CCE
	btst	#4,$1C(a3)		; 是否按左
	beq.s	loc_157C7C
	cmpi.w	#1,$C8(a2)		; 朝左1
	beq.s	loc_157C8A
loc_157C7C:
	btst	#3,$1C(a3)		; 是否按右
	beq.s	loc_157CCE
	tst.w	$C8(a2)			; 朝右0
	bne.s	loc_157CCE
loc_157C8A:
	cmpi.b	#$3E,d2			; 換將格擋動作
	beq.s	loc_157CCE
	pea		$3E.w
	pea		$2.w
	move.l	a2,-(sp)
	jsr		$15E152
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA
	addq.l	#8,sp
	clr.w	$FC(a2)
	clr.w	$CC(a2)
	bra.w	locret_157CCE
loc_157CCE:
	btst	#2,$20(a3)		; 換將挑釁動作
	beq.s	locret_157CCE
	btst	#1,$20(a3)
	beq.s	locret_157CCE
	pea		$9.w
	pea		$3.w
	move.l	a2,-(sp)
	jsr		$15E152
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA
	addq.l	#8,sp
	clr.w	$FC(a2)
	clr.w	$CC(a2)
locret_157CCE:
	rts


off_2119C4:
	dc.w	$0200
	dc.l	$0020FE7C,$01005000,$0,$0
	dc.w	$0201
	dc.l	$0020FEA0,$01005000,$0,$0
	dc.w	$0202
	dc.l	$0020FEC4,$01005000,$0,$0
	dc.w	$0203	; 向上走
	dc.l	off_20FF10,$01000000,$0,$0
	dc.w	$0204	; 斜上走
	dc.l	off_20FF98,$01000000,$0,$0
	dc.w	$0205	; 向前走
	dc.l	off_20FECC,$01000000,$0,$0
	dc.w	$0206	; 斜下走
	dc.l	off_20FFDC,$01000000,$0,$0
	dc.w	$0207	; 向下走
	dc.l	off_20FF54,$01000000,$0,$0
	dc.w	$0208
	dc.l	$00210020,$01000000,$0,$0
	dc.w	$0209
	dc.l	$00210064,$01000000,$0,$0
	dc.w	$020A
	dc.l	$002100A8,$01000000,$0,$0
	dc.w	$020B
	dc.l	$002100EC,$01000000,$0,$0
	dc.w	$020C
	dc.l	$00210150,$01000000,$0,$0
	dc.w	$020D
	dc.l	$002101B4,$01000000,$0,$0
	dc.w	$020E
	dc.l	$00210218,$01000000,$0,$0
	dc.w	$020F
	dc.l	$0021027C,$01000000,$0,$0
	dc.w	$0210
	dc.l	$002103A8,$01000000,$0,$0
	dc.w	$0211
	dc.l	$00210344,$01000000,$0,$0
	dc.w	$0212
	dc.l	$002102E0,$01000000,$0,$0
	dc.w	$0213
	dc.l	$002119BC,$01000000,$0,$0
	dc.w	$0214
	dc.l	$002119C0,$01000000,$0,$0
	dc.w	$0215
	dc.l	off_2111B2,$02000040,$0,$0	; 0215突行技
	dc.w	$0216
	dc.l	$002119BC,$01000000,$0,$0
	dc.w	$0217
	dc.l	$002119BC,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$0021040C,$01003000,$0,$0
	dc.w	$021A
	dc.l	$00210410,$02000000,$0,$0
	dc.w	$021B
	dc.l	$002119BC,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_081712,$01005000,$0,$0	; 格擋前動作

off_20FF10:	; 向上走
	dc.l	$000900FF,$000900FE,$000900FF,$000900FE,$000900FF
	dc.l	$000A00FE,$000A00FF,$000A00FE,$000A00FF,$000A00FE
	dc.l	$000B00FF,$000B00FE,$000B00FF,$000B00FE,$000B00FF
	dc.l	$000C00FE,$000C00FF,$000C00FE,$000C00FF,$000C00FE
	dc.l	$000D00FF,$000D00FE,$000D00FF,$000D00FE,$000D00FF
	dc.l	$000E00FE,$000E00FF,$000E00FE,$000E00FF,$000E00FE
	dc.l	$000F00FF,$000F00FE,$000F00FF,$000F00FE,$000F00FF
	dc.l	$001000FE,$001000FF,$001000FE,$001000FF,$001000FE
	dc.l	$F0010000
off_20FF98:	; 斜上走
	dc.l	$000903FF,$000903FF,$000903FF,$000903FF,$000903FF
	dc.l	$000A03FF,$000A03FF,$000A03FF,$000A03FF,$000A03FF
	dc.l	$000B03FF,$000B03FF,$000B03FF,$000B03FF,$000B03FF
	dc.l	$000C03FF,$000C03FF,$000C03FF,$000C03FF,$000C03FF
	dc.l	$000D03FF,$000D03FF,$000D03FF,$000D03FF,$000D03FF
	dc.l	$000E03FF,$000E03FF,$000E03FF,$000E03FF,$000E03FF
	dc.l	$000F03FF,$000F03FF,$000F03FF,$000F03FF,$000F03FF
	dc.l	$001003FF,$001003FF,$001003FF,$001003FF,$001003FF
	dc.l	$F0010000
off_20FECC:	; 向前走
	dc.l	$00090300,$00090300,$00090300,$00090300,$00090300
	dc.l	$000A0300,$000A0300,$000A0300,$000A0300,$000A0300
	dc.l	$000B0300,$000B0300,$000B0300,$000B0300,$000B0300
	dc.l	$000C0300,$000C0300,$000C0300,$000C0300,$000C0300
	dc.l	$000D0300,$000D0300,$000D0300,$000D0300,$000D0300
	dc.l	$000E0300,$000E0300,$000E0300,$000E0300,$000E0300
	dc.l	$000F0300,$000F0300,$000F0300,$000F0300,$000F0300
	dc.l	$00100300,$00100300,$00100300,$00100300,$00100300
	dc.l	$F0010000
off_20FFDC:	; 斜下走
	dc.l	$00090301,$00090301,$00090301,$00090301,$00090301
	dc.l	$000A0301,$000A0301,$000A0301,$000A0301,$000A0301
	dc.l	$000B0301,$000B0301,$000B0301,$000B0301,$000B0301
	dc.l	$000C0301,$000C0301,$000C0301,$000C0301,$000C0301
	dc.l	$000D0301,$000D0301,$000D0301,$000D0301,$000D0301
	dc.l	$000E0301,$000E0301,$000E0301,$000E0301,$000E0301
	dc.l	$000F0301,$000F0301,$000F0301,$000F0301,$000F0301
	dc.l	$00100301,$00100301,$00100301,$00100301,$00100301
	dc.l	$F0010000
off_20FF54:	; 向下走
	dc.l	$00090001,$00090002,$00090001,$00090002,$00090001
	dc.l	$000A0002,$000A0001,$000A0002,$000A0001,$000A0002
	dc.l	$000B0001,$000B0002,$000B0001,$000B0002,$000B0001
	dc.l	$000C0002,$000C0001,$000C0002,$000C0001,$000C0002
	dc.l	$000D0002,$000D0001,$000D0002,$000D0001,$000D0002,$000D0001
	dc.l	$000E0002,$000E0001,$000E0002,$000E0001,$000E0002
	dc.l	$000F0001,$000F0002,$000F0001,$000F0002,$000F0001
	dc.l	$00100002,$00100001,$00100002,$00100001,$00100002
	dc.l	$F0010000

off_2111B2:
	dc.l	$F00E0000
	dc.l	$F0540500
	dc.l	$F04F2E05
	dc.l	$F0450700
	dc.l	$F0130100,$004DF8F0
	dc.l	$F0280300	; 縮短位移量
	dc.l	$F00B4F00,$00C40000
	dc.l	$F0410100,$004DF800,$204EF8FD,$004FF800
	dc.l	$F0410100,$004DF800,$204EF8FD,$004FF800
	dc.l	$F0290000	; 循環陀螺轉
	dc.l	$F0110000,$00500810,$00500801,$00500802,$00500803
	dc.l	$F0030000,$0051081E
	dc.l	$F0130000
	dc.l	$F0140009,$00000100,$00521A00
	dc.l	$F0020A00,$00520000
	dc.l	$80000000

off_081712:	; 格擋圖$19
	dc.l	$F0020400,$00190000
	dc.l	$80000000


off_210632:
	dc.l	$F0130100
	dc.l	$F0540400
	dc.l	$F04F1111
	dc.l	$F0450200,$002E0000
	dc.l	$F0020100,$002F0000
	dc.l	$F00B9F00,$02C30000,$20300000
	dc.l	$F0330100
	dc.l	$F03400FF,$00320000,$00000000,$20310000
	dc.l	$F03400FF,$00340000,$00000000,$00330000
	dc.l	$F03400FF,$00350000,$00000000,$00330000
	dc.l	$F0330000
	dc.l	$F0020200,$00330000
	dc.l	$F0020100,$00360000
	dc.l	$80000000


off_2137CA:
	dc.w	$0600
	dc.l	$0021322A,$01002040,$0,$0
	dc.w	$0601
	dc.l	$0021325A,$01002040,$0,$0
	dc.w	$0602
	dc.l	$00211232,$02002040,$0,$0	; 夏侯惇-後空翻-26B
	dc.w	$0603
	dc.l	$0021360E,$02000040,$0,$0
	dc.w	$0604
	dc.l	off_210BDE,$01002040,$0,$0	; 疾風金珠-6A

off_210BDE:
	dc.l	$F0130100
	dc.l	$F0540A00
	dc.l	$F04F0115
	dc.l	$F00BEF00,$01420000
	dc.l	$F0020100,$00370000
	dc.l	$F0020300,$00380000
	dc.l	$F0330100
	dc.l	$F0340004,$003A0000,$00000000,$00380000
	dc.l	$F00B6F00,$02C80000
	dc.l	$F0070000,$0016945C	; $210B6A|疾風金珠|0304
	dc.l	$F0340004,$003B0000,$00000000,$00390000
	dc.l	$F0330000,$00390000
	dc.l	$F0130000	; 收尾取消無敵
	dc.l	$F0020600,$00380000
	dc.l	$80000000


off_21E70C:
	dc.w	$0200
	dc.l	$0021D070,$01003000,$0,$0
	dc.w	$0201
	dc.l	$0021D070,$01003000,$0,$0
	dc.w	$0202
	dc.l	$0021D32C,$01001000,$0,$0	; 張郃轉身速度$5000
	dc.w	$0203	; 向上走
	dc.l	off_21D404,$01000000,$0,$0
	dc.w	$0204	; 斜上走
	dc.l	off_21D37C,$01000000,$0,$0
	dc.w	$0205	; 向前走
	dc.l	off_21D338,$01000000,$0,$0
	dc.w	$0206	; 斜下走
	dc.l	off_21D3C0,$01000000,$0,$0
	dc.w	$0207	; 向下走
	dc.l	off_21D448,$01000000,$0,$0
	dc.w	$0208
	dc.l	$0021D514,$01000000,$0,$0
	dc.w	$0209
	dc.l	$0021D48C,$01000000,$0,$0
	dc.w	$020A
	dc.l	$0021D4D0,$01000000,$0,$0
	dc.w	$020B
	dc.l	$0021D558,$01000000,$0,$0
	dc.w	$020C
	dc.l	$0021D830,$01000000,$0,$0
	dc.w	$020D
	dc.l	$0021D6C4,$01000000,$0,$0
	dc.w	$020E
	dc.l	$0021D99C,$01000000,$0,$0
	dc.w	$020F
	dc.l	$0021DB08,$01000000,$0,$0
	dc.w	$0210
	dc.l	$0021DF4C,$01000000,$0,$0
	dc.w	$0211
	dc.l	$0021DC74,$01000000,$0,$0
	dc.w	$0212
	dc.l	$0021DDE0,$01000000,$0,$0
	dc.w	$0213
	dc.l	$0021E704,$01000000,$0,$0
	dc.w	$0214
	dc.l	$0021E708,$01000000,$0,$0
	dc.w	$03FF	; 若03類則有攻擊判定FF無傷害
	dc.l	off_21F996,$02000240,$0,$0	; 0215突行技-跑步
	dc.w	$0216
	dc.l	$0021E704,$01000000,$0,$0
	dc.w	$0217
	dc.l	$0021E704,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$0021CEDE,$01003000,$0,$0
	dc.w	$021A
	dc.l	$0021E0B8,$02000000,$0,$0
	dc.w	$021B
	dc.l	$0021E704,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_081715,$01005000,$0,$0

off_21D404:	; 向上走
	dc.l	$002B00FF,$002B00FE,$002B00FF,$002B00FE,$002B00FF
	dc.l	$002C00FE,$002C00FF,$002C00FE,$002C00FF,$002C00FE
	dc.l	$002D00FF,$002D00FE,$002D00FF,$002D00FE,$002D00FF
	dc.l	$002E00FE,$002E00FF,$002E00FE,$002E00FF,$002E00FE
	dc.l	$002F00FF,$002F00FE,$002F00FF,$002F00FE,$002F00FF
	dc.l	$003000FE,$003000FF,$003000FE,$003000FF,$003000FE
	dc.l	$003100FF,$003100FE,$003100FF,$003100FE,$003100FF
	dc.l	$003200FE,$003200FF,$003200FE,$003200FF,$003200FE
	dc.l	$F0010000
off_21D37C:	; 斜上走
	dc.l	$002B03FF,$002B03FF,$002B03FF,$002B03FF,$002B03FF
	dc.l	$002C03FF,$002C03FF,$002C03FF,$002C03FF,$002C03FF
	dc.l	$002D03FF,$002D03FF,$002D03FF,$002D03FF,$002D03FF
	dc.l	$002E03FF,$002E03FF,$002E03FF,$002E03FF,$002E03FF
	dc.l	$002F03FF,$002F03FF,$002F03FF,$002F03FF,$002F03FF
	dc.l	$003003FF,$003003FF,$003003FF,$003003FF,$003003FF
	dc.l	$003103FF,$003103FF,$003103FF,$003103FF,$003103FF
	dc.l	$003203FF,$003203FF,$003203FF,$003203FF,$003203FF
	dc.l	$F0010000
off_21D338:	; 向前走
	dc.l	$002B0300,$002B0300,$002B0300,$002B0300,$002B0300
	dc.l	$002C0300,$002C0300,$002C0300,$002C0300,$002C0300
	dc.l	$002D0300,$002D0300,$002D0300,$002D0300,$002D0300
	dc.l	$002E0300,$002E0300,$002E0300,$002E0300,$002E0300
	dc.l	$002F0300,$002F0300,$002F0300,$002F0300,$002F0300
	dc.l	$00300300,$00300300,$00300300,$00300300,$00300300
	dc.l	$00310300,$00310300,$00310300,$00310300,$00310300
	dc.l	$00320300,$00320300,$00320300,$00320300,$00320300
	dc.l	$F0010000
off_21D3C0:	; 斜下走
	dc.l	$002B0301,$002B0301,$002B0301,$002B0301,$002B0301
	dc.l	$002C0301,$002C0301,$002C0301,$002C0301,$002C0301
	dc.l	$002D0301,$002D0301,$002D0301,$002D0301,$002D0301
	dc.l	$002E0301,$002E0301,$002E0301,$002E0301,$002E0301
	dc.l	$002F0301,$002F0301,$002F0301,$002F0301,$002F0301
	dc.l	$00300301,$00300301,$00300301,$00300301,$00300301
	dc.l	$00310301,$00310301,$00310301,$00310301,$00310301
	dc.l	$00320301,$00320301,$00320301,$00320301,$00320301
	dc.l	$F0010000
off_21D448:	; 向下走
	dc.l	$002B0001,$002B0002,$002B0001,$002B0002,$002B0001
	dc.l	$002C0002,$002C0001,$002C0002,$002C0001,$002C0002
	dc.l	$002D0001,$002D0002,$002D0001,$002D0002,$002D0001
	dc.l	$002E0002,$002E0001,$002E0002,$002E0001,$002E0002
	dc.l	$002F0002,$002F0001,$002F0002,$002F0001,$002F0002,$002F0001
	dc.l	$00300002,$00300001,$00300002,$00300001,$00300002
	dc.l	$00310001,$00310002,$00310001,$00310002,$00310001
	dc.l	$00320002,$00320001,$00320002,$00320001,$00320002
	dc.l	$F0010000

off_21F996:	; 縮短位移
	dc.l	$F0130100
	dc.l	$F0540400
	dc.l	$F04F1B15
	dc.l	$F0450200
	dc.l	$F0330100
	dc.l	$F0260100
	dc.l	$F0410100
	dc.l	$F0280300	; $F0280400
	dc.l	$F02700FF,$007D0000,$00070000
	dc.l	$F03400FF,$00850000,$00070000,$20750500	; $20750700
	dc.l	$F0290000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280300
	dc.l	$F02700FF,$007E0000,$00070000
	dc.l	$F03400FF,$00860000,$00070000,$20760500
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F02700FF,$007F0000,$00070000
	dc.l	$F03400FF,$00870000,$00070000,$20770500
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F02700FF,$00800000,$00070000
	dc.l	$F03400FF,$00880000,$00070000,$20780500
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F02700FF,$00810000,$00070000
	dc.l	$F03400FF,$00890000,$00070000,$20790500
	dc.l	$F0290000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280300
	dc.l	$F02700FF,$00820000,$00070000
	dc.l	$F03400FF,$008A0000,$00070000,$207A0500
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F02700FF,$00830000,$00070000
	dc.l	$F03400FF,$008B0000,$00070000,$207B0500
	dc.l	$F0290000
	dc.l	$F0130000
	dc.l	$F0280300
	dc.l	$F02700FF,$00840000,$00070000
	dc.l	$F03400FF,$008C0000,$00070000,$207C0500
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$F0260000
	dc.l	$80000000

off_081715:	; 格擋圖$1D
	dc.l	$F0020400,$001D0000
	dc.l	$80000000


dword_21F116:
	dc.l	$F0540300
	dc.l	$F04F2E15
	dc.l	$F0451100
	dc.l	$F0130100
	dc.l	$F0020600,$00440000
	dc.l	$00452300,$00450500,$00450300,$00450200
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0260100
	dc.l	$F0020300
	dc.l	$F02700FF,$00590000,$00000000,$20460000
	dc.l	$F0020300
	dc.l	$F02700FF,$005A0000,$00000000,$20460000
	dc.l	$F0020300
	dc.l	$F02700FF,$005B0000,$00000000,$20470000
	dc.l	$F0020300
	dc.l	$F02700FF,$005C0000,$00000000,$20470000
	dc.l	$F0020300
	dc.l	$F02700FF,$005D0000,$00000000,$20480000
	dc.l	$F0020300
	dc.l	$F02700FF,$005E0000,$00000000,$20480000
	dc.l	$F0020300
	dc.l	$F02700FF,$005F0000,$00000000,$20490000
	dc.l	$F0020300
	dc.l	$F02700FF,$00600000,$00000000,$20490000
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0020300
	dc.l	$F02700FF,$00590000,$00000000,$204A0000
	dc.l	$F0020300
	dc.l	$F02700FF,$005A0000,$00000000,$204A0000
	dc.l	$F0260000
	dc.l	$F0020600,$00440000,$80000000
	dc.l	$80000000


dword_2214F2:	; 張郃普攻一式
	dc.l	$F0540300
	dc.l	$F04F1B15
	dc.l	$F0450C00
	dc.l	$F0550000	; 可接下一式
	dc.l	$F0580100
	dc.l	$F0020300,$00610000
	dc.l	$F00BBF00,$02C70000
	dc.l	$F0020200,$20620000
	dc.l	$F0110000,$206DF800
	dc.l	$F0020200,$206D0000
	dc.l	$F0020200,$206E0000
	dc.l	$F0020200,$006F0000
	dc.l	$F0110000,$0061F800
	dc.l	$F0020300,$00610000
	dc.l	$F0570301	; 可接二式
	dc.l	$80000000


off_222272:
	dc.w	$0600
	dc.l	$00221C5E,$01003240,$0,$0
	dc.w	$0601
	dc.l	$0022185A,$02000240,$0,$0
	dc.w	$0602	; 掃蕩群邪[↘B]
	dc.l	dword_259894,$01000240,$0,$0
	dc.w	$0603	; 上天下地|定位坐標
	dc.l	dword_21F47A,$02000240,$0,$0


dword_259894:
	dc.l	$F0540300
	dc.l	$F04F2E15
	dc.l	$F0451100
	dc.l	$F0130100
	dc.l	$F0121F00
	dc.l	$F0020200,$00440000
	dc.l	$F012FF00
	dc.l	$F0020300,$00440000
	dc.l	$F0121F00
	dc.l	$F0020200,$00440000
	dc.l	$F012FF00
	dc.l	$F0130000
	dc.l	$00452300,$00450500,$00450300,$00450200
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0260100
	dc.l	$F0020300
	dc.l	$F02700FF,$00590000,$00000000,$20460000
	dc.l	$F0020300
	dc.l	$F02700FF,$005A0000,$00000000,$20460000
	dc.l	$F0020300
	dc.l	$F02700FF,$005B0000,$00000000,$20470000
	dc.l	$F0020300
	dc.l	$F02700FF,$005C0000,$00000000,$20470000
	dc.l	$F0020300
	dc.l	$F02700FF,$005D0000,$00000000,$20480000
	dc.l	$F0020300
	dc.l	$F02700FF,$005E0000,$00000000,$20480000
	dc.l	$F0020300
	dc.l	$F02700FF,$005F0000,$00000000,$20490000
	dc.l	$F0020300
	dc.l	$F02700FF,$00600000,$00000000,$20490000
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0020300
	dc.l	$F02700FF,$00590000,$00000000,$204A0000
	dc.l	$F0020300
	dc.l	$F02700FF,$005A0000,$00000000,$204A0000
	dc.l	$F015FF00,off_259820,$00320000
	dc.l	$F0260000
	dc.l	$F0020600,$00440000
	dc.l	$80000000

off_259820:	; 地板鐵鏈
	dc.l	dword_2597CC
	dc.l	$0021B9D0,$0021B9D4,$0021B9D6,$00354D3C
	dc.l	$002E54D6,$07010420,$00000000,$00000A00
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000602,$00000035
	dc.l	$4D560000,$00000000,sub_17F7BE,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00001B00,$00000000,$00000000

dword_2597CC:	; 圓周前進運動
	dc.l	$F0280400
	dc.l	$F00B9F00,$02C60000
	dc.l	$F0020200,$20590600
	dc.l	$F0020200,$205A0600
	dc.l	$F0020200,$205B0600
	dc.l	$F0020200,$205C0600
	dc.l	$F0020200,$205D0600
	dc.l	$F0020200,$205E0600
	dc.l	$F0020200,$205F0600
	dc.l	$F0020200,$20600600
	dc.l	$F0290000
	dc.l	$80000000

sub_17F7BE:	; 受擊者動作
	link	a6,#0
	movea.l	8(a6),a1
	movea.l	$C(a6),a0
	move.w	$5C(a0),d0
	cmp.w	$C8(a1),d0
	bne.s	loc_17F7DA
	pea		(8).w
	bra.s	loc_17F7DE
loc_17F7DA:
	pea		($12).w
loc_17F7DE:
	pea		(8).w
	move.l	a1,-(sp)
	jsr		$15E152		; 計算動作指針
	unlk	a6
	rts


dword_21F47A:	; 上天下地
	dc.l	$F0540400
	dc.l	$F04F1115
	dc.l	$F0450800
	dc.l	$F0130100
	dc.l	$F0020600,$008D0000
	dc.l	$F00BFF00,$01550000
	dc.l	$F0020600,$008E0000
	dc.l	$F00BBF00,$02C70000
	dc.l	$F0330300
	dc.l	$F03400FF,$00900000,$00000000
	dc.l	$F03401FF,$00900000,$00000000
	dc.l	$F03402FF,$00910000,$00000000,$008F0000
	dc.l	$F03400FF,$00900000,$000000EC
	dc.l	$F03401FF,$00900000,$000000EC
	dc.l	$F03402FF,$00910000,$000000EC,$008F0000
	dc.l	$F03400FF,$00900000,$000000D8
	dc.l	$F03401FF,$00900000,$000000D8
	dc.l	$F03402FF,$00910000,$000000D8,$008F0000
	dc.l	$F03400FF,$00900000,$000000D8
	dc.l	$F03401FF,$00900000,$000000C4
	dc.l	$F03402FF,$00910000,$000000C4,$008F0000
	dc.l	$F03400FF,$00900000,$000000D8
	dc.l	$F03401FF,$00900000,$000000B0
	dc.l	$F03402FF,$00910000,$000000B0,$008F0000
	dc.l	$F0280300
	dc.l	$F03400FF,$00930000,$00000000
	dc.l	$F03401FF,$00930000,$FFF900CE
	dc.l	$F03402FF,$00930000,$FFF2009C,$00920000
	dc.l	$F0290000
	dc.l	$F061FE00,$0021F406,$00000100
	dc.l	$F0130000
	dc.l	$F03400FF,$00950000,$00000000
	dc.l	$F03401FF,$00950000,$000000CE
	dc.l	$F03402FF,$00950000,$0000009C,$00940000
	dc.l	$F0281100
	dc.l	$F03400FF,$00950000,$0000F200
	dc.l	$F03401FF,$00950000,$0000F2CE
	dc.l	$F03402FF,$00950000,$0000F29C,$009400F2
	dc.l	$F0290000
	dc.l	$F0070000,$00168E48	; 隨機空中待定時間
	dc.l	$F0020A00,$00940000
	dc.l	$F0070000,sub_168E72	; 定位敵人坐標
	dc.l	$F00E0000	; 恢復速度
	dc.l	$F0281100
	dc.l	$F03400FF,$00970000,$00000E00
	dc.l	$F03401FF,$00970000,$00000ECE
	dc.l	$F03402FF,$00970000,$00000E9C,$2096000E
	dc.l	$F0290000
	dc.l	$F03400FF,$00990000,$00000000
	dc.l	$F03401FF,$00990000,$000000CE
	dc.l	$F03402FF,$00990000,$0000009C
	dc.l	$F0030000,$0098000C
	dc.l	$F0140008,$00000100
	dc.l	$F0280500
	dc.l	$F03400FF,$00990000,$00000000
	dc.l	$F03401FF,$00990000,$000000CE
	dc.l	$F03402FF,$00990000,$0000009C,$00980000
	dc.l	$F0290000
	dc.l	$F0330000,$009A1000
	dc.l	$F0020400,$009A0000
	dc.l	$F0020400,$009B0000
	dc.l	$F0110000
	dc.l	$80000000

sub_168E72:	; 張郃上天入地|定位
	movem.l a2-a3,-(sp)
	movea.l $C(sp),a3
	jsr     $10B08C.l		; 第一順位敵方OBJ
	bra.w   loc_16B830
loc_16B76A:
; 是否定位
	tst.w   $174(a2)
	bne.w   loc_16B826
	cmpi.w  #2,$C(a2)
	bne.w   loc_16B826
	cmpi.w  #$A,$50(a2)
	beq.w   loc_16B826
	move.w  $20(a2),d0
	cmp.w   ($D0A000).l,d0
	blt.w   loc_16B826
	move.w  $20(a2),d0
	ext.l   d0
	move.w  ($D0A000).l,d1
	ext.l   d1
	addi.l  #$1C0,d1
	cmp.l   d1,d0
	bgt.s   loc_16B826
	tst.w   $A2(a2)
	bne.s   loc_16B826
	cmpi.w  #8,$50(a2)
	bne.s   loc_16B7D0
	cmpi.w  #5,$52(a2)
	beq.s   loc_16B826
	cmpi.w  #$F,$52(a2)
	beq.s   loc_16B826
loc_16B7D0:
; 定點坐標
	move.w  $C8(a2),d0
	moveq   #1,d1
	eor.w   d1,d0
	move.w  d0,$C8(a3)		; 面向
	move.w  $20(a2),$20(a3)	; 橫坐標
	move.w  $22(a2),$22(a3)	; 縱坐標
	bra.s	loc_16B858
loc_16B826:
	move.l  a2,-(sp)
	jsr     $10B0AC.l		; 下一順位敵方OBJ
	addq.l  #4,sp
loc_16B830:
	movea.l d0,a2
	move.l  a2,d0
	bne.w   loc_16B76A
loc_16B858:
	movem.l (sp)+,a2-a3
	rts


off_26214E:
	dc.l	$F0540800
	dc.l	$F04F1207
	dc.l	$F0450C00	; 反向橫飛
	dc.l	$F0550000
	dc.l	$F0580100	; 招式可取消
	dc.l	$F00BFF00,$01660000
	dc.l	$F0020300,$00810000
	dc.l	$F0140004,$00320100
	dc.l	$F00B9F00,$00C80000
	dc.l	$F0330100
	dc.l	$F03400FF,$00660000,$00000000,$20670000
	dc.l	$F0330000
	dc.l	$F0330200
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00660000,$003C0000,$20680000
	dc.l	$F0330000
	dc.l	$F0330300
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00650000,$00140000
	dc.l	$F03402FF,$00660000,$00500000,$20690000
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00650000,$00280000
	dc.l	$F03402FF,$00660000,$00640000,$206A0000
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00650000,$003C0000
	dc.l	$F03402FF,$00660000,$00780000,$206B0000
	dc.l	$F0280300
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00650000,$00500000
	dc.l	$F03402FF,$00660000,$008C0000,$206C0000
	dc.l	$F0290000
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00650000,$003C0000
	dc.l	$F03402FF,$00660000,$00780000,$006B0000
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00650000,$00280000
	dc.l	$F03402FF,$00660000,$00640000,$006A0000
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00650000,$00140000
	dc.l	$F03402FF,$00660000,$00500000,$00690000
	dc.l	$F0330000
	dc.l	$F0330200
	dc.l	$F03400FF,$00650000,$00000000
	dc.l	$F03401FF,$00660000,$003C0000,$00680000
	dc.l	$F0330000
	dc.l	$F0330100
	dc.l	$F03400FF,$00660000,$00000000,$00670000
	dc.l	$F0330000
	dc.l	$F0020300,$00810000
	dc.l	$80000000


off_22895A:	; 甘寧轉身用弓弩射出的箭矢
	dc.l	$0022893A,$00225142,$00225146,$00225148
	dc.l	$003562D4,$00324AB4,$07020100,$00000000	; $1A(OBJ)定義機關出畫面關閉|$1B(OBJ)定義機關色盤
	dc.l	$00000000,$0022894A,$00000000,$00000000
	dc.l	$00000000,$00000022,$894A0000,$00000605	; 對應編號
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000100,$00000000,$00000000,$00000000,$00000000	; $62(OBJ)爆炸屬性


off_22829C:
	dc.w	$0200
	dc.l	$0022671C,$01007000,$0,$0
	dc.w	$0201
	dc.l	$0022671C,$01007000,$0,$0
	dc.w	$0202	; 甘寧轉身速度$5000
	dc.l	$00226F54,$01001000,$0,$0
	dc.w	$0203	; 向上走
	dc.l	off_226FB0,$01000000,$0,$0
	dc.w	$0204	; 斜上走
	dc.l	off_227048,$01000000,$0,$0
	dc.w	$0205	; 向前走
	dc.l	off_226F64,$01000000,$0,$0
	dc.w	$0206	; 斜下走
	dc.l	off_227094,$01000000,$0,$0
	dc.w	$0207	; 向下走
	dc.l	off_226FFC,$01000000,$0,$0
	dc.w	$0208
	dc.l	$002270E0,$01000000,$0,$0
	dc.w	$0209
	dc.l	$0022712C,$01000000,$0,$0
	dc.w	$020A
	dc.l	$00227178,$01000000,$0,$0
	dc.w	$020B
	dc.l	$00228290,$02004040,$0,$0
	dc.w	$020C	; 斜上跑
	dc.l	off_227238,$01000000,$0,$0
	dc.w	$020D	; 直綫跑
	dc.l	off_2272AC,$01000000,$0,$0
	dc.w	$020E	; 斜下跑
	dc.l	off_227320,$01000000,$0,$0
	dc.w	$020F
	dc.l	$00228290,$02004040,$0,$0
	dc.w	$0210
	dc.l	$00228290,$02004040,$0,$0
	dc.w	$0211
	dc.l	$00228290,$02004040,$0,$0
	dc.w	$0212
	dc.l	$00228290,$02004040,$0,$0
	dc.w	$0213
	dc.l	$00228294,$01000000,$0,$0
	dc.w	$0214
	dc.l	$00228298,$01000000,$0,$0
	dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
	dc.l	$00229E2E,$01000040,$0,$0	; 0215突行技
	dc.w	$0216
	dc.l	$00228294,$01000000,$0,$0
	dc.w	$0217
	dc.l	$00228294,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$0022787C,$01003000,$0,$0
	dc.w	$021A
	dc.l	$002278A0,$02000000,$0,$0
	dc.w	$021B
	dc.l	$00228294,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E	; 格擋前動作
	dc.l	off_081718,$01005000,$0,$0

off_226FB0:	; 向上走
	dc.l	$001800FF,$001800FE,$001800FF,$001800FE,$001800FF
	dc.l	$001900FE,$001900FF,$001900FE,$001900FF,$001900FE
	dc.l	$001A00FF,$001A00FE,$001A00FF,$001A00FE,$001A00FF
	dc.l	$001B00FE,$001B00FF,$001B00FE,$001B00FF,$001B00FE
	dc.l	$001C00FF,$001C00FE,$001C00FF,$001C00FE,$001C00FF
	dc.l	$001D00FE,$001D00FF,$001D00FE,$001D00FF,$001D00FE
	dc.l	$001E00FF,$001E00FE,$001E00FF,$001E00FE,$001E00FF
	dc.l	$001F00FE,$001F00FF,$001F00FE,$001F00FF,$001F00FE
	dc.l	$F00B7F00,$00CA0000	; 腰間鈴鐺
	dc.l	$F0010000
off_227048:	; 斜上走
	dc.l	$001803FF,$001803FF,$001803FF,$001803FF,$001803FF
	dc.l	$001903FF,$001903FF,$001903FF,$001903FF,$001903FF
	dc.l	$001A03FF,$001A03FF,$001A03FF,$001A03FF,$001A03FF
	dc.l	$001B03FF,$001B03FF,$001B03FF,$001B03FF,$001B03FF
	dc.l	$001C03FF,$001C03FF,$001C03FF,$001C03FF,$001C03FF
	dc.l	$001D03FF,$001D03FF,$001D03FF,$001D03FF,$001D03FF
	dc.l	$001E03FF,$001E03FF,$001E03FF,$001E03FF,$001E03FF
	dc.l	$001F03FF,$001F03FF,$001F03FF,$001F03FF,$001F03FF
	dc.l	$F00B7F00,$00CA0000	; 腰間鈴鐺
	dc.l	$F0010000
off_226F64:	; 向前走
	dc.l	$00180300,$00180300,$00180300,$00180300,$00180300
	dc.l	$00190300,$00190300,$00190300,$00190300,$00190300
	dc.l	$001A0300,$001A0300,$001A0300,$001A0300,$001A0300
	dc.l	$001B0300,$001B0300,$001B0300,$001B0300,$001B0300
	dc.l	$001C0300,$001C0300,$001C0300,$001C0300,$001C0300
	dc.l	$001D0300,$001D0300,$001D0300,$001D0300,$001D0300
	dc.l	$001E0300,$001E0300,$001E0300,$001E0300,$001E0300
	dc.l	$001F0300,$001F0300,$001F0300,$001F0300,$001F0300
	dc.l	$F00B7F00,$00CA0000	; 腰間鈴鐺
	dc.l	$F0010000
off_227094:	; 斜下走
	dc.l	$00180301,$00180301,$00180301,$00180301,$00180301
	dc.l	$00190301,$00190301,$00190301,$00190301,$00190301
	dc.l	$001A0301,$001A0301,$001A0301,$001A0301,$001A0301
	dc.l	$001B0301,$001B0301,$001B0301,$001B0301,$001B0301
	dc.l	$001C0301,$001C0301,$001C0301,$001C0301,$001C0301
	dc.l	$001D0301,$001D0301,$001D0301,$001D0301,$001D0301
	dc.l	$001E0301,$001E0301,$001E0301,$001E0301,$001E0301
	dc.l	$001F0301,$001F0301,$001F0301,$001F0301,$001F0301
	dc.l	$F00B7F00,$00CA0000	; 腰間鈴鐺
	dc.l	$F0010000
off_226FFC:	; 向下走
	dc.l	$00180001,$00180002,$00180001,$00180002,$00180001
	dc.l	$00190002,$00190001,$00190002,$00190001,$00190002
	dc.l	$001A0001,$001A0002,$001A0001,$001A0002,$001A0001
	dc.l	$001B0002,$001B0001,$001B0002,$001B0001,$001B0002
	dc.l	$001C0002,$001C0001,$001C0002,$001C0001,$001C0002,$001C0001
	dc.l	$001D0002,$001D0001,$001D0002,$001D0001,$001D0002
	dc.l	$001E0001,$001E0002,$001E0001,$001E0002,$001E0001
	dc.l	$001F0002,$001F0001,$001F0002,$001F0001,$001F0002
	dc.l	$F00B7F00,$00CA0000	; 腰間鈴鐺
	dc.l	$F0010000

off_228BF2:
	dc.l	$F0130100	; 全程無敵
	dc.l	$F0070000,$0016ACB0
	dc.l	$F00E0200	; 後跳加速
	dc.l	$00810000,$0028FBFD,$0082F3FD,$0083EB00,$0084E706,$0085DF00,$0081D900
	dc.l	$F0140009,$FFF60100
	dc.l	$F00E0000
	dc.l	$F0540400
	dc.l	$F04F0413
	dc.l	$F0020A00,$00810000
	dc.l	$F0020300,$002806FB
	dc.l	$F0020300,$002806FC
	dc.l	$F0020400,$002806FD
	dc.l	$F0020300,$002906FE
	dc.l	$F0020400,$002A06FF
	dc.l	$F00BFF00,$01660000
	dc.l	$F0020400,$003D0600
	dc.l	$F00B9F00,$00CB0000
	dc.l	$F0020400,$203E0600
	dc.l	$F0280300
	dc.l	$F0330100
	dc.l	$F03400FF,$00400000,$00030001,$203F0301
	dc.l	$F0330000
	dc.l	$F0070000,$0016AFEC
	dc.l	$F0410100
	dc.l	$F0330200
	dc.l	$F03400FF,$00400000,$000F000D
	dc.l	$F03401FF,$00420000,$00030001,$203F0301
	dc.l	$F0330000
	dc.l	$F0330300
	dc.l	$F03400FF,$00410000,$0010000E
	dc.l	$F03401FF,$00420000,$000F000D
	dc.l	$F03402FF,$00440000,$00030001,$203F0301
	dc.l	$F0330000
	dc.l	$F0330200
	dc.l	$F03400FF,$00430000,$0010000E
	dc.l	$F03401FF,$00440000,$000F000D,$203F0301
	dc.l	$F0330000
	dc.l	$F0410100
	dc.l	$F0330100
	dc.l	$F03400FF,$00450000,$0010000E,$203F0301
	dc.l	$F0330000
	dc.l	$F0290000,$002A0612
	dc.l	$F0020300,$002A0302
	dc.l	$F0030000,$002A0314
	dc.l	$F0140009,$00000100
	dc.l	$F0020700,$002C0000
	dc.l	$80000000


off_229EAA:
	dc.w	$0600
	dc.l	$0022969A,$02000040,0,0
	dc.w	$0601	; 小鬼獻寶-燃燒彈
	dc.l	_off_229A5E,$01001040,0,0
	dc.w	$0602
	dc.l	$00229AAE,$02000040,$10000000,$0
	dc.w	$0603	; 上天下地-硬漢
	dc.l	off_229CAA,$02000040,0,0
	dc.w	$0604	; 後發制人-6A
	dc.l	off_2289CE,$01001040,0,0
	dc.w	$0605	; 小鬼獻寶-烟霧彈-426A
	dc.l	off_229A5E,$01001040,0,0

off_229A5E:	; 小鬼獻寶-烟霧彈
	dc.l	$F00BFF00,$01640000
	dc.l	$F0020200,$00100000
	dc.l	$F0020200,$00110000
	dc.l	$F0020200,$00120000
	dc.l	$F0070000,sub_16B612
	dc.l	$F0020200,$00130000
	dc.l	$F0020200,$00140000
	dc.l	$F0020A00,$00150000
	dc.l	$80000000

sub_16B612:	; 降將甘寧|小鬼獻寶|烟霧彈
	link	a6,#-4
	movem.l	d2-d6/a2-a3,-(sp)
	movea.l	8(a6),a2
	move.b	#1,-1(a6)
	tst.w	$C8(a2)
	beq.s	loc_16B632
	move.b	#$FF,-1(a6)
loc_16B632:
	move.w	$20(a2),d3
	move.w	$22(a2),d4
	move.w	$24(a2),d5
	moveq	#0,d2
loc_16B652:
	tst.w	$C8(a2)
	beq.s	loc_16B66C
	movea.l	#$2B5AC8,a0
	move.b	(a0,d2.l),d0
	ext.w	d0
	move.w	$20(a2),d3
	sub.w	d0,d3
	bra.s	loc_16B67C
loc_16B66C:
	movea.l	#$2B5AC8,a0
	move.b	(a0,d2.l),d3
	ext.w	d3
	add.w	$20(a2),d3
loc_16B67C:
	jsr		$14DF94		; 分配機關OBJ
	movea.l	d0,a3
	clr.l	-(sp)
	move.w	d5,d0
	ext.l	d0
	subi.l	#$1E,d0
	move.l	d0,-(sp)
	movea.l	#$2B5AD0,a0
	move.b	(a0,d2.l),d0
	ext.w	d0
	ext.l	d0
	move.w	d4,d1
	ext.l	d1
	add.l	d1,d0
	move.l	d0,-(sp)
	move.w	d3,d0
	ext.l	d0
	move.l	d0,-(sp)
	pea		($2299EA).l	; 小鬼獻寶：烟霧彈
	move.l	a3,-(sp)
	jsr		$14E076		; 設定機關
	lea		$18(sp),sp
	move.l	a2,$78(a3)
	move.w	#3,$6C(a3)	; 敵我判定
	move.l	a2,d0
	beq.s	loc_16B720
	move.l	$58(a2),$7C(a3)
loc_16B720:
	movea.l	#$2B5AD8,a0
	move.b	(a0,d2.l),d0
	ext.w	d0
	move.w	d0,$EA(a3)
	move.w	#1,$6E(a3)
	addq.l	#1,d2
	moveq	#7,d0
	cmp.l	d2,d0
	bgt.w	loc_16B652
	movem.l	-$20(a6),d2-d6/a2-a3
	unlk	a6
	rts

_off_229A5E:	; 小鬼獻寶-燃燒彈
	dc.l	$F00BFF00,$01650000
	dc.l	$F0130100
	dc.l	$F0020200,$00100000
	dc.l	$F0020200,$00110000
	dc.l	$F0020200,$00120000
	dc.l	$F0130000
	dc.l	$F0070000,_sub_16B612
	dc.l	$F0020200,$00130000
	dc.l	$F0020200,$00140000
	dc.l	$F0020A00,$00150000
	dc.l	$F0130000
	dc.l	$80000000

_sub_16B612:	; 降將甘寧|小鬼獻寶|燃燒彈
	link	a6,#-4
	movem.l	d2-d6/a2-a3,-(sp)
	movea.l	8(a6),a2
	move.b	#1,-1(a6)
	tst.w	$C8(a2)
	beq.s	_loc_16B632
	move.b	#$FF,-1(a6)
_loc_16B632:
	move.w	$20(a2),d3
	move.w	$22(a2),d4
	move.w	$24(a2),d5
	moveq	#0,d2
_loc_16B652:
	tst.w	$C8(a2)
	beq.s	_loc_16B66C
	movea.l	#$2B5AC8,a0
	move.b	(a0,d2.l),d0
	ext.w	d0
	move.w	$20(a2),d3
	sub.w	d0,d3
	bra.s	_loc_16B67C
_loc_16B66C:
	movea.l	#$2B5AC8,a0
	move.b	(a0,d2.l),d3
	ext.w	d3
	add.w	$20(a2),d3
_loc_16B67C:
	jsr		$14DF94		; 分配機關OBJ
	movea.l	d0,a3
	clr.l	-(sp)
	move.w	d5,d0
	ext.l	d0
	subi.l	#$1E,d0
	move.l	d0,-(sp)
	movea.l	#$2B5AD0,a0
	move.b	(a0,d2.l),d0
	ext.w	d0
	ext.l	d0
	move.w	d4,d1
	ext.l	d1
	add.l	d1,d0
	move.l	d0,-(sp)
	move.w	d3,d0
	ext.l	d0
	move.l	d0,-(sp)
	pea		($22987E).l	; 小鬼獻寶：燃燒彈
	move.l	a3,-(sp)
	jsr		$14E076		; 設定機關
	lea		$18(sp),sp
	move.w	$60(a2),$50(a3)
	move.w	$60(a2),$8A(a3)
	move.l	a2,$78(a3)
	clr.w	$6C(a3)
	move.l	a2,d0
	beq.s	_loc_16B720
	move.l	$58(a2),$7C(a3)
_loc_16B720:
	movea.l	#$2B5AD8,a0
	move.b	(a0,d2.l),d0
	ext.w	d0
	move.w	d0,$EA(a3)
	move.w	#1,$6E(a3)
	addq.l	#1,d2
	moveq	#7,d0
	cmp.l	d2,d0
	bgt.w	_loc_16B652
	movem.l	-$20(a6),d2-d6/a2-a3
	unlk	a6
	rts

off_2289CE:
	dc.l	$F0130100
	dc.l	$F00BEF00,$016D0000
	dc.l	$F0020200,$00630000
	dc.l	$F0020200,$00620000
	dc.l	$F0020200,$00610000
	dc.l	$F0020500,$006D0000
	dc.l	$F0070000,$0016B49A
	dc.l	$F0020C00,$00700000
	dc.l	$F0130000	; 收尾取消無敵
	dc.l	$F0020200,$00610000
	dc.l	$F0020200,$00620000
	dc.l	$F0020200,$00630000
	dc.l	$80000000


off_227238:
	dc.l	$F0020500,$002005FE	; 垂直位移05水平位移FE
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020500,$002105FE
	dc.l	$F0020500,$002205FE
	dc.l	$F0020500,$002305FE
	dc.l	$F00B7F00,$00CA01F4
	dc.l	$F0020500,$002405FE
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020500,$002505FE
	dc.l	$F0020500,$002605FE
	dc.l	$F0020500,$002705FE
	dc.l	$F00B7F00,$00CA00C8
	dc.l	$F0010000	; 招式循環
off_2272AC:
	dc.l	$F0020500,$00200700
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020500,$00210700
	dc.l	$F0020500,$00220700
	dc.l	$F0020500,$00230700
	dc.l	$F00B7F00,$00CA01F4
	dc.l	$F0020500,$00240700
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020500,$00250700
	dc.l	$F0020500,$00260700
	dc.l	$F0020500,$00270700
	dc.l	$F00B7F00,$00CA00C8
	dc.l	$F0010000
off_227320:
	dc.l	$F0020500,$00200502
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020500,$00210502
	dc.l	$F0020500,$00220502
	dc.l	$F0020500,$00230502
	dc.l	$F00B7F00,$00CA01F4
	dc.l	$F0020500,$00240502
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020500,$00250502
	dc.l	$F0020500,$00260502
	dc.l	$F0020500,$00270502
	dc.l	$F00B7F00,$00CA00C8
	dc.l	$F0010000
off_081718:
	dc.l	$F0020400,$00120000
	dc.l	$80000000

sub_16B4C2:
	movea.l d0,a3
	moveq   #0,d0
	move.b  d3,d0		; 原代碼
	eori.b	#$1, D0		; 反方向
	rts


off_229CAA:
	dc.l	$F0540100,$F04F1113,$F0451300
	dc.l	$F0020A00,$00810000
	dc.l	$F0070000,$0016B74A,$002800F7
	dc.l	$F0070000,$0016B85E,$002800F7
	dc.l	$F0070000,$0016B85E,$002800F7
	dc.l	$F0070000,$0016B85E,$002800F8
	dc.l	$F0070000,$0016B85E,$002800F8
	dc.l	$F0070000,$0016B85E,$002800F8
	dc.l	$F0070000,$0016B85E,$002800F9
	dc.l	$F0070000,$0016B85E,$002800F9
	dc.l	$F0070000,$0016B85E,$002800F9
	dc.l	$F0070000,$0016B85E,$002800FA
	dc.l	$F0070000,$0016B85E,$002800FA
	dc.l	$F0070000,$0016B85E,$002800FA
	dc.l	$F0070000,$0016B85E,$002800FB
	dc.l	$F0070000,$0016B85E,$002800FB
	dc.l	$F0070000,$0016B85E,$002900FB
	dc.l	$F0070000,$0016B85E,$002900FB
	dc.l	$F0070000,$0016B85E,$002900FC
	dc.l	$F0070000,$0016B85E,$002900FC
	dc.l	$F0070000,$0016B85E,$002900FC
	dc.l	$F0070000,$0016B85E,$002900FD
	dc.l	$F0070000,$0016B85E,$002A00FD
	dc.l	$F0070000,$0016B85E,$002A00FD
	dc.l	$F0070000,$0016B85E,$002A00FD
	dc.l	$F0070000,$0016B85E,$002A0000
	dc.l	$F0070000,$0016B85E,$002A0000
	dc.l	$F0070001,$0016B85E
	dc.l	$F05E0100	; 上天下地(硬漢)(換將)
	dc.l	$F0020A00,$002A0000
	dc.l	$F0030000,$2078000F
	dc.l	$F061FE00,$00228742,$00000100
	dc.l	$F061FE00,$0022B756,$00000100
	dc.l	$F0020200,$00780000
	dc.l	$F0020700,$002C0000
	dc.l	$80000000


off_23AB7E:
	dc.w	$0600	; 砍樹-223A
	dc.l	$0023A852,$01002240,$10000000,$0
	dc.w	$0601
	dc.l	$0023A966,$01002240,$10000000,$0
	dc.w	$0602	; 誰敢阻擋-223B
	dc.l	off_237F58,$01000000,$0,$0
	dc.w	$0603
	dc.l	$0023AA72,$02000240,$10000000,$0
	dc.w	$0604	; 撞樹-6A
	dc.l	$00237DB0,$01000000,$0,$0

off_237F58:
	dc.l	$F0540800
	dc.l	$F0450200
	dc.l	$F00BFF00,$01930000
	dc.l	$F0020200,$00470600
	dc.l	$F0330100
	dc.l	$F00B9F00,$02DF0000
	dc.l	$F05E0100	; 起手無硬漢
	dc.l	$F0280500
	dc.l	$F0340004,$00490000,$00020000,$20480200
	dc.l	$F0290000
	dc.l	$F014000E,$008C0000
	dc.l	$F0280400
	dc.l	$F0340004,$004B0000,$00020000,$204A0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$004D0000,$00020000,$204C0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00420000,$00020000,$20410200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00440000,$00020000,$20430200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00450000,$00020000,$00470200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00460000,$00000000,$00000000
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F00B9F00,$02DF0000
	dc.l	$F0280500
	dc.l	$F0340004,$00490000,$00020000,$20480200
	dc.l	$F0290000
	dc.l	$F014000E,$008C0000
	dc.l	$F0280400
	dc.l	$F0340004,$004B0000,$00020000,$204A0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$004D0000,$00020000,$204C0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00420000,$00020000,$20410200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00440000,$00020000,$20430200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00450000,$00020000,$00470200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00460000,$00000000,$00000000
	dc.l	$F0290000
	dc.l	$F05E0000	; 最後一斧取消硬漢
	dc.l	$F0410100
	dc.l	$F00B9F00,$02DF0000
	dc.l	$F0280500
	dc.l	$F0340004,$00490000,$00020000,$20480200
	dc.l	$F0290000
	dc.l	$F014000E,$008C0000
	dc.l	$F0280400
	dc.l	$F0340004,$004B0000,$00020000,$204A0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$004D0000,$00020000,$204C0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00420000,$00020000,$20410200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00440000,$00020000,$20430200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00450000,$00020000,$00470200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00460000,$00000000,$00000000
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$80000000

off_237E74:
	dc.l	$F0540800
	dc.l	$F05C0300	; 木化
	dc.l	$F0130100	; 無敵
	dc.l	$F00BFF00,$01900000
	dc.l	$F0020200,$00470600
	dc.l	$F0330100
	dc.l	$F00B9F00,$02DF0000
	dc.l	$F0280500
	dc.l	$F0340004,$00490000,$00020000,$20480200
	dc.l	$F0290000
	dc.l	$F014000E,$008C0000
	dc.l	$F0280400
	dc.l	$F0340004,$004B0000,$00020000,$204A0200
	dc.l	$F0290000
	dc.l	$F05E0000
	dc.l	$F0280300
	dc.l	$F0340004,$004D0000,$00020000,$204C0200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00420000,$00020000,$20410200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00440000,$00020000,$20430200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00450000,$00020000,$00470200
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00460000,$00000000,$00000000
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$80000000


off_215FDA:
	dc.w	$0200
	dc.l	$002141DA,$01007000,$0,$0
	dc.w	$0201
	dc.l	$002141DA,$01007000,$0,$0
	dc.w	$0202
	dc.l	$0021420E,$01001000,$0,$0	; 牛金轉身速度$5000
	dc.w	$0203	; 向上走
	dc.l	off_21421A,$01000000,$0,$0
	dc.w	$0204	; 斜上走
	dc.l	off_21425E,$01000000,$0,$0
	dc.w	$0205	; 向前走
	dc.l	off_2142A2,$01000000,$0,$0
	dc.w	$0206	; 斜下走
	dc.l	off_2142E6,$01000000,$0,$0
	dc.w	$0207	; 向下走
	dc.l	off_21432A,$01000000,$0,$0
	dc.w	$0208
	dc.l	$0021436E,$01000000,$0,$0
	dc.w	$0209
	dc.l	$002143B2,$01000000,$0,$0
	dc.w	$020A
	dc.l	$002143F6,$01000000,$0,$0
	dc.w	$020B
	dc.l	$0021443A,$01000000,$0,$0
	dc.w	$020C
	dc.l	$002144AE,$01000000,$0,$0
	dc.w	$020D
	dc.l	$00214522,$01000000,$0,$0
	dc.w	$020E
	dc.l	$00214596,$01000000,$0,$0
	dc.w	$020F
	dc.l	$0021460A,$01000000,$0,$0
	dc.w	$0210
	dc.l	$00214766,$01000000,$0,$0
	dc.w	$0211
	dc.l	$002146F2,$01000000,$0,$0
	dc.w	$0212
	dc.l	$0021467E,$01000000,$0,$0
	dc.w	$0213
	dc.l	$00215FD2,$01000000,$0,$0
	dc.w	$0214
	dc.l	$00215FD6,$01000000,$0,$0
	dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
	dc.l	off_215810,$01000040,$0,$0	; 0215神行技
	dc.w	$0216
	dc.l	$00215FD2,$01000000,$0,$0
	dc.w	$0217
	dc.l	$00215FD2,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$002148BE,$01003000,$0,$0
	dc.w	$021A
	dc.l	$002148F6,$02000000,$0,$0
	dc.w	$021B
	dc.l	$00215FD2,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_081713,$01005000,$0,$0

off_21421A:	; 向上走
	dc.l	$001200FF,$001200FE,$001200FF,$001200FE,$001200FF
	dc.l	$001300FE,$001300FF,$001300FE,$001300FF,$001300FE
	dc.l	$001400FF,$001400FE,$001400FF,$001400FE,$001400FF
	dc.l	$001500FE,$001500FF,$001500FE,$001500FF,$001500FE
	dc.l	$001600FF,$001600FE,$001600FF,$001600FE,$001600FF
	dc.l	$001700FE,$001700FF,$001700FE,$001700FF,$001700FE
	dc.l	$001800FF,$001800FE,$001800FF,$001800FE,$001800FF
	dc.l	$001900FE,$001900FF,$001900FE,$001900FF,$001900FE
	dc.l	$F0010000
off_21425E:	; 斜上走
	dc.l	$001203FF,$001203FF,$001203FF,$001203FF,$001203FF
	dc.l	$001303FF,$001303FF,$001303FF,$001303FF,$001303FF
	dc.l	$001403FF,$001403FF,$001403FF,$001403FF,$001403FF
	dc.l	$001503FF,$001503FF,$001503FF,$001503FF,$001503FF
	dc.l	$001603FF,$001603FF,$001603FF,$001603FF,$001603FF
	dc.l	$001703FF,$001703FF,$001703FF,$001703FF,$001703FF
	dc.l	$001803FF,$001803FF,$001803FF,$001803FF,$001803FF
	dc.l	$001903FF,$001903FF,$001903FF,$001903FF,$001903FF
	dc.l	$F0010000
off_2142A2:	; 向前走
	dc.l	$00120300,$00120300,$00120300,$00120300,$00120300
	dc.l	$00130300,$00130300,$00130300,$00130300,$00130300
	dc.l	$00140300,$00140300,$00140300,$00140300,$00140300
	dc.l	$00150300,$00150300,$00150300,$00150300,$00150300
	dc.l	$00160300,$00160300,$00160300,$00160300,$00160300
	dc.l	$00170300,$00170300,$00170300,$00170300,$00170300
	dc.l	$00180300,$00180300,$00180300,$00180300,$00180300
	dc.l	$00190300,$00190300,$00190300,$00190300,$00190300
	dc.l	$F0010000
off_2142E6:	; 斜下走
	dc.l	$00120301,$00120301,$00120301,$00120301,$00120301
	dc.l	$00130301,$00130301,$00130301,$00130301,$00130301
	dc.l	$00140301,$00140301,$00140301,$00140301,$00140301
	dc.l	$00150301,$00150301,$00150301,$00150301,$00150301
	dc.l	$00160301,$00160301,$00160301,$00160301,$00160301
	dc.l	$00170301,$00170301,$00170301,$00170301,$00170301
	dc.l	$00180301,$00180301,$00180301,$00180301,$00180301
	dc.l	$00190301,$00190301,$00190301,$00190301,$00190301
	dc.l	$F0010000
off_21432A:	; 向下走
	dc.l	$00120001,$00120002,$00120001,$00120002,$00120001
	dc.l	$00130002,$00130001,$00130002,$00130001,$00130002
	dc.l	$00140001,$00140002,$00140001,$00140002,$00140001
	dc.l	$00150002,$00150001,$00150002,$00150001,$00150002
	dc.l	$00160002,$00160001,$00160002,$00160001,$00160002,$00160001
	dc.l	$00170002,$00170001,$00170002,$00170001,$00170002
	dc.l	$00180001,$00180002,$00180001,$00180002,$00180001
	dc.l	$00190002,$00190001,$00190002,$00190001,$00190002
	dc.l	$F0010000

off_215810:
	dc.l	$F0130100
	dc.l	$F02A02FF,$006E0600,$006E0600,$006E0600,$006E0800
	dc.l	$F00B9F00,$02DC0000
	dc.l	$006F0800,$006F0800,$006F0900,$006F0900
	dc.l	$00700900,$00700900,$00700A00,$00700A00
	dc.l	$00710A00,$00710C00,$00710C00,$00710C00
	dc.l	$00710A00,$00710800,$00710600,$00710400,$00710200
	dc.l	$F0020700,$00720000
	dc.l	$F02A0000
	dc.l	$F0130000
	dc.l	$F0020200,$00330000
	dc.l	$F0020200,$00340000
	dc.l	$F0020200,$00350000
	dc.l	$80000000

off_081713:	; 格擋圖片$37
	dc.l	$F00BEF00,$014C0000
	dc.l	$F0020600,$00370000
	dc.l	$80000000


off_214E20:
	dc.l	$F0130100
	dc.l	$F0540400
	dc.l	$F04F1200
	dc.l	$F00BFF00,$01440000
	dc.l	$F00E0200,$00360000
	dc.l	$F00E0300
	dc.l	$F05E0100
	dc.l	$F0020100,$00370000
	dc.l	$F05E0000,$00380000,$00390000,$003A0000
	dc.l	$F00B9F00,$02850000
	dc.l	$F015FE00,$00214B18,$00500000
	dc.l	$F0020400,$003B0000,$00360000
	dc.l	$80000000


off_21761C:
	dc.w	$0600
	dc.l	$002171AC,$01000040,$0,$0
	dc.w	$0601	; 上勾火拳-28A
	dc.l	$00214E7C,$01000040,$0,$0
	dc.w	$0602	; 撥雲見日
	dc.l	$0021729C,$02000040,$0,$0
	dc.w	$0603	; 怒濤洶湧[硬漢]
	dc.l	off_217548,$01001040,$0,$0
	dc.w	$0604	; 風卷人轉-46A
	dc.l	$002173F8,$01000040,$0,$0
	dc.w	$0605	; 氣衝斗牛-6A
	dc.l	$002156EC,$01000040,$0,$0


off_217548:	; 怒濤洶湧
	dc.l	$F0540600,$F04F1200,$F0450300
	dc.l	$F00BEF00,$014D0000
	dc.l	$F0020100,$00690000
	dc.l	$F0020100,$006A0000
	dc.l	$F0020200,$006B0000
	dc.l	$F00E0000,$F05E0100	; 硬漢
	dc.l	$F015FF00,$002174D4,$001E1E00,$206C0A00,$006C0A00,$206C0A00
	dc.l	$F015FF00,$002174D4,$0032E200,$006C0800,$206C0800,$006C0800
	dc.l	$F015FF00,$002174D4,$001EF600,$206C0600,$006C0600,$206C0600
	dc.l	$F015FF00,$002174D4,$003C1900,$006C0400,$206C0400,$006C0400
	dc.l	$F015FF00,$002174D4,$0046EC00,$206C0200,$006C0200,$206C0200
	dc.l	$F015FF00,$002174D4,$00580700,$006C0000,$206C0000,$006C0000
	dc.l	$F015FF00,$002174D4,$006E0000,$006C0000
	dc.l	$F0020400,$006D0000
	dc.l	$80000000



off_237442:
	dc.w	$0200
	dc.l	$002369C6,$01007000,$0,$0
	dc.w	$0201
	dc.l	$002369C6,$01007000,$0,$0
	dc.w	$0202
	dc.l	$002369FA,$01001000,$0,$0	; 徐晃轉身速度$5000
	dc.w	$0203
	dc.l	$00236A4A,$01000000,$0,$0
	dc.w	$0204
	dc.l	$00236AD2,$01000000,$0,$0
	dc.w	$0205
	dc.l	$00236A06,$01000000,$0,$0
	dc.w	$0206
	dc.l	$00236B16,$01000000,$0,$0
	dc.w	$0207
	dc.l	$00236A8E,$01000000,$0,$0
	dc.w	$0208
	dc.l	$00236B5A,$01000000,$0,$0
	dc.w	$0209
	dc.l	$00236B9E,$01000000,$0,$0
	dc.w	$020A
	dc.l	$00236BE2,$01000000,$0,$0
	dc.w	$020B
	dc.l	$00238660,$01000000,$0,$0
	dc.w	$020C
	dc.l	$00238F24,$01000000,$0,$0
	dc.w	$020D
	dc.l	$0023894C,$01000000,$0,$0
	dc.w	$020E
	dc.l	$00239210,$01000000,$0,$0
	dc.w	$020F
	dc.l	$00238C38,$01000000,$0,$0
	dc.w	$0210
	dc.l	$002394FC,$01000000,$0,$0
	dc.w	$0211
	dc.l	$002397E8,$01000000,$0,$0
	dc.w	$0212
	dc.l	$00239AD4,$01000000,$0,$0
	dc.w	$0213
	dc.l	$0023743A,$01000000,$0,$0
	dc.w	$0214
	dc.l	$0023743E,$01000000,$0,$0
	dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
	dc.l	off_237CBC,$01000000,$0,$0	; 0215突行技[短跑]
	dc.w	$0216
	dc.l	$0023743A,$01000000,$0,$0
	dc.w	$0217
	dc.l	$0023743A,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$00236C26,$01003000,$0,$0
	dc.w	$021A
	dc.l	$00236C72,$02000000,$0,$0
	dc.w	$021B
	dc.l	$0023743A,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_08171C,$01005000,$0,$0
off_237CBC:
	dc.l	$F0130100
	dc.l	$F0330100
	dc.l	$F00B7F00,$00D00000
	dc.l	$F0280300
	dc.l	$F0340004,$001D0000,$FF9A000E,$00190600
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$001E0000,$FF9A000E,$00190600
	dc.l	$F0290000
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0280300
	dc.l	$F0340004,$001F0000,$FF9A000E,$001A0600
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$00200000,$FF9A000E,$001A0600
	dc.l	$F0290000
	dc.l	$F00B7F00,$00D00000
	dc.l	$F0280300
	dc.l	$F0340004,$001D0000,$FF9A000E,$001B0600
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$001E0000,$FF9A000E,$001B0600
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$001F0000,$FF9A000E,$001C0600
	dc.l	$F0290000
	dc.l	$F0130000
	dc.l	$F0280300
	dc.l	$F0340004,$00200000,$FF9A000E,$001C0600
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$80000000
off_08171C:
	dc.l	$F0020400,$00400000	; 格擋$40
	dc.l	$80000000


off_20E262:
	dc.w	$0200
	dc.l	$0020C194,$01007000,$0,$0
	dc.w	$0201
	dc.l	$0020C1BC,$01007000,$0,$0
	dc.w	$0202
	dc.l	$0020C1E4,$01005000,$0,$0
	dc.w	$0203	; 向上走
	dc.l	off_20C230,$01000000,$0,$0
	dc.w	$0204	; 斜上走
	dc.l	off_20C2B8,$01000000,$0,$0
	dc.w	$0205	; 向前走
	dc.l	off_20C1EC,$01000000,$0,$0
	dc.w	$0206	; 斜下走
	dc.l	off_20C2FC,$01000000,$0,$0
	dc.w	$0207	; 向下走
	dc.l	off_20C274,$01000000,$0,$0
	dc.w	$0208
	dc.l	$0020C340,$01000000,$0,$0
	dc.w	$0209
	dc.l	$0020C384,$01000000,$0,$0
	dc.w	$020A
	dc.l	$0020C3C8,$01000000,$0,$0
	dc.w	$020B
	dc.l	$0020C40C,$01000000,$0,$0
	dc.w	$020C
	dc.l	$0020C470,$01000000,$0,$0
	dc.w	$020D
	dc.l	$0020C4D4,$01000000,$0,$0
	dc.w	$020E
	dc.l	$0020C538,$01000000,$0,$0
	dc.w	$020F
	dc.l	$0020C59C,$01000000,$0,$0
	dc.w	$0210
	dc.l	$0020C6C8,$01000000,$0,$0
	dc.w	$0211
	dc.l	$0020C664,$01000000,$0,$0
	dc.w	$0212
	dc.l	$0020C600,$01000000,$0,$0
	dc.w	$0213
	dc.l	$0020E25A,$01000000,$0,$0
	dc.w	$0214
	dc.l	$0020E25E,$01000000,$0,$0
	dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
	dc.l	off_20DB96,$01000240,$0,$0	; 突行技
	dc.w	$0216
	dc.l	$0020E25A,$01000000,$0,$0
	dc.w	$0217
	dc.l	$0020E25A,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$0020CA44,$01003000,$0,$0
	dc.w	$021A
	dc.l	$0020CA90,$02000000,$0,$0
	dc.w	$021B
	dc.l	$0020E25A,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_081711,$01005000,$0,$0

off_20C230:	; 向上走
	dc.l	$001400FF,$001400FE,$001400FF,$001400FE,$001400FF
	dc.l	$001500FE,$001500FF,$001500FE,$001500FF,$001500FE
	dc.l	$001600FF,$001600FE,$001600FF,$001600FE,$001600FF
	dc.l	$001700FE,$001700FF,$001700FE,$001700FF,$001700FE
	dc.l	$001800FF,$001800FE,$001800FF,$001800FE,$001800FF
	dc.l	$001900FE,$001900FF,$001900FE,$001900FF,$001900FE
	dc.l	$001A00FF,$001A00FE,$001A00FF,$001A00FE,$001A00FF
	dc.l	$001B00FE,$001B00FF,$001B00FE,$001B00FF,$001B00FE
	dc.l	$F0010000
off_20C2B8:	; 斜上走
	dc.l	$001403FF,$001403FF,$001403FF,$001403FF,$001403FF
	dc.l	$001503FF,$001503FF,$001503FF,$001503FF,$001503FF
	dc.l	$001603FF,$001603FF,$001603FF,$001603FF,$001603FF
	dc.l	$001703FF,$001703FF,$001703FF,$001703FF,$001703FF
	dc.l	$001803FF,$001803FF,$001803FF,$001803FF,$001803FF
	dc.l	$001903FF,$001903FF,$001903FF,$001903FF,$001903FF
	dc.l	$001A03FF,$001A03FF,$001A03FF,$001A03FF,$001A03FF
	dc.l	$001B03FF,$001B03FF,$001B03FF,$001B03FF,$001B03FF
	dc.l	$F0010000
off_20C1EC:	; 向前走
	dc.l	$00140300,$00140300,$00140300,$00140300,$00140300
	dc.l	$00150300,$00150300,$00150300,$00150300,$00150300
	dc.l	$00160300,$00160300,$00160300,$00160300,$00160300
	dc.l	$00170300,$00170300,$00170300,$00170300,$00170300
	dc.l	$00180300,$00180300,$00180300,$00180300,$00180300
	dc.l	$00190300,$00190300,$00190300,$00190300,$00190300
	dc.l	$001A0300,$001A0300,$001A0300,$001A0300,$001A0300
	dc.l	$001B0300,$001B0300,$001B0300,$001B0300,$001B0300
	dc.l	$F0010000
off_20C2FC:	; 斜下走
	dc.l	$00140301,$00140301,$00140301,$00140301,$00140301
	dc.l	$00150301,$00150301,$00150301,$00150301,$00150301
	dc.l	$00160301,$00160301,$00160301,$00160301,$00160301
	dc.l	$00170301,$00170301,$00170301,$00170301,$00170301
	dc.l	$00180301,$00180301,$00180301,$00180301,$00180301
	dc.l	$00190301,$00190301,$00190301,$00190301,$00190301
	dc.l	$001A0301,$001A0301,$001A0301,$001A0301,$001A0301
	dc.l	$001B0301,$001B0301,$001B0301,$001B0301,$001B0301
	dc.l	$F0010000
off_20C274:	; 向下走
	dc.l	$00140001,$00140002,$00140001,$00140002,$00140001
	dc.l	$00150002,$00150001,$00150002,$00150001,$00150002
	dc.l	$00160001,$00160002,$00160001,$00160002,$00160001
	dc.l	$00170002,$00170001,$00170002,$00170001,$00170002
	dc.l	$00180002,$00180001,$00180002,$00180001,$00180002,$00180001
	dc.l	$00190002,$00190001,$00190002,$00190001,$00190002
	dc.l	$001A0001,$001A0002,$001A0001,$001A0002,$001A0001
	dc.l	$001B0002,$001B0001,$001B0002,$001B0001,$001B0002
	dc.l	$F0010000

off_20DB96:
	dc.l	$F0130100
	dc.l	$F00E0000
	dc.l	$F02A0000
	dc.l	$F0020600,$001C0500
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020600,$001D0500
	dc.l	$F0020600,$001E0500
	dc.l	$F0130000
	dc.l	$F0020600,$001F0500
	dc.l	$80000000

off_081711:	; 格擋前動作$2A
	dc.l	$F0020400,$002A0000
	dc.l	$80000000


off_20D4C6:
	dc.l	$F0130100
	dc.l	$F00E0100
	dc.l	$F0540400
	dc.l	$F04F2711
	dc.l	$F0450300
	dc.l	$F00B4F00,$00C10000
	dc.l	$F0330100
	dc.l	$F0340004,$008E0000,$00000000,$208D0000,$008D0000
	dc.l	$F0340004,$00900000,$00000000,$208F0000,$008F0000
	dc.l	$F0340004,$00920000,$00000000,$20910000,$00910000
	dc.l	$F0340004,$00940000,$00000000,$20930000,$00930000
	dc.l	$F0340004,$00960000,$00000000,$20950000,$00950000
	dc.l	$F0340004,$00980000,$00000000,$20970000
	dc.l	$F0340004,$00990000,$00000000,$20970000
	dc.l	$F0340004,$009A0000,$00000000,$20970000
	dc.l	$F0340004,$009B0000,$00000000,$20970000
	dc.l	$F0330000
	dc.l	$F0020200,$009C0000
	dc.l	$80000000


off_20D332:	; 橫掃千軍|爆炸效果
	dc.l	$F00E0200
	dc.l	$F0540A00
	dc.l	$F04F2011
	dc.l	$F0330100
	dc.l	$F0130100
	dc.l	$F03400FF,$005D0000,$001F0000,$003F0F00,$005C0000	; 縮短X位移1F
	dc.l	$F03400FF,$005F0000,$00120000,$00410900,$005E0000	; 縮短X位移12
	dc.l	$F0130000
	dc.l	$F03400FF,$00610000,$00000000
	dc.l	$F0020200,$00600000
	dc.l	$F0330000
	dc.l	$F0330200
	dc.l	$F0340104,$00640000,$00240000
	dc.l	$F03400FF,$00630000,$00240000,$20621200	; 縮短X位移24
	dc.l	$F00BFF00,$02C00000
	dc.l	$F00BFF00,$02C00000
	dc.l	$F0410100
	dc.l	$F05C0900
	dc.l	$F04F2111
	dc.l	$F0340104,$00670000,$00000000
	dc.l	$F03400FF,$00660000,$00000000,$20650000
	dc.l	$F0410100
	dc.l	$F0450300
	dc.l	$F04F2511
	dc.l	$F0340104,$006A0000,$002E0000
	dc.l	$F03400FF,$00690000,$002E0000,$20681700	; 縮短X位移2E
	dc.l	$F0340104,$006D0000,$00000000
	dc.l	$F03400FF,$006C0000,$00000000,$006B0000
	dc.l	$F0340104,$00700000,$00000000
	dc.l	$F03400FF,$006F0000,$00000000,$006E0000
	dc.l	$F0340104,$00730000,$00000000
	dc.l	$F03400FF,$00720000,$00000000,$00710000
	dc.l	$F0340104,$00740000,$00000000
	dc.l	$F03400FF,$00720000,$00000000,$00710000
	dc.l	$F0330000
	dc.l	$F0330100
	dc.l	$F03400FF,$00720000,$00000000
	dc.l	$F0020200,$00710000
	dc.l	$F03400FF,$00760000,$00000000
	dc.l	$F0020200,$00750000
	dc.l	$F03400FF,$00780000,$00210100,$00771002,$00770000	; 縮短X位移21
	dc.l	$F0330000
	dc.l	$80000000


off_20EA1A:	; 畫地爲牢|硬漢
	dc.l	$F0540A00,$F04F2711,$F0550000,$F0580100,$F05E0100
	dc.l	$F00B4F00,$00C10000
	dc.l	$F0330100,$F0410100
	dc.l	$F0340004,$008E0000,$00000000,$208D0000,$008D0000,$F0410100
	dc.l	$F0340004,$00900000,$00000000,$208F0000,$008F0000,$F0410100
	dc.l	$F0340004,$00920000,$00000000,$20910000,$00910000,$F0450200,$F0410100
	dc.l	$F0340004,$00940000,$00000000,$20930000,$00930000,$F0410100
	dc.l	$F0340004,$00960000,$00000000,$20950000,$00950000,$F0410100
	dc.l	$F0340004,$00980000,$00000000,$20970000
	dc.l	$F0340004,$00990000,$00000000,$00970000
	dc.l	$F0340004,$009A0000,$00000000,$00970000
	dc.l	$F0340004,$009B0000,$00000000,$00970000
	dc.l	$F0330000,$F0020200,$009C0000
	dc.l	$80000000


off_206A52:
	dc.w	$0200
	dc.l	$00205C3A,$01007000,$0,$0
	dc.w	$0201
	dc.l	$00205C3A,$01007000,$0,$0
	dc.w	$0202	; 程昱轉身速度$5000
	dc.l	$00205C6E,$01001000,$0,$0
	dc.w	$0203	; 向上走
	dc.l	off_205CBE,$01000000,$0,$0
	dc.w	$0204	; 斜上走
	dc.l	off_205D46,$01000000,$0,$0
	dc.w	$0205	; 向前走
	dc.l	off_205C7A,$01000000,$0,$0
	dc.w	$0206	; 斜下走
	dc.l	off_205D8A,$01000000,$0,$0
	dc.w	$0207	; 向下走
	dc.l	off_205D02,$01000000,$0,$0
	dc.w	$0208
	dc.l	$00205DCE,$01000000,$0,$0
	dc.w	$0209
	dc.l	$00205E12,$01000000,$0,$0
	dc.w	$020A
	dc.l	$00205E56,$01000000,$0,$0
	dc.w	$020B
	dc.l	$00205E9A,$01000000,$0,$0
	dc.w	$020C
	dc.l	$00205EFE,$01000000,$0,$0
	dc.w	$020D
	dc.l	$00205F62,$01000000,$0,$0
	dc.w	$020E
	dc.l	$00205FC6,$01000000,$0,$0
	dc.w	$020F
	dc.l	$0020602A,$01000000,$0,$0
	dc.w	$0210
	dc.l	$00206156,$01000000,$0,$0
	dc.w	$0211
	dc.l	$002060F2,$01000000,$0,$0
	dc.w	$0212
	dc.l	$0020608E,$01000000,$0,$0
	dc.w	$0213
	dc.l	$00206A4A,$01000000,$0,$0
	dc.w	$0214
	dc.l	$00206A4E,$01000000,$0,$0
	dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
	dc.l	$00207548,$01003040,$0,$0	; 0215突行技
	dc.w	$0216
	dc.l	$00206A4A,$01000000,$0,$0
	dc.w	$0217
	dc.l	$00206A4A,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$002062AA,$01003000,$0,$0
	dc.w	$021A
	dc.l	$002062FA,$02000000,$0,$0
	dc.w	$021B
	dc.l	$00206A4A,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_08170D,$01005000,$0,$0
off_08170D:	; 格擋前動作$30
	dc.l	$F0020400,$00300000
	dc.l	$80000000

off_205CBE:	; 向上走
	dc.l	$001B00FF,$001B00FE,$001B00FF,$001B00FE,$001B00FF
	dc.l	$001C00FE,$001C00FF,$001C00FE,$001C00FF,$001C00FE
	dc.l	$001D00FF,$001D00FE,$001D00FF,$001D00FE,$001D00FF
	dc.l	$001E00FE,$001E00FF,$001E00FE,$001E00FF,$001E00FE
	dc.l	$001F00FF,$001F00FE,$001F00FF,$001F00FE,$001F00FF
	dc.l	$002000FE,$002000FF,$002000FE,$002000FF,$002000FE
	dc.l	$002100FF,$002100FE,$002100FF,$002100FE,$002100FF
	dc.l	$002200FE,$002200FF,$002200FE,$002200FF,$002200FE
	dc.l	$F0010000
off_205D46:	; 斜上走
	dc.l	$001B03FF,$001B03FF,$001B03FF,$001B03FF,$001B03FF
	dc.l	$001C03FF,$001C03FF,$001C03FF,$001C03FF,$001C03FF
	dc.l	$001D03FF,$001D03FF,$001D03FF,$001D03FF,$001D03FF
	dc.l	$001E03FF,$001E03FF,$001E03FF,$001E03FF,$001E03FF
	dc.l	$001F03FF,$001F03FF,$001F03FF,$001F03FF,$001F03FF
	dc.l	$002003FF,$002003FF,$002003FF,$002003FF,$002003FF
	dc.l	$002103FF,$002103FF,$002103FF,$002103FF,$002103FF
	dc.l	$002203FF,$002203FF,$002203FF,$002203FF,$002203FF
	dc.l	$F0010000
off_205C7A:	; 向前走
	dc.l	$001B0300,$001B0300,$001B0300,$001B0300,$001B0300
	dc.l	$001C0300,$001C0300,$001C0300,$001C0300,$001C0300
	dc.l	$001D0300,$001D0300,$001D0300,$001D0300,$001D0300
	dc.l	$001E0300,$001E0300,$001E0300,$001E0300,$001E0300
	dc.l	$001F0300,$001F0300,$001F0300,$001F0300,$001F0300
	dc.l	$00200300,$00200300,$00200300,$00200300,$00200300
	dc.l	$00210300,$00210300,$00210300,$00210300,$00210300
	dc.l	$00220300,$00220300,$00220300,$00220300,$00220300
	dc.l	$F0010000
off_205D8A:	; 斜下走
	dc.l	$001B0301,$001B0301,$001B0301,$001B0301,$001B0301
	dc.l	$001C0301,$001C0301,$001C0301,$001C0301,$001C0301
	dc.l	$001D0301,$001D0301,$001D0301,$001D0301,$001D0301
	dc.l	$001E0301,$001E0301,$001E0301,$001E0301,$001E0301
	dc.l	$001F0301,$001F0301,$001F0301,$001F0301,$001F0301
	dc.l	$00200301,$00200301,$00200301,$00200301,$00200301
	dc.l	$00210301,$00210301,$00210301,$00210301,$00210301
	dc.l	$00220301,$00220301,$00220301,$00220301,$00220301
	dc.l	$F0010000
off_205D02:	; 向下走
	dc.l	$001B0001,$001B0002,$001B0001,$001B0002,$001B0001
	dc.l	$001C0002,$001C0001,$001C0002,$001C0001,$001C0002
	dc.l	$001D0001,$001D0002,$001D0001,$001D0002,$001D0001
	dc.l	$001E0002,$001E0001,$001E0002,$001E0001,$001E0002
	dc.l	$001F0002,$001F0001,$001F0002,$001F0001,$001F0002,$001F0001
	dc.l	$00200002,$00200001,$00200002,$00200001,$00200002
	dc.l	$00210001,$00210002,$00210001,$00210002,$00210001
	dc.l	$00220002,$00220001,$00220002,$00220001,$00220002
	dc.l	$F0010000

off_2081B2:
	dc.l	$F0540400
	dc.l	$F04F1100
	dc.l	$F0450800
	dc.l	$F05C0100
	dc.l	$F00BFF00,$01230000
	dc.l	$F0130100
	dc.l	$F0020300,$00490000
	dc.l	$F0020300,$004A0000
	dc.l	$F0020300,$004B0000
	dc.l	$F0020200,$004C0000,$204D0000
	dc.l	$F0330100
	dc.l	$F03400FF,$004F0000,$00000000,$204E0000
	dc.l	$F03400FF,$00510000,$00000000,$00500000
	dc.l	$F03400FF,$00520000,$00000000,$00500000
	dc.l	$F0330000
	dc.l	$F0020300,$00500000,$00530000
	dc.l	$80000000


off_2085A0:
	dc.w	$600
	dc.l	$2080DA,$1003040,0,0
	dc.w	$601
	dc.l	$2081B2,$1001040,0,0
	dc.w	$602
	dc.l	$208376,$1003040,0,0
	dc.w	$603	; 紙人舞
	dc.l	$20851C,$1003040,0,0
	dc.w	$604	; 搖鈴刺
	dc.l	off_207450,$1003040,0,0

off_207450:
	dc.l	$F00B9F00,$00BD0000
	dc.l	$F00E0300
	dc.l	$F0330100
	dc.l	$F0280300
	dc.l	$F03400FF,$00710000,$00000000,$00700000
	dc.l	$F03400FF,$00720000,$00000000,$00700000
	dc.l	$F03400FF,$00730000,$00000000,$00700000
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$F015FF00,$002073DC,$00000000
	dc.l	$F0540600
	dc.l	$F04F1600
	dc.l	$F00E0400
	dc.l	$60481E00,$60481E00
	dc.l	$F00E0100,$20480000
	dc.l	$F00E0300,$60481E00
	dc.l	$F00E0400,$60481E00,$60481E00
	dc.l	$F00E0100,$20480000
	dc.l	$F00E0300,$60481E00,$60481E00,$60481E00
	dc.l	$F0020300,$00480000,$00470000
	dc.l	$80000000


off_1FEA26:
	dc.w	$0200
	dc.l	$001FDFEA,$01007000,$0,$0
	dc.w	$0201
	dc.l	$001FDFEA,$01007000,$0,$0
	dc.w	$0202
	dc.l	$001FE01E,$01001000,$0,$0	; 曹操轉身速度$5000
	dc.w	$0203
	dc.l	$001FE02E,$01000000,$0,$0
	dc.w	$0204
	dc.l	$001FE072,$01000000,$0,$0
	dc.w	$0205
	dc.l	$001FE0B6,$01000000,$0,$0
	dc.w	$0206
	dc.l	$001FE0FA,$01000000,$0,$0
	dc.w	$0207
	dc.l	$001FE13E,$01000000,$0,$0
	dc.w	$0208
	dc.l	$001FE182,$01000000,$0,$0
	dc.w	$0209
	dc.l	$001FE1C6,$01000000,$0,$0
	dc.w	$020A
	dc.l	$001FE20A,$01000000,$0,$0
	dc.w	$020B
	dc.l	$001FE8CA,$01000040,$0,$0
	dc.w	$020C
	dc.l	$001FE8CA,$01000040,$0,$0
	dc.w	$020D
	dc.l	$001FE8CA,$01000040,$0,$0
	dc.w	$020E
	dc.l	$001FE8CA,$01000040,$0,$0
	dc.w	$020F
	dc.l	$001FE8CA,$01000040,$0,$0
	dc.w	$0210
	dc.l	$001FE8CA,$01000040,$0,$0
	dc.w	$0211
	dc.l	$001FE8CA,$01000040,$0,$0
	dc.w	$0212
	dc.l	$001FE8CA,$01000040,$0,$0
	dc.w	$0213
	dc.l	$001FEA1E,$01000000,$0,$0
	dc.w	$0214
	dc.l	$001FEA22,$01000000,$0,$0
	dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
	dc.l	off_1FF004,$01000040,$0,$0	; 0215突行技
	dc.w	$0216
	dc.l	$001FEA1E,$01000000,$0,$0
	dc.w	$0217
	dc.l	$001FEA1E,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$001FE24E,$01003000,$0,$0
	dc.w	$021A
	dc.l	$001FE28A,$02000000,$0,$0
	dc.w	$021B
	dc.l	$001FEA1E,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_08170B,$01005000,$0,$0	; 格擋動作$1FE628
off_1FF004:
	dc.l	$F0130100
	dc.l	$F0020500,$003C0000
	dc.l	$F00B4F00,$00B50000
	dc.l	$F0330100
	dc.l	$F0280100
	dc.l	$F0340004,$00730000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00740000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00750000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00760000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00770000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280500
	dc.l	$F0340004,$00770000,$0010FF00,$407820FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00770000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00760000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00750000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00740000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0280100
	dc.l	$F0340004,$00730000,$0010FF00,$007810FF
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$F0130000
	dc.l	$F0020300,$00720CFF
	dc.l	$F0020300,$007208FF
	dc.l	$F0020300,$007204FF
	dc.l	$F0020300,$007202FF
	dc.l	$F0020500,$003C0000
	dc.l	$80000000
off_08170B:
	dc.l	$F00BEF00,$01100000
	dc.l	$F0020800,$004A0000	; 格擋前動作$1E
	dc.l	$80000000


off_1FF800:
	dc.l	$F0130100
	dc.l	$F0540600
	dc.l	$F04F2E00
	dc.l	$F0450300
	dc.l	$F0020100,$00490000
	dc.l	$F0020200,$00480000
	dc.l	$F00BFF00,$01080000
	dc.l	$F00B9F00,$00B40000,$00490000,$204A0000
	dc.l	$F0330100
	dc.l	$F0340004,$004C0000,$00000000,$204B0000
	dc.l	$F0340004,$004E0000,$00000000,$004D0000
	dc.l	$F0340004,$00500000,$00000000,$004F0000
	dc.l	$F0340004,$00510000,$00000000,$004F0000
	dc.l	$F0340004,$00520000,$00000000,$004F0000
	dc.l	$F0330000,$002D0000
	dc.l	$80000000


off_2017D2:	; 援軍曹操06類動作
	dc.w	$0600	; 地裂劍[三氣|0304]
	dc.l	$0020049C,$01003040,$10000000,0
	dc.w	$0601	; 天斷劍[硬漢]
	dc.l	off_201202,$02000040,$10000000,0
	dc.w	$0602	; 人如劍[硬漢]
	dc.l	off_2010EE,$02000040,$10000000,0
	dc.w	$0603	; 心是劍[無敵]
	dc.l	off_2016EA,$01003840,0,0
	dc.w	$0604	; 一指剑[劍氣]
	dc.l	off_1FF504,$01003040,0,0

off_201202:	; 天斷劍
	dc.l	$F0540600
	dc.l	$F04F2E06
	dc.l	$F0450200
	dc.l	$F05E0100	; 硬漢
	dc.l	$F0020500,$003C0000
	dc.l	$F0020500,$006B0000
	dc.l	$F0260100
	dc.l	$F02700FF,$006D0000,$000000F6,$006C0000
	dc.l	$F02700FF,$006D0000,$000000E2,$006C0000
	dc.l	$F02700FF,$006D0000,$000000C4,$006C0000
	dc.l	$F02700FF,$006D0000,$0000009C,$006C0000
	dc.l	$F02700FF,$007B0000,$0000009C,$00790000
	dc.l	$F02700FF,$007B0000,$0000009C,$00790000
	dc.l	$F02700FF,$007B0000,$0000009C,$00790000
	dc.l	$F02700FF,$007B0000,$0000009C,$00790000
	dc.l	$F02700FF,$007B0000,$0000009C,$00790000
	dc.l	$F0130100
	dc.l	$F02A020A
	dc.l	$F02700FF,$007B0000,$0000008A,$007A00EE
	dc.l	$F02700FF,$007B0000,$000000A0,$007A00F0
	dc.l	$F02700FF,$007B0000,$000000B6,$007A00F2
	dc.l	$F02700FF,$007B0000,$000000C2,$007A00F4
	dc.l	$F02700FF,$007B0000,$000000CE,$007A00F6
	dc.l	$F02700FF,$007B0000,$000000DA,$007A00F8
	dc.l	$F02700FF,$007B0000,$000000E6,$007A00FA
	dc.l	$F02700FF,$007B0000,$000000F3,$007A00FD
	dc.l	$F0260000,$007C0000,$007C0000,$007C0000,$007C0000,$007C0000
	dc.l	$F0130000
	dc.l	$F00BFF00,$010A0000
	dc.l	$F0330100
	dc.l	$F0340004,$007E0000,$00000001,$007D0001
	dc.l	$F0340004,$007F0000,$00000002,$007D0002
	dc.l	$F0340004,$00800000,$00000003,$007D0003
	dc.l	$F0340004,$00810000,$00000004,$007D0004
	dc.l	$F0340004,$007E0000,$00000004,$007D0005
	dc.l	$F0330000,$208200E7,$20820007
	dc.l	$F0030000,$2082000C
	* dc.l	$F0070000,$001249C6	; 白屏
	dc.l	$F02A0000
	dc.l	$F0450300
	dc.l	$F0410100
	dc.l	$F0140009,$00000100
	dc.l	$F0330100
	dc.l	$F00BFF00,$00B40000
	dc.l	$F00BFF00,$00B40000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00840000,$00000000,$20830000
	dc.l	$F0340004,$00860000,$00000000,$00850000
	dc.l	$F0340004,$00860000,$00000000,$00850000
	dc.l	$F0340004,$00860000,$00000000,$00850000
	dc.l	$F0330000
	dc.l	$F0260100
	dc.l	$F0270004,$00880000,$00000000,$00870000
	dc.l	$F0270004,$00880000,$00000000,$00870000
	dc.l	$F0270004,$00890000,$00000000,$00870000
	dc.l	$F0270004,$00890000,$00000000,$00870000
	dc.l	$F0270004,$008A0000,$00000000,$00870000
	dc.l	$F0270004,$008A0000,$00000000,$00870000
	dc.l	$F0260000
	dc.l	$F05E0000
	dc.l	$F0020E00,$00870000
	dc.l	$F0020500,$00710000
	dc.l	$80000000

off_2010EE:	; 人如劍
	dc.l	$F0540600
	dc.l	$F04F2E00
	dc.l	$F0450300
	dc.l	$F05E0100	; 霸體狀態
	dc.l	$F0020500,$003C0000
	dc.l	$F00BFF00,$01090000
	dc.l	$F00B4F00,$00B50000
	dc.l	$F0020500,$00720E00
	dc.l	$F0330100
	dc.l	$F0280300
	dc.l	$F0340004,$00190000,$000E0000,$20720E00
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F0340004,$001A0000,$000E0000,$20720E00
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$001B0000,$000E0000,$20720E00
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F0340004,$001C0000,$000E0000,$20720E00
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$001D0000,$000E0000,$20720E00
	dc.l	$F0290000
	dc.l	$F0410100
	dc.l	$F0280300
	dc.l	$F0340004,$00190000,$000E0000,$20720E00
	dc.l	$F0290000
	dc.l	$F0280300
	dc.l	$F0340004,$001A0000,$000E0000,$20720E00
	dc.l	$F0290000
	dc.l	$F0330000
	dc.l	$F05E0000	; 取消霸體
	dc.l	$F0020300,$00720C00
	dc.l	$F0020300,$00720800
	dc.l	$F0020300,$00720400
	dc.l	$F0020300,$00720200
	dc.l	$F0020500,$003C0000
	dc.l	$80000000

off_2016EA:	; 心是劍
	dc.l	$003C0000
	dc.l	$F0140332,$0000019E
	dc.l	$F00BFF00,$01130000
	dc.l	$F0130100	; 起手無敵
	dc.l	$F0020500,$006B0000,$006C0000
	dc.l	$F00B9F00,$00B70000
	dc.l	$F0130000,$F00E0000
	dc.l	$F0260100
	dc.l	$F02700FF,$006D0000,$000000F6,$006C0000
	dc.l	$F02700FF,$006D0000,$000000E2,$006C0000
	dc.l	$F02700FF,$006D0000,$000000C4,$006C0000
	dc.l	$F02700FF,$006D0000,$0000009C,$006C0000
	dc.l	$F0260000
	dc.l	$F00E0300
	dc.l	$F015FE00,$00201676,$00000100
	dc.l	$F0020F00,$006C0000
	dc.l	$F00E0000
	dc.l	$F0260100
	dc.l	$F02700FF,$006D0000,$0000009C,$006C0000
	dc.l	$F02700FF,$006D0000,$000000C4,$006C0000
	dc.l	$F02700FF,$006D0000,$000000E2,$006C0000
	dc.l	$F02700FF,$006D0000,$000000F6,$006C0000
	dc.l	$F0260000
	dc.l	$F00E0300,$00700000,$00710000
	dc.l	$80000000

off_1FF504:	; 一指剑
	dc.l	$F0540600
	dc.l	$F04F1200
	dc.l	$F05C0600
	dc.l	$F0450300,$003C0000
	dc.l	$F00BFF00,$01080000
	dc.l	$F0330100
	dc.l	$F00E0000
	dc.l	$F0130100
	dc.l	$F0070000,$001673B6
	dc.l	$F0340004,$002F0000,$00000000,$202E0000
	dc.l	$F0340004,$002F0000,$00000000,$202E0000
	dc.l	$F0130000
	dc.l	$F0530000
	dc.l	$F0340004,$002F0000,$00000000,$202E0000
	dc.l	$F00E0300
	dc.l	$F0340004,$00310000,$00000000,$00300000
	dc.l	$F0330000
	dc.l	$F00B6F00,$00B20000
	dc.l	$F015FE00,off_1FF490,$00000100	; 雷電劍光
	dc.l	$F0020400,$00320000,$003B0000,$002D0000
	dc.l	$80000000

off_1FF490:
	dc.l	$001FF46C,$001FCD18,$001FCD1C,$001FCD1E
	dc.l	$0034F4EC,$001F1E60,$00050420,$00000000
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000604	; 道具傷害0604
	dc.l	$00000034,$F5060000,$00000000,sub_17A088	; 電劍擊飛
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00001200,$00000000,$00000000

sub_17A088:	; 一指劍雷電擊飛
	link	a6,#0
	movem.l	a2-a3,-(sp)
	movea.l	8(a6),a2
	movea.l	$C(a6),a3
; 雷電攻擊
	move.w	#$10,$258(a2)
	clr.l	-(sp)
	move.l	a2,-(sp)
	jsr		$12AB2C
	addq.l	#8,sp
	bset	#2,$244(a2)		; 電屬性
; 擊飛動作
	move.w	$5C(a3),d0
	cmp.w	$C8(a2),d0
	beq.s	loc_17A0A4
	pea		(3).w
	bra.s	loc_17A0A8
loc_17A0A4:
	pea		($D).w
loc_17A0A8:
	pea		(8).w
	move.l	a2,-(sp)
	jsr		$15E152			; 計算動作指針
	lea		$C(sp),sp
	movem.l	(sp)+,a2-a3
	unlk	a6
	rts


off_22D636:
	dc.w	$0200
	dc.l	$0022CA36,$01007000,$0,$0
	dc.w	$0201
	dc.l	$0022CA36,$01007000,$0,$0
	dc.w	$0202
	dc.l	$0022CA6A,$01001000,$0,$0	; 周泰轉身速度$5000
	dc.w	$0203	; 向上走
	dc.l	off_22CA76,$01000000,$0,$0
	dc.w	$0204	; 斜上走
	dc.l	off_22CABA,$01000000,$0,$0
	dc.w	$0205	; 向前走
	dc.l	off_22CAFE,$01000000,$0,$0
	dc.w	$0206	; 斜下走
	dc.l	off_22CB42,$01000000,$0,$0
	dc.w	$0207	; 向下走
	dc.l	off_22CB86,$01000000,$0,$0
	dc.w	$0208
	dc.l	$0022CBCA,$01000000,$0,$0
	dc.w	$0209
	dc.l	$0022CC0E,$01000000,$0,$0
	dc.w	$020A
	dc.l	$0022CC52,$01000000,$0,$0
	dc.w	$020B
	dc.l	$0022CC96,$01000000,$0,$0
	dc.w	$020C
	dc.l	$0022CCFA,$01000000,$0,$0
	dc.w	$020D
	dc.l	$0022CD5E,$01000000,$0,$0
	dc.w	$020E
	dc.l	$0022CDC2,$01000000,$0,$0
	dc.w	$020F
	dc.l	$0022CE26,$01000000,$0,$0
	dc.w	$0210
	dc.l	$0022CF52,$01000000,$0,$0
	dc.w	$0211
	dc.l	$0022CEEE,$01000000,$0,$0
	dc.w	$0212
	dc.l	$0022CE8A,$01000000,$0,$0
	dc.w	$0213
	dc.l	$0022D62E,$01000000,$0,$0
	dc.w	$0214
	dc.l	$0022D632,$01000000,$0,$0
	dc.w	$0215
	dc.l	off_22AC0E,$02000040,$0,$0
	dc.w	$0216
	dc.l	$0022D62E,$01000000,$0,$0
	dc.w	$0217
	dc.l	$0022D62E,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$0022D006,$01003000,$0,$0
	dc.w	$021A
	dc.l	$0022D03E,$02000000,$0,$0
	dc.w	$021B
	dc.l	$0022D62E,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_081719,$01005000,$0,$0

off_22CA76:	; 向上走
	dc.l	$001100FF,$001100FE,$001100FF,$001100FE,$001100FF
	dc.l	$001200FE,$001200FF,$001200FE,$001200FF,$001200FE
	dc.l	$001300FF,$001300FE,$001300FF,$001300FE,$001300FF
	dc.l	$001400FE,$001400FF,$001400FE,$001400FF,$001400FE
	dc.l	$001500FF,$001500FE,$001500FF,$001500FE,$001500FF
	dc.l	$001600FE,$001600FF,$001600FE,$001600FF,$001600FE
	dc.l	$001700FF,$001700FE,$001700FF,$001700FE,$001700FF
	dc.l	$001800FE,$001800FF,$001800FE,$001800FF,$001800FE
	dc.l	$F0010000
off_22CABA:	; 斜上走
	dc.l	$001103FF,$001103FF,$001103FF,$001103FF,$001103FF
	dc.l	$001203FF,$001203FF,$001203FF,$001203FF,$001203FF
	dc.l	$001303FF,$001303FF,$001303FF,$001303FF,$001303FF
	dc.l	$001403FF,$001403FF,$001403FF,$001403FF,$001403FF
	dc.l	$001503FF,$001503FF,$001503FF,$001503FF,$001503FF
	dc.l	$001603FF,$001603FF,$001603FF,$001603FF,$001603FF
	dc.l	$001703FF,$001703FF,$001703FF,$001703FF,$001703FF
	dc.l	$001803FF,$001803FF,$001803FF,$001803FF,$001803FF
	dc.l	$F0010000
off_22CAFE:	; 向前走
	dc.l	$00110300,$00110300,$00110300,$00110300,$00110300
	dc.l	$00120300,$00120300,$00120300,$00120300,$00120300
	dc.l	$00130300,$00130300,$00130300,$00130300,$00130300
	dc.l	$00140300,$00140300,$00140300,$00140300,$00140300
	dc.l	$00150300,$00150300,$00150300,$00150300,$00150300
	dc.l	$00160300,$00160300,$00160300,$00160300,$00160300
	dc.l	$00170300,$00170300,$00170300,$00170300,$00170300
	dc.l	$00180300,$00180300,$00180300,$00180300,$00180300
	dc.l	$F0010000
off_22CB42:	; 斜下走
	dc.l	$00110301,$00110301,$00110301,$00110301,$00110301
	dc.l	$00120301,$00120301,$00120301,$00120301,$00120301
	dc.l	$00130301,$00130301,$00130301,$00130301,$00130301
	dc.l	$00140301,$00140301,$00140301,$00140301,$00140301
	dc.l	$00150301,$00150301,$00150301,$00150301,$00150301
	dc.l	$00160301,$00160301,$00160301,$00160301,$00160301
	dc.l	$00170301,$00170301,$00170301,$00170301,$00170301
	dc.l	$00180301,$00180301,$00180301,$00180301,$00180301
	dc.l	$F0010000
off_22CB86:	; 向下走
	dc.l	$00110001,$00110002,$00110001,$00110002,$00110001
	dc.l	$00120002,$00120001,$00120002,$00120001,$00120002
	dc.l	$00130001,$00130002,$00130001,$00130002,$00130001
	dc.l	$00140002,$00140001,$00140002,$00140001,$00140002
	dc.l	$00150002,$00150001,$00150002,$00150001,$00150002,$00150001
	dc.l	$00160002,$00160001,$00160002,$00160001,$00160002
	dc.l	$00170001,$00170002,$00170001,$00170002,$00170001
	dc.l	$00180002,$00180001,$00180002,$00180001,$00180002
	dc.l	$F0010000

off_22AC0E:
	dc.l	$F0130100
	dc.l	$F0020300,$00470000
	dc.l	$F0020300,$00480000
	dc.l	$F00BFF00,$01710000
	dc.l	$F00B9F00,$00CC0000,$00491900
	dc.l	$F0020300,$00490600
	dc.l	$F0020300,$004A0800
	dc.l	$F0020300,$004B0800
	dc.l	$F0020300,$004C0800
	dc.l	$F0020300,$004D0800
	dc.l	$F0020300,$004A0800
	dc.l	$F0020300,$004B0800
	dc.l	$F0020300,$004C0800
	dc.l	$F0020300,$004D0800
	dc.l	$F00BFF00,$016F0000
	dc.l	$004E08FC,$004E08FA,$004E08F8,$004E08F6
	dc.l	$004F08F6,$004F08F8,$004F08FA,$004F08FC
	dc.l	$005008FE,$005008FF,$00500801,$00500802
	dc.l	$00510804,$00510806,$00510808
	dc.l	$F0030000,$0051080A
	dc.l	$F0130000
	dc.l	$F0140009,$00000100
	dc.l	$F0020600,$00520000
	dc.l	$80000000

off_081719:	; 格擋前動作$47
	dc.l	$F0020400,$00470000
	dc.l	$80000000

off_22B982:
	dc.l	$F0130100
	dc.l	$F0540800
	dc.l	$F04F2E00
	dc.l	$F05C0100
	dc.l	$F05E0100
	dc.l	$F0020300,$00760000
	dc.l	$F0020300,$00390000
	dc.l	$F05E0000
	dc.l	$F00BFF00,$01700000
	dc.l	$F0330100
	dc.l	$F00B9F00,$02C50000
	dc.l	$F03400FF,$003D0000,$00000000,$003C0000
	dc.l	$F03400FF,$003D0000,$00000000,$003C0000
	dc.l	$F03400FF,$003D0000,$00000000,$003C0000
	dc.l	$F03400FF,$003F0000,$00000000,$203E0000
	dc.l	$F05C0000
	dc.l	$F0451D00
	dc.l	$F03400FF,$00410000,$00000000,$20400000
	dc.l	$F03400FF,$00430000,$00000000,$00420000
	dc.l	$F03400FF,$00440000,$00000000,$00420000
	dc.l	$F03400FF,$00450000,$00000000,$00420000
	dc.l	$F0330000
	dc.l	$F0020600,$00420000
	dc.l	$F0020300,$00460000
	dc.l	$80000000


off_22B04A:	; [滿腔怒火]機關
	dc.l	$0022B016,$001C9D96,$001CA74E,$001CAA74
	dc.l	$00319D02,$00587F33,$05090420,$00000000
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$40000000,$00000000,$00000000,$00000602	; 對應編號0602
	dc.l	$00000000,$00000052,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000100,$00000000,$00000000,$00000000,0


off_23C1CE:
	dc.w	$0200
	dc.l	$0023B87A,$01007000,$0,$0
	dc.w	$0201
	dc.l	$0023B87A,$01007000,$0,$0
	dc.w	$0202
	dc.l	$0023B8AA,$01005000,$0,$0
	dc.w	$0203
	dc.l	$0023B8B2,$01000000,$0,$0
	dc.w	$0204
	dc.l	$0023B9AE,$01000000,$0,$0
	dc.w	$0205
	dc.l	$0023B906,$01000000,$0,$0
	dc.w	$0206
	dc.l	$0023BA02,$01000000,$0,$0
	dc.w	$0207
	dc.l	$0023B95A,$01000000,$0,$0
	dc.w	$0208
	dc.l	$0023BA56,$01000000,$0,$0
	dc.w	$0209
	dc.l	$0023BAAA,$01000000,$0,$0
	dc.w	$020A
	dc.l	$0023BAFE,$01000000,$0,$0
	dc.w	$020B
	dc.l	$0023C1C2,$01000000,$0,$0
	dc.w	$020C
	dc.l	$0023C1C2,$01000000,$0,$0
	dc.w	$020D
	dc.l	$0023C1C2,$01000000,$0,$0
	dc.w	$020E
	dc.l	$0023C1C2,$01000000,$0,$0
	dc.w	$020F
	dc.l	$0023C1C2,$01000000,$0,$0
	dc.w	$0210
	dc.l	$0023C1C2,$01000000,$0,$0
	dc.w	$0211
	dc.l	$0023C1C2,$01000000,$0,$0
	dc.w	$0212
	dc.l	$0023C1C2,$01000000,$0,$0
	dc.w	$0213
	dc.l	$0023C1C6,$01000000,$0,$0
	dc.w	$0214
	dc.l	$0023C1CA,$01000000,$0,$0
	dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
	dc.l	off_23E5EA,$01001040,$0,$0	; 0215突行技
	dc.w	$0216
	dc.l	$0023C1C6,$01000000,$0,$0
	dc.w	$0217
	dc.l	$0023C1C6,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$0023BB52,$01003000,$0,$0
	dc.w	$021A
	dc.l	$0023BB86,$02000000,$0,$0
	dc.w	$021B
	dc.l	$0023C1C6,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_08171D,$01005000,$0,$0
off_23E5EA:
	dc.l	$F0130100
	dc.l	$F0280300
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0290000
	dc.l	$F0020D00,$407A1003
	dc.l	$F0280300
	dc.l	$F0020200,$007A0000
	dc.l	$F0020200,$407A0000
	dc.l	$F0290000
	dc.l	$80000000
off_08171D:
	dc.l	$F0020400,$00400000	; 格擋前動作$40
	dc.l	$80000000


off_23C694:
	dc.l	$F0130100
	dc.l	$F0540600
	dc.l	$F04F280D
	dc.l	$F0450300,$004A1800,$004A0000,$204B1600
	dc.l	$F0020200,$204B0000
	dc.l	$F00B9F00,$02C30000
	dc.l	$F0330100
	dc.l	$F0340004,$004D0000,$00000000,$204C0000
	dc.l	$F0340004,$004E0000,$00000000,$204C0000
	dc.l	$F0330000
	dc.l	$F0020200,$004F0000
	dc.l	$F0020200,$00500000
	dc.l	$F0020200,$00510000
	dc.l	$80000000


off_23E802:
	dc.w	$0600
	dc.l	$0023E62E,$01002240,$10000000,$0
	dc.w	$0601
	dc.l	$0023E1DE,$02000240,$0,$0
	dc.w	$0602
	dc.l	$0023E4E6,$01002240,$0,$0
	dc.w	$0603
	dc.l	$0023E52E,$01002240,$10000000,$0
	dc.w	$0604
	dc.l	$0023E5EA,$01000240,$0,$0
	dc.w	$0605
	dc.l	$0023E6E6,$01002240,$0,$0
	dc.w	$0606
	dc.l	off_23C700,$01002240,$0,$0	; 四招[節奏A觸發下招][6A-A-A-A]


off_23C700:
	dc.l	$F0540600
	dc.l	$F04F2A01
	dc.l	$F05E0100
	dc.l	$F0410100
	dc.l	$F0550100
	dc.l	$F00B9F00,$02C20000
	dc.l	$F0020200,$203E0000
	dc.l	$F0020400,$203F0000
	dc.l	$F0560300
	dc.l	$F0020400,$00400000
	dc.l	$80000000
	dc.l	$F0410100
	dc.l	$F0550100
	dc.l	$F00B9F00,$02C20000
	dc.l	$F0020200,$00400000,$20401000,$20410000
	dc.l	$F0020400,$20420000
	dc.l	$F0020200,$00430000
	dc.l	$F0560100
	dc.l	$80000000
	dc.l	$F0410100
	dc.l	$F0550100
	dc.l	$F00B9F00,$02C30000
	dc.l	$F0450A00,$20440700,$20440000
	dc.l	$F0330100
	dc.l	$F0340004,$00460000,$00000000,$20450000
	dc.l	$F0340004,$00460000,$00000000,$20450000
	dc.l	$F0340004,$00480000,$00000000,$00470000
	dc.l	$F0340004,$00490000,$00000000,$00470000
	dc.l	$F0330000,$004A1900
	dc.l	$F0560100
	dc.l	$80000000
	dc.l	$F0450300
	dc.l	$F0410100
	dc.l	$F00B9F00,$02C30000
	dc.l	$204B2001,$204B0000
	dc.l	$F0020200,$004A0000
	dc.l	$F0330100
	dc.l	$F0340004,$004D0000,$00000000,$204C0000
	dc.l	$F0340004,$004E0000,$00000000,$204C0000
	dc.l	$F0330000
	dc.l	$F0020200,$004F0000
	dc.l	$F0020200,$00500000
	dc.l	$F0020200,$00510000
	dc.l	$80000000


off_21A1DA:
	dc.w	$0200
	dc.l	$0021828E,$01007000,$0,$0
	dc.w	$0201
	dc.l	$002182BE,$01007000,$0,$0
	dc.w	$0202
	dc.l	$002182EE,$01002000,$0,$0	; 許褚轉身速度$8000
	dc.w	$0203
	dc.l	$00218342,$01000000,$0,$0
	dc.w	$0204
	dc.l	$002183CA,$01000000,$0,$0
	dc.w	$0205
	dc.l	$002182FE,$01000000,$0,$0
	dc.w	$0206
	dc.l	$0021840E,$01000000,$0,$0
	dc.w	$0207
	dc.l	$00218386,$01000000,$0,$0
	dc.w	$0208
	dc.l	$00218452,$01000000,$0,$0
	dc.w	$0209
	dc.l	$00218496,$01000000,$0,$0
	dc.w	$020A
	dc.l	$002184DA,$01000000,$0,$0
	dc.w	$020B
	dc.l	$0021851E,$01000000,$0,$0
	dc.w	$020C
	dc.l	$00218582,$01000000,$0,$0
	dc.w	$020D
	dc.l	$002185E6,$01000000,$0,$0
	dc.w	$020E
	dc.l	$0021864A,$01000000,$0,$0
	dc.w	$020F
	dc.l	$002186AE,$01000000,$0,$0
	dc.w	$0210
	dc.l	$002187DA,$01000000,$0,$0
	dc.w	$0211
	dc.l	$00218776,$01000000,$0,$0
	dc.w	$0212
	dc.l	$00218712,$01000000,$0,$0
	dc.w	$0213
	dc.l	$0021A1D2,$01000000,$0,$0
	dc.w	$0214
	dc.l	$0021A1D6,$01000000,$0,$0
	dc.w	$0400	; 04/05/06/07類動作無后續[如落地動作]
	dc.l	off_218DCC,$01000000,$0,$0	; 0215突行技
	dc.w	$0216
	dc.l	$0021A1D2,$01000000,$0,$0
	dc.w	$0217
	dc.l	$0021A1D2,$01000000,$0,$0
	dc.w	$0218
	dc.l	$0,$0,$0,$0
	dc.w	$0219
	dc.l	$00218B7E,$01003000,$0,$0
	dc.w	$021A
	dc.l	$00218BDA,$02000000,$0,$0
	dc.w	$021B
	dc.l	$0021A1D2,$01001000,$0,$0
	dcb.l	$99,$0	; $264偏移
	dc.w	$023E
	dc.l	off_081714,$01005000,$0,$0

off_218DCC:	; 0215突行技|縮短距離
	dc.l	$F0130100
	dc.l	$F0020600,$001A0500
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020200,$001B0500
	dc.l	$F0020400,$001B0500
	dc.l	$F0020600,$001C0500
	dc.l	$F0020600,$001D0500
	dc.l	$F0020600,$001E0500
	* dc.l	$F00B3F00,$02BE0000
	* dc.l	$F0140008,$00000100
	* dc.l	$F0020200,$001F0500
	* dc.l	$F0020400,$001F0500
	* dc.l	$F0020600,$00200500
	* dc.l	$F0020600,$00210500
	* dc.l	$F0020600,$001A0500
	dc.l	$F00B3F00,$02BE0000
	dc.l	$F0140008,$00000100
	dc.l	$F0020200,$001B0500
	dc.l	$F0130000
	dc.l	$F0020400,$001B0500
	dc.l	$F0020600,$001C0500
	dc.l	$80000000

off_081714:	; 格擋前動作$3C
	dc.l	$F0020400,$003C0000
	dc.l	$80000000


off_21AF34:	; 普攻一式|輕拳
	dc.l	$F0540400
	dc.l	$F04F0B13
	dc.l	$F0450000
	dc.l	$F0550000	; 可接下一式
	dc.l	$F0580100
	dc.l	$F0020400,$003C0000
	dc.l	$F00B9F00,$02C50000,$203D0000,$203E0000
	dc.l	$F0020500,$003F0000
	dc.l	$F0570301	; 可接二式
	dc.l	$80000000

off_219060:	; 普攻一式|重腿
	dc.l	$F0540200
	dc.l	$F04F1100
	dc.l	$F0450700
	dc.l	$F05E0100
	dc.l	$F0020200,$00400000,$20412800,$20410000	; 向前位移$0051
	dc.l	$F00B9F00,$02C30000
	dc.l	$F0410100
	dc.l	$F0020200,$20420000
	dc.l	$F05E0000
	dc.l	$F0020400,$00430000,$0044F0FC,$00440000,$0000EE04	; 向後位移$FFE0+$FFDC
	dc.l	$80000000


off_21B8D4:
	dc.w	$0600	; 六丁開山
	dc.l	$0021B260,$01000240,$10000000,$0
	dc.w	$0601	; 探海求珠[爆炸]
	dc.l	$00219754,$01002240,$0,$0
	dc.w	$0602	; 投石問路[0304]-26B
	dc.l	off_219330,$01002040,$0,$0
	dc.w	$0603	; 泰山壓頂
	dc.l	$0021B5C8,$02000040,$10000000,$0
	dc.w	$0604	; 推天搶地-46A
	dc.l	off_218F94,$01002240,$0,$0
	dc.w	$0605	; 懷中抱月-6A
	dc.l	$0021B19C,$02000240,$10000000,$0

off_219330:	; 投石問路
	dc.l	$F05E0100	; 起手霸體
	dc.l	$F0020200,$00490000
	dc.l	$F0020200,$004A0000
	dc.l	$F0020400,$004B0000,$004C0000
	dc.l	$F05E0000
	dc.l	$F00B6F00,$02C80000
	dc.l	$F0140122,$005400C2
	dc.l	$F015FF00,$002192BC,$006400D3
	dc.l	$F0020600,$004D0000,$004E0000
	dc.l	$80000000

off_218F94:	; 推天搶地
	dc.l	$F0540600
	dc.l	$F04F0F0F
	dc.l	$F0450300
	dc.l	$F05E0100,$00381100	; $23
	dc.l	$F0020100,$00380000
	dc.l	$F00B9F00,$02C50000
	dc.l	$F00BFF00,$014E0000,$20390000
	dc.l	$F05E0000
	dc.l	$F0020200,$20390000
	dc.l	$F0020300,$003A0000,$003B1900,$003B0000,$00000603	; $32+$0D
	dc.l	$80000000


byte_1E84AA:	; 援軍普攻攻擊力表|03類動作
		*  0300| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | A | B | C | D
	dc.b	$28,$28,$34,0,  $1E,0,  0,  0,  0,  0,  0,  0,  0,  $40	; 曹操0B
	dcb.b	$E,0
	dc.b	$14,0,  0,  0,  0,  0,  0,  0,  $14,0,  0,  0,  0,  $30	; 程昱0D
	dcb.b	$E,0
	dcb.b	$E,0
	dcb.b	$E,0
	dc.b	$14,$18,$24,$30,0,  0,  0,  0,  0,  0,  0,  0,  0,  $40	; 夏侯淵11
	dc.b	$12,$1C,0,  0,  $20,0,  0,  0,  $1C,0,  0,  0,  0,  $40	; 夏侯惇12
	dc.b	$1E,$28,0,  0,  0,  0,  0,  0,  $1E,0,  0,  0,  0,  $40	; 牛金13
	dc.b	$1E,$22,0,  0,  $24,0,  0,  0,  $1E,0,  0,  0,  0,  $40	; 許褚14
	dc.b	$1E,$22,0,  0,  0,  0,  0,  0,  $1E,0,  0,  0,  0,  $40	; 張郃15
	dcb.b	$E,0
	dcb.b	$E,0
	dc.b	$18,$2A,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $40	; 甘寧18
	dc.b	$30,$19,0,  0,  0,  0,  0,  0,  $1E,0,  0,  0,  0,  $30	; 周泰19
	dcb.b	$E,0
	dcb.b	$E,0
	dc.b	$2A,0,  0,  0,  0,  0,  0,  0,  $28,0,  0,  0,  0,  $40	; 徐晃1C
	dc.b	$32,$50,0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  $40	; 呂布1D

byte_1E8672:	; 援軍必殺攻擊力表|06類動作
		*  0600| 1 | 2 | 3 | 4 | 5 | 6 |
	dc.b	$3C,$50,$32,0,  $3C,0,  0,  0	; 曹操0B
	dcb.b	$8,0
	dc.b	$18,$22,$14,$14,$1C,0,  0,  0	; 程昱0D
	dcb.b	$8,0
	dcb.b	$8,0
	dcb.b	$8,0
	dc.b	$50,$20,$18,$18,0,  0,  0,  0	; 夏侯淵11
	dc.b	$18,$A, $18,$18,0,  0,  0,  0	; 夏侯惇12
	dc.b	$A, $28,$18,$1E,$2E,$18,0,  0	; 牛金13
	dc.b	$24,$48,$2E,$50,$40,$32,0,  0	; 許褚14
	dc.b	$20,$18,$3C,$24,0,  0,  0,  0	; 張郃15
	dcb.b	$8,0
	dcb.b	$8,0
	dc.b	$2C,$18,$14,$3C,0,  $40,0,  0	; 甘寧18
	dc.b	$1E,$3C,$40,$24,0,  0,  0,  0	; 周泰19
	dcb.b	$8,0
	dcb.b	$8,0
	dc.b	$3E,$32,$38,$50,$28,0,  0,  0	; 徐晃1C
	dc.b	$46,$3C,$46,$5A,0,  $38,$40,0	; 呂布1D

; --------------- 道具調整 --------------------------------------------------

byte_1C6470:	; 關羽
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 4, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 5, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 6, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 7, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 8, 8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A
byte_1C66F2:	; 張飛
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 4, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 5, 5, 4, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 6, 6, 5, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 7, 7, 6, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 8, 8, 7, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A
byte_1C6974:	; 趙雲
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 4, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 5, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 6, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 7, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 8, 7, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A
byte_1C6BF6:	; 黃忠
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 4, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 5, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 6, 5, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 7, 6, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 8, 8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A
byte_1C6E78:	; 馬超
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 4, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 5, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 4, 0, 0, 0, 5, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 6, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 0, 0, 0, 6, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 6, 0, 0, 0, 7, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 7, 0, 0, 0, 8, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 9, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A
byte_1C70FA:	; 孔明
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4, 0, 0, 0, 3, 2, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 5, 0, 0, 0, 4, 2, 0, 2, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 0, 0, 6, 0, 0, 0, 5, 3, 0, 2, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 7, 0, 0, 0, 0, 7, 0, 0, 0, 6, 4, 0, 3, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 8, 0, 0, 0, 0, 8, 0, 0, 0, 7, 5, 0, 4, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 9, 0, 0, 0, 0, 9, 0, 0, 0, 9, 6, 0, 5, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A
byte_1C737C:	; 貂蟬
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 2, 3, 1, 1, 0, 0, 0, 3, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 3, 4, 2, 2, 0, 0, 0, 4, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 4, 5, 3, 3, 0, 0, 0, 5, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 5, 6, 4, 4, 0, 0, 0, 6, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 6, 7, 5, 5, 0, 0, 0, 7, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 9, 9, 9, 9, 0, 0, 0, 9, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A
byte_1C75FE:	; 龐統
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 2, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 3, 4, 0, 0, 4, 0, 0, 0, 0, 0, 0, 3, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 4, 5, 3, 0, 5, 0, 0, 0, 0, 0, 0, 4, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 6, 6, 5, 0, 6, 0, 0, 0, 0, 0, 0, 5, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 6, 0, 7, 0, 0, 0, 0, 0, 0, 6, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A
byte_1C7880:	; 孫權
			*  1| 2| 3| 4| 5| 6| 7| 8| 9| A| B| C| D| E| F|10|11|12|13|14|15|16|17|18|19|1A|1B|1C|1D|1E|1F|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|2F|30|31|32|33|34|35|36|37|38|39|3A|3B|3C|3D|3E|3F|40|41|42
	dc.b	0, 4, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $6B
	dc.b	0, 5, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $D6
	dc.b	0, 6, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $141
	dc.b	0, 7, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $1AC
	dc.b	0, 8, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; $217
	dc.b	0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0
	   dc.b	1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	; 0
		*  43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|5D|5E|5F|60|61|62|63|64|65|66|67|68|69|6A


dword_1C135E:
	dc.l	$00000000,$000000F8,$000000F9,$000000FA
	dc.l	$000000FB,$000000FC,$000000FD,$000000FE,$000000FF
	dc.l	$F0030000,$00000003
	dc.l	$F0070000,sub_11BFF8
	dc.l	$80000000

sub_11BFF8:
	movea.l	4(sp),a0
	move.l	#dword_1C13F2,$2C(a0)
	clr.w	$3C(a0)
	clr.w	$54(a0)
	rts

dword_1C13F2:
	dc.l	$00000000,$000000FD,$00000003,$00000003,$000000FD
	dc.l	$F00E0000
	dc.l	$F028FF00	; 地面
	dc.l	$F0020F00,$00000000
	dc.l	$F0290000
	dc.l	$F0283C00	; 閃爍
	dc.l	$00000000,$00000000,$40000000,$40000000
	dc.l	$F0290000
	dc.l	$80000000


sub_1245F6:
	movea.l	-$C(a6),a0
	move.b	2(a0),d0		; 當前格道具數目
	andi.l	#$FF,d0
	addq.l	#1,d0			; 假設增目[d0]
	add.b	(ram_0005).l,d0	; 107版本+2
	moveq	#0,d1
	move.b	-$1D(a6),d1		; 當前道具上限[d1]
	cmp.l	d1,d0
	bge.s	loc_12461A
	move.b	d0,2(a0)		; +1/+2
	movea.l	#$124624,a0		; 下一道具格
	rts
loc_12461A:
	movea.l	#$12461A,a0		; 寫入上限
	rts


sub_12615A:
; 七星燈不存放
	cmpi.b	#$50, D2		; 是否七星燈
	bne.s	loc_12615B
	movea.l $F8(A3), A4
	move.l  A4, -(A7)		; 角色基址$8186C0(1P例)
	jsr     sub_14CC4A		; 七星燈增加生命數
	addq.l  #4, A7
	moveq   #$1, D0			; 撿取有效
	bra.w	locret_12615A
loc_12615B:
; 道具原位增目規則
	moveq   #$0, D5
	bra.s   loc_126388
loc_1262CA:
	moveq   #$0, D0
	add.l   A4, D0
	move.l  D5, D1
	lsl.l   #2, D1
	add.l   D1, D0
	addi.l  #$a, D0
	movea.l D0, A2
	moveq   #$0, D0
	move.b  ($1,A2), D0
	cmp.l   D2, D0			; 是否已有道具
	bne.s   loc_126386
	move.b  #$2, (A2)
	move.b  ($2,A2), D0
	cmpi.b  #$9, D0			; 撿取數目上限為9
	bcs.s	loc_1262BE
	moveq   #$0, D0			; 無法撿起|取消換分|完成撿取|地面保留道具[D0=0]
	bra.w   locret_12615A
loc_1262BE:
	moveq   #$0, D0			; 撿取道具增目不超上限
	move.b  ($2,A2), D0
	moveq   #$0, D1
	move.b  D3, D1
	add.l   D1, D0
	cmpi.l  #$9, D0
	ble.s   loc_126376
	movea.l -$C(A6), A5
	subi.b	#$9, D0
	move.b  D0, $D(A5)		; 傳遞[道具相增超出數目]到[地面道具數目]
	move.b  #$9, ($2,A2)
	moveq   #$0, D0			; 完成撿取|地面保留道具[D0=0]
	bra.w   locret_12615A
loc_126376:
	moveq   #$0, D0
	move.b  D3, D0
	move.w  D0, ($15a,A3)
	add.b   D3, ($2,A2)
	bra.w   loc_12615C		; [D0=1]撿取地面道具
loc_126386:
	addq.l  #1, D5			; 下一投擲道具位
loc_126388:
	cmpi.b	#16, D5			; AB兩面道具格目共16
	blt.s   loc_1262CA
; 道具增位存放規則
	movea.l ($58,A3), A0	; 操作原A面投擲道具格
	move.b  ($1,A0), D0
	andi.l  #$ff, D0
	lsl.w   #2, D0
	movea.l #$2abce0, A1
	movea.l (A1,D0.w), A0	; 計算投擲道具格目到A0
	move.b  (A0), (-$8,A6)
	tst.b   (-$8,A6)
	beq.s   loc_126170		; 無投擲格目則操作援軍格
	moveq   #$0, D5			; 從A面第一格操作起
	jsr		sub_1262C4		; 道具存放
	tst.b	D0				; 是否撿取完畢
	bne.s	loc_12615C
loc_126170:
	move.b  #$8, (-$8,A6)	; 操作原A面援軍道具格
	moveq   #$8, D5
	moveq   #$0, D1
	move.b  (-$5,A6), D1
	lsl.w   #2, D1
	movea.l #$2abce0, A1
	movea.l (A1,D1.w), A0
	sub.b   ($4,A0), D5		; 計算援軍格目到D5
	cmpi.b  #$8, D5			; 是否可降將
	beq.s   loc_12615A		; 無援軍格目則操作B面
	jsr		sub_1262C4
	tst.b	D0
	bne.s	loc_12615C
loc_12615A:
	moveq   #$1, D4			; 切換到B面
	move.b  #$8, (-$8,A6)	; 全員B面8格
	moveq   #$0, D5			; 從B面第一格操作起
	jsr		sub_1262C4
	tst.b	D0
	beq.s	locret_12615A
	move.b	($6b,A4), D1	; 判斷B面是否自動增格
	addq.l  #1, D5
	cmp.b   D5, D1			; 比較當前操作格號與B面已開啟格目
	bge.s	loc_12615C
	move.b	D5, ($6b,A4)
loc_12615C:
; 撿取武器顯示攻擊值
	moveq	#$27,d0
	cmp.l	d2,d0
	bgt.s	locret_12615A
	moveq	#$42,d0
	cmp.l	d2,d0
	blt.s	locret_12615A
	clr.w	$15A(a3)
	move.l	d2,-(sp)
	move.l	a3,-(sp)
	jsr		$128F5A			; 上升文字
	addq.l	#8,sp
	moveq   #1,d0			; 撿取成功
locret_12615A:
	rts

sub_1262C4:	; 道具的增位存放規則
	bra.s   loc_1263d6
loc_126398:
	moveq   #$0, D0
	move.b  D4, D0
	lsl.l   #5, D0
	add.l   A4, D0
	move.l  D5, D1
	lsl.l   #2, D1
	add.l   D1, D0
	addi.l  #$a, D0
	movea.l D0, A2
	tst.b	($1,A2)			; 判斷當前操作的道具格是否空道具位0x00
	bne.s   loc_1263D4
	move.b  D2, ($1,A2)		; 撿取的道具
	move.b  D3, ($2,A2)		; 撿取的數目
	move.w  D3, ($15a,A3)	; 撿起時顯示的數目
	tst.b	D3				; 檢查撿取的數目是否為0
	beq.s	loc_1263BC
	move.b  #$2, (A2)		; 標記可用
	bra.s	loc_1263BD
loc_1263BC:
	move.b  #$1, (A2)		; 標記禁止
loc_1263BD:
	moveq   #$1, D0			; 撿取成功
	bra.s   locret_1262C4	; D2=0
loc_1263D4:
	addq.l  #1, D5			; 操作下一道具格
loc_1263d6:
	moveq   #$0, D0
	move.b  (-$8,A6), D0
	cmp.l   D5, D0
	bgt.s   loc_126398
	moveq   #$0, D0			; 無法撿起|地面保留道具[D0=0]
locret_1262C4:
	rts						; 完成撿取


sub_12668C:
	moveq   #$16, D0
	cmp.l   D6, D0
	blt.s	loc_126696
	clr.b   D2				; 特殊技于A面00
loc_126696:
	moveq   #$54, D0
	cmp.l   D6, D0			; 防具于C面02
	bgt.s   loc_12668C
	moveq   #$2, D2
	bra.s	locret_12668C
loc_12668C:
	move.b  $6B(A3),d4		; B面開啓的格目
	andi.l  #$FF,d4
	moveq   #$0, D3
loc_12668D:
	moveq   #$1, D0			; B面01
	lsl.l   #5, D0
	add.l   A3, D0
	move.l  D3, D1			; 當前循環次數D3
	lsl.l   #2, D1
	add.l   D1, D0
	addi.l  #$a, D0
	movea.l D0, A2			; 當前操作道具格
	moveq   #$0, D0
	move.b  ($1,A2), D0
	cmp.l   D6, D0			; 比較丟出與當前
	bne.s   loc_12668E
	moveq   #$1, D2
	bra.s	locret_12668C	; 標記于B面01
loc_12668E:
	addq.l  #1, D3			; 對比下一道具位
	cmp.l   D3, D4
	bgt.s   loc_12668D
	clr.b   D2				; 標記于A面00
locret_12668C:
	rts


sub_126742:
	move.l  4(a2),(a2)+		; 原代碼
	addq.l  #1,d5
	cmpi.b  #1,d2			; 是否B面
	bne.s   locret_126742
	cmpi.b  #8,d5			; 是否格8
	bne.s   locret_126742
	clr.l	-(a2)			; 格8置零
locret_126742:
	rts


sub_1266E4:	; 原代碼，騰位
	addi.l  #$a, D0
	movea.l D0, A2
	moveq   #$0, D0
	move.b  ($1,A2), D0
	rts


sub_126D4C:
	btst    #2,$20(a4)		; 是否按下AC
	beq.s	loc_126D4C
	moveq	#1,d0
	bra.s	locret_126D4C
loc_126D4C:
	btst    #1,$20(a4)		; 原代碼:是否按下BC
locret_126D4C:
	rts

	
sub_126E72:
	move.w  #$6C,$1CA(a3)	; 原代碼
	btst    #2,$20(a4)		; 判斷按下的組合鍵是否AC
	beq.s	locret_126E72
	tst.b	D0
	beq.s	loc_126E72		; 或丟出0個
	moveq	#1, D0
loc_126E72:
	move.w  D0, $15A(a3)	; 丟出道具數目置1
locret_126E72:
	rts


sub_129314:	; 0701前庭限制使用水攻計
	moveq	#$15,d0			; 是否恐嚇計
	cmp.l	d2,d0
	beq.s	loc_12931A
	moveq	#$13,d0			; 是否水攻計
	cmp.l	d2,d0
	bne.s	loc_12932A
; 0701前庭水攻計
	cmpi.b	#7,($8182F9).l
	bne.s	loc_12932A
	cmpi.b	#1,($8182FA).l
	bne.s	loc_12932A
	move.w	#1,($80D068).l	; 限制使用
	bra.s	loc_12933E
loc_12931A:	; 恐嚇計
	jsr		$12571C			; 敵將是否在場
	tst.w	d0
	bne.s	loc_129344
loc_12933E:
	move.b	#1,(a2)			; 封禁道具
	movea.l	#$129348,a0
	rts
loc_12932A:	; 判定是否解封
	movea.l	#$12932A,a0
	rts
loc_129344:	; 解封道具格
	movea.l	#$129344,a0
	rts


sub_1268CE:
	move.l  ($4,A2), (A2)+
	addq.l  #1, D4			; 原代碼
	cmpi.b  #$54, ($1,A2)	; 判斷下格是否防具
	blt.s   locret_1268CE
	clr.l	-(A2)			; 當前格置零
locret_1268CE:
	rts


sub_11D2BA:
	cmpi.b	#$C, D2
	bgt.s	locret_11D2BA	; 編號D+的策略無CD
	move.w  #1,$80D03A.l	; 原代碼
locret_11D2BA:
	rts


sub_121452:
	movem.l	d2/d3,-(sp)
	move.l	$C(sp),d3		; 角色的生命值上限
; 循環補充3個生命值
	moveq	#3-1,d2
loc_121452:
	cmp.w	$6C(a2),d3		; 是否超過上限[d3]
	ble.s	locret_121452
	subq.b  #1, $80C3ED.l	; 木牛生命值儲量-1
	blt.s	locret_121452
	addq.w  #1,$6C(a2)
	pea     $1.w			; 生命值+1
	move.l  a4,-(sp)		; 角色基址
	jsr     $14CF6A			; 調整血槽
	addq.l  #8,sp
	dbf		d2,loc_121452
; 明光魚鱗吞食[3]
loc_121453:
	cmpi.w	#$565C,$22A(a2)
	bne.s	locret_121452
	addq.b  #1, $80C3ED.l	; 彌補木牛生命值+1
locret_121452:
	movem.l	(sp)+,d2/d3
	rts


sub_1212EC:
	moveq	#0,d3
loc_1212EE:
; 當前操作的道具格[a3]
	moveq	#0,d0
	move.b	-5(a6),d0
	lsl.l	#5,d0
	add.l	-4(a6),d0
	move.l	d3,d1
	lsl.l	#2,d1
	add.l	d1,d0
	addi.l	#$A,d0
	movea.l	d0,a3
; 是否有增目權限[a5]
	move.b	1(a3),d7		; 當前道具格存放的物品
	moveq	#0,d0
	move.b	d7,d0
	add.l	-$C(a6),d0
	movea.l	d0,a5
; 是否援軍令/投擲道具
	cmpi.b	#$17,d7
	bcs.s	loc_121330		; 是否特殊技
	cmpi.b	#$25,d7
	bhi.s	loc_121342		; 是否援軍令/投擲道具
	cmpi.b	#9,2(a3)		; 最高上限
	bcc.s	loc_121342
	move.b	#2,(a3)			; 標記可用
	bra.s	loc_121334
loc_121330:
	move.b	2(a3),d0
	cmp.b	(a5),d0			; 判斷特殊技的上限
	bcc.s	loc_121342
; 增加一個數目
loc_121334:
	addq.b	#1,2(a3)		; 增目
	move.l	a2,-(sp)
	jsr		$129182			; 是否封禁特殊技
	addq.l	#4,sp
; 下一個道具格
loc_121342:
	addq.l	#1,d3			; 下一個
	move.l	$200(a2),a3		; 道具欄信息基址：80CC18(1P例)
	move.b	$6B(a3),d0		; 當前B面開啓的格目
	addq.b	#8,d0			; A,B面總格目
	cmp.b	d3,d0
	bgt.s	loc_1212EE
	rts


aBloodUp:		dc.b	'BLOOD UP 100',0,0


sub_1205D0:	; 薤葉芸香使用效果
	movem.l	a2-a3,-(sp)
	movea.l	$C(sp),a2
; 薤葉芸香|解除異常狀態
	btst	#1,$244(a2)
	bne.s	loc_1205E8
	btst	#0,$244(a2)
	beq.s	loc_120616
loc_1205E8:
	bclr	#0,$244(a2)
	clr.w	$238(a2)
	pea		(1).w
	move.l	$64(a2),-(sp)
	moveq	#0,d0
	move.w	$122(a2),d0
	move.l	d0,-(sp)
	jsr		$10391E			; 計算色盤
	addq.l	#4,sp
	move.l	d0,-(sp)
	jsr		$100AF6			; 變更色盘
	lea		$C(sp),sp
loc_120616:
	bclr	#1,$244(a2)
	movea.l	$DC(a2),a3
	move.l	a3,d0
	beq.s	loc_120640
	clr.w	$234(a2)
	bclr	#6,$244(a2)
	clr.w	$6A(a3)
	move.l	a3,-(sp)
	jsr		$14E464
	addq.l	#4,sp
	clr.l	$DC(a2)
loc_120640:
	clr.l	-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#1,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	jsr		$1541AC
	lea		$10(sp),sp
; 播放音效
	jsr		$12D4B4
	tst.l	d0
	beq.w	loc_1206F4
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_12068A
	subi.b	#$40,($81B4C4).l
loc_12068A:
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.s	loc_1206F4
	jsr		$13A578
	pea		(1).w
	moveq	#0,d0
	move.b	($81B4C4).l,d0
	lsl.l	#2,d0
	ori.l	#$9FCC02,d0
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA			; 寫入音效
	lea		$C(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_1206EE
	move.l	($81B4A8).l,($81B4B0).l
loc_1206EE:
	jsr		$13A58E
loc_1206F4:
; 打印文顯|薤葉芸香
	clr.l	-(sp)
	pea		($1C1F32).l		; 循環上升
	pea		($2F4384).l		; "POISON CLEAR"
	move.w	$24(a2),d0
	ext.l	d0
	subq.l	#4,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#2,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l  #$3A,d0			; 文字居中[1]
	move.l	d0,-(sp)
	jsr		$12D506			; 分配OBJ
	move.l	d0,-(sp)
	jsr		$12D72C			; 打印文字
	lea		$1C(sp),sp
; 勛章|士氣最大
	clr.l	-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#1,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	jsr		$1541AC
	movea.l	$F8(a2),a3
	moveq	#0,d0
	move.b	1(a3),d0
	move.l	d0,d1
	lsl.l	#2,d0
	add.l	d1,d0
	moveq	#0,d1
	move.b	$2EA(a3),d1
	add.l	d1,d0
	movea.l	#$1F26F8,a0 	; 士氣上限表
	move.b	(a0,d0.l),d1
	move.l	d1,-(sp)
	move.l	a3,-(sp)
	jsr		$165E90			; 調整士氣條
	lea		$18(sp),sp
; 打印文顯|勛章
	clr.l	-(sp)
	pea		($1C1F32).l		; 循環上升
	pea		($2F4392).l		; "MAX MORALE"
	move.w	$24(a2),d0
	ext.l	d0
	addq.l	#4,d0			; 高度下移[1]
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#2,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$32,d0
	move.l	d0,-(sp)
	jsr		$12D506			; 分配OBJ
	move.l	d0,-(sp)
	jsr		$12D72C			; 打印文字
	lea		$1C(sp),sp
; 明光魚鱗吞食甲|補充生命值
	cmpi.w	#$565C,$22A(a4)
	bne.w	locret_1205D0
	movea.l	$F8(a2),a3		; 角色基址
	clr.l	-(sp)
	move.w	$24(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#1,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	move.l	d0,-(sp)
	jsr		$1541AC
	lea		$10(sp),sp
	move.l	#$1E,d2			; 生命值補充量
	moveq	#0,d0
	move.w	$6C(a2),d0
	moveq	#0,d1
	move.b	6(a3),d1
	cmp.l	d1,d0
	bne.s	loc_1204B2
	pea		($7D0).w
	jsr		$14DA44
	add.l	d0,$A(a3)
	move.l	a3,-(sp)
	jsr		$14CC4A			; 是否獎命
; 打印文顯|吞食甲
	clr.l	-(sp)
	pea		($1C1F32).l		; 循環上升
	pea		($7D0).w
	move.w	$24(a2),d0
	ext.l	d0
	addi.l  #12,d0			; 高度下移[2]
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#1,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$1A,d0			; 數字居中
	move.l	d0,-(sp)
	jsr		$12DB22			; 打印分數
	lea		$20(sp),sp
	bra.w	locret_1205D0
loc_1204B2:
	moveq	#0,d0
	move.w	$6C(a2),d0
	add.l	d2,d0
	moveq	#0,d1
	move.b	6(a3),d1		; 生命值上限
	cmp.l	d1,d0
	bgt.s	loc_1204D8
	add.w	d2,$6C(a2)		; 增加生命值
	move.w	d2,d0
	move.l	d0,-(sp)
	move.l	a3,-(sp)
	jsr		$14CF6A			; 我方生命條變動
	addq.l	#8,sp
	bra.s	loc_1204F8
loc_1204D8:
	moveq	#0,d0
	move.b	6(a3),d0
	sub.w	$6C(a2),d0
	move.l	d0,-(sp)
	move.l	a3,-(sp)
	jsr		$14CF6A			; 我方生命條變動
	addq.l	#8,sp
	moveq	#0,d0
	move.b	6(a3),d0
	move.w	d0,$6C(a2)
loc_1204F8:
	clr.l	-(sp)
	pea		($1C1F32).l		; 循環上升
	pea		($2F437A).l		; "BLOOD UP"
	move.w	$24(a2),d0
	ext.l	d0
	addi.l  #12,d0			; 高度下移[2]
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	addq.l	#2,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$2A,d0			; 文字居中[2]
	move.l	d0,-(sp)
	jsr		$12D506			; 分配OBJ
	move.l	d0,-(sp)
	jsr		$12D72C			; 打印文字
	lea		$1C(sp),sp
locret_1205D0:
	movem.l	(sp)+,a2-a3
	rts


sub_14CC4A:
	movem.l A2-A3, -(A7)		; 撿取七星燈增加一命
	movea.l $C(A7), A2
	addq.b  #1, ($5,A2)			; 生命數+1
	move.l  A2, -(A7)
	jsr		$14abb8
	addq.l  #4, A7
	jsr     $12d4b4.l
	tst.l   D0
	beq.w   loc_14CC4C
	addq.b  #1, $81b4c4.l
	cmpi.b  #$40, $81b4c4.l
	bcs.s   loc_14CC4A
	subi.b  #$40, $81b4c4.l
loc_14CC4A:
	move.l  $81b4c0.l, D0
	cmp.l   $81b4bc.l, D0
	bge.s   loc_14CC4C
	jsr     $13a578.l
	pea     $1.w
	moveq   #$0, D0
	move.b  $81b4c4.l, D0
	lsl.l   #2, D0
	ori.l   #$ff0400, D0
	move.l  D0, -(A7)
	move.l  $81b4b0.l, -(A7)
	jsr     $100cea.l
	lea     $C(A7), A7
	move.l  $81b4b8.l, D0
	add.l   D0, $81b4b0.l
	addq.l  #1, $81b4c0.l
	move.l  $81b4b0.l, D0
	cmp.l   $81b4b4.l, D0
	bne.s   loc_14CC4B
	move.l  $81b4a8.l, $81b4b0.l
loc_14CC4B:
	jsr     $13a58e.l
loc_14CC4C:
	movea.l ($10,A2), A3
	clr.l   -(A7)
	pea     $1eb380.l
	pea     $2fe34e.l			; "LIFE+1"
	move.w  ($24,A3), D0
	ext.l   D0
	subq.l  #4, D0
	move.l  D0, -(A7)
	move.w  ($22,A3), D0
	ext.l   D0
	addq.l  #2, D0
	move.l  D0, -(A7)
	move.w  ($20,A3), D0
	ext.l   D0
	subi.l  #$30, D0
	move.l  D0, -(A7)
	jsr     $12d506.l
	move.l  D0, -(A7)
	jsr     $12d72c.l
	lea     $1C(A7), A7
	movem.l (A7)+, A2-A3
	rts


sub_124488:
	moveq	#$0, D2
	moveq   #$0, D3
	move.w  #1,(-$10,A6)
	move.l  $200(A3),(-$8,A6)	; 道具欄信息起：80CC18(1P例)
	bra.s	loc_12448A
loc_124488:
	moveq   #$0, D0
	add.l   (-$8,A6), D0
	move.l  D3, D1
	lsl.l   #2, D1
	add.l   D1, D0
	addi.l  #$A, D0
	movea.l D0, A0				; 當前操作的(AB面)道具格
	cmpi.b  #$17, ($1,A0)		; 是否援軍令
	bcs.s   loc_124489
	cmpi.b  #$21, ($1,A0)
	bhi.s   loc_124489
	moveq	#$1, D2				; 標記已有援軍令
	cmpi.b  #$9, ($2,A0)		; 援軍令、投擲道具上限為9
	bcc     loc_124489
	move.b  #2,	(A0)
	addq.b  #1, ($2,A0)
	clr.w	(-$10,A6)			; $1245EA原代碼
loc_124489:
	addq.l  #1, D3
loc_12448A:
	move.l  ($200,A3), A0		; 道具欄信息起：80CC18(1P例)
	move.b	($6b,A0), D0		; 當前B面開啓的格目
	addq.b	#$8, D0				; 循環判斷的總格目
	cmp.b   D3, D0
	bgt.s   loc_124488
locret_124488:
	rts


sub_11CA18:
	move.w  D2, D0
	lsl.w   #2, D0
	movea.l #unk_11CA18, A0
	move.l  (A0,D0.w), ($2c,A2)	; 5個金珠動作
	clr.w   ($3c,A2)			; 原代碼
	clr.w   ($54,A2)
	clr.w   ($68,A2)
	rts

unk_11CA18:
	dc.l	$1C1F5E,$1C1F5E,$1C1F72,$1C1F8A,$1C1FA2


off_1C20E2:
	dc.l	$000106FD,$000206FF,$00030600,$00040600,$00050601,$00000602
	dc.l	$00010603,$00020604,$00030606,$00040607,$00050609	; $0B
	dc.l	$F01B1100,$0000060C,$0001060C,$0002060C,$0003060C
	dc.l	$F0010B00	; $11
	dc.l	$F0070023,$0011EBA8,$F0070023,$0011EAB8
	dc.l	$F00E0100
	dc.l	$000106FA,$000206FA,$000306FC,$000406FD
	dc.l	$000506FE,$000006FF,$00010600,$00020600,$00030602,$00040603	; $20
	dc.l	$F01B2800,$00000606,$00010606,$00020606,$00030606,$00040606,$00050606
	dc.l	$F0012000	; $28
	dc.l	$F0070023,$0011EBA8,$F0070023,$0011EAB8
	dc.l	$000206FA,$000306FA,$000406FC,$000506FD,$000006FE,$000106FF
	dc.l	$00020600,$00040602,$00030600,$00050603	; $36
	dc.l	$F01B3E00,$00000606,$00010606,$00020606,$00030606,$00040606,$00050606
	dc.l	$F0013600	; $3E
	dc.l	$F0070023,$0011EBA8,$F0070023,$0011EAB8
	dc.l	$000206FA,$000306FA,$000406FC,$000506FD,$000006FE,$000106FF
	dc.l	$00020600,$00040602,$00030600,$00050603	; $4C
	dc.l	$F01B5400,$00000606,$00010606,$00020606,$00030606,$00040606,$00050606
	dc.l	$F0014C00	; $54
	dc.l	$F0070023,$0011EBA8,$F0070023,$0011EAB8
	dc.l	$000206FA,$000306FA,$000406FC,$000506FD,$000006FE,$000106FF
	dc.l	$00020600,$00040602,$00030600,$00050603	; $62
	dc.l	$F01B6A00,$00000606,$00010606,$00020606,$00030606,$00040606,$00050606
	dc.l	$F0016200	; $6A
	dc.l	$F0070023,$0011EBA8,$F0070023,$0011EAB8
	dc.l	$F0280200,$00000000,$40000000,$F0290000
	dc.l	$80000000

off_1E22B4:
	dc.l	unk_1E2278,$001EC144,$001CA3E2,$002A10DA	; 001EC144|坐標偏移
	dc.l	$0031B554,$006102E1,$0E0D0420,$00000000	; 火球圖
	dc.l	$03E81000,$00000000,$00000000,$00000000
	dc.l	$40000000,$00000000,$00000000,$00000602
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000

unk_1E2278:	; 投火球車之火球圖
	dc.l	$F00B9F00
	dc.l	$02CD0000,$00370000,$20380000,$00390000
	dc.l	$203A0000,$003B0000,$203C0000,$203D0000
	dc.l	$003E0000,$003F0000,$00400000,$00410000,$00420000
	dc.l	$80000000

sub_1392BA:	; 燃燒彈可以炸開鐵盒
	movea.l	$74(a1),a2		; 擊打鐵盒的對象OBJ
	tst.w	$88(a1)			; 是否道具攻擊
	beq.s	loc_1392C4
	movea.l	$10(a2),a0
	cmpi.w	#$0602,$3E(a0)	; 是否燃燒彈[0602]
	bne.s	loc_1392E8
	movea.l #$1392EC,a0		; 擊打有效
	rts
loc_1392C4:
	movea.l #$1392C4,a0		; 判斷其他
	rts
loc_1392E8:
	movea.l #$1392E8,a0		; 擊打無效
	rts


off_1C240A:
	dc.l	$00000AFB,$00000AFD,$00010AFF,$00010A00,$00020A03,$00020A05
	dc.l	$F01B0E00,$00030608,$00030608,$00040608,$00040608,$00050608,$00050608
	dc.l	$F0010600
	dc.l	$F0070024,$0011EBA8
	dc.l	$F0070024,$0011EAB8
	dc.l	$00000500,$00000500,$00010500,$00010500,$00020500
	dc.l	$F0070024,$0011EAB8
	dc.l	$00000500,$00000500,$00010500,$00010500,$00020500
	dc.l	$F0070024,$0011EAB8
	dc.l	$00000500,$00000500,$00010500,$00010500,$00020500
	dc.l	$F0070024,$0011EAB8
	dc.l	$00020500,$00030500,$00040500,$00040500,$00040500
	dc.l	$F0070024,$0011EAB8,$00050500,$00050500
	dc.l	$F0280600,$00000000,$40000000
	dc.l	$F0290000
	dc.l	$80000000


sub_129CA5:	; 青龍神器|補充一目
	movem.l	a2-a3/d2-d3,-(sp)
	movea.l	$14(sp),a2		; 角色OBJ
	movea.l	$F8(a2),a0		; 角色基址
	moveq	#0,d2
	move.b	$2EA(a0),d2		; 當前等級階
	move.l	d2,d0
	lsl.l	#3,d2
	sub.l	d0,d2
	lsl.l	#2,d2
	sub.l	d0,d2
	lsl.l	#2,d2
	sub.l	d0,d2
	moveq	#0,d0
	movea.l	$58(a2),a0		; 角色指針
	move.b	1(a0),d0		; 角色編號
	lsl.l	#2,d0
	movea.l	#$2ABCB8,a0		; 各道具上限指針總表
	add.l	(a0,d0.l),d2	; 當前角色道具上限表
	move.l	$200(a2),a3		; 道具欄基址|1P例$80CC18
	moveq	#8,d3			; A面開啓格目[00-07]
	add.b	$6B(a3),d3		; B面開啓格目
	bra.s	loc_129CA7
loc_129CA5:
	movea.l	a3,a0
	move.l	d3,d0
	lsl.l	#2,d0
	adda.l	d0,a0
	adda.l	#$A,a0			; 當前操作的道具格
	moveq	#0,d0
	move.b	1(a0),d0		; 當前道具格物品
	cmpi.b	#$17,d0			; 補充超必殺技、策略、魔法
	bcc.s	loc_129CA7
	move.l	d0,d1
	add.l	d2,d1
	movea.l	d1,a1			; 計算道具上限值
	move.b	2(a0),d0
	cmp.b	(a1),d0			; 對比
	bcc.s	loc_129CA7
loc_129CA6:
	addq.b	#1,2(a0)		; 增加數目
	move.l	a2,-(sp)
	jsr		($129182).l		; 是否封禁特殊技
	addq.l	#4,sp
loc_129CA7:
	dbra	d3,loc_129CA5	; 是否倒序至零
	movem.l	(sp)+,a2-a3/d2-d3
	rts

sub_129CA4:	; 青龍神器
	link	a6,#0
	clr.l	-(sp)
	move.l	8(a6),-(sp)
	bsr.w	sub_129A18	; 神器施放
	move.l	8(a6),-(sp)	; 角色OBJ
	bsr.w	sub_129CA5	; 補充超殺
	unlk	a6
	rts

sub_129CB6:	; 玄武神器
	link	a6,#0
	pea		(1).w
	move.l	8(a6),-(sp)
	bsr.w	sub_129A18	; 神器施放
	unlk	a6
	rts

sub_129CCA:	; 朱雀神器
	link	a6,#0
	pea		(2).w
	move.l	8(a6),-(sp)
	bsr.w	sub_129A18	; 神器施放
	unlk	a6
	rts

sub_129D82:	; 白虎神器
	link	a6,#0
	pea		(3).w
	move.l	8(a6),-(sp)
	bsr.w	sub_129A18	; 神器施放
	unlk	a6
	rts

sub_129A18:	; 神器施放
	link	a6,#0
	movem.l	d2-d3/a2,-(sp)
	move.l	$C(a6),d3				; 神器編號
; 神器計時
	moveq	#0,d0
	move.b	d3,d0
	move.l	d0,-(sp)
	jsr		$161FCC					; 神器圖騰
	addq.l	#4,sp
	move.b	#$32,(byte_810A7E).l	; 倒計數字個位數圖片'2'
	move.b	#$35,(byte_810A7E+1).l	; 倒計數字十位數圖片'5'
	tst.b	(byte_810A22).l			; 計時圖顯標記
	bne.s	loc_129A94
	jsr		$12D506					; 分配OBJ序號
	move.l	d0,d2
	cmpi.l	#$FF,d2					; 是否超限
	beq.s	loc_129A8C
	clr.l	-(sp)
	pea		(off_1E6430).l			; 刷新計時圖顯
	pea		(a25_1).l				; "25"
	clr.l	-(sp)
	pea		($64).w
	pea		($28).w
	move.l	d2,-(sp)
	jsr		$12D72C					; 打印計時貼圖
	lea		$1C(sp),sp
loc_129A8C:
	move.b	#1,(byte_810A22).l		; 標記計時圖顯
loc_129A94:
	moveq	#0,d0
	move.b	d3,d0
	movea.l	#byte_810A1E,a0			; 神器計時
	move.b	#25,(a0,d0.l)			; 25秒
	moveq	#0,d0
	move.b	d3,d0
	movea.l	#byte_810A06,a0			; 神器標記
	move.b	#1,(a0,d0.l)
; 旋轉神器
	clr.l	-(sp)
	pea		($FF1A).w
	pea		($15E).w
	pea		($54).w
	pea		(off_1E64D8).l			; 神器旋轉機關
	jsr		$1517D4					; 佈置場景機關
	lea		$14(sp),sp
	movea.l	d0,a2
	moveq	#0,d0
	move.b	d3,d0
	add.w	d0,d0
	movea.l	#word_1E4C10,a0			; 神器圖片編號
	move.w	(a0,d0.w),$3E(a2)
	moveq	#0,d0
	move.b	d3,d0
	movea.l	#byte_1E4C18,a0			; 神器色表編號
	move.b	(a0,d0.l),d0
	andi.l	#$FF,d0
	move.w	d0,$50(a2)
	move.w	d0,$8A(a2)
	clr.w	$C0(a2)
	clr.w	$C2(a2)
	tst.l	(dword_810A1A).l		; 當前旋轉神器OBJ
	beq.s	loc_129B46
	movea.l	dword_810A1A.l,a0		; 當前旋轉神器OBJ
	move.w	$3C(a0),d0
	addi.w	#9,d0
	move.w	d0,$3C(a2)
	cmpi.w	#$26,$3C(a2)
	bcs.s	loc_129B46
	subi.w	#$26,$3C(a2)
loc_129B46:
	cmpi.w	#$26,$3C(a2)
	bls.s	loc_129B52
	clr.w	$3C(a2)
loc_129B52:
	move.l	a2,(dword_810A1A).l		; 當前旋轉神器OBJ
	moveq	#0,d0
	move.b	d3,d0
	lsl.w	#2,d0
	movea.l	#dword_810A0A,a0		; 四神器旋轉OBJ表格
	move.l	a2,(a0,d0.w)
	move.w	$3C(a2),d0
	add.w	d0,d0
	movea.l	#word_1E4C1C,a0			; 神器相對坐標表|X
	move.w	(a0,d0.w),d0
	add.w	d0,$20(a2)
	move.w	$3C(a2),d0
	add.w	d0,d0
	movea.l	#(word_1E4C1C+$4E),a0	; 神器相對坐標表|Y
	move.w	(a0,d0.w),d0
	add.w	d0,$22(a2)
; 神器文顯
	bsr.w	sub_129702				; 四神器文字顯示
; 施放台詞
	movea.l	8(a6),a0
	move.w	$F6(a0),d2				; 角色編號
	andi.l	#$FFFF,d2
	move.w	d2,d0
	lsl.w	#3,d0
	moveq	#0,d1
	move.b	d3,d1
	add.w	d1,d1
	add.w	d1,d0
	movea.l	#word_1E4CB8,a0			; 施放神器的台詞音頻表
	cmpi.w	#$29F,(a0,d0.w)
	beq.s	loc_129BD2
	jsr		$12D4B4
	tst.l	d0
	beq.w	loc_129C9A
loc_129BD2:
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_129BEA
	subi.b	#$40,($81B4C4).l
loc_129BEA:
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.w	loc_129C9A
	jsr		$13A578
	pea		(1).w
	move.w	d2,d0
	lsl.w	#3,d0
	moveq	#0,d1
	move.b	d3,d1
	add.w	d1,d1
	add.w	d1,d0
	movea.l	#word_1E4CB8,a0			; 施放神器的台詞音頻表
	move.w	(a0,d0.w),d0
	andi.l	#$FFFF,d0
	asr.l	#8,d0
	andi.l	#3,d0
	move.l	d0,-(sp)
	move.w	d2,d0
	lsl.w	#3,d0
	moveq	#0,d1
	move.b	d3,d1
	add.w	d1,d1
	add.w	d1,d0
	movea.l	#word_1E4CB8,a0			; 施放神器的台詞音頻表
	move.w	(a0,d0.w),d0
	andi.l	#$FFFF,d0
	lsl.l	#8,d0
	moveq	#0,d1
	move.b	($81B4C4).l,d1
	lsl.l	#2,d1
	or.l	d1,d0
	or.l	(sp)+,d0
	ori.l	#$9F0000,d0				; 音頻音量
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_129C94
	move.l	($81B4A8).l,($81B4B0).l
loc_129C94:
	jsr		$13A58E
; 敵人時停
loc_129C9A:
	jsr		$10B08C			; 第一敵方
	bra.s	loc_12364E
loc_1235FA:
	move.w	#180,$258(a2)	; 定停3秒
	move.l	a2,-(sp)
	jsr		$10F564
	move.l	a2,-(sp)
	jsr		$10B0AC			; 下一敵方
	addq.l	#8,sp
loc_12364E:
	movea.l	d0,a2
	move.l	a2,d0
	bne.s	loc_1235FA
	pea		($B4).w			; 陰暗3秒
	jsr		($124C1E).l
	addq.l	#4,sp
	movem.l	-$C(a6),d2-d3/a2
	unlk	a6
	rts

off_1E6430:	; 刷新計時圖顯
	dc.l	dword_1E4BE8,$03070280,0

dword_1E4BE8:	; 刷新圖片
	dc.l	$F0020600,$00000000
	dc.l	$F0121F00,$00000000
	dc.l	$F012FF00
	dc.l	$F0020500,$00000000
	dc.l	$F0070000,sub_129858
	dc.l	$80000000

sub_129858:	; 神器倒計數字圖片切換
	link	a6,#-4
	movem.l	d2/a2,-(sp)
; 四神器倒計數
	moveq	#0,d2
loc_129920:
	movea.l	#byte_810A06,a0		; 神器標記
	tst.b	(a0,d2.l)
	beq.s	loc_129960
	movea.l	#byte_810A1E,a0		; 神器計時
	subq.b	#1,(a0,d2.l)
	movea.l	#byte_810A1E,a0		; 神器計時
	tst.b	(a0,d2.l)
	bne.s	loc_129960
; 四神器倒計數|關閉神器
	move.b	d2,d0
	ext.w	d0
	movea.l	#byte_810A06,a0		; 當前使用神器按序標記
	clr.b	(a0,d0.w)
	bsr.w	sub_129702			; 四神器文字顯示
	move.b	d2,d0
	ext.w	d0
	ext.l	d0
	move.l	d0,-(sp)
	jsr		$161FCC				; 神器圖騰
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#dword_810A0A,a0	; 四神器旋轉OBJ表格
	move.l	(a0,d0.w),-(sp)
	jsr		$151A3A				; 清除機關
	addq.l	#8,sp
loc_129960:
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_129920
; 清除神器文顯OBJ
	move.l	#byte_810A1E,d0		; 神器計時
	bne.s	loc_12998E
	clr.l	(dword_810A1A).l	; 當前旋轉神器OBJ
	moveq	#0,d2
loc_129978:
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#dword_810A24,a0	; 四神器文顯OBJ表格
	clr.l	(a0,d0.w)
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_129978
; 刷新計時圖顯
loc_12998E:
	subq.b	#1,(byte_810A7E+1).l		; 倒計時數字圖片切換下一張
	cmpi.b	#$30,(byte_810A7E+1).l		; 倒計數字十位數圖是否為'0'
	bcc.s	loc_1299BE
	cmpi.b	#$30,(byte_810A7E).l		; 倒計數字個位數圖是否為'0'
	bne.s	loc_1299B0
	clr.b	(byte_810A22).l		; 計時圖顯標記
	bra.s	loc_129A0E
loc_1299B0:
	subq.b	#1,(byte_810A7E).l			; 倒計數字個位數圖片
	move.b	#$39,(byte_810A7E+1).l		; '9'|倒計數字十位數圖片
loc_1299BE:
	move.b	(byte_810A7E).l,-4(a6)		; 倒計數字個位數圖片
	move.b	(byte_810A7E+1).l,-3(a6)	; 倒計數字十位數圖片
	clr.b	-2(a6)
	jsr		$12D506				; 分配OBJ序號
	move.l	d0,d2
	cmpi.l	#$FF,d2
	beq.s	loc_129A0E
	clr.l	-(sp)
	pea		(off_1E6430).l		; 循環刷新圖顯
	pea		-4(a6)
	clr.l	-(sp)
	pea		($64).w
	pea		($28).w
	move.l	d2,-(sp)
	jsr		$12D72C				; 打印計時貼圖
loc_129A0E:
	movem.l	-$C(a6),d2/a2
	unlk	a6
	rts

a25_1:	; 數字
	dc.b	'25',0,0

off_1E64D8:	; 神器旋轉機關
	dc.l	dword_1E643C,$001C5BF4,$00000000,$00000000
	dc.l	$0031AF3A,$005DFEF4,$02020428,$00000000
	dc.l	$00000A00,$00000000,$00000000,$00000000
	dc.l	$80000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$00000000,$00000000,$00000000,0

dword_1E643C:	; 神器旋轉動作
	dc.l	$F0121F00,$00000002
	dc.l	$F012FF00,$0000FF03,$0000FF02,$0000FF02,$0000FE02
	dc.l	$0000FE01,$0000FE01,$0000FD01,$0000FE00
	dc.l	$0000FE00,$0000FDFF,$0000FEFF,$0000FEFF
	dc.l	$0000FEFE,$0000FFFE,$0000FFFE,$0000FFFD
	dc.l	$000000FE,$000000FE,$000001FD,$000001FE
	dc.l	$000001FE,$000002FE,$000002FF,$000002FF
	dc.l	$000003FF,$00000200,$00000200,$00000301
	dc.l	$00000201,$00000201,$00000202,$00000102
	dc.l	$00000102,$00000103,$00000002
	dc.l	$F0010000

word_1E4C10:	; 四神器圖片編號
	dc.w	$0046,$0049,$0048,$0047

byte_1E4C18:	; 四神器色表編號
	dc.b	$06,$08,$07,$08

word_1E4C1C:	; 神器相對坐標
	dc.w	$0000,$0000,$0000,$FFFF,$FFFE,$FFFD,$FFFB,$FFF9	; 0
	dc.w	$FFF7,$FFF4,$FFF2,$FFF0,$FFED,$FFEB,$FFE9,$FFE7	; 8
	dc.w	$FFE6,$FFE5,$FFE4,$FFE4,$FFE4,$FFE5,$FFE6,$FFE7	; $10
	dc.w	$FFE9,$FFEB,$FFED,$FFF0,$FFF2,$FFF4,$FFF7,$FFF9	; $18
	dc.w	$FFFB,$FFFD,$FFFE,$FFFF,$0000,$0000,$0000	; $20
	dc.w	$0000,$0002,$0000,$0005,$0007,$0009,$000B,$000C	; 0
	dc.w	$000D,$000E,$000E,$000E,$000D,$000C,$000B,$0009	; 8
	dc.w	$0007,$0005,$0002,$0000,$FFFE,$FFFB,$FFF9,$FFF7	; $10
	dc.w	$FFF5,$FFF4,$FFF3,$FFF2,$FFF2,$FFF2,$FFF3,$FFF4	; $18
	dc.w	$FFF5,$FFF7,$FFF9,$FFFB,$FFFE,$0000,$0000	; $20

sub_129702:	; 四神器文字顯示
	movem.l	d2-d4/a2,-(sp)
; 清除文顯
	moveq	#0,d2
loc_129708:
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#dword_810A24,a0	; 四神器文顯OBJ表格
	tst.l	(a0,d0.w)
	beq.s	loc_12973C
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#dword_810A24,a0	; 四神器文顯OBJ表格
	move.l	(a0,d0.w),-(sp)
	jsr		$12D576				; 清除上升文字
	addq.l	#4,sp
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#dword_810A24,a0	; 四神器文顯OBJ表格
	clr.l	(a0,d0.w)
loc_12973C:
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_129708
; 打印文顯
	moveq	#$7D,d3
	moveq	#0,d2
loc_129748:
	movea.l	#byte_810A06,a0		; 神器標記
	tst.b	(a0,d2.l)
	beq.s	loc_1297B0
	jsr		$12D506				; 分配OBJ序號
	move.l	d0,d4
	move.l	d4,-(sp)
	jsr		sub_137E22			; 計算OBJ地址
	addq.l	#4,sp
	move.w	d2,d1
	lsl.w	#2,d1
	movea.l	#dword_810A24,a0	; 四神器文顯OBJ表格
	move.l	d0,(a0,d1.w)
	cmpi.l	#$FF,d2
	beq.s	loc_1297AC
	move.w	d2,d0
	lsl.w	#2,d0
	movea.l	#off_31C95E,a0		; 四神器效果文字
	movea.l	(a0,d0.w),a2
	clr.l	-(sp)
	pea		(off_1E6600).l		; 四神器文顯效果
	move.l	a2,-(sp)
	clr.l	-(sp)
	move.w	d3,d0
	ext.l	d0
	move.l	d0,-(sp)
	pea		($1E).w
	move.l	d4,-(sp)
	jsr		$12D72C				; 打印文顯貼圖
	lea		$1C(sp),sp
loc_1297AC:
	addi.w	#$C,d3
loc_1297B0:
	addq.l	#1,d2
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_129748
	movem.l	(sp)+,d2-d4/a2
	rts

sub_137E22:	; 計算文顯OBJ地址
	move.l	d2,-(sp)
	move.l	8(sp),d2
	cmpi.l	#$FF,d2
	bne.s	loc_137E34
	moveq	#0,d0
	bra.s	loc_137E4A
loc_137E34:
	move.l	d2,d0
	move.l	d0,d1
	lsl.l	#4,d0
	sub.l	d1,d0
	move.l	d0,d1
	lsl.l	#3,d0
	sub.l	d1,d0
	lsl.l	#2,d0
	addi.l	#($816346).l,d0
loc_137E4A:
	move.l	(sp)+,d2
	rts

off_31C95E:	; 四神器效果文字
	dc.l	aSkillMax,aSkillMax+$A,aSkillMax+$14,aSkillMax+$1E
aSkillMax:
	dc.b	'SKILL MAX',0,'SPEED DN',0,0,'FOOD MAX',0,0,'POWER UP',0,0

off_1E6600:	; 四神器文顯效果
	dc.l	dword_1E65EC,$00040080,0
dword_1E65EC:	; 四神器文顯動作
	dc.l	$F0020F00,$00000000
	dc.l	$F0020F00,$40000000
	dc.l	$F0010000

word_1E4CB8:	; 神器施放台詞音頻表
	dc.w	$01BF,$01C0,$01C1,$01C3	; 0
	dc.w	$01D2,$01D3,$01D4,$01D6	; 4
	dc.w	$01E0,$01E2,$01E3,$01E5	; 8
	dc.w	$01ED,$01EF,$01F0,$01F2	; $C
	dc.w	$01FA,$01FD,$01FE,$01FF	; $10
	dc.w	$0204,$0209,$020A,$020C	; $14
	dc.w	$0219,$021C,$021D,$021F	; $18
	dcb.w	4,0	; $1C
	dc.w	$022A,$0230,$0231,$0233	; $20
	dc.w	$023E,$0240,$0241,$0243	; $24


sub_11D24E:
; 神器冷卻
	cmpi.b	#$43,d2
	bne.s	loc_12621E
	tst.b	(byte_810A06).l		; 青龍神器標記寄存
	bra.s	loc_12624E
loc_12621E:
	cmpi.b	#$44,d2
	bne.s	loc_12622C
	tst.b	(byte_810A06+3).l	; 白虎神器標記寄存
	bra.s	loc_12624E
loc_12622C:
	cmpi.b	#$45,d2
	bne.s	loc_12623A
	tst.b	(byte_810A06+2).l	; 朱雀神器標記寄存
	bra.s	loc_12624E
loc_12623A:
	cmpi.b	#$46,d2
	bne.s	loc_126248
	tst.b	(byte_810A06+1).l	; 玄武神器標記寄存
	bra.s	loc_12624E
loc_126248:
; 魔法冷卻
	tst.w	($80D03A).l			; 魔法是否冷卻狀態
	beq.s	loc_11D28E
	moveq	#6,d0
	cmp.l	d2,d0
	bgt.s	loc_11D28E
	moveq	#$13,d0
	cmp.l	d2,d0
	blt.s	loc_11D28E
loc_11D262:	; 無法施放
	movea.l	#($11D262).l,a0
	rts
loc_12624E:
	bne.s	loc_11D262
loc_11D28E:	; 可以施放
	movea.l	#($11D28E).l,a0
	rts


sub_11D2FC:	; 使用策略魔法不減目
	moveq	#$17,d0			; 是否超殺[01-16]
	cmp.l	d2,d0
	ble.s	loc_11D2FC
	tst.b	(byte_810A06).l	; 青龍神器開關
	bne.s	locret_11D2FC	; 無需減目
loc_11D2FC:
	move.l	a2,-(sp)
	jsr		$1267DC
	addq.l	#4,sp
locret_11D2FC:
	rts

sub_126B42:	; 使用超必殺技不減目
	tst.b	(byte_810A06).l	; 青龍神器開關
	bne.s	locret_126B42
	move.l	a2,-(sp)
	jsr		$1267DC			; 消耗超必殺技
	addq.l	#4,sp
locret_126B42:
	rts


sub_12F82C:	; 擊殺敵兵掉落隨機道具|朱雀神器
	tst.w	$1C6(a2)
	bne.s	loc_12F836
	tst.b	(byte_810A06+2).l	; 朱雀神器開關
	bne.s	loc_12F82C
	moveq	#0,d0			; 原代碼
	movea.l	#$12F886,a0
	bra.s	locret_12F82C
; 隨機掉落
loc_12F82C:
	pea		(30).w
	jsr		($102480).l		; 大隨機
	addq.l	#4,sp
	movea.l	#byte_12F82C,a1
	move.b	(a1,d0.l),d0
	move.w	d0,$1C6(a2)
loc_12F836:
	movea.l	#$12F836,a0
locret_12F82C:
	rts

byte_12F82C:	; 敵兵隨機掉落表 | 30
	dc.b	$02,$03,$04,$05	; 超殺補充 [4|13.3%]
	dc.b	$82,$83,$84,$86,$3E	; 一般補給 [5|16.6%]
	dc.b	$11,$12,$13,$14, $11,$12,$13,$14, $11,$12,$13,$14	; 投擲道具重三 [12|40%]
	dc.b	$8E,$8F,$91,$88,$89,$8A,$8B,$8C,$8D	; 金銀珍寶 [3+6|30%]


sub_12EDE8:	; 撞擊敵人掉落隨機物品|朱雀神器
	jsr		$12571C.l		; 敵將是否在場
	tst.l   d0
	beq.s	loc_12EDE8
	tst.b	(byte_810A06+2).l	; 朱雀神器開關
	bne.s	loc_12EDE9
; 原代碼
loc_12EDE8:
	move.l	a2,-(sp)
	jsr		($12ECBC).l		; 是否分配了撞物表
	addq.l	#4,sp
	movea.l	#$12EDF0,a0
	bra.s	locret_12EDE8
; 隨機撞物
loc_12EDE9:
	pea		(40).w
	jsr		($102480).l		; 大隨機
	addq.l	#4,sp
	movea.l	$58(a2),a0		; 敵人指針
	cmpi.b	#2,(a0)
	beq.s	loc_12EDEA
	movea.l	#byte_12EDE8,a0	; [1]敵將表
	bra.s	loc_12EDEB
loc_12EDEA:
	movea.l	#byte_12EDE9,a0	; [2]敵兵表
loc_12EDEB:
	move.b	(a0,d0.l),d2
	movea.l	#$12EE16,a0
locret_12EDE8:
	rts

byte_12EDE8:	; 敵將隨機掉落表 | 40
	dc.b	$3F, $32,$33,$34,$35	; 七星燈、四神器 [5|12.5%]
	dc.b	$3C,$41, $3C,$41, $3C,$41, $3C,$41, $3C,$41	; 攜帶補給重五 [10|25%]
	dc.b	$81,$85,$87,$93, $81,$85,$87,$93, $81,$85,$87,$93, $81,$85,$87,$93, $81,$85,$87,$93	;  加強補給重五 [20|0.5%]
	dcb.b	5,0	; 無效撞擊 * 5

byte_12EDE9:	; 敵兵隨機掉落表 | 40
	dc.b	$43,$44,$45,$46,$47,$48,$49, $4A,$4B,$4C,$4D,$4E,$4F	; 全部防具 [13|32.5%]
	dc.b	$02,$03,$04,$05, $02,$03,$04,$05, $02,$03,$04,$05	; 超殺補充重三 [12|30%]
	dc.b	$82,$83,$84,$86,$3E, $82,$83,$84,$86,$3E, $82,$83,$84,$86,$3E	; 一般補給重三 [15|37.5%]


sub_10EFDA:	; 敵人延時刷新動作
	moveq	#0,d0
	move.b	8(a3),d0
	lsr.l	#4,d0
	andi.w	#$F,d0
	tst.b	(byte_810A06+1).l	; 玄武神器開關
	beq.s	locret_10EFDA
	addq.w	#2,d0				; 動作刷新降低2倍速率
locret_10EFDA:
	rts

sub_15ED28:	; 玄武神器|最強防御
; 玄武神器
	tst.b	(byte_810A06+1).l	
	beq.s	loc_15ED28
	moveq	#1,d0			; 抑傷為一
	bra.s	locret_15ED28
; 靈甲護主
loc_15ED28:
	cmpi.w	#$555E,$22A(a2)
	bne.s	loc_14D9F4
	movea.l	#(ram_0029),a0	; 受擊寄存
	move.w	$E(a2),d0		; 角色位號
	cmpi.b	#15,(a0,d0.w)	; 受擊次數
	bcc.s	loc_14D9F4
	moveq	#0,d0			; 免疫傷害
	bra.s	locret_15ED28
; 原代碼
loc_14D9F4:
	move.l	d2,-(sp)
	jsr		($14D9F4).l		; 難度疊加傷害
	addq.l	#4,sp
locret_15ED28:
	rts

sub_114228:	; 四招一式[1]
	tst.b	(byte_810A06+1).l	; 玄武神器開關
	bne.s	locret_114228
	cmpi.w	#6,$50(a4)			; 是否06類動作
	bne.s	loc_114228
	movea.l	$58(a4),a0			; 角色指針
	move.b	1(a0),d0			; 角色編號
	ext.w	d0
	movea.l	#byte_114228,a1		; 破招表格
	move.b	(a1,d0.w),d0
	cmp.w	$52(a4),d0			; 判斷編號
	beq.s	locret_114228
loc_114228:
	move.w	#1,$174(a3)			; 原代碼|第五式無敵保護
locret_114228:
	rts

sub_11B520:	; 四招一式[2]
	tst.b	(byte_810A06+1).l	; 玄武神器開關
	bne.s	locret_11B520
	cmpi.w	#6,$50(a3)			; 是否06類動作
	bne.s	loc_11B520
	movea.l	$58(a3),a0			; 角色指針
	move.b	1(a0),d0			; 角色編號
	ext.w	d0
	movea.l	#byte_114228,a1		; 破招表格
	move.b	(a1,d0.w),d0
	cmp.w	$52(a3),d0			; 判斷編號
	beq.s	locret_11B520
loc_11B520:
	move.w	#1,$174(a2)			; 原代碼|第五式無敵保護
locret_11B520:
	rts

byte_114228:	; 各角色新增[破招]超必殺技表
	dc.b	$23,$FF,$26,$26,$23,$FF,$FF,0,$FF,$26


sub_15F1E2:	; 取消高Hits減傷
; 原代碼
	move.w	$1A0(a2),d1	; Hits 累計
	asr.l	#3,d1		; 每 8 Hits 一階
; 玄武神器
	tst.b	(byte_810A06+1).l
	beq.s	locret_15F1E2
	asr.l	#2,d1		; 每 32 Hits 一階
locret_15F1E2:
	rts


sub_1E6146:	; 防具防禦屬性計算
	movem.l	a2/a3,-(sp)
	movea.l	$C(sp),a2
	movea.l	#(ram_001D),a3	; 防禦屬性
	move.w	$E(a2),d0		; 角色位號
	ext.l	d0
	lsl.l	#2,d0
	adda.l	d0,a3
	clr.l	(a3)			; 初始化
; 計算防禦屬性
	moveq	#0,d0
	move.b	$22A(a2),d0     ; 寶甲
	lsl.l	#2,d0
	movea.l	#$1E5FF6,a0		; 防具屬性表基址
	adda.l	d0,a0			; 寶甲不防禦值
	moveq	#0,d0
	move.b	$22B(a2),d0     ; 寶衣
	lsl.l	#2,d0
	movea.l	#$1E5FF6,a1		; 防具屬性表基址
	adda.l	d0,a1			; 寶衣不防禦值
; 計算防禦值|單甲
	tst.b	$22A(a2)
	beq.s	loc_1E6146
	tst.b	$22B(a2)
	bne.s	loc_1E6147		; 是否叠甲
loc_1E6146:
	move.b	(a0),d0
	or.b	(a1),d0			; 實際不防禦值
	move.b	d0,(a3)			; 寄存
	bra.s	loc_1E6148
; 計算防禦值|疊甲
loc_1E6147:
	moveq	#$40,d0
	sub.b	(a0),d0			; 寶甲防禦值
	moveq	#$40,d1
	sub.b	(a1),d1			; 寶衣防禦值
	add.l	d0,d1			; 防禦值和
	moveq	#$D,d0			; 79.6875%≈80%
	jsr		$1BEBE0.l		; d0*d1,d0
	asr.l	#4,d0			; 實際防禦值
	moveq	#$40,d1
	sub.l	d0,d1			; 實際不防禦值
	move.b	d1,(a3)			; 寄存
loc_1E6148:
; 計算屬性免疫
	move.b	1(a0),d0
	or.b	1(a1),d0		; 實際屬性免疫
	move.b	d0,1(a3)		; 寄存
; 計算防盜設定
	move.b	2(a0),d0
	or.b	2(a1),d0		; 實際防盜設定
	move.b	d0,2(a3)		; 寄存
	movem.l	(sp)+,a2/a3
	rts


sub_12654C:	; 分位裝備寶甲寶衣
	move.l	d2,d5
	addi.b	#-$53,d5	; 01-07 08-0D
	lsr.b	#3,d5		; 00|寶甲類 01|寶衣類
	lea		$22A(a3),a0	; 角色OBJ的防具寄存
	move.b	d2,(a0,d5.l)	; 分位裝備
	move.l	a3,-(sp)
	bsr.w	(sub_1E6146).l	; 更新防禦
	addq.l	#4,sp
	moveq	#0,d6		; 從第一格開始
loc_12654C:
	moveq	#0,d0
	move.b	d4,d0
	lsl.l	#5,d0
	add.l	a4,d0
	move.l	d6,d1		; 格目偏移量
	lsl.l	#2,d1
	add.l	d1,d0
	addi.l	#$A,d0
	movea.l	d0,a2		; 道具位地址
	addq.l	#1,d6
	move.b	1(a2),d0	; 當前防具
	beq.s	loc_126596
	addi.b	#-$53,d0
	lsr.b	#3,d0		; 防具分類
	eor.b	d5,d0
	bne.s	loc_12654C	; 0|同類 1|不同
; 掉回替換防具
	moveq	#0,d0
	move.b	1(a2),d0
	addi.w	#-$11,d0
	move.w	d0,$158(a3)	; 寫入掉回道具
	clr.w	$15A(a3)	; 置零掉回數目
; 替換當前防具
	move.b	#2,(a2)
	move.b	d2,1(a2)
	move.b	d3,2(a2)
	move.l	d2,-(sp)
	move.l	a3,-(sp)
	jsr		$128F5A		; 打印防禦值
	addq.l	#8,sp
	moveq	#0,d0		; 掉回
	movea.l	#$12666A,a0
	bra.s	locret_12654C
loc_126596:	; 新增防具
	movea.l	#$126596,a0
locret_12654C:
	rts


sub_126D8A:	; 分位清除寶甲寶衣
	move.w	#$6C,$1CA(a3)	; 原代碼
	move.b	1(a5),d0
	addi.b	#-$53,d0		; 01-07 08-0D
	lsr.b	#3,d0			; 00|寶甲類 01|寶衣類
	lea		$22A(a3),a0		; 角色OBJ的防具寄存
	clr.b	(a0,d0.l)		; 分位清除
	move.l	a3,-(sp)
	bsr.w	(sub_1E6146).l	; 更新防禦
	addq.l	#4,sp
	rts


sub_127062:
	cmpi.w	#$545F,$22A(a3)	; 青銅天師星旋甲
	beq.w	locret_127062	; 取消打印
; 打印防禦數值|鎖子天師磨礪
	cmpi.w	#$555F,$22A(a3)	; 鎖子天師磨礪甲
	bne.s	loc_127062
	movea.l	#(ram_0029),a0	; 受擊寄存
	moveq	#0,d0
	move.w	$E(a3),d0		; 角色位號
	move.b	(a0,d0.w),d0	; 受擊次數
	addi.b	#$15,d0			; 防禦值|基礎+1.5625%/擊
	bra.s	loc_127063
loc_127062:
; 打印防禦數值|計算防具防禦
	movea.l	$200(a3),a0		; 道具欄基址
	cmpi.b	#2,$6C(a0)		; 防具頁格目
	bne.s	locret_127062	; 單甲不打印
	movea.l	#(ram_001D),a1	; 防禦屬性
	moveq	#0,d0
	move.w	$E(a3),d0		; 角色位號
	lsl.l	#2,d0
	adda.l	d0,a1			; 不防禦值
	moveq	#$40,d0
	sub.b	(a1),d0			; 實際防禦
; 打印防禦數值
loc_127063:
	clr.l	-(sp)			; 打印防禦
	move.l	d0,-(sp)
	move.l	a3,-(sp)
	bsr.w	sub_128F5A
	lea		$C(sp),sp
; 打印攻擊加成|鎖子於吉巨靈
	cmpi.w	#$555D,$22A(a3)	; 鎖子於吉巨靈甲
	bne.s	loc_127064
	moveq	#($40+$20),d0	; 攻擊力+50%
	bra.s	loc_127065
; 打印攻擊加成|明光天師獻祭
loc_127064:
	cmpi.w	#$565F,$22A(a3)	; 明光天師獻祭甲
	bne.s	locret_127062
	moveq	#0,d0
	movea.l $F8(a3),a0		; 角色基址
	move.b	$26C(a0),d0		; 收割敵將數目
	lsl.l	#1,d0			; 攻擊力追加值
	addi.b	#$40,d0			; 基礎值
; 打印攻擊加成
loc_127065:
	pea		(1).w			; 打印攻擊
	move.l	d0,-(sp)
	move.l	a3,-(sp)
	bsr.w	sub_128F5A
	lea		$C(sp),sp
locret_127062:
	move.b	#1,(a2)			; 原代碼
	moveq	#1,d0
	rts

sub_128F5A:	; 打印防具防禦值或攻擊值
	link	a6,#-8
	movem.l	d2-d6/a2-a3,-(sp)
	movea.l	8(a6),a2			; 角色OBJ
	move.l	$C(a6),d2			; 數值
	moveq	#0,d3
	tst.l	$10(a6)
	bne.s	loc_128FA6
; 防御力[0]
	moveq	#8,d6				; 豎坐標
	move.l	d2,d0
	lsl.l	#5,d0
	add.l	d0,d2
	lsl.l	#2,d2
	sub.l	d0,d2				; D2*100
	bge.s	loc_128F9A
	moveq	#63,d0
	add.l	d0,d2
loc_128F9A:
	asr.l	#6,d2
	movea.l	$2ABDA4.l,a3		; "DEFENSE"
	bra.s	loc_128FD8
loc_128FA6:
; 攻擊力[1]
	moveq	#0,d6				; 豎坐標
	move.l	d2,d0
	lsl.l	#5,d0
	add.l	d0,d2
	lsl.l	#2,d2
	sub.l	d0,d2
	subi.l	#6400,d2
	bge.s	loc_128FCE
	moveq	#63,d0
	add.l	d0,d2
loc_128FCE:
	asr.l	#6,d2
	movea.l	$2ABDA8.l,a3		; "POWER"
; 數值百分比
loc_128FD8:
	tst.l	d2
	bge.s	loc_128FF8
	move.l	d3,d0
	addq.l	#1,d3
	move.b	#$2D,-8(a6,d0.w)	; 減號
	neg.l	d2
	bra.s	loc_129002
loc_128FF8:
	move.l	d3,d0
	addq.l	#1,d3
	move.b	#$2B,-8(a6,d0.w)	; 加號
loc_129002:
	moveq	#100,d0
	cmp.l	d2,d0
	bgt.s	loc_129026
	clr.b	d5
	bra.s	loc_129012
loc_12900C:
	moveq	#100,d0
	sub.l	d0,d2
	addq.b	#1,d5
loc_129012:
	moveq	#100,d0
	cmp.l	d2,d0
	ble.s	loc_12900C
	move.b	d5,d0
	addi.b	#$30,d0
	move.l	d3,d1
	addq.l	#1,d3
	move.b	d0,-8(a6,d1.w)		; 百位數
loc_129026:
	clr.b	d5
	bra.s	loc_129030
loc_12902A:
	moveq	#10,d0
	sub.l	d0,d2
	addq.b	#1,d5
loc_129030:
	moveq	#10,d0
	cmp.l	d2,d0
	ble.s	loc_12902A
	move.b	d5,d0
	addi.b	#$30,d0
	move.l	d3,d1
	addq.l	#1,d3
	move.b	d0,-8(a6,d1.w)		; 十位數
	move.b	d2,d0
	addi.b	#$30,d0
	move.l	d3,d1
	addq.l	#1,d3
	move.b	d0,-8(a6,d1.w)		; 個位數
	move.l	d3,d0
	addq.l	#1,d3
	move.b	#$20,-8(a6,d0.w)	; 空格
	move.l	d3,d0
	addq.l	#1,d3
	move.b	#$25,-8(a6,d0.w)	; 百分號
	clr.b	-8(a6,d3.w)			; 結束符
; 打印文字
	jsr		$12D506				; 分配OBJ
	move.l	d0,d4
	clr.l	-(sp)
	pea		(off_1C1F32).l		; 文顯效果
	move.l	a3,-(sp)			; 文字
	move.w	$24(a2),d0
	ext.l	d0
	add.l	d6,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	subi.l	#$30,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	subi.l	#$36,d0
	move.l	d0,-(sp)
	move.l	d4,-(sp)
	jsr		$12D72C				; 打印
	lea		$1C(sp),sp
; 打印數值
	jsr		$12D506				; 分配OBJ
	move.l	d0,d4
	clr.l	-(sp)
	pea		(off_1C1F32).l		; 文顯效果
	pea		-8(a6)				; 數值
	move.w	$24(a2),d0
	ext.l	d0
	add.l	d6,d0
	move.l	d0,-(sp)
	move.w	$22(a2),d0
	ext.l	d0
	subi.l	#$30,d0
	move.l	d0,-(sp)
	move.w	$20(a2),d0
	ext.l	d0
	addi.l	#$A,d0
	move.l	d0,-(sp)
	move.l	d4,-(sp)
	jsr		$12D72C				; 打印
loc_129102:
	movem.l	-$24(a6),d2-d6/a2-a3
	unlk	a6
	rts

off_1C1F32:	; 防具頁文顯效果
	dc.l	dword_1C1F22,$00040000,0
dword_1C1F22:	; 防具頁文顯動作
	dc.l	$F0280200
	dc.l	$F0020F00,$00000000
	dc.l	$F0020F00,$40000000
	dc.l	$F0290000
	dc.l	$80000000


sub_1135D6:	; 防具屬性計算
	movem.l	a2/a3,-(sp)
	movea.l	$C(sp),a2
	movea.l	#(ram_001D+$10),a3	; 臨時寄存
; 未裝備防禦甲
	tst.w	$22A(a2)		; 是否無甲
	bne.s	loc_1135DC
	move.l	#$40000000,(a3)	; 無甲屬性
	bra.s	loc_1135D7
; 青銅天師甲|星旋
loc_1135DC:
	cmpi.w	#$545F,$22A(a2)
	bne.s	loc_1135DD
	clr.l	(a3)			; 重置屬性
	pea		($40).w
	jsr		$102506			; 小隨機
	addq.l	#4,sp
	move.b	d0,(a3)			; 不防禦值[00-40]
	pea		($FF).w
	jsr		$102506			; 小隨機
	addq.l	#4,sp
	move.b	d0,1(a3)		; 屬性免疫[00-FF]
	bset	#7,2(a3)		; 防盜設定[80]
	bra.w	loc_1135D7
loc_1135DD:
; 防具防禦寄存
	movea.l	#(ram_001D),a0	; 防禦屬性
	move.w	$E(a2),d0		; 角色位號
	lsl.w	#2,d0
	move.l	(a0,d0.w),(a3)	; 屬性寄存
; 鎖子天師甲|磨礪
loc_1135DA:
	cmpi.w	#$555F,$22A(a2)
	bne.s	loc_1135D7
	tst.w	$BE(a2)			; 是否換將狀態
	bne.s	loc_1135D7
	movea.l	#(ram_0029),a1	; 受擊寄存
	move.w	$E(a2),d0		; 角色位號
	move.b	(a1,d0.w),d0	; 受擊次數
	sub.b	d0,(a3)			; 不防禦值減成
; 傳出計算結果
loc_1135D7:
	tst.b	(byte_810A06+1).l	; 玄武神器開關
	beq.s	loc_1135D8
	move.b	#-$1,1(a3)		; 屬性攻擊全免疫
loc_1135D8:
	tst.w	$BE(a2)
	beq.s	loc_1135D9
	clr.b	1(a3)			; 援軍不免疫屬性攻擊
loc_1135D9:
	moveq	#0,d0
	move.b  (a3),d0			; 傳出不防禦值
	movea.l	a3,a0			; 傳出屬性寄存
	movem.l	(sp)+,a2/a3
	rts


sub_15BDB4:
	addq.l	#1,8(a2)
	addq.l	#1,$198(a2)		; 原代碼
; 青銅太平甲|判斷
	cmpi.w	#$545E,$22A(a2)
	bne.s	locret_15BDB4
	tst.b	$244(a2)		; 是否異常狀態
	bne.s	locret_15BDB4
	tst.w	$BE(a2)			; 是否換將狀態
	bne.s	locret_15BDB4
	cmpi.w	#2,$50(a2)		; 是否站立0201
	bne.s	locret_15BDB4
	cmpi.w	#1,$52(a2)
	bne.s	locret_15BDB4
	cmpi.w	#128,$6C(a2)	; 是否滿血
	bcc.s	locret_15BDB4
	move.l	8(a2),d0
	andi.l	#$1F,d0			; 每31幀
	bne.s	locret_15BDB4
; 青銅太平甲|養生
	addq.w	#1,$6C(a2)		; 增加一血
	pea		(1).w
	movea.l	$F8(a2),a0
	move.l	a0,-(sp)
	jsr		($14CF6A).l		; 生命槽變動
	addq.l	#8,sp
locret_15BDB4:
	rts

sub_10FC68:
	add.l	d0,$A(a3)
	addq.w	#1,$262(a3)		; 原代碼
; 青銅於吉甲|判斷
	cmpi.w	#$545D,$22A(a4)
	bne.s	locret_10FC68
	tst.b	$244(a4)		; 是否異常狀態
	bne.s	locret_10FC68
	tst.w	$BE(a4)			; 是否換將狀態
	bne.s	locret_10FC68
; 青銅於吉甲|浴血
	moveq	#0,d6
	move.b	$26C(a3),d6
	lsr.b	#3,d6			; 每收割8將回血量+1
loc_10FC68:
	cmpi.w	#128,$6C(a4)	; 是否滿血
	bcc.s	locret_10FC68
	addq.w	#1,$6C(a4)		; 增加一血
	pea		(1).w
	move.l	a3,-(sp)
	jsr		($14CF6A).l		; 生命槽變動
	addq.l	#8,sp
	dbf		d6,loc_10FC68	; 循環
locret_10FC68:
	rts

sub_114618:
	tst.w	$BE(a2)			; 是否換將狀態
	bne.s	loc_11AC86
; 鎖子天師|記錄
loc_114619:
	movea.l	#(ram_0029),a0	; 受擊寄存
	move.w	$E(a2),d0		; 角色位號
	cmpi.b	#$2B,(a0,d0.w)	; 最高值|$40-$15
	bge.s	loc_11461A
	addq.b	#1,(a0,d0.w)	; 更新次數
; 青銅魚鱗甲|判斷
loc_11461A:
	cmpi.w	#$545C,$22A(a2)
	bne.s	loc_114618
	moveq	#3,d0			; 是否03類動作
	cmp.l	-4(a6),d0
	beq.s	loc_11AC80
	moveq	#6,d0			; 是否06類動作
	cmp.l	-4(a6),d0
	bne.s	loc_11AC86
; 青銅魚鱗甲|強襲
loc_11AC80:
	move.w	#1,$23E(a2)		; 霸體狀態
	bra.s	loc_11AC86
loc_114618:
; 鎖子魚鱗甲|判斷
	cmpi.w	#$555C,$22A(a2)
	bne.s	loc_11AC86
	cmpi.w	#24,$6C(a3)		; 敵人生命值
	bls.s	loc_11AC86
; 鎖子魚鱗甲|反刃
	clr.l	-(sp)
	pea		(24).w
	move.l	a2,-(sp)
	move.l	a3,-(sp)
	jsr		$10FAC4			; 敵方扣血
	lea		$10(sp),sp
; 原代碼
loc_11AC86:
	tst.w	$23E(a2)
	beq.s	loc_1148C0
	movea.l	#$114620,a0
	bra.s	locret_114618
loc_1148C0:
	movea.l	#$1148C0,a0
locret_114618:
	rts

sub_11A604:
	tst.w	$BE(a3)			; 是否換將狀態
	bne.s	loc_11A604
; 青銅魚鱗甲|判斷
	cmpi.w	#$545C,$22A(a3)
	bne.s	loc_11A604
	cmpi.b	#3,d7
	beq.s	loc_11A61A
	cmpi.b	#6,d7
	bne.w	loc_11A604
loc_11A61A:
; 青銅魚鱗甲|強襲
	clr.w	$23E(a2)		; 取消敵方霸體
loc_11A604:	; 原代碼
	tst.w	$23E(a2)
	beq.s	loc_11A7D2
	movea.l	#$11A60C,a0
	bra.s	locret_11A604
loc_11A7D2:
	movea.l	#$11A7D2,a0
locret_11A604:
	rts

sub_11A888:
	tst.w	$BE(a3)			; 是否換將狀態
	bne.s	loc_11A888
; 青銅魚鱗甲|強襲
	cmpi.w	#$545C,$22A(a3)
	bne.s	loc_11A888
	move.l	#$3FF,d0		; 最大隨機值
	bra.s	locret_11A888
loc_11A888:	; 原代碼
	pea		($3FF).w
	jsr		$1024B0
	addq.l	#4,sp
locret_11A888:
	rts

sub_1151E6:
; 原代碼
	move.l	d2,-(sp)
	move.l	a2,-(sp)
	jsr		$15ED1A			; 我方扣血
	addq.l	#8,sp
; 鎖子魚鱗甲|判斷
	tst.w	$BE(a2)			; 是否換將狀態
	bne.w	locret_1151E6
	cmpi.w	#$555C,$22A(a2)
	bne.w	locret_1151E6
; 鎖子魚鱗甲|逆鱗
	movea.l	$58(a3),a0
	cmpi.b	#2,(a0)			; 是否敵兵
	beq.s	loc_1151EA
	lsl.l	#2,d2			; 四倍傷害
	cmp.w	$6C(a3),d2		; 敵人生命值
	bcs.w	loc_1151E9
; 鎖子魚鱗甲|反殺
loc_1151EA:
	move.w	$6C(a3),d2		; 生命槽調整值
	pea		($3A0160).l		; 強制死亡動作
	move.l	a3,-(sp)
	jsr		($10EF18).l
	addq.l	#8,sp
; 鎖子魚鱗甲|慘叫
	movea.l	$54(a3),a0
	cmpi.w	#$29F,$68(a0)
	beq.s	loc_1151E6
	jsr		$12D4B4
	tst.l	d0
	beq.w	loc_1151E9
loc_1151E6:
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_1151E7
	subi.b	#$40,($81B4C4).l
loc_1151E7:
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.w	loc_1151E9
	jsr		$13A578
	pea		($1).w
	movea.l	$54(a3),a0
	move.w	$68(a0),d0		; 慘叫音效
	andi.l	#$FFFF,d0
	asr.l	#8,d0
	andi.l	#3,d0
	move.l	d0,-(sp)
	movea.l	$54(a3),a0
	move.w	$68(a0),d0
	andi.l	#$FFFF,d0
	lsl.l	#8,d0
	moveq	#0,d1
	move.b	($81B4C4).l,d1
	lsl.l	#2,d1
	or.l	d1,d0
	or.l	(sp)+,d0
	ori.l	#$EF0000,d0		; 音頻音量
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	lea		$C(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_1151E8
	move.l	($81B4A8).l,($81B4B0).l
loc_1151E8:
	jsr		$13A58E
; 鎖子魚鱗甲|反刃
loc_1151E9:
	clr.l	-(sp)
	move.l	d2,-(sp)		; 反饋傷害
	move.l	a2,-(sp)
	move.l	a3,-(sp)
	jsr		$10FAC4			; 敵方扣血
	lea		$10(sp),sp
locret_1151E6:
	rts

sub_11B2F8:
; 基本條件判斷
	tst.w	$BE(a3)			; 是否換將狀態
	bne.s	locret_11B2F8
	; 超殺無加成|0622~0626
	cmpi.w	#6,$50(a3)
	bne.s	loc_11B2F9
	cmpi.w	#$22,$52(a3)
	bcs.s	loc_11B2F9
	cmpi.w	#$26,$52(a3)
	bls.s	locret_11B2F8
; 白虎神器|高攻暴擊
loc_11B2F9:
	tst.b	(byte_810A06+3).l
	beq.s	loc_11B2F8
	pea		(10).w
	jsr		$102480			; 大隨機
	addq.l	#4,sp
	tst.l	d0				; 10%概率暴擊
	bne.s	loc_11B2FA
	bsr.s	sub_15854A		; 暴擊提示音
	move.l	#($10+$A0),d0	; 十倍暴擊
	bra.s	loc_11B2FB
loc_11B2FA:
	moveq	#($10+$10),d0	; 攻擊力追加100%
loc_11B2FB:
	move.l	d2,d1			; 當前傷害值
	jsr		$1BEBE0.l		; d0*d1,d0
	asr.l	#4,d0			; 最终傷害值
	move.l	d0,d2
	bra.s	locret_11B2F8
loc_11B2F8:
; 鎖子於吉|巨靈
	cmpi.w	#$555D,$22A(a3)
	bne.s	locret_11B2F8
	move.l  d2,d0
	moveq	#3,d1			; 50%加成
	jsr		$1BEBE0.l		; d0*d1,d0
	asr.l	#1,d0
	move.l	d0,d2			; 最終傷害值
; 原代碼
locret_11B2F8:
	move.l	d5,-(sp)
	move.l  d2,-(sp)
	move.l  a3,-(sp)
	move.l  a2,-(sp)
	jsr		$10FAC4		; 敵方扣血
	lea		$10(sp),sp
	rts

sub_15854A:	; 暴擊音頻
	jsr		$12D4B4
	tst.l	d0
	beq.w	locret_15854A
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_15854A
	subi.b	#$40,($81B4C4).l
loc_15854A:
	move.l	($81B4C0).l,d0
	addq.l	#1,d0
	cmp.l	($81B4BC).l,d0
	bge.w	locret_15854A
	jsr		$13A578
	pea		(1).w
	moveq	#0,d0
	move.b	($81B4C4).l,d0
	lsl.l	#2,d0
	ori.l	#$4EF2100,d0	; 音頻代碼[21_0]
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_15854B
	move.l	($81B4A8).l,($81B4B0).l
loc_15854B:
	pea		(1).w
	clr.l	-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	lea		$18(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_15854C
	move.l	($81B4A8).l,($81B4B0).l
loc_15854C:
	jsr		$13A58E
locret_15854A:
	rts

sub_10FAE2:
	andi.l	#$FF,d6		; 原代碼
	move.l	a4,d0		; 是否角色攻擊
	beq.w	locret_10FAE2
; 明光天師|判斷
	cmpi.w	#$565F,$22A(a4)
	bne.s	loc_10FAE2
	tst.b	(byte_810A06+3).l	; 不與白虎神器疊攻
	bne.s	locret_10FAE2
	tst.w	$BE(a4)				; 是否換將狀態
	bne.s	locret_10FAE2
; 明光天師|獻祭
	moveq	#0,d0
	movea.l $F8(a4),a0			; 角色基址
	move.b	$26C(a0),d0			; 收割敵將數目
	addi.b	#$20,d0				; 基礎值=100%
	move.l  d2,d1
	jsr		$1BEBE0.l			; d0*d1,d0
	asr.l	#5,d0				; 單將加成3.125%
	move.l	d0,d2				; 最終傷害值
	bra.s	locret_10FAE2
loc_10FAE2:
; 青銅於吉|判斷
	cmpi.w	#$545D,$22A(a4)
	bne.s	locret_10FAE2
	tst.w	$BE(a4)			; 是否換將狀態
	bne.s	locret_10FAE2
	moveq	#1,d0
	cmp.l	d6,d0			; 是否敵將[01]
	bne.s	locret_10FAE2
; 青銅於吉|浴血
	move.l  d2,d0			; 傷害值
	lsr.l	#4,d0			; 生命補充值
	bne.s	loc_10FAE3
	moveq	#1,d0			; 最小值一
loc_10FAE3:
	move.w	$6C(a4),d1
	add.w	d0,d1
	cmpi.w	#128,d1			; 生命值上限
	bgt.s	loc_10FAE4
	add.w	d0,$6C(a4)		; 增加生命值
	bra.s	loc_10FAE5
loc_10FAE4:
	move.w	#128,$6C(a4)	; 加滿生命值
	move.l	#128,d0
	sub.w	$6C(a4),d0
loc_10FAE5:
	move.l	d0,-(sp)		; 生命補充值
	movea.l	$F8(a4),a0		; 角色基址
	move.l	a0,-(sp)
	jsr		($14CF6A).l		; 生命槽變動
	addq.l	#8,sp
locret_10FAE2:
	rts

sub_14DA4A:
	move.l	4(sp),d0	; 原代碼
; 明光魚鱗|判斷
	cmpi.w	#$565C,$22A(a4)
	bne.s	locret_14DA4A
	moveq	#3,d1		; 50%加成
	jsr		$1BEBE0.l	; d0*d1,d0
	asr.l	#1,d0		; 最終補血量
locret_14DA4A:
	rts

sub_11C572:
; 明光魚鱗|判斷
	cmpi.w	#$565C,$22A(a4)
	bne.s	loc_11C572
	movea.l	#byte_1C1166,a0	; 金銀財寶|補血值
	bra.s	locret_11C572
loc_11C572:
	movea.l	#$1C1166,a0		; 即食補給|補血值
locret_11C572:
	rts
byte_1C1166:
	dc.b	36, 16, 30, 28, 48, 32, 56	; 即食補給
	dc.b	8,  12, 16, 20, 24, 28, 32, 40, 0, 50, 90, 60, 0	; 金銀財寶

sub_1464CA:
	clr.w	($80D032).l	; 原代碼
; 重置當前關卡角色受擊次數
	clr.b	(ram_0029).l
	clr.b	(ram_0029+1).l
	clr.b	(ram_0029+2).l
	clr.b	(ram_0029+3).l
	rts

sub_11679C:
; 鎖子天師|記錄
	movea.l	#(ram_0029),a0	; 受擊寄存
	move.w	$E(a3),d0		; 角色位號
	cmpi.b	#$2B,(a0,d0.w)	; 最高值|$40-$15
	bge.s	loc_11679C
	addq.b	#1,(a0,d0.w)	; 更新次數
loc_11679C:	; 原代碼
	moveq	#0,d0
	move.w	$A(a4),d0
	rts

sub_15ED44:
	moveq	#0,d2
	movea.l	$F8(a2),a3
; 鎖子太平|靈識
	cmpi.w	#$555E,$22A(a2)
	bne.s	loc_15ED44
	move.w	$6C(a2),d2
	subq.w	#1,d2
	move.w	#1,$6C(a2)		; 保護|回復殘血
	move.w	#4,$1E2(a2)		; 保護|限時無敵[4]
	move.w	#300,$D2(a2)	; 保護|計時五秒
	bra.s	locret_15ED44
loc_15ED44:	; 原代碼
	move.w	$6C(a2),d2
	clr.w	$6C(a2)
locret_15ED44:
	rts

sub_1096A8:	; 角色保護計時
	move.l	a2,-(sp)
	movea.l	8(sp),a2
	tst.w	$1E2(a2)		; 角色是否保護狀態
	beq.w	loc_1096FE
	tst.w	$D2(a2)
	beq.w	loc_1096FE
	subq.w	#1,$D2(a2)		; 保護狀態倒計時
; 切換色盤
	* cmpi.w	#1,$1E2(a2)	; 原代碼
	btst	#1,$1E3(a2)		; 是否[1]或[4]
	bne.s	loc_1096DE
	move.w	$D2(a2),d0
	andi.w	#1,d0			; 循環切換色盤|隱身效果
	beq.s	loc_1096D8
	move.w	#$D,$62(a2)		; 隱身色盤|深藍色表號$D
	bra.s	loc_1096DE
loc_1096D8:
	move.w	$60(a2),$62(a2)	; 本體色盤
loc_1096DE:
	tst.w	$D2(a2)
	bne.w	loc_1096FE
; 清除圖片
	cmpi.w	#1,$1E2(a2)
	bne.s	loc_1096FA
	pea		(7).w
	move.l	a2,-(sp)
	jsr		$15D940			; 清除「P」符號
	addq.l	#8,sp
loc_1096FA:
; 鎖子太平靈識甲[4]
	cmpi.w	#4,$1E2(a2)		; 是否返照
	bne.w	loc_1096F3
	cmpi.w	#1,$6C(a2)		; 是否殘血
	bhi.w	loc_1096F3
	clr.w	$6C(a2)			; 生命值清零
	pea		($FFFF).W
	movea.l	$F8(a2),a0
	move.l	a0,-(sp)
	jsr		$14CF6A			; 生命條變動
	addq.l	#8,sp
; 倒地方向
	movea.l	$1EC(a2),a0		; 攻擊者
	move.w	$C8(a0),d0
	cmp.w	$C8(a2),d0
	bne.s	loc_1096F9
	moveq	#$C,d3
	bra.s	loc_1096F8
loc_1096F9:
	moveq	#2,d3
; 死亡慘叫
loc_1096F8:
	movea.l	$54(a2),a0
	cmpi.w	#$29F,$68(a0)
	beq.s	loc_1096F7
	jsr		$12D4B4
	tst.l	d0
	beq.w	loc_1096F4
loc_1096F7:
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_1096F6
	subi.b	#$40,($81B4C4).l
loc_1096F6:
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.w	loc_1096F4
	jsr		$13A578
	pea		($1).w
	movea.l	$54(a2),a0
	move.w	$68(a0),d0		; 慘叫音頻
	andi.l	#$FFFF,d0
	asr.l	#8,d0
	andi.l	#3,d0
	move.l	d0,-(sp)
	movea.l	$54(a2),a0
	move.w	$68(a0),d0
	andi.l	#$FFFF,d0
	lsl.l	#8,d0
	moveq	#0,d1
	move.b	($81B4C4).l,d1
	lsl.l	#2,d1
	or.l	d1,d0
	or.l	(sp)+,d0
	ori.l	#$DF0000,d0		; 音頻音量
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA
	lea		$C(sp),sp
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_1096F5
	move.l	($81B4A8).l,($81B4B0).l
loc_1096F5:
	jsr		$13A58E
; 倒地動作
loc_1096F4:
	move.w	d3,d0
	move.l	d0,-(sp)
	pea		($8).w			; 受擊動作
	move.l	a2,-(sp)
	jsr		$15E152			; 動作指針
	lea		$C(sp),sp
	move.l	d0,-(sp)
	move.l	a2,-(sp)
	jsr		$15E2DA			; 寫入動作
	addq.l	#8,sp
	move.w	#1,$B4(a2)
	move.w	#1,$174(a2)
loc_1096F3:
	clr.w	$1E2(a2)
loc_1096FE:
	movea.l	(sp)+,a2
	rts

sub_15AE48:
; 青銅天師|判斷
	cmpi.w	#$545F,$22A(a4)
	bne.s	loc_15AE48
	tst.w	$BE(a4)			; 是否換將狀態
	beq.s	loc_15AE50
loc_15AE48:	; 原代碼
	tst.w   $16E(a4)
	beq.s	locret_15AE48
loc_15AE50:
; 青銅天師|飛將
	move.l	a4,-(sp)
	jsr		$15F61A			; 移動加速
	addq.l	#4,sp
locret_15AE48:
	rts

sub_1BA7A4:	; 0505江陵道|登車判斷範圍
	movem.l	d2-d3/a2,-(sp)
	moveq	#0,d3
	jsr		$15EC62
	bra.s	loc_1BA824
loc_1BA7B2:
	cmpi.w	#2,$50(a2)
	bne.s	loc_1BA7C2
	cmpi.w	#1,$52(a2)
	beq.s	loc_1BA7C6
loc_1BA7C2:
	addq.l	#1,d3
	bra.s	loc_1BA81A
loc_1BA7C6:
	cmpi.w	#$AA,$22(a2)
	bge.s	loc_1BA7D6
	move.w	#$B4,$22(a2)
	bra.s	loc_1BA7E4
loc_1BA7D6:
	cmpi.w	#$DC,$22(a2)
	ble.s	loc_1BA7E4
	move.w	#$D2,$22(a2)
loc_1BA7E4:
	move.w	$22(a2),d0
	ext.l	d0
	move.l	#$DC,d2
	sub.l	d0,d2
	move.w	$20(a2),d0
	ext.l	d0
	move.l	d2,d1
	addi.l	#$2A0,d1
	cmp.l	d1,d0
	ble.s	loc_1BA80E
	move.w	d2,d0
	addi.w	#$2A0,d0
	move.w	d0,$20(a2)
loc_1BA80E:
	move.w	#$FFF0,$1C8(a2)
	move.w	#$FFF0,$24(a2)
loc_1BA81A:
	move.l	a2,-(sp)
	jsr		$15EC88
	addq.l	#4,sp
loc_1BA824:
	movea.l	d0,a2
	move.l	a2,d0
	bne.s	loc_1BA7B2
	tst.l	d3
	beq.s	loc_1BA832
	moveq	#0,d0
	bra.s	loc_1BA834
loc_1BA832:
	moveq	#1,d0
loc_1BA834:
	movem.l	(sp)+,d2-d3/a2
	rts

sub_171BB4:
	link	a6,#-$10
	movem.l	d2-d5/a2,-(sp)
	move.l	8(a6),d5
	moveq	#0,d2
	movea.l	#$D09000,a2
	bra.s	loc_171BF4
loc_171BCA:
	move.w	#1,$A2(a2)
	move.w	#1,$174(a2)
	move.w	#1,$84(a2)
; 取消防具效果
	moveq	#0,d0
	move.w	$22A(a2),d0
	move.w	d2,d1
	lsl.w	#2,d1
	move.l	d0,-$10(a6,d1.w)
	clr.w	$22A(a2)		; 飛將甲
	addq.l	#1,d2
	lea		$400(a2),a2
loc_171BF4:
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_171BCA
	jsr		$1578E4			; 封我行關道具
	jsr		$10F4F4			; 敵方不攻擊
	jsr		$100D74			; 分配計時器
	move.l	d0,d4
	move.l	d5,-(sp)
	move.l	d4,-(sp)
	jsr		$100E1A			; 設定計時器
	addq.l	#8,sp
	moveq	#1,d3
loc_171C1A:
	clr.w	d3
	moveq	#0,d2
	movea.l	#$D09000,a2
	bra.s	loc_171C4C
loc_171C26:
	cmpi.w	#2,$C(a2)
	bne.s	loc_171C46
	cmpi.w	#2,$50(a2)
	beq.s	loc_171C3A
	moveq	#1,d3
	bra.s	loc_171C52
loc_171C3A:
	cmpi.w	#1,$52(a2)
	beq.s	loc_171C46
	moveq	#1,d3
	bra.s	loc_171C52
loc_171C46:
	addq.l	#1,d2
	lea		$400(a2),a2
loc_171C4C:
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_171C26
loc_171C52:
	jsr		$13A646			; 主循環
	tst.l	d5
	beq.s	loc_171C6C
	move.l	d4,-(sp)
	jsr		$100E62			; 剩餘計時
	addq.l	#4,sp
	tst.l	d0
	bne.s	loc_171C6C
	clr.w	d3
loc_171C6C:
	tst.w	d3
	bne.s	loc_171C1A
	move.l	d4,-(sp)
	jsr		$100DC2			; 關閉計時
	addq.l	#4,sp
	moveq	#0,d2
	movea.l	#$D09000,a2
	bra.s	loc_171CB2
loc_171C84:
	cmpi.w	#2,$C(a2)
	bne.s	loc_171C96
	move.l	a2,-(sp)
	jsr		$15FDE2			; 出場動作
	addq.l	#4,sp
loc_171C96:
	clr.w	$A2(a2)
	tst.w	$196(a2)
	beq.s	loc_171CA8
	move.w	#1,$174(a2)
	bra.s	loc_171CAC
loc_171CA8:
	clr.w	$174(a2)
loc_171CAC:
	addq.l	#1,d2
	lea		$400(a2),a2
loc_171CB2:
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_171C84
; 恢復防具效果
	moveq	#0,d2
	movea.l	#$D09000,a2
	bra.s	loc_171CD2
loc_171CC2:
	move.w	d2,d0
	lsl.w	#2,d0
	move.w	-$E(a6,d0.w),$22A(a2)
	addq.l	#1,d2
	lea		$400(a2),a2
loc_171CD2:
	moveq	#4,d0
	cmp.l	d2,d0
	bgt.s	loc_171CC2
	movem.l	-$24(a6),d2-d5/a2
	unlk	a6
	rts


sub_1703F4:
	link	a6,#-$28		; 擴展寄存器|防具頁2、B面8
	movem.l	d2-d6/a2-a5,-(sp)
	movea.l	8(a6),a3
	cmpi.b	#1,($81827F).l	; 是否調試模式
	beq.w	locret_1705C8
	tst.w	$1C6(a3)
	beq.s	loc_17041C
	cmpi.w	#$80,$1C6(a3)
	bne.w	locret_1705C8
loc_17041C:
	tst.w	$B8(a3)
	beq.w	locret_1705C8
	movea.l	$1F4(a3),a5
	tst.w	$BE(a5)
	bne.w	locret_1705C8
	movea.l	$200(a5),a2		; 道具欄基址
	moveq	#0,d4			; 寄存的道具位數[d4]
; 寄存防具道具位
	moveq	#2,d3			; 防具頁[2]
	moveq	#0,d0
	move.b	d3,d0
	movea.l	d0,a0
	move.b	$6A(a2,a0.l),d5	; 防具頁格目
	andi.l	#$FF,d5
	moveq	#0,d2
	bra.s	loc_1704AC
loc_17045E:
	movea.l	#(ram_001D+2),a0	; 防盜屬性
	moveq	#0,d0
	move.w	$E(a5),d0		; 角色位號
	lsl.l	#2,d0
	btst	#7,(a0,d0.l)	; 是否防盜
	bne.w	locret_1705C8
	moveq	#0,d0
	move.b	d3,d0
	lsl.l	#5,d0
	add.l	a2,d0
	move.l	d2,d1
	lsl.l	#2,d1
	add.l	d1,d0
	addi.l	#$A,d0
	move.l	d4,d1
	addq.l	#1,d4
	lsl.w	#2,d1
	move.l	d0,-$28(a6,d1.w)	; 寄存道具位
	addq.l	#1,d2
loc_1704AC:
	cmp.l	d5,d2
	blt.s	loc_17045E
; 寄存B面道具位
	moveq	#1,d3			; B面[1]
	moveq	#0,d0
	move.b	d3,d0
	movea.l	d0,a0
	move.b	$6A(a2,a0.l),d5	; 防具頁格目
	andi.l	#$FF,d5
	moveq	#0,d2
	bra.s	loc_170502
loc_1704C6:
	moveq	#0,d0
	move.b	d3,d0
	lsl.l	#5,d0
	add.l	a2,d0
	move.l	d2,d1
	lsl.l	#2,d1
	add.l	d1,d0
	addi.l	#$A,d0
	movea.l	d0,a4
	tst.b	2(a4)			; 物品數目
	beq.s	loc_170500
	moveq	#0,d0
	move.b	d3,d0
	lsl.l	#5,d0
	add.l	a2,d0
	move.l	d2,d1
	lsl.l	#2,d1
	add.l	d1,d0
	addi.l	#$A,d0
	move.l	d4,d1
	addq.l	#1,d4
	lsl.w	#2,d1
	move.l	d0,-$28(a6,d1.w)	; 寄存道具位
loc_170500:
	addq.l	#1,d2
loc_170502:
	cmp.l	d5,d2
	blt.s	loc_1704C6
; 隨機盜取道具
	tst.l	d4
	beq.w	locret_1705C8
	move.l	d4,-(sp)
	jsr		$102480			; 大隨機
	lsl.w	#2,d0
	movea.l	-$28(a6,d0.w),a0
	move.b	1(a0),d6		; 被偷的物品
; 清除被盜防具
	cmp.b	$22A(a5),d6
	bne.s	loc_1703F4
	clr.b	$22A(a5)		; 清除寶甲
	bra.s	loc_1703F5
loc_1703F4:
	cmp.b	$22B(a5),d6
	bne.s	loc_1703F6
	clr.b	$22B(a5)		; 清除寶衣
loc_1703F5:	; 更新防禦
	move.l	a5,-(sp)
	bsr.w	(sub_1E6146).l
	addq.l	#4,sp
loc_1703F6:
; 減除被盜物品
	pea		(1).w			; 被偷的數目
	moveq	#0,d0
	move.b	d6,d0
	move.l	d0,-(sp)
	move.l	a5,-(sp)
	jsr		$126674			; 消耗道具
	lea		$10(sp),sp
	moveq	#0,d0
	move.b	d6,d0
	addi.w	#-$11,d0
	move.w	d0,$1C6(a3)		; 寫入已盜道具
; 被盜提示音
	jsr		$12D4B4
	tst.l	d0
	beq.s	locret_1705C8
	addq.b	#1,($81B4C4).l
	cmpi.b	#$40,($81B4C4).l
	bcs.s	loc_170562
	subi.b	#$40,($81B4C4).l
loc_170562:
	move.l	($81B4C0).l,d0
	cmp.l	($81B4BC).l,d0
	bge.s	locret_1705C8
	jsr		$13A578
	pea		(1).w
	moveq	#0,d0
	move.b	($81B4C4).l,d0
	lsl.l	#2,d0
	ori.l	#$7FCC02,d0
	move.l	d0,-(sp)
	move.l	($81B4B0).l,-(sp)
	jsr		$100CEA			; 寫入音效
	move.l	($81B4B8).l,d0
	add.l	d0,($81B4B0).l
	addq.l	#1,($81B4C0).l
	move.l	($81B4B0).l,d0
	cmp.l	($81B4B4).l,d0
	bne.s	loc_1705C2
	move.l	($81B4A8).l,($81B4B0).l
loc_1705C2:
	jsr		$13A58E
locret_1705C8:
	movem.l	-$4C(a6),d2-d6/a2-a5
	unlk	a6
	rts


sub_128ED6:
	move.b  ($1,A2), D2
	moveq   #$0, D0
	move.b  D2, D0
	lea     (A5,D0.l), A0
	movea.l A0, A4			; 原代碼
	tst.b	D2				; 是否空格
	rts 


sub_12763E:
	cmpi.b  #$21, D2		; 是否投擲道具-1
	bcs.s   loc_12763E
	cmpi.b  #$24, D2
	bhi.s	loc_12763E
	move.l	#$3150AC,d0		; 03XX顯示圖
loc_12763E:
	move.l  d0,$80B276.l	; 原代碼
	rts


; =============== RAM 擴容 ==================================================
	
	ORG RAMBase

ram_0000:	ds.b	1	; 是否初始化過菜單設定
ram_0001:	ds.b	1	; 敵人模式[玩家數目難度]
ram_0002:	ds.b	1	; 敵人模式[難度|0/+1/+2/+3/+4]
ram_0003:	ds.b	1	; 真敵人模式[變動|0/+1/+2/+3/+4]
ram_0004:	ds.b	1	; 開局場景[RANDOM/選定]
ram_0005:	ds.b	1	; 遊戲版本[100/107]
ram_0006:	ds.b	1	; 動作移動[V10X/V20X]
ram_0007:	ds.b	1	; 出招指令[A/B/C/D]
			ds.w	4

ram_000A:	ds.w	1	; 對戰進度
ram_000B:	ds.w	1	; 是否出兵
ram_000C:	ds.b	1	; 敵將位目[總]
ram_000D:	ds.b	1	; 同階關卡

ram_000E:	ds.b	1	; ram_000E+0 | 敵將序號[1]
			ds.b	1	; ram_000E+1 | 敵將位目[1]
			ds.l	1	; ram_000E+2 | 敵將OBJ[1]
			ds.w	1	; ram_000E+6 | 是否速殺敵將[1]
			ds.l	1	; ram_000E+8 | 敵將[1]速殺計時器編號
ram_0010:	ds.b	1	; ram_0010+0 | 敵將序號[2]
			ds.b	1	; ram_0010+1 | 敵將位目[2]
			ds.l	1	; ram_0010+2 | 敵將OBJ[2]
			ds.w	1	; ram_0010+6 | 是否速殺敵將[2]
			ds.l	1	; ram_0010+8 | 敵將[2]速殺計時器編號
ram_0012:	ds.b	21	; 敵將標記

ram_0013:	ds.w	1	; ram_0013+0 | 場景序號
			ds.b	24	; ram_0013+2 | 場景標記
ram_0015:	ds.w	1	; ram_0015+0 | 音樂序號
			ds.b	25	; ram_0015+2 | 音樂標記

ram_0019:	ds.l	1	; 任務計時器編號
ram_001A:	ds.w	1	; 機關計時器
ram_001B:	ds.b	24	; 任務獎賞標記
ram_001C:	ds.b	21	; 盲盒標記

ram_001E:	ds.w	1	; 指令施放策略魔法是否滿氣
ram_0021:	ds.b	1	; 是否掉落多武器
ram_001F:	ds.b	1	; 掉落的武器數目
ram_0022:	ds.b	10	; 已進入0206武器庫的角色標記表

ram_0023:	ds.w	1	; ram_0023+0 | 遊戲名稱所在圖層
			ds.l	4	; ram_0023+2 | 遊戲名稱OBJ寄存
ram_0024:	ds.b	1	; 右下角信息的編號
			ds.b	1	; 右下角信息輪換頻率

ram_0025:	ds.l	8	; 敵將對話信息寄存
ram_0026:	ds.b	1	; 南蠻（孟獲、孟優）出現次數
ram_0027:	ds.b	1	; 敵將生命保險
ram_001D:	ds.l	4+1	; 當前裝備防具防禦
ram_0029:	ds.b	4	; 當前角色當前關卡受擊次數

ram_0028:		ds.b	1	; 序章進度
byte_8168C2:	ds.b	1	; 左慈攜人遁入青室進度
byte_8168DC:	ds.b	1	; 是否完成遁入青室劇情
dword_8168D0:	ds.l	1	; 關底轉場出場的左慈OBJ
dword_816052:	ds.l	4	; 觸發真呂布晴天霹靂的角色OBJ寄存*4

byte_810A06:	ds.b	4	; 當前使用神器按序標記
dword_810A0A:	ds.l	4	; 四神器旋轉OBJ表格
dword_810A1A:	ds.l	1	; 當前旋轉中的神器OBJ
byte_810A1E:	ds.b	4	; 四神器計時當前倒數
byte_810A22:	ds.b	1	; 四神器計時圖顯標記
dword_810A24:	ds.l	4	; 四神器文顯OBJ表格
byte_810A7E:	ds.b	2	; 四神器計時圖顯個十位

	END	START