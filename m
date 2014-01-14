From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 14:10:10 +0000
Subject: [PATCH] ARM: S3C[24|64]xx: move includes back under <mach/> scope
In-Reply-To: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
References: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140114141010.GK15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 02:53:38PM +0100, Linus Walleij wrote:
> When refactoring and breaking out the includes for the
> machine-specific GPIO configuration, two files were created
> in <linux/platform_data/gpio-samsung-s3c[24|64]xx.h>, but as
> that namespace shall be used for defining data exchanged
> between machines and drivers, using it for these broad macros
> and config settings is wrong.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/cb346089/attachment.sig>
