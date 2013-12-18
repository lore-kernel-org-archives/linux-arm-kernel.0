From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 12:46:35 +0000
Subject: [PATCH 2/2 v2] ARM: s3c64xx: get rid of custom <mach/gpio.h>
In-Reply-To: <1386939234-12828-1-git-send-email-linus.walleij@linaro.org>
References: <1386939234-12828-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131218124635.GN28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 01:53:54PM +0100, Linus Walleij wrote:
> This isolates the custom S3C64xx GPIO definition table to
> <linux/platform_data/gpio-samsung-s3x64xx.h> as this is
> used in a few different places in the kernel, removing the
> need to depend on the implicit inclusion of <mach/gpio.h>
> from <linux/gpio.h> and thus getting rid of a few nasty
> cross-dependencies.

Tested-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/4252177e/attachment.sig>
