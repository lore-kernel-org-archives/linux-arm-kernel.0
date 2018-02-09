From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Feb 2018 17:21:38 -0600
Subject: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <1517957663-16668-2-git-send-email-jollys@xilinx.com>
References: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
 <1517957663-16668-2-git-send-email-jollys@xilinx.com>
Message-ID: <20180209232138.dviqnyqxyso6fatp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 06, 2018 at 02:54:20PM -0800, Jolly Shah wrote:
> Add documentation to describe Xilinx ZynqMP firmware driver
> bindings. Firmware driver provides an interface to firmware
> APIs. Interface APIs can be used by any driver to communicate
> to PMUFW (Platform Management Unit).
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

Reviewed-by: Rob Herring <robh@kernel.org>
