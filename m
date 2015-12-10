From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 18:25:09 +0100
Subject: [PATCH] ARM: at91: fix pinctrl driver selection
In-Reply-To: <1448966680-30281-1-git-send-email-ludovic.desroches@atmel.com>
References: <1448966680-30281-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkdaHUrkx-KC9ycw7_O6UQiqEgrGSN1UTjiK1S-_sHVtLwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 1, 2015 at 11:44 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> Move the selection of the pinctrl driver to SoC family level since we
> have two pinctrl drivers. It is useless to select one which is not
> compatible with the SoC.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
