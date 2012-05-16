From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2012 13:24:36 +0200
Subject: [PATCH] [SPI] Refactor spi-orion to use SPI framework queue.
In-Reply-To: <1337162384-14088-1-git-send-email-andrew@lunn.ch>
References: <1337162384-14088-1-git-send-email-andrew@lunn.ch>
Message-ID: <CACRpkdaC+MTX6hRaHdxt02xQb648DT63f_aXu1sZ0eCEvKA-Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 11:59 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>
> NOTE: This patch will only apply once the clk-next pull request of
> Mike Turquette on 15th May has been included. So should this go in
> via arm-soc, not the spi-next tree?

Merge it wherever it applies, usually where the dependencies are,
ARM SoC I guess?

Yours,
Linus Walleij
