From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 10:58:39 +0100
Subject: [PATCH 1/2] pinctrl: nomadik: Silence compiler warn for !CONFIG_PM
In-Reply-To: <1392209979-31636-1-git-send-email-ulf.hansson@linaro.org>
References: <1392209979-31636-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdY78NAX42zDRDMgeGTATow66Ep=+bZqbca3Sub56GQSqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 1:59 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The static suspend/resume functions were not being used while
> !CONFIG_PM. Fix it and convert to CONFIG_PM_SLEEP.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied. Sorry for the delay.

Yours,
Linus Walleij
