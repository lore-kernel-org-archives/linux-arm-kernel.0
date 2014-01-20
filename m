From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 09:20:14 +0100
Subject: [PATCH v2] pinctrl: sunxi: Honor GPIO output initial vaules
In-Reply-To: <1389854063-31016-1-git-send-email-wens@csie.org>
References: <1389854063-31016-1-git-send-email-wens@csie.org>
Message-ID: <CACRpkdbJnsxazMfe7BvOYEsczQ_XLCc-nAy7q4CUySmvuvKpGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 7:34 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> Some GPIO users, such as fixed-regulator, request GPIO output with
> initial value of 1. This was ignored by sunxi driver.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>
> Changes since v2:
>
>   * Set output value before setting the pin function to avoid a glitch.

Patch applied with Maxime's ACK and tagged for stable.

Yours,
Linus Walleij
