From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Aug 2017 15:10:48 +0200
Subject: [PATCH] gpio: brcmstb: check return value of
 gpiochip_irqchip_add()
In-Reply-To: <1502319087-23396-1-git-send-email-yamada.masahiro@socionext.com>
References: <1502319087-23396-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdacW8dBOaHUmp=dJDPMT22X088eMdepUoXtza4_DEiEGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 12:51 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Because gpiochip_irqchip_add() may fail, its return value should
> be checked.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied with Gregory's ACK.

Yours,
Linus Walleij
