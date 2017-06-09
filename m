From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 09:42:26 +0200
Subject: [PATCH] gpio: mvebu: change compatible string for PWM support
In-Reply-To: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
References: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
Message-ID: <CACRpkdY7yy=U1DgFHXGd06UXg0hh5eC7mBKHLr7hq01hR__q8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 1, 2017 at 10:08 PM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:

> As it turns out more than just Armada 370 and XP support using GPIO
> lines as PWM lines. For example the Armada 38x family has the same
> hardware support. As such "marvell,armada-370-xp-gpio" for the
> compatible string is a misnomer.
>
> Change the compatible string to "marvell,armada-370-gpio" before the
> driver makes it out of the -rc stage. This also follows the practice of
> using only the first device family supported as part of the name.
>
> Also update the documentation and comments in the code accordingly.
>
> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Patch applied for next with the tags.

Yours,
Linus Walleij
