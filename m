From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jun 2013 10:41:10 +0200
Subject: [PATCH 1/3] ARM: imx: prepare for removal of flexcan_platform_data
In-Reply-To: <1372317731-24966-2-git-send-email-mkl@pengutronix.de>
References: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
 <1372317731-24966-2-git-send-email-mkl@pengutronix.de>
Message-ID: <20130627084110.GE516@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 09:22:09AM +0200, Marc Kleine-Budde wrote:
> As there are no imx in-tree users of flexcan_platform_data, this patch removes
> the possibility to register a flexcan device with platform data.
> 
> The functionality to swith on/off CAN transceivers is added to DT via
> regulators on a later patch.
> 
> Compile time tested with imx_v4_v5_defconfig and imx_v6_v7_defconfig.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

I like to see platform stuff go away ;)

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
