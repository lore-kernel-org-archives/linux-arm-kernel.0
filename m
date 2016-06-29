From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jun 2016 10:14:15 +0200
Subject: [PATCH 1/2] pinctrl: qcom: Clear all function selection bits
In-Reply-To: <20160626052132.7178-2-stephen.boyd@linaro.org>
References: <20160626052132.7178-1-stephen.boyd@linaro.org>
 <20160626052132.7178-2-stephen.boyd@linaro.org>
Message-ID: <CACRpkdaqcOJGutDtwo+AezZa=F5de+U9JnhzTb-Q2_jDaAq68A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 7:21 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:

> The function selection bitfield is not always 3 bits wide.
> Sometimes it is 4 bits wide. Let's use the npins struct member to
> determine how many bits wide the function selection bitfield is
> so we clear the correct amount of bits in the register while
> remuxing the pins.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Patch applied.

Yours,
Linus Walleij
