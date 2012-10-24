From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 19:25:26 +0200
Subject: [PATCH 0/2] clk: ux500: Make mtu driver use apb_pclock
In-Reply-To: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
References: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdb3dcDhVD5qkOrRkLJ-RXdmqJ2tAkosoeEB_DwSDSShKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 2:13 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The apb clock was before the "common" clock driver for ux500 was merged,
> handled internally by the clock driver. Now this clock needs to be managed
> from the mtu driver as a separate clock.
>
> This patches is based in 3.7 rc2.
>
> It is important the "ARM nomadik patch" is merged together with the
> clock patch to not break boot. Therefore I suggest this series to go
> through Mike Turquettes clock tree.

OK go ahead:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
