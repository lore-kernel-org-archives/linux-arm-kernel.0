From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Mon, 18 Jun 2012 23:30:17 +0530
Subject: [PATCH] watchdog: coh901327_wdt: use clk_prepare/unprepare
In-Reply-To: <1339521541-30183-1-git-send-email-linus.walleij@stericsson.com>
References: <1339521541-30183-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CADTbHxqkWxjp9L-qyai=N7b4_NRaYDOw8Z-mKoFp4BqyTMZZTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 12, 2012 at 10:49 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Make sure we prepare/unprepare the COH901327 watchdog timer
> as is required by the clk API especially if you use common
> clock.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by : Pankaj Jangra <jangra.pankaj9@gmail.com>

Regards,
Pankaj Jangra
