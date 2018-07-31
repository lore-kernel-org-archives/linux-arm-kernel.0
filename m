From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 31 Jul 2018 14:17:38 +0200
Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
In-Reply-To: <20180801100457.25614-1-nava.manne@xilinx.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
Message-ID: <63c5cfb5-e36b-86b7-732e-c37fe47a7fec@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1.8.2018 12:04, Nava kishore Manne wrote:
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

This should be ZynqMP.

> +
> +Required properties:
> +- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	pcap: pcap at 00 {

no reason for address if there is no any below.

> +		compatible = "xlnx,zynqmp-pcap-fpga";
> +	};
> 

Thanks,
Michal
