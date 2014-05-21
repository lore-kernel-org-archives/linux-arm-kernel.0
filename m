From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 21 May 2014 15:10:14 +0800
Subject: [PATCH] ARM: dt: imx28-cfa10036: introduce a regulator for mmc0
In-Reply-To: <1400166768-18801-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1400166768-18801-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140521071011.GA20050@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 05:12:48PM +0200, Alexandre Belloni wrote:
> The PWM3 pinmux configuration conflicts with gpio 3.28. Introduce a regulator
> for mmc0 so that it conflicts with the pwm driver and fails gracefully. The
> kernel will then able to access mmc0 normally.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied, thanks.
