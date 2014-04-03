From: monstr@monstr.eu (Michal Simek)
Date: Thu, 03 Apr 2014 15:56:49 +0200
Subject: [PATCH RFC 3/3] nand: pl353: Add driver for arm pl353 smc nand
 interface
In-Reply-To: <04cb5d02-db4c-4a4c-ba3c-3a5958e42324@VA3EHSMHS036.ehs.local>
References: <1395944467-26291-1-git-send-email-punnaia@xilinx.com>
 <04cb5d02-db4c-4a4c-ba3c-3a5958e42324@VA3EHSMHS036.ehs.local>
Message-ID: <533D68A1.6070102@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On 03/27/2014 07:21 PM, Punnaiah Choudary Kalluri wrote:
> Add driver for arm pl353 static memory controller nand interface.
> This controller is used in xilinx zynq soc for interfacing the nand
> flash memory.
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> ---
>  drivers/mtd/nand/Kconfig      |    8 +
>  drivers/mtd/nand/Makefile     |    1 +
>  drivers/mtd/nand/pl353_nand.c | 1122 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1131 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mtd/nand/pl353_nand.c

Any comment regarding this nand driver?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/0231a62c/attachment.sig>
