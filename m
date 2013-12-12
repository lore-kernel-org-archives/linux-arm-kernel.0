From: monstr@monstr.eu (Michal Simek)
Date: Thu, 12 Dec 2013 09:53:13 +0100
Subject: [PATCH v2 1/9] arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
In-Reply-To: <1385514296-26702-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <52A97979.1030205@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2013 02:04 AM, Soren Brinkmann wrote:
> The bindings for the TTC changed in commit 'arm: zynq: Use standard
> timer binding' (e932900a3279b5dbb6d8f43c7b369003620e137c). That change
> removed possible subnodes from this driver rendering the 'clock-ranges'
> property invalid for this node.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 2 --
>  1 file changed, 2 deletions(-)

I think this is completely unrelated to cpufreq and should just go
directly via arm-soc tree.
If yes, I will add 1/9 and 2/9 to zynq/dt branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/10c9cf34/attachment.sig>
