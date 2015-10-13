From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 13 Oct 2015 22:33:44 +0200
Subject: [PATCH v2] ARM: socfpga: dts: add fpga manager
In-Reply-To: <alpine.DEB.2.02.1510131450480.4441@linux-builds1>
References: <1444765139-2040-1-git-send-email-atull@opensource.altera.com>
 <alpine.DEB.2.02.1510131450480.4441@linux-builds1>
Message-ID: <20151013203344.GE17155@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 02:51:28PM -0500, Dinh Nguyen wrote:
> On Tue, 13 Oct 2015, atull at opensource.altera.com wrote:
> 
> > From: Alan Tull <atull@opensource.altera.com>
> > 
> > Add FPGA manager to device tree for SoCFPGA.
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > ---
> > v2: Remove 0x after @
> >     No caps in hex numbers
> >     renamed hps_0_fpgamgr to fpgamgr0
> >     move node to be in alpha order by node name
> > ---
> >  arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> 
> Applied!

What about the

"Also, you need to document the "altr,socfpga-fpga-mgr"."

you mentioned in v1 ???

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
