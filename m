From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Feb 2017 11:08:40 +0100
Subject: [PATCH] pinctrl: sunxi: Remove stray printk call in sun5i
 driver's probe function
In-Reply-To: <20170201160209.9261-1-wens@csie.org>
References: <20170201160209.9261-1-wens@csie.org>
Message-ID: <CACRpkdYYRY9bZtGiD6Kshd9Jpo3bVaV+pTR5vhnS4CZeZhe7hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 5:02 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> There is a stray printk call in the new sun5i pinctrl driver's probe
> function.
>
> Remove it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied.

Yours,
Linus Walleij
