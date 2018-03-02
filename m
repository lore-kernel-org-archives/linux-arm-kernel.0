From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Mar 2018 12:51:45 -0600
Subject: [PATCH v2 4/5] arm: zynq: Add support for Xilinx zc770 xm012 dc3
 board
In-Reply-To: <05bf43a5ecf7d31af17d6e3d9b89ae75f112c9f5.1519398009.git.michal.simek@xilinx.com>
References: <cover.1519398009.git.michal.simek@xilinx.com>
 <05bf43a5ecf7d31af17d6e3d9b89ae75f112c9f5.1519398009.git.michal.simek@xilinx.com>
Message-ID: <20180302185144.zslujqf53umsyryb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 04:00:22PM +0100, Michal Simek wrote:
> zc770 is based board which is extended by FMC/DC cards for SoC
> validation. FMCs/DCs are supposed to cover all SoC configurations.
> FMC/DC contains can, 2x i2c, nor flash, spi and uart.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt |  1 +
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/zynq-zc770-xm012.dts           | 64 ++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-zc770-xm012.dts

Reviewed-by: Rob Herring <robh@kernel.org>
