From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 10:15:01 -0500
Subject: [PATCH v6 01/11] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <1523389127-14243-2-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-2-git-send-email-jollys@xilinx.com>
Message-ID: <20180413151501.gvroqgbmwwyfy5pq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 12:38:37PM -0700, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP firmware driver
> bindings. Firmware driver provides an interface to firmware
> APIs. Interface APIs can be used by any driver to communicate
> to PMUFW (Platform Management Unit).
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

Please add acks/reviewed-by's when posting new versions.

Rob
