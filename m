From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 19:32:15 +0200
Subject: [RESEND PATCH 1/2] mmc: mmci: Fix incorrect handling of HW flow
 control for SDIO
In-Reply-To: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdYarGEzYoJwHggQh2O=hw_wyhP9KQ2GRruWh64SwnH=VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 6:03 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For data writes <= 8 bytes, HW flow control was disabled but
> never re-enabled when the transfer was completed. This meant
> that a following read request would give buffer overrun errors.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks correct to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this goes into Russell's patch tracker.

Yours,
Linus Walleij
