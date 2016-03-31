From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 14:14:05 +0800
Subject: [PATCHv2 0/8] ARM: dts: update Ka-Ro i.MX6 module support
In-Reply-To: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
References: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160331061405.GP28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2016 at 09:03:56AM +0100, Lothar Wa?mann wrote:
> This patch set updates the Ka-Ro electronics i.MX6 based module
> support and adds support for some new modules and a new baseboard.
> 
> changes vs. v1:
> - relicense DTS files under GPLv2/X11
> - dropped patches which have been applied already
> - added some cleanup patches
> 
> [PATCHv2 1/8] ARM: dts: imx6-tx6: Relicense the Ka-Ro DT files under GPLv2/X11
> [PATCHv2 2/8] ARM: dts: imx6-tx6: cleanup; no functional change
> [PATCHv2 4/8] ARM: dts: imx6-tx6: disable the spi node by default
> [PATCHv2 5/8] ARM: dts: imx6-tx6: remove container node around pinctrl nodes
> [PATCHv2 6/8] ARM: dts: imx6qdl-tx6: add mdio node for ethernet phy

Applied above 5 patches, thanks.
