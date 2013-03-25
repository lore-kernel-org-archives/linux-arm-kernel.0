From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 25 Mar 2013 10:08:02 +0900
Subject: [PATCH v4 0/4] Initial Device Tree support for S3C64xx
In-Reply-To: <2474214.PvUtMM3R7F@flatron>
References: <1362860975-18635-1-git-send-email-tomasz.figa@gmail.com>
 <2474214.PvUtMM3R7F@flatron>
Message-ID: <16de01ce28f5$32d3e850$987bb8f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi,
> 
> On Saturday 09 of March 2013 21:29:31 Tomasz Figa wrote:
> > This series adds Device Tree support for Samsung S3C64xx SoC series.
> >
> > It fixes several problems preventing from booting an S3C64xx-based
> > system using Device Tree, adds all the infrastructure for Device
> > Tree-based board support, including mach-s3c64xx-dt and dts include
> > files for S3C64xx SoCs, and (very) basic device tree source for
> > FriendlyARM Mini6410 board.
> >
> > Current support is very limited and allows only basic bootup with UART
> > and SDHCI, but should be fine as a start and will be extended in
> > future, hopefully with help of S3C64xx board maintainers.
> >
> > This series depends on my other series reworking samsung-time for
> > multiplatform: [PATCH v3 00/12] ARM: samsung-time: Prepare for
> > multiplatform support
> > http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16664
> >
> > Changes since v3:
> >  - Rebased onto current for-next branch of Kgene's tree
> >  - Updated timer node for next version of samsung-time patches
> >  - Replaced local s3c64xx_dt_init_irq with irqchip_init
> >
> > Changes since v2:
> >  - Updated timer node for next version of samsung-time patches
> >
> > Changes since v1:
> >  - Dropped two VIC-related patches that are no longer necessary
> >  - Added Device Tree-based instantation of system timers
> >  - Corrected VIC interrupt specifiers
> >  - Adjusted CPU compatible values and dropped @id
> >
> > Tomasz Figa (4):
> >   ARM: common: vic: Parse interrupt and resume masks from device tree
> >   ARM: s3c64xx: Add board file for boot using Device Tree
> >   ARM: dts: Add basic dts include files for Samsung S3C64xx SoCs
> >   ARM: dts: Add dts file for S3C6410-based Mini6410 board
> 
> Any comments for this series?
> 
Basically, looks good to me but I need to check your samsung-time patches,
if any updates, let you know.

Thanks.

- Kukjin
