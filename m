From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 2 Dec 2013 11:09:28 -0600
Subject: [GIT PULL] clk: socfpga: Clock fix for 3.13
In-Reply-To: <20131127204948.16819.21032@quantum>
References: <1382604095-3097-1-git-send-email-dinguyen@altera.com>
 <527B6765.1000409@gmail.com> <20131127204948.16819.21032@quantum>
Message-ID: <1386004168.11807.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-27 at 12:49 -0800, Mike Turquette wrote:
> Quoting Dinh Nguyen (2013-11-07 02:11:49)
> > Hi Mike,
> > 
> > On 10/24/13 3:41 AM, dinguyen at altera.com wrote:
> > > The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
> > >
> > >   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
> > >
> > > are available in the git repository at:
> > >
> > >   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-for-3.13
> > >
> > > for you to fetch changes up to f592c5da6869133de941e44ef2ed4ede7f6b2791:
> > >
> > >   clk: socfpga: Remove check for "reg" property in socfpga_clk_init (2013-10-24 03:18:30 -0500)
> > >
> > > ----------------------------------------------------------------
> > > Clock fix for SOCFPGA
> > >
> > > Remove check for "reg" property in socfpga_clk_init() function
> > > This allows for clk property to be assigned for the arm_twd timer, which
> > > will lead to removing socfpga_init_clocks().
> > >
> > > ----------------------------------------------------------------
> > > Dinh Nguyen (1):
> > >       clk: socfpga: Remove check for "reg" property in socfpga_clk_init
> > >
> > >  drivers/clk/socfpga/clk.c |    4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > Can you please pull this?
> 
> Taken into clk-next.

Thanks Mike.

Dinh
> 
> Thanks,
> Mike
> 
> > Thanks,
> > Dinh
> 
