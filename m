From: gerg@snapgear.com (gerg at snapgear.com)
Date: Mon, 10 Sep 2012 13:31:36 +1000
Subject: [PATCH] ARM: add back in KS8695 based OpenGear board entries
Message-ID: <1347247896-6833-1-git-send-email-gerg@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

Board support code for the OpenGear boards based on the Micrel KS8695 SoC
will soon appear in mainline kernel. The board IDs had been removed from
the mach-types file, so add them back in.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/tools/mach-types |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 69a3e81..c90ce5a 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -133,12 +133,14 @@ kb9200			MACH_KB9200		KB9200			612
 sx1			MACH_SX1		SX1			613
 ixdp465			MACH_IXDP465		IXDP465			618
 ixdp2351		MACH_IXDP2351		IXDP2351		619
+cm4008			MACH_CM4008		CM4008			624
 iq80332			MACH_IQ80332		IQ80332			629
 gtwx5715		MACH_GTWX5715		GTWX5715		641
 csb637			MACH_CSB637		CSB637			648
 n30			MACH_N30		N30			656
 nec_mp900		MACH_NEC_MP900		NEC_MP900		659
 kafa			MACH_KAFA		KAFA			662
+cm41xx			MACH_CM41XX		CM41XX			672
 ts72xx			MACH_TS72XX		TS72XX			673
 otom			MACH_OTOM		OTOM			680
 nexcoder_2440		MACH_NEXCODER_2440	NEXCODER_2440		681
@@ -182,6 +184,7 @@ mx21ads			MACH_MX21ADS		MX21ADS			851
 ams_delta		MACH_AMS_DELTA		AMS_DELTA		862
 nas100d			MACH_NAS100D		NAS100D			865
 magician		MACH_MAGICIAN		MAGICIAN		875
+cm4002			MACH_CM4002		CM4002			876
 nxdkn			MACH_NXDKN		NXDKN			880
 palmtx			MACH_PALMTX		PALMTX			885
 s3c2413			MACH_S3C2413		S3C2413			887
@@ -218,6 +221,7 @@ fsg			MACH_FSG		FSG			1091
 at91sam9260ek		MACH_AT91SAM9260EK	AT91SAM9260EK		1099
 glantank		MACH_GLANTANK		GLANTANK		1100
 n2100			MACH_N2100		N2100			1101
+im42xx			MACH_IM42XX		IM42XX			1105
 qt2410			MACH_QT2410		QT2410			1108
 kixrp435		MACH_KIXRP435		KIXRP435		1109
 cc9p9360dev		MACH_CC9P9360DEV	CC9P9360DEV		1114
@@ -251,6 +255,7 @@ csb726			MACH_CSB726		CSB726			1359
 davinci_dm6467_evm	MACH_DAVINCI_DM6467_EVM	DAVINCI_DM6467_EVM	1380
 davinci_dm355_evm	MACH_DAVINCI_DM355_EVM	DAVINCI_DM355_EVM	1381
 littleton		MACH_LITTLETON		LITTLETON		1388
+im4004			MACH_IM4004		IM4004			1400
 realview_pb11mp		MACH_REALVIEW_PB11MP	REALVIEW_PB11MP		1407
 mx27_3ds		MACH_MX27_3DS		MX27_3DS		1430
 halibut			MACH_HALIBUT		HALIBUT			1439
-- 
1.7.0.4
