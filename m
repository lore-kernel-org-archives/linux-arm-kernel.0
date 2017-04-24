From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 13:48:12 +0200
Subject: [PATCH v4 4/7] pinctrl: armada-37xx: Add gpio support
In-Reply-To: <83a4f4c08275b41333a2583f01ceb0453b009d9f.1491405475.git-series.gregory.clement@free-electrons.com>
References: <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <83a4f4c08275b41333a2583f01ceb0453b009d9f.1491405475.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdYMt2X5-c2GOAdO-dWNnLK4L66-7hns1AwwCxDcTSdADw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 5, 2017 at 5:18 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> GPIO management is pretty simple and is part of the same IP than the pin
> controller for the Armada 37xx SoCs.  This patch adds the GPIO support to
> the pinctrl-armada-37xx.c file, it also allows sharing common functions
> between the gpiolib and the pinctrl drivers.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
