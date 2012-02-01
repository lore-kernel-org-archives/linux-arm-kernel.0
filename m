From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Feb 2012 17:27:18 +0000
Subject: [PATCH] pinctrl: delete raw device pointers in pinmux maps
In-Reply-To: <1328117053-27807-1-git-send-email-linus.walleij@stericsson.com>
References: <1328117053-27807-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120201172717.GG17170@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 06:24:13PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> After discussion with Mark Brown in an unrelated thread about
> ADC lookups, it came to my knowledge that the ability to pass
> a struct device * in the regulator consumers is just a
> historical artifact, and not really recommended. Since there
> are no in-kernel users of these pointers, we just kill them
> right now, before someone starts to use them.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120201/6f896644/attachment.sig>
