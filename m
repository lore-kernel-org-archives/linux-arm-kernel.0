From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 19:46:48 +0800
Subject: [PATCH] ARM: dts: imx23-olinuxino: Fix polarity of LED GPIO
In-Reply-To: <1429020304-31045-1-git-send-email-fabio.estevam@freescale.com>
References: <1429020304-31045-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150427114645.GI9231@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 11:05:04AM -0300, Fabio Estevam wrote:
> On imx23-olinuxino the LED turns on when level logic high is aplied to
> GPIO2_1.
> 
> Fix the gpios property accordingly.
> 
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
