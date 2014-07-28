From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jul 2014 12:14:19 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: number gpio ranges starting from 0
In-Reply-To: <1405358677-23657-3-git-send-email-wens@csie.org>
References: <1405358677-23657-1-git-send-email-wens@csie.org>
 <1405358677-23657-3-git-send-email-wens@csie.org>
Message-ID: <CACRpkda0K0JcA46AjcW===G1Rm5PSDC9jUCWf2Y9YpM2jLFtkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 7:24 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> The pinctrl-sunxi driver originally used the pin number as the gpio
> range offset. This resulted in large, bogus gpio numbers for the
> new sun6i-a31-r pinctrl devices.
>
> This patch makes the driver number the gpios ranges starting from an
> offset of 0, by subtracting the pin_base number from the pin number.
> This also makes the system-wide gpio number match the pin number.
>
> Tested on sun8i with sysfs exported gpios.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
