From: navam@xilinx.com (Nava kishore Manne)
Date: Tue, 31 Jul 2018 13:07:55 +0000
Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
In-Reply-To: <20180801100457.25614-1-nava.manne@xilinx.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
Message-ID: <MWHPR0201MB34813A97EC92F8DC6E3F9CA6C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Alan Tull

> -----Original Message-----
> From: Nava kishore Manne [mailto:nava.manne at xilinx.com]
> Sent: Wednesday, August 1, 2018 3:35 PM
> To: robh+dt at kernel.org; mark.rutland at arm.com; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> atull at opensource.altera.com; moritz.fischer at ettus.com; Nava kishore Manne
> <navam@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; chinnikishore369 at gmail.com
> Cc: Nava kishore Manne <navam@xilinx.com>
> Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx zynqmp
> FPGA manager
> 
> New bindings document for zynqmp fpga manager.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-
> pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-
> fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-
> fpga.txt
> new file mode 100644
> index 000000000000..0eac747747f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,9 @@
> +Xilinx Zynqmp FPGA Manager
> +
> +Required properties:
> +- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	pcap: pcap at 00 {
> +		compatible = "xlnx,zynqmp-pcap-fpga";
> +	};
> --
> 2.18.0
