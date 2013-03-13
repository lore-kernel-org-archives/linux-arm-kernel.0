From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 20:05:36 +0100
Subject: [PATCH] ARM: at91: add gpio suspend/resume support when using
 pinctrl
In-Reply-To: <1362755901-20279-1-git-send-email-ludovic.desroches@atmel.com>
References: <1362755901-20279-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkdbAVTPvRaX_q5L=rB3+9Je42fDfMf5Dwu-9CeDXkTADkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 8, 2013 at 4:18 PM,  <ludovic.desroches@atmel.com> wrote:

> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> gpio suspend/resume and wakeup sources where not managed when using pinctrl so
> it was impossible to wake up the system with a gpio.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I saw that Nicolas is taking care of it...

Yours,
Linus Walleij
