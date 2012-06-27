From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 27 Jun 2012 06:45:32 +0300
Subject: [PATCH v11 0/4] MTD: at91: Add PMECC support for at91 nand
 flash driver
In-Reply-To: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1340768732.2317.3.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-25 at 18:07 +0800, Josh Wu wrote:
> Those patches is based on v3.5-rc4
> 
> Changes since v10,
> 	add one more patch in this patch set, which add 'int' return value for write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
> 	Instead of calling BUG(), atmel_nand_pmecc_write_page() will return -EIO when time out to read the pmecc status register.
> 	increase the time-out duration to 100ms, which has more toleration.
> 	add oob_required argument for pmecc read/write functions to align with v3.5-rc4.

Please, send patches against the l2-mtd.git tree, not against the
upstream tree.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/14eecfca/attachment-0001.sig>
