From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 14:34:11 -0600
Subject: [PATCH v3 2/5] arm: zynq: Add support for Xilinx zc770 xm010 dc1
 board
In-Reply-To: <44eba6a11ccc653a07b8c44640cecb78e711a2be.1520018484.git.michal.simek@xilinx.com>
References: <cover.1520018484.git.michal.simek@xilinx.com>
 <44eba6a11ccc653a07b8c44640cecb78e711a2be.1520018484.git.michal.simek@xilinx.com>
Message-ID: <20180307203411.63wvldylpwt6o54o@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 08:21:34PM +0100, Michal Simek wrote:
> zc770 is based board which is extended by FMC/DC cards for SoC
> validation. FMCs/DCs are supposed to cover all SoC configurations.
> FMC/DC contains ethernet port, can, i2c, sd, qspi, spi, uart and usb.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3:
> - Fix partition for flash
> 
> Changes in v2:
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt |  3 +
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/zynq-zc770-xm010.dts           | 95 ++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 arch/arm/boot/dts/zynq-zc770-xm010.dts

Reviewed-by: Rob Herring <robh@kernel.org>
