From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Aug 2014 15:07:21 +0200
Subject: [PATCH 1/4] gpio: pca953x: Drop deprecated DT bindings
In-Reply-To: <1406618686-22385-2-git-send-email-mpa@pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
 <1406618686-22385-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdYOuUXv9U+sb_hQFNvVUm1G7W46sRv6n3nSPMwz7yLUiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 9:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> Drop deprecated DT bindings and use automaticly assigned gpio and irq
> bases.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Patch applied.

> -       val = of_get_property(node, "linux,gpio-base", &size);
> -       WARN(val, "%s: device-tree property 'linux,gpio-base' is deprecated!", __func__);

Gah! This should never have been merged.

I even consider this patch a bug fix now.

Yours,
Linus Walleij
