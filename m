From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:08:41 +0200
Subject: [PATCH 05/10 v2] usb: musb: ux500: attempt to find channels by
 name before using pdata
In-Reply-To: <20130424150521.GE9652@gmail.com>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-6-git-send-email-lee.jones@linaro.org>
 <20130424150521.GE9652@gmail.com>
Message-ID: <CACRpkdac6zF0fZfGCkXDAKqc+ZtxvU4RXYMurgcM9612Xj07Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 5:05 PM, Lee Jones <lee.jones@linaro.org> wrote:

> If we can ever get to a state where we can solely search for DMA channels
> by name, this will almost completely alleviate the requirement to pass
> copious amounts of information though platform data. Here we take the
> first step towards this. The next step will be to enable Device Tree
> complete with name<->event_line mapping.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looking good, would be nice if Arnd checked it tho.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
