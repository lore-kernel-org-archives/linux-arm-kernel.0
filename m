From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:30:55 +0200
Subject: [PATCH 21/39] usb: musb: ux500: move the MUSB HDRC configuration
 into the driver
In-Reply-To: <1368611522-9984-22-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-22-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYOxOz_hGpijHhVeDJFg66j31CuDqA-cTmaJoJSJMoDqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The MUSB HDRC configuration never changes between each of the ux500
> supported platforms, so there's little point passing it though platform
> data. If we set it in the driver instead, we can make good use of it
> when booting with either ATAGs or Device Tree.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tentatively applied with Felipe's ACK.

Yours,
Linus Walleij
