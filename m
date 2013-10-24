From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Oct 2013 12:06:23 +0200
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
In-Reply-To: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbymhLhHObL+fdWCHKbNG_LtudvhXbdxC0NCJApUBjT9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 1, 2013 at 12:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This converts the gemini machine to use generic clockevents
> by rewriting the timer driver.
>
> Cc: arm at kernel.org
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This is flagged as Request for Testing (RFT) as I have no Gemini
> platform. If I do not get help with testing this, the next step
> will be a patch series to delete the platform.

OK nobody is able to test this it seems, but it is a vital refactoring.

Should we just apply this and see what happens?

Or should I just send a deletion patch right away?

I would lean toward just applying it and see if the OpenWRT
people will notice and/or complain.

What does the ARM SoC people say?

Yours,
Linus Walleij
