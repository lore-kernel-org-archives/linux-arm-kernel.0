From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 30 Sep 2012 10:26:08 +0200
Subject: [PATCH 1/2] gpio-lpc32xx: Add GPI_28
In-Reply-To: <1348559774-15484-1-git-send-email-stigge@antcom.de>
References: <1348559774-15484-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdYU4sjzcstrTx+apgN1Cp8fF_C9WCkhpmPJzsFTDx6qqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 9:56 AM, Roland Stigge <stigge@antcom.de> wrote:

> This patch adds the missing gpi28 to the list of GPIOs in the GPI P3 "chip".
>
> NOTE: This patch depends on incrementing LPC32XX_GPI_P3_MAX.  When applied
> without the respective mach-lpc32xx patch (merged via arm-soc.git), gcc will
> give a warning about "excess elements in array initializer" but this doesn't
> harm.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

OK patch applied.

Yours,
Linus Walleij
