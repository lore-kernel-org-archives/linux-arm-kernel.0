From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Oct 2013 14:55:56 +0100
Subject: [PATCH v6 1/8] pinctrl: imx1 core driver
In-Reply-To: <1382950843-26066-2-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <1382950843-26066-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdZZhwYtvki-2AQFOSND4BQmOenZb6sSm2tOpQUYWwETgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 10:00 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> Core driver for register formats of imx1/imx21/imx27 processors.
>
> The pins of those processors are grouped into ports. Each port has 32
> pins. The pins mux configuration is controlled by registers with 1 or 2
> bit per pin, depending on the specific control register.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Allright, as it is a new driver and I feel sorry for it being stuck in
DT review limbo, patch applied.

Yours,
Linus Walleij
