From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 15 Oct 2012 15:47:43 +0300
Subject: [PATCH] ARM: nomadik: fixup some FSMC merge problems
In-Reply-To: <1349994182-26116-1-git-send-email-linus.walleij@linaro.org>
References: <1349994182-26116-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1350305263.4115.3.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-12 at 00:23 +0200, Linus Walleij wrote:
> Due to a clash between refactoring and due to loss of a header
> file that remained in my working tree the Nomadik stopped
> compiling after switching to the FSMC driver. This patch fixes
> it up.
> 
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Pushed this one to l2-mtd.git as well, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121015/8838b88e/attachment.sig>
