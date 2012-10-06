From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 6 Oct 2012 21:52:33 +0800
Subject: [PATCH] ARM: dts: imx6q-sabreauto: Add basic support
In-Reply-To: <CAOMZO5Dk2YKS=RTMKe5jejvtPqw1rNFt2G0EPvYo3uM2rFZYEw@mail.gmail.com>
References: <1348615018-14465-1-git-send-email-festevam@gmail.com>
 <20121006130344.GE20231@S2101-09.ap.freescale.net>
 <CAOMZO5Dk2YKS=RTMKe5jejvtPqw1rNFt2G0EPvYo3uM2rFZYEw@mail.gmail.com>
Message-ID: <20121006135228.GF20231@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 06, 2012 at 10:16:10AM -0300, Fabio Estevam wrote:
> On Sat, Oct 6, 2012 at 10:03 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> >>  Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
> >>  arch/arm/boot/dts/imx6q-sabreauto.dts         |   65 +++++++++++++++++++++++++
> >
> > Add imx6q-sabreauto.dtb into arch/arm/boot/dts/Makefile.
> 
> Ok, looking at arch/arm/boot/dts/Makefile I see that
> imx6q-sabrelite.dtb, for example appears
> under dtb-$(CONFIG_ARCH_MXC) and dtb-$(CONFIG_SOC_IMX6Q)
> 
I also noticed the problem.  It's a merge issue, and we intend to use
CONFIG_ARCH_MXC cover all imx dtb targets.

> Would you like a patch to remove this duplicate entry?
> 
Just sent a fix to Olof.

Shawn
