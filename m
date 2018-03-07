From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 14:33:01 -0600
Subject: [PATCH v3 8/8] arm64: zynqmp: Add support for Xilinx zc1751
In-Reply-To: <9f84bb43ee3e57b1635250a59e7b588831374649.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
 <9f84bb43ee3e57b1635250a59e7b588831374649.1520017397.git.michal.simek@xilinx.com>
Message-ID: <20180307203301.kufwtfsnxtks2gps@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 08:04:34PM +0100, Michal Simek wrote:
> Xilinx zc1751 boards is used for silicon validation. Board can be
> extended with 5 FMCs/DCs cards to connect various IPs. Describe all
> these combinations.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3:
> - Remove aliases for can, usb, gpio
> - dc2 fix spi_flashes and partitions
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt   |   3 +
>  arch/arm64/boot/dts/xilinx/Makefile                |   5 +
>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    | 131 +++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 168 +++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 150 +++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    | 178 +++++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    | 125 +++++++++++++++
>  7 files changed, 760 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts

Reviewed-by: Rob Herring <robh@kernel.org>
