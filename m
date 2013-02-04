From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 04 Feb 2013 09:07:41 +0200
Subject: [PATCH 05/11 v2] ARM: nomadik: add FSMC NAND
In-Reply-To: <1358607204-24264-1-git-send-email-linus.walleij@linaro.org>
References: <1358607204-24264-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1359961661.13791.5.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-01-19 at 15:53 +0100, Linus Walleij wrote:
> This adds the FSMC NAND driver and flash partitions to the Nomadik
> device tree.
> 
> The only compatible string accepted by this driver is currently
> "st,spear600-fsmc-nand" which is inappropriate for this system, so
> this patch adds the compatible value "stericsson,fsmc-nand" as
> well.
> 
> Cc: linux-mtd at vger.kernel.org
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I'm requesting an ACK from the MTD maintainers to be able to apply
> this patch through the ARM SoC tree.

Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/d87f0656/attachment.sig>
