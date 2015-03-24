From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Mar 2015 20:18:11 +0800
Subject: [PATCH v2 1/2] ARM: dts: imx6: factor out pinmux for edm1 module
In-Reply-To: <20150323151937.GA20161@pengutronix.de>
References: <1425831960-10259-1-git-send-email-m.grzeschik@pengutronix.de>
 <20150323151937.GA20161@pengutronix.de>
Message-ID: <20150324121810.GI28410@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 04:19:37PM +0100, Michael Grzeschik wrote:
> On Sun, Mar 08, 2015 at 05:25:59PM +0100, Michael Grzeschik wrote:
> > Thw Wandboard is using the EDM1-CF-IMX6 module which is
> > defined under the edm standard.
> > 
> > http://www.edm-standard.org/
> > 
> > As this module is used on more boards this patch moves the default
> > pinmux settings into the special file imx6qdl-edm1.dtsi.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > - fixed the alphabetical order of the nodes
> > - moved MX6QDL_PAD_GPIO_16__ENET_REF_CLK to the board hogpins
> > 
> >  arch/arm/boot/dts/imx6qdl-edm1.dtsi            | 230 +++++++++++++++++++++++++
> >  arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi |   1 +
> >  arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi |   1 +
> >  arch/arm/boot/dts/imx6qdl-wandboard.dtsi       |  99 +----------
> >  4 files changed, 234 insertions(+), 97 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/imx6qdl-edm1.dtsi
> 
> subliminal ping...

Have we got anyone test the patch on Wandboard as requested by rsc [1]?

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/394350/focus=394353
