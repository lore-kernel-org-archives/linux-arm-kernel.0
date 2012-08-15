From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Aug 2012 10:51:36 +0200
Subject: [PATCH 01/14] ARM: at91: gpio: implement request and free
In-Reply-To: <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdasfFL15qHxucycjNjDeBddo_577W8fuedcU8WN-+JcTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 3:01 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> Configure a gpio as input when freeing it to reduce power consumption/
> Confire the pin as pio when requested.
>
> This is need by DT as we do not mux them any more.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Seems straight-forward and I guess this driver will eventually be
superseded by the new pinctrl driver.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
