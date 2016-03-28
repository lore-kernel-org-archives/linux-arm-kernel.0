From: robh@kernel.org (Rob Herring)
Date: Mon, 28 Mar 2016 16:10:15 -0500
Subject: [PATCH V2] ARM: dts: AM572x-IDK Initial Support
In-Reply-To: <1459182909-23502-1-git-send-email-nm@ti.com>
References: <1459182909-23502-1-git-send-email-nm@ti.com>
Message-ID: <20160328211015.GA28249@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 11:35:09AM -0500, Nishanth Menon wrote:
> From: Schuyler Patton <spatton@ti.com>
> 
> The AM572x-IDK board is a board based on TI's AM5728 SOC
> which has a dual core 1.5GHz A15 processor. This board is a
> development platform for the Industrial market with:
> - 2GB of DDR3L
> - Dual 1Gbps Ethernet
> - HDMI,
> - PRU-ICSS
> - uSD
> - 16GB eMMC
> - CAN
> - RS-485
> - PCIe
> - USB3.0
> - Video Input Port
> - Industrial IO port and expansion connector
> 
> The link to the data sheet and TRM can be found here:
> 
> http://www.ti.com/product/AM5728
> 
> This patch creates a common dtsi file that will provide a common board
> dtsi file to define the nodes that are common to AM57xx (including the
> upcoming AM5718) IDK boards.
> 
> Initial support is only for basic peripherals
> 
> Signed-off-by: Schuyler Patton <spatton@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> based on v4.6-rc1
> 
> Changes since V1:
> 	- Renamed the led nodes
> 	- Dropped unused src_clk_x1 node (will introduce when needed).
> 
> Test: http://pastebin.ubuntu.com/15540747/
> 
> V1: https://patchwork.kernel.org/patch/8665181/
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am572x-idk.dts                   |  85 ++++++
>  arch/arm/boot/dts/am57xx-idk-common.dtsi           | 302 +++++++++++++++++++++
>  4 files changed, 391 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am572x-idk.dts
>  create mode 100644 arch/arm/boot/dts/am57xx-idk-common.dtsi

Acked-by: Rob Herring <robh@kernel.org>
