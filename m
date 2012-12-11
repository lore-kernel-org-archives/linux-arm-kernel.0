From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Dec 2012 15:35:59 +0100
Subject: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
In-Reply-To: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
References: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbhOJxr9M1BjRD5=F4vX33WfWRMY-hkD=J+EVtZ2vSFgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 3:17 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The amba bus is already performing same actions but for the apb_pclk.
> So here we just make sure the clock to card is gated as well to save
> more power. At runtime resume we will thus restore the clock again.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks correct to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
