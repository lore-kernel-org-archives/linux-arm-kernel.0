From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Apr 2014 17:50:16 +0200
Subject: [PATCH V2 11/19] mmc: mmci: Mark the DT bindings for highspeed
 mode as deprecated
In-Reply-To: <1396279100-2920-12-git-send-email-ulf.hansson@linaro.org>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
 <1396279100-2920-12-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdY+pgXOjxaLYH=m7v3-7xt1mzDvt=6tAyJz4smJ-2RoAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 5:18 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The common mmc DT parser supports bindings for highspeed mode, thus
> there are no need for mmci to provide it's own versions for these. Mark
> them as deprecated in the documentation.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
