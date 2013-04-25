From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:02:56 +0200
Subject: [PATCH 02/10] usb: musb: ux500: move the MUSB HDRC configuration
 into the driver
In-Reply-To: <1366729394-11406-3-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZbHy9CX+b1zUAyuFWw4+9VffG2KVx4CgqdHtHpP4w40A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 5:03 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The MUSB HDRC configuration never changes between each of the ux500
> supported platforms, so there's little point passing it though platform
> data. If we set it in the driver instead, we can make good use of it
> when booting with either ATAGs or Device Tree.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
