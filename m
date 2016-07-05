From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jul 2016 15:44:02 +0200
Subject: [PATCH 03/11] ASoC: ab8500-codec: remove platform data based probe
In-Reply-To: <1467722710-1577-3-git-send-email-linus.walleij@linaro.org>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
 <1467722710-1577-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160705134402.GU6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 02:45:02PM +0200, Linus Walleij wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ux500 platform hasn't used board files for a long time, and
> nothing defines a ab8500_codec_platform_data, so we can just
> remove the probing based on that and always use device tree
> properties directly.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/2bee59bf/attachment.sig>
