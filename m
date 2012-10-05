From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Oct 2012 14:52:06 +0200
Subject: [PATCH 1/2] ARM: nomadik: switch over to using the FSMC driver
In-Reply-To: <1349335709-13399-1-git-send-email-linus.walleij@linaro.org>
References: <1349335709-13399-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdYMz05DwtLtHkggvo8VFOtvPLpovwq6fLceeiFK0Wci0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2012 at 9:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The Nomadik NAND driver is really just a subset of the existing
> FSMC driver, so let's switch over to using that driver instead,
> since it handles more variants of this chip. The callbacks for
> setting up the chip is doing stuff now handled by the FSMC
> driver.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I'm requesting Mike Turquette's ACK on this patch so I can merge
> it through ARM SoC.

Still requesting Mike's ACK, but not for merging through ARM SoC
but through MTD.

If you apply Jean-Christophe's patch first (please do that) I will
send a v2 of this patch set to be applied onto MTD as well
(should be OK).

Yours,
Linus Walleij
