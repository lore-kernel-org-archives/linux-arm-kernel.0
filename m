From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Apr 2012 10:40:50 +0200
Subject: [PATCH 3/7] drivers/gpio: gpio-nomadik: Apply Device Tree bindings
In-Reply-To: <1334325909-5779-4-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbypo3fbUnfzLPR5Hk3_SqWsRKgfX02dDefADY8PnXx5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 4:05 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?arch/arm/boot/dts/db8500.dtsi ? ? ?| ? 18 +++++++++++++++
> ?arch/arm/boot/dts/snowball.dts ? ? | ? 10 ++++----
> ?arch/arm/mach-ux500/board-mop500.c | ? 12 ++++++++++
> ?drivers/gpio/gpio-nomadik.c ? ? ? ?| ? 41 +++++++++++++++++++++++++++++++++--
> ?4 files changed, 73 insertions(+), 8 deletions(-)

Thanks, I added a commit blurb and applied this to ux500-core.
(So let's keep this out of the GPIO tree.)

I am planning to do some pinctrl changes for ux500 this development
cycle as well, let us take all of this through the ux500 tree up through
ARM SoC to avoid conflicts and confusion.

Yours,
Linus Walleij
