From: jliang@xilinx.com (Jiaying Liang)
Date: Fri, 5 Jan 2018 22:15:02 +0000
Subject: [PATCH v3 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <20180105153146.lgxlhfsql5tq2kn5@rob-hp-laptop>
References: <1515109891-17133-1-git-send-email-jliang@xilinx.com>
 <1515109891-17133-3-git-send-email-jliang@xilinx.com>
 <20180105153146.lgxlhfsql5tq2kn5@rob-hp-laptop>
Message-ID: <BY1PR0201MB0885D19DEBB9AAF572DEE9A7B01C0@BY1PR0201MB0885.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Friday, January 05, 2018 7:32 AM
> To: Jiaying Liang <jliang@xilinx.com>
> Cc: jassisinghbrar at gmail.com; michal.simek at xilinx.com;
> mark.rutland at arm.com; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; Jiaying Liang
> <jliang@xilinx.com>
> Subject: Re: [PATCH v3 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
> 
> On Thu, Jan 04, 2018 at 03:51:31PM -0800, Wendy Liang wrote:
> > Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block in
> > ZynqMP SoC used for the communication between various processor
> > systems.
> >
> > Signed-off-by: Wendy Liang <jliang@xilinx.com>
> > ---
> >  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 104
> +++++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> 
> Please add acks and reviewed-by's when posting new versions.
[Wendy] Thanks, will add this in the next version.
