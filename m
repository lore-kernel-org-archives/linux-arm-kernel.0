From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Sep 2018 10:59:47 +0200
Subject: [PATCH] pinctrl: at91: don't use the same irqchip with multiple
 gpiochips
In-Reply-To: <20180913124213.32065-1-ludovic.desroches@microchip.com>
References: <20180913124213.32065-1-ludovic.desroches@microchip.com>
Message-ID: <CACRpkdZWoZ1YCP9eJbB0BgfgON=Zf8q4w=OV4w2nRxvkcd6VaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 2:46 PM Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Sharing the same irqchip with multiple gpiochips is not a good
> practice. For instance, when installing hooks, we change the state
> of the irqchip. The initial state of the irqchip for the second
> gpiochip to register is then disrupted.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Patch applied.

Yours,
Linus Walleij
