From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jul 2014 12:11:28 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: use gpiolib API to mark a GPIO used
 as an IRQ
In-Reply-To: <1405358677-23657-2-git-send-email-wens@csie.org>
References: <1405358677-23657-1-git-send-email-wens@csie.org>
 <1405358677-23657-2-git-send-email-wens@csie.org>
Message-ID: <CACRpkdZHLgi1D-+pQmhS60tjrgEu82AnYH23UhSuHcCnFKKUsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 7:24 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
> the gpiolib so we can keep track of the usage centrally.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
