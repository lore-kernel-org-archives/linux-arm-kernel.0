From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 May 2014 23:15:45 -0700
Subject: [PATCH v6 0/2] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <20140513015905.GB29336@verge.net.au>
References: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
 <20140513015905.GB29336@verge.net.au>
Message-ID: <20140513061545.5943.33241@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Simon Horman (2014-05-12 18:59:05)
> Hi Mike,
> 
> I'm wondering if you would consider this series.
> I'm happy to take it through my tree and then arm-soc is
> that works best for you.

I've just taken these into clk-next.

Thanks!
Mike

> 
> On Fri, Apr 18, 2014 at 08:05:49AM +0900, Simon Horman wrote:
> > Hi Mike,
> > 
> > please consider applying this series.
> > 
> > It is the first step on the way towards using the common clock framework
> > and in turn multi-platform on the r8a7779 (R-Car H1) SoC.
> > 
> > It has been acked by Laurent Pinchart who did similar work
> > for the R-Car Gen-2 family of SoCs. This work is based on that work.
> > 
> > The bindings added in this series have not been changed since
> > v4 was posted with devicetree at vger.kernel.org CCed on the 13th of March.
> > 
> > Simon Horman (2):
> >   clk: shmobile: r8a7779: Add clocks support
> >   clk: shmobile: r8a7779: Add MSTP clock support
> > 
> >  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
> >  .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  27 ++++
> >  drivers/clk/shmobile/Makefile                      |   1 +
> >  drivers/clk/shmobile/clk-r8a7779.c                 | 180 +++++++++++++++++++++
> >  include/linux/clk/shmobile.h                       |   3 +
> >  5 files changed, 212 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> >  create mode 100644 drivers/clk/shmobile/clk-r8a7779.c
> > 
> > -- 
> > 1.8.4
> > 
