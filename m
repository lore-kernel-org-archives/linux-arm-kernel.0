From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Jan 2013 13:37:26 +0000
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130102133726.GD4627@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 09:25:07PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This makes the device core auto-grab the pinctrl handle and set
> the "default" (PINCTRL_STATE_DEFAULT) state for every device
> that is present in the device model right before probe. This will
> account for the lion's share of embedded silicon devcies.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks for doing this - sorry it took me a while to get round to reading
this properly, the end of last year was very hectic.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130102/0442023d/attachment.sig>
