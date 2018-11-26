From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 14:05:49 -0600
Subject: [PATCH v6 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
In-Reply-To: <1542662761-31158-3-git-send-email-wendy.liang@xilinx.com>
References: <1542662761-31158-1-git-send-email-wendy.liang@xilinx.com>
 <1542662761-31158-3-git-send-email-wendy.liang@xilinx.com>
Message-ID: <20181126200549.GA611@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2018 13:26:01 -0800, Wendy Liang wrote:
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.
> 
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 +++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
