From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 17 Feb 2014 00:25:13 -0600
Subject: [GIT PULL] SOCFPGA DT updates for 3.15
In-Reply-To: <53019DE5.2010604@gmail.com>
References: <1391621517-17219-1-git-send-email-dinguyen@altera.com>
 <53019DE5.2010604@gmail.com>
Message-ID: <1392618313.29346.2.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-02-16 at 23:28 -0600, Dinh Nguyen wrote:
> On 2/5/14 11:31 AM, dinguyen at altera.com wrote:
> > Hi Arnd, Kevin, and Olof,
> >
> > Please consider pulling in these 2 patches for the enabling SD/MMC on the SOCFPGA
> > platform.
> >
> > Thanks,
> > Dinh
> >
> > The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> >
> >   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dts-for-3.15
> >
> > for you to fetch changes up to e422c12bc07192289c3fec4edd457e6ffaa03b2b:
> >
> >   ARM: socfpga_defconfig: enable SD/MMC support (2014-02-05 11:19:34 -0600)
> >
> > ----------------------------------------------------------------
> > SOCFPGA dts updates for v3.15
> >
> > ----------------------------------------------------------------
> > Dinh Nguyen (2):
> >       dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
> >       ARM: socfpga_defconfig: enable SD/MMC support
> >
> >  arch/arm/boot/dts/socfpga.dtsi          |   13 ++++++++++++-
> >  arch/arm/boot/dts/socfpga_arria5.dtsi   |   11 +++++++++++
> >  arch/arm/boot/dts/socfpga_cyclone5.dtsi |   11 +++++++++++
> >  arch/arm/boot/dts/socfpga_vt.dts        |   11 +++++++++++
> >  arch/arm/configs/socfpga_defconfig      |    2 ++
> >  5 files changed, 47 insertions(+), 1 deletion(-)
> Just a ping...
> 

Apologies, but please ignore this thread. I need to rework this based on
this thread:

http://thread.gmane.org/gmane.linux.kernel.mmc/25039/focus=25076

Dinh
> Thanks,
> Dinh
> 
> 
