From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 13:50:16 +0800
Subject: [PATCH v2] ARM: dts: imx28-evk: Use pinctrl for gpio-led
In-Reply-To: <1348427918-19143-1-git-send-email-festevam@gmail.com>
References: <1348427918-19143-1-git-send-email-festevam@gmail.com>
Message-ID: <20120925055014.GC27291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2012 at 04:18:38PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 8fe4554f (leds: leds-gpio: adopt pinctrl support) gpio-led driver 
> has pinctrl support, so setup the gpio led pin via pinctrl and avoid the 
> following warning:
> 
> leds-gpio leds.12: pins are not configured from the driver
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Queued for 3.8, thanks.
