From: monstr@monstr.eu (Michal Simek)
Date: Mon, 07 Apr 2014 07:46:30 +0200
Subject: [PATCH v2 1/5] ARM: zynq: DT: Add 'clock-latency' property
In-Reply-To: <1396653256-28397-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396653256-28397-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <53423BB6.7010508@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2014 01:14 AM, Soren Brinkmann wrote:
> Specify the 'clock-latency' property to avoid certain cpufreq governors
> from refusing to work with the following error:
>   ondemand governor failed, too long transition latency of HW, fallback to performance governor
> 
> Reported-by: Mike Looijmans <mike.looijmans@topic.nl>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Tested-by: Mike Looijmans <mike.looijmans@topic.nl>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> This is a fix from our vendor tree
> 
> Changes in v2:
>  - This patch has been added
> 
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to zynq-dt.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/c727c966/attachment.sig>
