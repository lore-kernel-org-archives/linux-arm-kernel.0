From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 11:23:56 +0100
Subject: [PATCH V2] mmc: mmci: Fixup clock gating when freq is 0 for
 ST-variants
In-Reply-To: <1357748222-26829-1-git-send-email-ulf.hansson@stericsson.com>
References: <1357748222-26829-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbHWtyDVApiZZjueZA=60SK39ZuCS6Kmhz88OupSqNENQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 5:17 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Johan Rudholm <johan.rudholm@stericsson.com>
>
> In the ST Micro variant, the MMCICLOCK register must not be used to
> gate the clock. Instead use MMCIPOWER register and by clearing the
> PWR_ON bit to do this.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
