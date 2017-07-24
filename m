From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Jul 2017 23:44:50 +0200
Subject: [PATCH] ARM: dts: gemini: Switch to using macros
In-Reply-To: <20170707223227.20477-1-linus.walleij@linaro.org>
References: <20170707223227.20477-1-linus.walleij@linaro.org>
Message-ID: <CACRpkdYCcqqQMPyApnZekS-7eSchQbgWRyWWnq7tFVO-iQPHhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 8, 2017 at 12:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The macros for reset and clock lines were merged during the merge
> window, this switches the Gemini to use these macros rather than
> numerical defines.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: The required header files are now upstream. Please
> apply and merge this at -rc1 or whenever fits you best (it can be
> applied to Torvald's tree right now.)

Ping on this, this should go in right after -rc1, we are now at -rc2
and I need it for new development baseline.

Yours,
Linus Walleij
