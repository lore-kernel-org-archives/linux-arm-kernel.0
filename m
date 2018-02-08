From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Feb 2018 15:09:48 +0800
Subject: [PATCH v2 BUGFIX] ARM: dts: imx6ull: fix the imx6ull-14x14-evk
 configuration
In-Reply-To: <1516956738-24673-1-git-send-email-LW@KARO-electronics.de>
References: <1516955159-21626-1-git-send-email-LW@KARO-electronics.de>
 <1516956738-24673-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20180208070946.GC31910@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 09:52:18AM +0100, Lothar Wa?mann wrote:
> imx6ull-14x14-evk.dts currently includes the imx6ul.dtsi file for an
> i.MX6ULL SoC which is plain wrong.
> 
> Rename the current imx6ul-14x14-evk.dts to .dtsi and include it from
> imx6ul-14x14-evk.dts and imx6ull-14x14-evk.dts, so that both can
> include the appropriate SoC specific (imx6ul.dtsi/imx6ull.dtsi) file.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks.
