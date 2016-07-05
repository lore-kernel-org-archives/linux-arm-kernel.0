From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jul 2016 15:43:48 +0200
Subject: [PATCH 02/11] ARM: ux500: move ab8500_regulator_plat_data into
 driver
In-Reply-To: <1467722710-1577-2-git-send-email-linus.walleij@linaro.org>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
 <1467722710-1577-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160705134348.GT6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 02:45:01PM +0200, Linus Walleij wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is only one instance of ab8500_regulator_platform_data, and it's
> safe to assume we won't ever merge another one, so it's rather pointless
> to pass it through multiple levels of platform data pointers.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/9d225757/attachment.sig>
