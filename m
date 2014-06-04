From: monstr@monstr.eu (Michal Simek)
Date: Wed, 04 Jun 2014 07:17:39 +0200
Subject: [PATCH v2 0/3] mmc: Add APM X-Gene SoC SDHC controller support
 to Arasan SDHCI driver
In-Reply-To: <1401829985-5212-1-git-send-email-lho@apm.com>
References: <1401829985-5212-1-git-send-email-lho@apm.com>
Message-ID: <538EABF3.7030809@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2014 11:13 PM, Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC SDHC controller to Arasan
> SDHCI driver.
> 
> v2:
> * Update binding documentation
> * Change compatible string from "xgene,arasan" to "apm,arasan"

Please write these changes directly to the patch version.
Hard to guess what you have changed in every patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/d87d43c2/attachment.sig>
