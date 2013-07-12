From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 12 Jul 2013 08:49:57 +0200
Subject: [PATCH] ARM: dts: imx: share pad macro names between imx6q and
 imx6dl
In-Reply-To: <1373522316-12319-1-git-send-email-shawn.guo@linaro.org>
References: <1373522316-12319-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130712064957.GH14452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Nice patch.

On Thu, Jul 11, 2013 at 01:58:36PM +0800, Shawn Guo wrote:
> The imx6q and imx6dl are two pin-to-pin compatible SoCs.  The same board
> design can work with either chip plugged into the socket, e.g. sabresd
> and sabreauto boards.
> 
> We currently define pin groups in imx6q.dtsi and imx6dl.dtsi
> respectively because the pad macro names are different between two
> chips.  This brings a maintenance burden on having the same label point
> to the same pin group defined in two places.
> 
> The patch drops prefix MX6Q_ and MX6DL_ from those pad macro names.

Can we use another prefix instead of removing it completely? Maybe
MX6QDL_?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
