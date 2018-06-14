From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 14 Jun 2018 18:30:03 +0000
Subject: [PATCH v7 10/10] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <c042fd9b-85cb-f0d3-101c-f78f3dc4fc44@infradead.org>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
 <1527713725-1086-11-git-send-email-jollys@xilinx.com>
 <c042fd9b-85cb-f0d3-101c-f78f3dc4fc44@infradead.org>
Message-ID: <SN1PR02MB3758971F60A9800642B16F95B87D0@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Thanks for review,

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap at infradead.org]
> Sent: Wednesday, May 30, 2018 2:18 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; mturquette at baylibre.com;
> sboyd at codeaurora.org; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-clk at vger.kernel.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Tejas Patel
> <TEJASP@xilinx.com>; Shubhrajyoti Datta <shubhraj@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v7 10/10] drivers: clk: Add ZynqMP clock driver
> 
> On 05/30/2018 01:55 PM, Jolly Shah wrote:
> > From: Jolly Shah <jolly.shah@xilinx.com>
> 
> 
> > diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
> > new file mode 100644 index 0000000..fe815f7
> > --- /dev/null
> > +++ b/drivers/clk/zynqmp/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +config COMMON_CLK_ZYNQMP
> > +	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
> > +	depends on OF
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	depends on ZYNQMP_FIRMWARE
> > +	help
> > +	  Support for the Zynqmp Ultrascale clock controller.
> > +	  It has a dependency on the PMU firmware.
> > +	  Say Y if you want to support clock support
> 
> 	  Say Y if you want to include clock support.
> 
	Fixed in v8

> 
> --
> ~Randy
