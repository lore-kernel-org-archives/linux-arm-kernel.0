From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Nov 2012 22:33:45 +0800
Subject: [PATCH 4/4] ARM: dts: imx: add imx5x phy-mode entries
In-Reply-To: <50A6073C.2010509@pengutronix.de>
References: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352988014-14769-5-git-send-email-m.grzeschik@pengutronix.de>
 <20121116071519.GE2941@S2100-06.ap.freescale.net>
 <50A6073C.2010509@pengutronix.de>
Message-ID: <20121116143344.GJ2941@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 10:28:28AM +0100, Marc Kleine-Budde wrote:
> On 11/16/2012 08:15 AM, Shawn Guo wrote:
> > On Thu, Nov 15, 2012 at 03:00:14PM +0100, Michael Grzeschik wrote:
> >> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >> ---
> >>  arch/arm/boot/dts/imx51.dtsi |    2 ++
> >>  arch/arm/boot/dts/imx53.dtsi |    2 ++
> >>  2 files changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> >> index 366b8d3..ffc6bc8 100644
> >> --- a/arch/arm/boot/dts/imx51.dtsi
> >> +++ b/arch/arm/boot/dts/imx51.dtsi
> >> @@ -145,6 +145,7 @@
> >>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
> >>  				reg = <0x73f80200 0x0200>;
> >>  				interrupts = <14>;
> >> +				phy-mode = "utmiw";
> > 
> > I tried to grep "phy-mode" and "utmiw" on linux-next and found nothing.
> > So it's not something we can take for 3.8, right?
> 
> But it wouldn't hurt, if we agree on a common usb phy-mode binding helper.
> 
Generally, I intend to only take the dts changes which have the
corresponding binding merged by subsystems, so that we can avoid
the possible noisy patches to adopt binding changes back and forth.

Shawn
