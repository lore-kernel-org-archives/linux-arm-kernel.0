From: robh@kernel.org (Rob Herring)
Date: Tue, 14 Aug 2018 10:19:17 -0600
Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
In-Reply-To: <20180801100457.25614-1-nava.manne@xilinx.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
Message-ID: <20180814161917.GA26926@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 03:34:56PM +0530, Nava kishore Manne wrote:
> New bindings document for zynqmp fpga manager.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
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

How is this accessed? Via firmware interface? If so, need to define it 
is a child of the firmware node.

> +	};
> -- 
> 2.18.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
