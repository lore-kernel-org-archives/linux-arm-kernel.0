From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Apr 2014 17:00:41 +0800
Subject: [PATCH v2 0/4] arm: mxs: dts: small fixes for I2SE's duckbills
In-Reply-To: <20140402085225.GE8753@dragon>
References: <1395960690-19531-1-git-send-email-mhei@heimpold.de>
 <20140402085225.GE8753@dragon>
Message-ID: <20140402090039.GA10283@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 04:52:26PM +0800, Shawn Guo wrote:
> On Thu, Mar 27, 2014 at 11:51:26PM +0100, Michael Heimpold wrote:
> > This series fixes two issues with the DT file: first, it frees up
> > some GPIOs which are mis-used by MMC interface, and second, it
> > fixes the GPIO used to reset the ethernet phy.
> > 
> > While at it, use symbolic names for LED definitions.
> > 
> > Changes in v2:
> >  - add missing patch for imx28.dtsi to include gpio.h
> > 
> > 
> > Michael Heimpold (4):
> >   arm: mxs: dt: imx28-duckbill: fix mmc settings
> >   arm: mxs: dt: imx28-duckbill: fix phy reset gpio
> >   arm: mxs: dt: imx28: include gpio.h to allow use of symbolic names
> >   arm: mxs: dt: imx28-duckbill: use symbolic names from gpio.h
> 
> Changed patch prefix as below and applied all patches.
> 
>   ARM: dts: imx28-duckbill: fix mmc settings
>   ARM: dts: imx28-duckbill: fix phy reset gpio
>   ARM: dts: imx28: include gpio.h to allow use of symbolic names
>   ARM: dts: imx28-duckbill: use symbolic names from gpio.h

Forgot mentioning that the patches should be reordered as below, since
the patch fixing phy reset gpio already uses GPIO symbolic name.

   ARM: dts: imx28-duckbill: fix mmc settings
   ARM: dts: imx28: include gpio.h to allow use of symbolic names
   ARM: dts: imx28-duckbill: fix phy reset gpio
   ARM: dts: imx28-duckbill: use symbolic names from gpio.h

Shawn
