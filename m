From: navam@xilinx.com (Nava kishore Manne)
Date: Fri, 19 Oct 2018 09:20:58 +0000
Subject: [PATCH 3/3] reset: reset-zynqmp: Adding support for Xilinx zynqmp
 reset controller.
In-Reply-To: <1539939793.3395.2.camel@pengutronix.de>
References: <20181020084107.28251-1-nava.manne@xilinx.com>
 <20181020084107.28251-4-nava.manne@xilinx.com>
 <1539939793.3395.2.camel@pengutronix.de>
Message-ID: <BYAPR02MB47108BCDC1AF5454F2DDF328C2F90@BYAPR02MB4710.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp

Thanks for the quicks response....

> -----Original Message-----
> From: Philipp Zabel [mailto:p.zabel at pengutronix.de]
> Sent: Friday, October 19, 2018 2:33 PM
> To: Nava kishore Manne <navam@xilinx.com>; robh+dt at kernel.org;
> mark.rutland at arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; chinnikishore369 at gmail.com
> Subject: Re: [PATCH 3/3] reset: reset-zynqmp: Adding support for Xilinx
> zynqmp reset controller.
> 
> Hi Nava,
> 
> On Sat, 2018-10-20 at 14:11 +0530, Nava kishore Manne wrote:
> > Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> > The zynqmp reset-controller has the ability to reset lines connected
> > to different blocks and peripheral in the Soc.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v1:
> > 		-None.
> 
> I had comments on RFC v3 that are not addressed yet, see below.
> 

Sorry, I have missed your comments . Will fix in the next version.

Regards,
Navakishore.
