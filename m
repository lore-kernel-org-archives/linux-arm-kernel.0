From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 11:02:23 +0200
Subject: [PATCH v2 1/3] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <1334933916-12971-1-git-send-email-b29396@freescale.com>
References: <1334933916-12971-1-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdah8Mr2riXGJXZ2VEYXdORyLznPYG0s-O05vYiGYjQcdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 4:58 PM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> The driver has mux and config support while the gpio is still
> not supported.
> For select input setting, the driver will handle it internally
> and do not need user to take care of it.
>
> The pinctrl-imx core driver will parse the dts file and dynamically
> create the pinmux functions and groups.
>
> Each IMX SoC pinctrl driver should register pins with a pin register map
> including mux register and config register and select input map to core
> for proper operations.
>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

I'm pretty happy with this driver and would love to merge it.

However it'd be nice to have someone else ACK it first.
Someone like Sascha or Shawn would work fine :D

Yours,
Linus Walleij
