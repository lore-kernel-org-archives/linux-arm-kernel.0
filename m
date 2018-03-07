From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 14:31:31 -0600
Subject: [PATCH v3 4/8] arm64: zynqmp: Add support for Xilinx zcu104-revA
In-Reply-To: <409e614b762bd6da24bc26364fcf28c805986eaf.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
 <409e614b762bd6da24bc26364fcf28c805986eaf.1520017397.git.michal.simek@xilinx.com>
Message-ID: <20180307203131.vubpjgh6jootrkyc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 08:04:30PM +0100, Michal Simek wrote:
> Xilinx zcu104 is another customer board. It is sort of zcu102 clone
> with some differences.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3:
> - Use i2c-mux instead of i2cswitch - was done with zcu106
> - Remove gpio and usb aliases
> 
> Changes in v2:
> - Remove i2c mw u-boot commands
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt  |   3 +
>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 195 ++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts

Reviewed-by: Rob Herring <robh@kernel.org>
