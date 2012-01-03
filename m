From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 3 Jan 2012 22:16:48 +0100
Subject: [GIT PULL] mxs: clk-prepare for 3.3
In-Reply-To: <201201032041.52234.arnd@arndb.de>
References: <20111228141415.GB10881@S2100-06.ap.freescale.net>
 <201201032041.52234.arnd@arndb.de>
Message-ID: <201201032216.48999.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wednesday 28 December 2011, Shawn Guo wrote:
> > Hi Arnd, Olof,
> > 
> > Please consider to pull mxs/clk-prepare for 3.3.  I have not collected
> > the ack tag from every single subsystem maintainer, but I do not want
> > to hold this any longer, since it's close to merge window now.
> > 
> > Hi Sascha,
> > 
> > I send a couple of Richard's patch you have collected here for
> > completeness.
> 
> Pulled into a new next/clk branch of the arm-soc tree, so I can revert
> it more easily in case someone complains when it hits linux-next.
> 
> I've taken the other subsystem maintainers that haven't acked the patches
> on Cc here so they know it's coming and can complain if necessary.
> For all I know, this all good, but I haven't followed the discussion
> leading up to the series.
> 
> Thanks,
> 
> 	Arnd

Thanks for notifying Arnd, I'm keeping an eye on this stuff and do tests from 
time to time.

M
> 
> > The following changes since commit 384703b8e6cd4c8ef08512e596024e028c91c339:
> >   Linux 3.2-rc6 (2011-12-16 18:36:26 -0800)
> > 
> > are available in the git repository at:
> >   git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/clk-prepare
> > 
> > Richard Zhao (2):
> >       clk: add helper functions clk_prepare_enable and
> >       clk_disable_unprepare net: fec: add clk_prepare/clk_unprepare
> > 
> > Shawn Guo (10):
> >       ARM: mxs: convert platform code to clk_prepare/clk_unprepare
> >       dma: mxs-dma: convert to clk_prepare/clk_unprepare
> >       mmc: mxs-mmc: convert to clk_prepare/clk_unprepare
> >       mtd: gpmi-lib: convert to clk_prepare/clk_unprepare
> >       net: flexcan: convert to clk_prepare/clk_unprepare
> >       serial: mxs-auart: convert to clk_prepare/clk_unprepare
> >       video: mxsfb: convert to clk_prepare/clk_unprepare
> >       ASoC: mxs-saif: convert to clk_prepare/clk_unprepare
> >       clk: add config option HAVE_CLK_PREPARE into Kconfig
> >       ARM: mxs: select HAVE_CLK_PREPARE for clock
