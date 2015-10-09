From: joshc@ni.com (Josh Cartwright)
Date: Fri, 9 Oct 2015 11:04:23 -0500
Subject: [PATCH 1/3] doc: dt: fpga: Added Documentation for Xilinx Zynq
 FPGA manager.
In-Reply-To: <1444344307-22509-2-git-send-email-moritz.fischer@ettus.com>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20151009160423.GL10631@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 12:45:05AM +0200, Moritz Fischer wrote:
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  .../bindings/fpga/xilinx-zynq-fpga-mgr.txt         | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
> new file mode 100644
> index 0000000..82ffda8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
> @@ -0,0 +1,26 @@
> +Xilinx Zynq FPGA Manager
> +
> +Required properties:
> +- compatible:		should contain "xlnx,zynq-devcfg-1.0"
> +- reg:			base address and size for memory mapped io
> +- interrupt parent:	interrupt source phandle

I think you mean 'interrupt-parent', with the hyphen.

Actually, this isn't really a 'required' property of this node, as it
could be specified in a parent node.

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151009/2a9e3420/attachment.sig>
