From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Dec 2012 20:31:33 +0100
Subject: [PATCH 1/2] pinctrl: add sleep mode management for hogs
In-Reply-To: <50C7A194.7070102@wwwdotorg.org>
References: <1355234393-17368-1-git-send-email-linus.walleij@stericsson.com>
 <50C7A194.7070102@wwwdotorg.org>
Message-ID: <CACRpkdak+f8Nnyns+jdGsxrzD1839-kdOqySChD9aDG+7KMU7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 10:11 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> Since I assume those function are only supposed to be used by pinctrl
> drivers themselves, should the prototypes go into drivers/pinctrl/core.h
> or similar, rather than something in include/linux/pinctrl?

Good point, Julien can you fix this?

Hm, maybe pinctrl_force_sleep()/default() isn't such a good name,
maybe it should be pinctrl_hogs_sleep()/pinctrl_hogs_default() intead?

> Oh, and don't you need EXPORT_SYMBOL in case the pinctrl driver is a module?

True.

> Aside from that,
>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Thanks.

Yours,
Linus Walleij
