From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 23 Sep 2012 15:58:26 -0300
Subject: [PATCH] ARM: dts: imx28-evk: Use pinctrl for gpio-led
In-Reply-To: <1348423277-10740-1-git-send-email-festevam@gmail.com>
References: <1348423277-10740-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5C8bCZuCJG=jCdE1=nwL-XN+jEpdbD4wrCNByf9KKyCgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Sun, Sep 23, 2012 at 3:01 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Since commit 8fe4554f (leds: leds-gpio: adopt pinctrl support) gpio-led driver
> has pinctrl support, so setup the gpio led pin via pinctrl and avoid the
> following warning:
>
> leds-gpio leds.12: pins are not configured from the driver

Ops, I still see the warning. Please discard this patch.

Will sent v2 soon.

Regards,

Fabio Estevam
