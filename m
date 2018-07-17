From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 17 Jul 2018 16:24:50 +0200
Subject: [PATCH v3 0/6] arm: dts: zynq: improvements and cleanup
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Message-ID: <c4ad9790-c7f6-03e1-84e6-e08782cf332b@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.7.2018 06:10, Luis Araneda wrote:
> This series attempts to standardize device naming and improve
> its information for better identification
> 
> The values of the "compatible" and "model" device-tree properties
> are corrected for some devices, adding complementary information
> when necessary
> 
> Changes since v2:
> - Split dt-bindings patch (too many changes)
> - Apply dts patches first (reorder)
> 
> Changes since v1 (RFC):
> - Add values to compatible property instead of replacing them
> - Don't remove "internal" word from Xilinx boards on dt-bindings
> - Migrate content of adapteva dt-binding file into Xilinx's
> - Sort additional compatible strings alphabetically
>   by manufacturer
> - Dropped patch that renamed the zedboard development board
>   (no apparent benefit)
> - Dropped the patch that removed the "zynq" value from the
>   compatible strings (breaks the ABI)
> 
> Luis Araneda (6):
>   arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
>     boards
>   arm: dts: zynq: correct and improve the model property of dt files
>   dt-bindings: xilinx: zynq: Improve boards description
>   dt-bindings: xilinx: zynq: Sort entries alphabetically
>   dt-bindings: Move Paralella board to Xilinx
>   dt-bindings: xilinx: zynq: Add missing boards
> 
>  .../devicetree/bindings/arm/adapteva.txt      |  7 -----
>  .../devicetree/bindings/arm/xilinx.txt        | 30 +++++++++++++++----
>  arch/arm/boot/dts/zynq-cc108.dts              |  2 +-
>  arch/arm/boot/dts/zynq-microzed.dts           |  4 +--
>  arch/arm/boot/dts/zynq-parallella.dts         |  2 +-
>  arch/arm/boot/dts/zynq-zc702.dts              |  2 +-
>  arch/arm/boot/dts/zynq-zc706.dts              |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm010.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm011.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm012.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm013.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zed.dts                |  4 +--
>  arch/arm/boot/dts/zynq-zybo-z7.dts            |  2 +-
>  arch/arm/boot/dts/zynq-zybo.dts               |  2 +-
>  14 files changed, 39 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
> 

Applied all.

Thanks,
Michal
