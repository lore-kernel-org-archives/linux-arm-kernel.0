From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 26 Jul 2018 11:48:47 +0200
Subject: [PATCH v8 0/6] provide power off support for iMX6 with external
 PMIC
In-Reply-To: <20180726092220.17250-1-o.rempel@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
Message-ID: <650c8289-f3a1-8bb1-2e4b-876100f9ae21@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

Am 26.07.2018 um 11:22 schrieb Oleksij Rempel:
> 2018.07.26:
> v8 is a rebase against kernel v4.18-rc6. No other changes are made.
> Added: linux-imx at nxp.com and yibin.gong at nxp.com to the CC.

your patches won't apply to regulator-next or linux-next because 
"regulator: pfuze100: add pfuze3001 support" has been merged before.

Since the pfuze3001 doesn't support standby, it would be nice to make 
the driver take care of this.

Best regards
Stefan
