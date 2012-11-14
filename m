From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 14 Nov 2012 15:14:07 +0000
Subject: [PATCH v3] clk: Add support for fundamental zynq clks
In-Reply-To: <20121113235516.20034.31067@nucleus>
References: <20121113232648.GA19911@beefymiracle.amer.corp.natinst.com>
 <20121113235516.20034.31067@nucleus>
Message-ID: <e71b86f3-58fe-4785-9f9d-bbade8aa7afb@AM1EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mike Turquette [mailto:mturquette at ti.com]
> Sent: Wednesday, November 14, 2012 12:55 AM
> To: Josh Cartwright; Michal Simek
> Cc: Soren Brinkmann; Rob Herring; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; John Linn; arm at kernel.org
> Subject: Re: [PATCH v3] clk: Add support for fundamental zynq clks
> 
> Quoting Josh Cartwright (2012-11-13 15:26:48)
> > Provide simplified models for the necessary clocks on the zynq-7000
> > platform.  Currently, the PLLs, the CPU clock network, and the basic
> > peripheral clock networks (for SDIO, SMC, SPI, QSPI, UART) are modelled.
> >
> > OF bindings are also provided and documented.
> >
> > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> > ---
> > Michal-
> >
> > Here is a v3 with a fix for the problem Soren Brinkmann spotted.  Am I
> > correct that your current plan is to merge this into your tree?
> >
> > If so:
> >
> > Mike-
> >
> > Can we get your Acked-by on this one?
> >
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>

Applied.

Thanks,
Michal
