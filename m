From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Jun 2013 15:47:32 +0100
Subject: [PATCH 1/3] drivers: pinctrl sleep and idle states in the core
In-Reply-To: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130605144732.GF31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 03:44:31PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> If a device have sleep and idle states in addition to the
> default state, look up these in the core and stash them in
> the pinctrl state container.
> 
> Add accessor functions for pinctrl consumers to put the pins
> into "default", "sleep" and "idle" states passing nothing but
> the struct device * affected.

Reviewed-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130605/dcfa13aa/attachment.sig>
