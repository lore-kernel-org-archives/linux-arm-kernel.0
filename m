From: eric@anholt.net (Eric Anholt)
Date: Mon, 14 Nov 2016 10:24:15 -0800
Subject: [PATCH 2/2] pinctrl: bcm2835: Return pins to inputs when freed
In-Reply-To: <1479126214-20529-1-git-send-email-linus.walleij@linaro.org>
References: <1479126214-20529-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <874m39vs1c.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> From: Phil Elwell <phil@raspberrypi.org>
>
> When dynamically unloading overlays, it is important that freed pins are
> restored to being inputs to prevent functions from being enabled in
> multiple places at once.
>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/9b3ddd85/attachment-0001.sig>
