From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 31 May 2013 12:14:37 -0700
Subject: [PATCH 0/4] clk, mfd: u8540 clock tree definition
In-Reply-To: <20130531065532.GA10355@gmail.com>
References: <1369658492-31358-1-git-send-email-philippe.begnic.st@gmail.com>
 <20130531012509.21525.90187@quantum> <20130531065532.GA10355@gmail.com>
Message-ID: <20130531191437.21525.40759@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2013-05-30 23:55:32)
> On Thu, 30 May 2013, Mike Turquette wrote:
> 
> > Quoting Philippe Begnic (2013-05-27 05:41:28)
> > > From: Philippe Begnic <philippe.begnic@st.com>
> > > 
> > > Create U8540 clock tree definitions for common clock framework
> > > 
> > 
> > The clock changes look good to me.  How did you want to merge the
> > patches?
> 
> You may as well take them through your tree Mike.
> 

Sure I can take them but it would be best to wait for an Ack from Samuel
for the MFD parts, if only so that we are coordinated.

Regards,
Mike

> > > Philippe Begnic (4):
> > >   clk: ux500: Pass clock base adresses in initcall for u8540 and u9540
> > >   mfd: db8500: Update register definition for u8540 clock
> > >   mfd: db8500: Update BML clock register for db8580
> > >   clk: ux500: Clocks definition for u8540
> > > 
> > >  arch/arm/mach-ux500/cpu.c                 |    6 +-
> > >  drivers/clk/ux500/u8540_clk.c             |  564 ++++++++++++++++++++++++++++-
> > >  drivers/clk/ux500/u9540_clk.c             |    4 +-
> > >  drivers/mfd/db8500-prcmu.c                |    1 +
> > >  drivers/mfd/dbx500-prcmu-regs.h           |    1 +
> > >  include/linux/mfd/abx500/ab8500-sysctrl.h |    4 +-
> > >  include/linux/mfd/dbx500-prcmu.h          |   12 +
> > >  include/linux/platform_data/clk-ux500.h   |    6 +-
> > >  8 files changed, 587 insertions(+), 11 deletions(-)
> > > 
> 
> -- 
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
