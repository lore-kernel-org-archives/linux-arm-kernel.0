From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Apr 2016 21:57:49 +0800
Subject: [PATCHv3 0/5] ARM: dts: update Ka-Ro i.MX6 module support
In-Reply-To: <1459427625-15568-1-git-send-email-LW@KARO-electronics.de>
References: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
 <1459427625-15568-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160411135749.GD13735@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 02:33:40PM +0200, Lothar Wa?mann wrote:
> This patch set updates the Ka-Ro electronics i.MX6 based module
> support and adds support for some new modules and a new baseboard.
> 
> changes vs. v1:
> - relicense DTS files under GPLv2/X11
> - dropped patches which have been applied already
> - added some cleanup patches
> 
> changes vs. v2:
> - dropped patches which have been applied already
> - addressed comments from Shawn Guo
> - added patch to remove LED pinctrl from hoggrp
> - added patch to enable rtscts support on UARTs
> 
> [PATCHv3 1/5] ARM: dts: imx6-tx6: remove regulator bus
> [PATCHv3 2/5] ARM: dts: imx6-tx6: remove LED pinctrl setting from hoggrp
> [PATCHv3 3/5] ARM: dts: imx6-tx6: enable support for rtscts on UARTs
> [PATCHv3 4/5] ARM: dts: imx6: add support for more Ka-Ro electronics modules
> [PATCHv3 5/5] ARM: dts: imx6: add support for the Ka-Ro electronics 'MB7' baseboard

Applied all, thanks.
