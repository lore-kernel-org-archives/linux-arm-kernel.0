From: monstr@monstr.eu (Michal Simek)
Date: Mon, 21 Aug 2017 14:14:54 +0200
Subject: [GIT PULL] ARM64: Xilinx ZynqMP DT fixes for v4.14
Message-ID: <36ea049b-a57f-78e5-440f-ab6cdf1df1f7@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these patches to your tree.

Thanks,
Michal

> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
> 
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.14
> 
> for you to fetch changes up to 0bb6f25a6ee5ff0826d2e620cbb78b1579c3d2ee:
> 
>   arm64: zynqmp: Add generic compatible string for I2C EEPROM (2017-08-21 14:07:37 +0200)
> 
> ----------------------------------------------------------------
> arm: Xilinx ZynqMP DT fixes for v4.14
> 
> - Fix DTC warnings
> - Add idle states, OP, cci-400, RTC, pcie prefetchable memory
>   fpd/lpd dmas, clocks for ep108
> - Enable can1
> - Fix smmu IRQ, aliases, uart compatible string
> - Use generic compatible string for i2c eeprom
> 
> ----------------------------------------------------------------
> Alistair Francis (1):
>       arm64: zynqmp: Use C pre-processor for includes
> 
> Bharat Kumar Gogada (1):
>       arm64: zynqmp: Adding prefetchable memory space to pcie node
> 
> Edgar E. Iglesias (1):
>       arm64: zynqmp: Correct IRQ nr for the SMMU
> 
> Javier Martinez Canillas (1):
>       arm64: zynqmp: Add generic compatible string for I2C EEPROM
> 
> Michal Simek (9):
>       arm64: zynqmp: Remove leading 0s from mtd table for spi flashes
>       arm64: zynqmp: Move nodes which have no reg property out of bus
>       arm64: zynqmp: Add references to cpu nodes
>       arm64: zynqmp: Add dcc console for zynqmp
>       arm64: zynqmp: Add CCI-400 node
>       arm64: zynqmp: Add support for RTC
>       arm64: zynqmp: Add new uartps compatible string
>       arm64: zynqmp: Add fpd/lpd dmas
>       arm64: zynqmp: Add missing mmc aliases in ep108
> 
> Naga Sureshkumar Relli (2):
>       arm64: zynqmp: Set status disabled in dtsi
>       arm64: zynqmp: Enable can1 for ep108
> 
> Rob Herring (1):
>       arm64: dts: xilinx: fix PCI bus dtc warnings
> 
> Shubhrajyoti Datta (1):
>       arm64: zynqmp: Add operating points
> 
> Stefan Krsmanovic (1):
>       arm64: zynqmp: Add idle state for ZynqMP
> 
> VNSL Durga (1):
>       arm64: zynqmp: Added clocks to DT for ep108
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi |  50 +++++++++++++++++++++++++++-
>  arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts      |  18 +++++++----
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi           | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
>  3 files changed, 321 insertions(+), 24 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/51ffcab6/attachment.sig>
