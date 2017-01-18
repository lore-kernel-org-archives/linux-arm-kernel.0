From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2017 13:26:44 +0100
Subject: [PATCH] pinctrl: uniphier: fix Ethernet (RMII) pin-mux setting
 for LD20
In-Reply-To: <1484650374-30989-1-git-send-email-yamada.masahiro@socionext.com>
References: <1484650374-30989-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZXTmGmsGG7kiVuPRs4vRk_-8FbRHvZGjt1cnmYutFvDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 11:52 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Fix the pin-mux values for the MDC, MDIO, MDIO_INTL, PHYRSTL pins.
>
> Fixes: 1e359ab1285e ("pinctrl: uniphier: add Ethernet pin-mux settings")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for fixes.

Yours,
Linus Walleij
