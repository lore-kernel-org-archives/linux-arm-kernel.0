From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Fri, 08 Oct 2010 10:11:35 +0200
Subject: [PATCH] i.MX35: use the correct IIM register to get CPU revision
In-Reply-To: <1286524957-30218-1-git-send-email-eric@eukrea.com>
References: <1286523290-25321-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1286524957-30218-1-git-send-email-eric@eukrea.com>
Message-ID: <4CAED237.7020703@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Le 08/10/2010 10:02, Eric B?nard a ?crit :
 > @@ -182,11 +184,7 @@
 >
 >   #define MX35_PROD_SIGNATURE		0x1	/* For MX31 */
 >
 > -/* silicon revisions specific to i.MX35 */
 > -#define MX35_CHIP_REV_1_0		0x1
 > -#define MX35_CHIP_REV_2_0		0x2
 > -
 > -#define MX35_SYSTEM_REV_MIN		MX35_CHIP_REV_1_0
 > +#define MX35_SYSTEM_REV_MIN		MX3x_CHIP_REV_1_0
 >   #define MX35_SYSTEM_REV_NUM		3
 >
 >   #ifdef IMX_NEEDS_DEPRECATED_SYMBOLS

oops I made a mistake when importing your patches, the end of this one 
shjould'nt be there.

Eric
