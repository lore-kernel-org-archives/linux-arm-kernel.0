From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Nov 2017 14:10:08 +0100
Subject: [PATCH] pinctrl: armada-37xx: Fix direction_output() callback
 behavior
In-Reply-To: <20171114165150.19599-1-gregory.clement@free-electrons.com>
References: <20171114165150.19599-1-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYKOLi=Z0oKiS-9Wq_WvVLTLYbTbY4sYfDEy770pvAqKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 5:51 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The direction_output callback of the gpio_chip structure is supposed to
> set the output direction but also to set the value of the gpio. For the
> armada-37xx driver this callback acted as the gpio_set_direction callback
> for the pinctrl.
>
> This patch fixes the behavior of the direction_output callback by also
> applying the value received as parameter.
>
> Cc: stable at vger.kernel.org
> Fixes: 5715092a458c ("pinctrl: armada-37xx: Add gpio support")
> Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied for fixes.

Sorry for taking so long, merge window you know.

Yours,
Linus Walleij
