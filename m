From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Dec 2012 19:57:16 +0100
Subject: [PATCH] mmc: mmci: Gate the clock when freq is 0
In-Reply-To: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
References: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdabPfZ0mmU3XYh_NT-w6ZYZeJaGLiQK8__1H9qA-dWAAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 4:50 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Johan Rudholm <johan.rudholm@stericsson.com>
>
> In the ST Micro variant, the MMCI_CLOCK register should not be used to
> gate the clock. Use MMCI_POWER to do this.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I don't know if I'm qualified to ACK anything more today after
misunderstanding so many patches, but this seems correct to
me and won't affect any non-ST IP, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
