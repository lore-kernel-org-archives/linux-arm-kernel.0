From: monstr@monstr.eu (Michal Simek)
Date: Wed, 17 Jan 2018 16:50:49 +0100
Subject: [PATCH 0/6] arm64: zynqmp: Various dts cleanups
In-Reply-To: <cover.1516202975.git.michal.simek@xilinx.com>
References: <cover.1516202975.git.michal.simek@xilinx.com>
Message-ID: <c5acb769-a72b-fef3-d67e-5ca522353b4a@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17.1.2018 16:29, Michal Simek wrote:
> this patchset is adding minor dt pieces for ep108.
> Also adding SPDX headers, fixing minor coding style issue and extending
> gem compatible string for all boards.
> The next patchset will add much more zynqmp based board.
> 
> Thanks,
> Michal
> 
> 
> 
> Anurag Kumar Vulisha (1):
>   arm64: zynqmp: Added OOB timing settings in zynqmp-ep108.dts
> 
> Michal Simek (4):
>   arm64: zynqmp: Use zynqmp specific compatible string for macb
>   arm64: zynqmp: Fix alignment in dts files
>   arm64: zynqmp: Add SPDX license identifier
>   arm64: zynqmp: Add missing aliases for ep108
> 
> P L Sai Krishna (1):
>   arm64: zynqmp: Add 8-bit bus width property for ep108
> 
>  arch/arm64/boot/dts/xilinx/Makefile              |  1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi |  1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts      | 18 +++++++++++++++++-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi           | 17 +++++++++--------
>  4 files changed, 28 insertions(+), 9 deletions(-)
> 

subject wasn't propagated properly that's why I am fixing it now. But
patches should be fine.

Thanks,
Michal


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180117/8047554d/attachment-0001.sig>
