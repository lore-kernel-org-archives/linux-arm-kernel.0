From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 17:34:34 +0100
Subject: [PATCH 1/3] pinctrl: sunxi: Add of_xlate function
In-Reply-To: <1359889813-10029-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1359889813-10029-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359889813-10029-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdYcp5_BvTdSTgHg2xhmnsdx=oT=e19oJnFHCyMaMkGT5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 3, 2013 at 12:10 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Since the pin controller of sunxi chips is represented as a single bank
> in the driver.
> Since this is neither convenient nor represented that way in the
> datasheets, define a custom of_xlate function with the layout <bank pin
> flag>
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to my allwinner branch. I will soon lock down this branch
and merge it into devel so I mature my devel branch for the
merge window.

Yours,
Linus Walleij
