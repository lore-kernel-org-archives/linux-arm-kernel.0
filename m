From: navam@xilinx.com (Nava kishore Manne)
Date: Tue, 31 Jul 2018 13:12:32 +0000
Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
In-Reply-To: <63c5cfb5-e36b-86b7-732e-c37fe47a7fec@xilinx.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
 <63c5cfb5-e36b-86b7-732e-c37fe47a7fec@xilinx.com>
Message-ID: <MWHPR0201MB34814FE28937F4A6F3540C72C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the quick response..

Please see my comments inline....

> -----Original Message-----
> From: Michal Simek [mailto:michal.simek at xilinx.com]
> Sent: Tuesday, July 31, 2018 5:48 PM
> To: Nava kishore Manne <navam@xilinx.com>; robh+dt at kernel.org;
> mark.rutland at arm.com; Michal Simek <michals@xilinx.com>; Soren Brinkmann
> <sorenb@xilinx.com>; atull at opensource.altera.com;
> moritz.fischer at ettus.com; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; chinnikishore369 at gmail.com
> Cc: Nava kishore Manne <navam@xilinx.com>
> Subject: Re: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
> zynqmp FPGA manager
> 
> On 1.8.2018 12:04, Nava kishore Manne wrote:
> > New bindings document for zynqmp fpga manager.
> >
> > Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > ---
> >  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-
> pcap-fpga.txt
> >
> > diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-
> fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-
> fpga.txt
> > new file mode 100644
> > index 000000000000..0eac747747f5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > @@ -0,0 +1,9 @@
> > +Xilinx Zynqmp FPGA Manager
> 
> This should be ZynqMP.
> 
Will fix in the next version..

> > +
> > +Required properties:
> > +- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
> > +
> > +Example:
> > +	pcap: pcap at 00 {
> 
> no reason for address if there is no any below.
> 
 Will fix in the next version....

Regards,
Navakishore.
