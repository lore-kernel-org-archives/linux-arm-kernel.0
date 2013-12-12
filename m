From: monstr@monstr.eu (Michal Simek)
Date: Thu, 12 Dec 2013 09:48:56 +0100
Subject: [PATCH] ARM: zynq: add gem support
In-Reply-To: <1386782989-2720-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1386782989-2720-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <52A97878.7050503@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 06:29 PM, Soren Brinkmann wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> The zynq includes a Cadence GEM IP core. This is compatible with the macb driver.
> Add it to the zynq-7000 DT.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Josh Cartwright <josh.cartwright@ni.com>
> [soren: rebased to current Linus tree, added zc706 + zed support, moved phy-mode property to board level dtses]
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> This has a soft dependency on the net-next tree which has some patches for the
> macb driver which are required for full functionality. But adding this patch to
> any tree without net-next shouldn't do any harm, network might be
> non-operational at the worst - I think.
> 
> 	S?ren
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 18 ++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts |  5 +++++
>  arch/arm/boot/dts/zynq-zc706.dts |  5 +++++
>  arch/arm/boot/dts/zynq-zed.dts   |  5 +++++
>  4 files changed, 33 insertions(+)

Applied to zynq/dt branch.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/e6b01d6e/attachment.sig>
