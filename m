From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Aug 2012 10:57:58 +0200
Subject: [PATCH 06/14] arm: at91: dt: at91sam9 add pinctrl support
In-Reply-To: <1344603731-32667-6-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-6-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdY2HjwOBy7P8mZ81f8bYU4V2=taXzqv03q9NWqbfMVQ4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 3:02 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> +                               atmel,mux-mask = <
> +                                     /*    A         B     */
> +                                      0xffffffff 0xffc00c3b  /* pioA */
> +                                      0xffffffff 0x7fff3ccf  /* pioB */
> +                                      0xffffffff 0x007fffff  /* pioC */
> +                                     >;

If I read a devcie tree like this it will be a bit hard to understand what is
happening. But again Nicolas is maintaining the AT91 DT.

Yours,
Linus Walleij
