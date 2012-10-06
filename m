From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 6 Oct 2012 23:35:25 +0800
Subject: [PATCH 1/3] ARM: dts: imx53-qsb: Use pinctrl for gpio-led
In-Reply-To: <1348702057-2351-1-git-send-email-festevam@gmail.com>
References: <1348702057-2351-1-git-send-email-festevam@gmail.com>
Message-ID: <20121006153522.GH20231@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 08:27:35PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 8fe4554f (leds: leds-gpio: adopt pinctrl support) gpio-led driver 
> has pinctrl support, so setup the gpio led pin via pinctrl and avoid the 
> following warning:
> 
> leds-gpio leds.2: pins are not configured from the driver
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Queued first 2 patches for 3.8, and leave patch #3 to Sascha.

Shawn
