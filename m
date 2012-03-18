From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Mar 2012 00:57:18 +0100
Subject: [PATCH 1/2] ARM: dts: versatile-pb/ab fix MMC IRQs
In-Reply-To: <1330682843-21163-1-git-send-email-linus.walleij@linaro.org>
References: <1330682843-21163-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdYu-kSW0SEkMWXiuuu+sy5h2qLSBCYn+vo-NpdohzaM6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2012 at 11:07 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The MMCI driver will not work without two IRQs since this is not
> flagged as a single-irq variant. Looking through the complex IRQ
> definition for the MMCI on the versatile (including an #if 1
> statement forcing MMCI IRQ0 to the VIC) this appears to the the
> correct IRQ number for both models.
>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Ping on this and 2/2, could go in as fixes as well.

Yours,
Linus Walleij
