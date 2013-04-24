From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Apr 2013 10:54:30 +0100
Subject: [PATCH 13/23] regulator: ab3100: refactor probe to use IDs
In-Reply-To: <1366624634-6579-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624634-6579-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130424095430.GA5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 11:57:14AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This refactors the AB3100 regulator probe to use regulator IDs
> and pass this to a separate registration function. This works
> much smoother when migrating to device tree, as we can use a
> match table with this regulator ID encoded in the .driver_data.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130424/6d5c23cf/attachment-0001.sig>
