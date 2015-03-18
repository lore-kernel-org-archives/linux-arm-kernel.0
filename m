From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 13:02:50 +0100
Subject: [PATCH 02/12] gpio: Remove gpio-msm-v1 driver
In-Reply-To: <1426270185-19510-3-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
 <1426270185-19510-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdZD4=aZPh91o=eNDRtp=HO-BkWpkLX7CvwOD6UgZOqa=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 7:09 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> This driver is orphaned now that mach-msm has been removed.
> Delete it.
>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>
> This can be acked and go through arm-soc or applied directly to gpio tree.

This would collide with Arnds multiplatform patches.

If you coordinate with Arnd and agree:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
