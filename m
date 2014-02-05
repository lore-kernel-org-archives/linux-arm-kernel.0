From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Feb 2014 13:53:05 +0100
Subject: [PATCH 10/17] spi: pl022: Remove redundant pinctrl to default
 state in probe
In-Reply-To: <1391529538-21685-11-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-11-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdYd9zp4DhpXurNgda2GfzEHVc_ds0m2QWMhbfOtFQLqwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 4:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The driver core is now taking care of putting our pins into default
> state at probe. Thus we can remove the redundant call for it in probe.
>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
