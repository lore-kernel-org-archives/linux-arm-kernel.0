From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Mar 2018 12:06:58 -0600
Subject: [PATCH v2 7/8] arm64: zynqmp: Add support for Xilinx zc12XX boards
In-Reply-To: <10883c083dfe48fe5349292f78e47143d87c0a15.1519396753.git.michal.simek@xilinx.com>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <10883c083dfe48fe5349292f78e47143d87c0a15.1519396753.git.michal.simek@xilinx.com>
Message-ID: <20180302180658.26qjuqeiucvam4yk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 03:40:29PM +0100, Michal Simek wrote:
> These 3 boards requires minimal support to get Linux up and running.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt  |  9 ++++
>  arch/arm64/boot/dts/xilinx/Makefile               |  3 ++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts | 54 +++++++++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts | 42 ++++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts | 42 ++++++++++++++++++
>  5 files changed, 150 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts

Reviewed-by: Rob Herring <robh@kernel.org>
