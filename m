From: joshc@ni.com (Josh Cartwright)
Date: Sun, 18 Oct 2015 12:51:20 -0500
Subject: [PATCHv2 1/3] ARM: dt: fpga: Added binding docs for Xilinx Zynq
 FPGA manager.
In-Reply-To: <1445035350-3569-2-git-send-email-moritz.fischer@ettus.com>
References: <1445035350-3569-1-git-send-email-moritz.fischer@ettus.com>
 <1445035350-3569-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20151018175120.GG12756@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 03:42:28PM -0700, Moritz Fischer wrote:
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
> 
> v2:
>  - Clock names are now a required property
>  - Removed interrupt-parent property
> 
> ---
>  .../devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
> new file mode 100644
> index 0000000..7018aa8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
> @@ -0,0 +1,19 @@
> +Xilinx Zynq FPGA Manager
> +
> +Required properties:
> +- compatible:		should contain "xlnx,zynq-devcfg-1.0"
> +- reg:			base address and size for memory mapped io
> +- interrupts:		interrupt for the FPGA manager device
> +- clocks:		phandle for clocks required operation

Technically a "clock specifier", but other than that:

Reviewed-by: Josh Cartwright <joshc@ni.com>

  Josh
