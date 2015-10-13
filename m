From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 13 Oct 2015 16:16:19 -0500
Subject: [PATCH v2] ARM: socfpga: dts: add fpga manager
In-Reply-To: <20151013203344.GE17155@pengutronix.de>
References: <1444765139-2040-1-git-send-email-atull@opensource.altera.com>
 <alpine.DEB.2.02.1510131450480.4441@linux-builds1>
 <20151013203344.GE17155@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1510131615350.4441@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Oct 2015, Steffen Trumtrar wrote:

> On Tue, Oct 13, 2015 at 02:51:28PM -0500, Dinh Nguyen wrote:
> > On Tue, 13 Oct 2015, atull at opensource.altera.com wrote:
> > 
> > > From: Alan Tull <atull@opensource.altera.com>
> > > 
> > > Add FPGA manager to device tree for SoCFPGA.
> > > 
> > > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > > ---
> > > v2: Remove 0x after @
> > >     No caps in hex numbers
> > >     renamed hps_0_fpgamgr to fpgamgr0
> > >     move node to be in alpha order by node name
> > > ---
> > >  arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > 
> > Applied!
> 
> What about the
> 
> "Also, you need to document the "altr,socfpga-fpga-mgr"."
> 
> you mentioned in v1 ???
>

It was my oversight. It has already been documented. 

BR,
Dinh
