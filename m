From: b38343@freescale.com (Robin Gong)
Date: Thu, 13 Nov 2014 10:10:08 +0800
Subject: [PATCH v4 0/3] add power off driver for i.mx6
In-Reply-To: <20141112105620.GM2704@dragon>
References: <1415780439-29728-1-git-send-email-b38343@freescale.com>
 <20141112105620.GM2704@dragon>
Message-ID: <20141113021007.GA30646@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Shawn.
On Wed, Nov 12, 2014 at 06:56:22PM +0800, Shawn Guo wrote:
> On Wed, Nov 12, 2014 at 04:20:36PM +0800, Robin Gong wrote:
> > Resend the patchset  with the latest MAINTAINERS
> > Add simple power off driver for i.mx6, including:
> > - add basic imx-snvs-poweroff driver in drivers/power/reset
> > - add device node in all dts files of i.mx6.
> > - enable in config file
> > 
> > Change from v3:
> > - disable poweroff driver in soc level dts and enable it in board level dts
> > - replace 'EIO' with 'ENODEV' while of_iomap fail.
> > Change from v2:
> > - remove useless included head files
> > - split device binding doc from dts patch
> > - add description for the case that PMIC_ON_REQ not used as external power
> >   control
> > 
> > Robin Gong (3):
> >   ARM: dts: imx6: add pm_power_off support for i.mx6 chips
> >   power: reset: imx-snvs-poweroff: add power off driver for i.mx6
> >   ARM: configs: imx_v6_v7_defconfig: add power off driver
> 
> I'm fine with the series.  But before I take the patches, I need an ACK
> from DT folks on the bindings.
> 
> Shawn
