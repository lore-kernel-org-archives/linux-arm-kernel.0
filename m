From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jun 2012 19:29:16 +0200
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <CACRpkdbWQdqQDF7mP51kdZGpiCS+nJ+91j=AkN8S=3Nzvk9sbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 11:12 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Lee might be able to test this with his DT bindings (and patch them to use
the new handling in the core..)

Yours,
Linus Walleij
