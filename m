From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:35:39 +0200
Subject: [PATCH 24/39] usb: musb: ux500: attempt to find channels by name
 before using pdata
In-Reply-To: <1368611522-9984-25-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-25-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYpY60FrbgMEpY2RftRN8iWca2SgzzUF=bRAk23doN_Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> If we can ever get to a state where we can solely search for DMA channels
> by name, this will almost completely alleviate the requirement to pass
> copious amounts of information though platform data. Here we take the
> first step towards this. The next step will be to enable Device Tree
> complete with name<->event_line mapping.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tentatively applied with Felipe's ACK.

Yours,
Linus Walleij
