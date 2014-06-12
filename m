From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Jun 2014 13:40:23 -0600
Subject: [PATCH v2 1/3] arm: multi_v7: enable igb, stmpe, lm95245, pwm leds
In-Reply-To: <1741a33cd88cd5525f3c50c0e0cacc0853a3512a.1402350905.git.marcel@ziswiler.com>
References: <1741a33cd88cd5525f3c50c0e0cacc0853a3512a.1402350905.git.marcel@ziswiler.com>
Message-ID: <539A0227.1000909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2014 04:49 PM, Marcel Ziswiler wrote:
> The NVIDIA Tegra 3 based Apalis T30 module contains an Intel i210 resp.
> i211 gigabit Ethernet controller, an STMPE811 ADC/touch controller, PWM
> LEDs generically accessible from user space and an LM95245 temperature
> sensor chip. The later three can also be found on the Colibri T30
> module.
> 
> While at it move the NEON entry down to its proper place to have it all
> nicely ordered again.

Acked-by: Stephen Warren <swarren@nvidia.com>

I assume this will be applied directly to the arm-soc tree.
