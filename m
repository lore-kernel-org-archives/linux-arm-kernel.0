From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 05:03:38 -0700
Subject: [PATCH] pinctrl: at91-pio4: add PM stuff
In-Reply-To: <1443172449-19915-1-git-send-email-ludovic.desroches@atmel.com>
References: <1443172449-19915-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkdav_3NCJR9_UO854P7gEqc6N0qiKWAZm9ypqXd4t8a9vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 2:14 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> Allow GPIOs to be configured as wakeup sources. When going to suspend,
> disable all GPIO irqs excepting the one configured as wakeup sources.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Patch applied.

Yours,
Linus Walleij
