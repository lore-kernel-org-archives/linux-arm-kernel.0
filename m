From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 11 Oct 2012 14:07:12 +0300
Subject: [PATCH 1/2] ARM: nomadik: switch over to using the FSMC driver
In-Reply-To: <1349335709-13399-1-git-send-email-linus.walleij@linaro.org>
References: <1349335709-13399-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1349953632.12014.8.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-04 at 09:28 +0200, Linus Walleij wrote:
> The Nomadik NAND driver is really just a subset of the existing
> FSMC driver, so let's switch over to using that driver instead,
> since it handles more variants of this chip. The callbacks for
> setting up the chip is doing stuff now handled by the FSMC
> driver.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Pushed both to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121011/fdb275c4/attachment-0001.sig>
