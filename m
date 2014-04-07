From: monstr@monstr.eu (Michal Simek)
Date: Mon, 07 Apr 2014 07:47:56 +0200
Subject: [PATCH v5 3/3] ARM: zynq: dt: Add I2C nodes to Zynq device tree
In-Reply-To: <1396646876-27336-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1396646876-27336-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396646876-27336-3-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <53423C0C.6050308@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 11:27 PM, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v5:
>  - use lower case hex digits in 'reg' property
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
>  - replace 'pmbus' with 'ti' in compatibility strings of UCD devices
> 
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 22 ++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts | 76 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 68 +++++++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+)

Applied to zynq-dt branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/9b3cf52a/attachment.sig>
