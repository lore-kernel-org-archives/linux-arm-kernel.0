From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 27 Jun 2012 16:25:08 +0300
Subject: [PATCH] Atmel NAND ECC: Remove unaffected config option
In-Reply-To: <1340371768-24703-1-git-send-email-richard.genoud@gmail.com>
References: <1340371768-24703-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1340803508.3070.6.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-06-22 at 15:29 +0200, Richard Genoud wrote:
> The commit bf4289cba02b8cf770ecd7959ca70839f0dd9d3c removed the use of
> CONFIG_MTD_NAND_ATMEL_ECC_NONE and CONFIG_MTD_NAND_ATMEL_ECC_HW but the
> Kconfig file was forgotten.
> 
> This patch remove those inoperative options.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  arch/arm/configs/afeb9260_defconfig    |    1 -
>  arch/arm/configs/at91sam9263_defconfig |    1 -
>  arch/arm/configs/qil-a9260_defconfig   |    1 -
>  arch/arm/configs/usb-a9260_defconfig   |    1 -

I've dropped these changes.

>  drivers/mtd/nand/Kconfig               |   40 --------------------------------

And pushed Kconfig changes to l2-mtd.git, thank you!

http://git.infradead.org/users/dedekind/l2-mtd.git/commit/61251f029c8d1168370db922a22ac4d0d7df3b8b
-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/58b9e117/attachment.sig>
