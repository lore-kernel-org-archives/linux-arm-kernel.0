From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Jul 2016 14:41:15 +0200
Subject: [PATCH 0/6] CLCD support for Nomadik and Versatile series
In-Reply-To: <1466069778-16087-1-git-send-email-linus.walleij@linaro.org>
References: <1466069778-16087-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdY6FDisofanQX9oiXMr2otoBsYKsx+fTs-EkV2F-004Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

On Thu, Jun 16, 2016 at 11:36 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> This is a rebase and repost of my earlier "uncontroversial"
> series of patches to CLCD, which excludes the part where
> we deal with the Versatile autodetected displays. This makes
> it possible to handle Nomadik graphics and RealView with just
> device tree while keeping the Versatile specialties on hold.
>
> We got an earlier nod from Tomi on this series:
> http://marc.info/?l=linux-fbdev&m=145733624305361&w=2

Is there any chance that we can progress with this series
for the v4.8 kernel?

I think Arnd is waiting eagerly to apply my patches removing
the RealView board files that requires something like this
series to go in first (the crucial part is the system controller
set-up).

Yours,
Linus Walleij
