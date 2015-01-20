From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 15:38:18 +0800
Subject: [PATCH] ARM: dts: imx25: Fix PWM "per" clocks
In-Reply-To: <1421241063-8928-1-git-send-email-festevam@gmail.com>
References: <1421241063-8928-1-git-send-email-festevam@gmail.com>
Message-ID: <20150120073817.GU2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 11:11:03AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Currently PWM functionality is broken on mx25 due to the wrong assignment of the
> PWM "per" clock.
> 
> According to Documentation/devicetree/bindings/clock/imx25-clock.txt:
> 	pwm_ipg_per		52
> 
> ,so update the pwm "per" to use 'pwm_ipg_per' instead of 'per10' clock.
> 
> With this change PWM can work fine on mx25.
> 
> Cc: <stable@vger.kernel.org> 
> Reported-by: Carlos Soto <csotoalonso@gmail.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
