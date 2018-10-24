From: navam@xilinx.com (Nava kishore Manne)
Date: Wed, 24 Oct 2018 06:45:11 +0000
Subject: [PATCH 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
In-Reply-To: <CANk1AXQ_AFGX9_80YM7-GYncfZ8pOhaYdSb=O-ZpYCWuHx71vA@mail.gmail.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <20181020084805.29103-3-nava.manne@xilinx.com>
 <CANk1AXQ_AFGX9_80YM7-GYncfZ8pOhaYdSb=O-ZpYCWuHx71vA@mail.gmail.com>
Message-ID: <BYAPR02MB47101F176968C213EA05B5D5C2F60@BYAPR02MB4710.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

Thanks for the quick response..
Please find my response inline.

> -----Original Message-----
> From: Alan Tull [mailto:atull at kernel.org]
> Sent: Monday, October 22, 2018 11:12 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Moritz Fischer <mdf@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Michal Simek <michals@xilinx.com>;
> Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; linux-
> fpga at vger.kernel.org; open list:OPEN FIRMWARE AND FLATTENED DEVICE
> TREE BINDINGS <devicetree@vger.kernel.org>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel at lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>;
> kishore m <chinnikishore369@gmail.com>
> Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga
> driver
> 
> On Fri, Oct 19, 2018 at 3:49 AM Nava kishore Manne
> <nava.manne@xilinx.com> wrote:
> 
> Hi Nava,
> 
> Just some nits, below.
> 
> >
> > Add documentation to describe Xilinx ZynqMP fpga driver bindings.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v1:
> >                 Created a Seperate(New) DT binding file as
> >                 suggested by Rob.
> >
> > Changes for RFC-V2:
> >                 -Moved pcap node as a child to firwmare
> >                  node as suggested by Rob.
> >
> >  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt     | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > new file mode 100644
> > index 000000000000..248ff0ee60a8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > @@ -0,0 +1,17 @@
> > +---------------------------------------------------------------------
> > +-----
> 
> Please get rid of all these '----' separators (in 4 places).
> 
Will fix in the next version.

> > +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC
> > +controlled using ZynqMP SoC firmware interface
> > +---------------------------------------------------------------------
> > +----- For Bitstream configuration on ZynqMp Soc uses processor
> > +configuration
> > +port(PCAP) to configure the programmable logic(PL) through PS by
> > +using FW interface.
> > +
> > +Required properties:
> > +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> > +
> > +-------
> > +Example
> 
> Nit: please add a colon so 'Example:'
Will fix in the next version

Regards,
Navakishore.
