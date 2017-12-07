From: robh@kernel.org (Rob Herring)
Date: Thu, 7 Dec 2017 16:14:17 -0600
Subject: [RFC v2 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <1512368735-27147-3-git-send-email-jliang@xilinx.com>
References: <1512368735-27147-1-git-send-email-jliang@xilinx.com>
 <1512368735-27147-3-git-send-email-jliang@xilinx.com>
Message-ID: <20171207221417.yfejyl37kecv7mxc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 03, 2017 at 10:25:35PM -0800, Wendy Liang wrote:
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.
> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt

Reviewed-by: Rob Herring <robh@kernel.org>
