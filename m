From: monstr@monstr.eu (Michal Simek)
Date: Mon, 02 Dec 2013 20:45:48 +0100
Subject: [PATCH v3 2/2] arm: dt: zynq: Add SDHCI nodes
In-Reply-To: <1386007357-11956-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1386007357-11956-1-git-send-email-soren.brinkmann@xilinx.com>
 <1386007357-11956-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <529CE36C.4020707@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 07:02 PM, Soren Brinkmann wrote:
> Add nodes for the Arasan SDHCI controller to Zynq dts files.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v2:
>  - update compatibilty string according to changes in 1/2 (append
>    '-8.9a' IP version string)
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts |  4 ++++
>  arch/arm/boot/dts/zynq-zc706.dts |  4 ++++
>  arch/arm/boot/dts/zynq-zed.dts   |  4 ++++
>  4 files changed, 32 insertions(+)

Chris: It is up to you if you want to take this through your tree
or just let me to take it through my tree. It is adding new nodes
to DTS file that's why it shouldn't be any problem to apply it
separately.

Anyway please let me know what you think.
If you want to add it to your tree here is my

Acked-by: Michal Simek <monstr@monstr.eu>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/0b4a24fe/attachment-0001.sig>
