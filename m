From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Jul 2014 16:43:56 -0700
Subject: [PATCH v2 1/3] arm: multi_v7: enable igb, stmpe, lm95245, pwm leds
In-Reply-To: <1741a33cd88cd5525f3c50c0e0cacc0853a3512a.1402350905.git.marcel@ziswiler.com>
References: <1741a33cd88cd5525f3c50c0e0cacc0853a3512a.1402350905.git.marcel@ziswiler.com>
Message-ID: <20140706234356.GB5539@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 12:49:50AM +0200, Marcel Ziswiler wrote:
> The NVIDIA Tegra 3 based Apalis T30 module contains an Intel i210 resp.
> i211 gigabit Ethernet controller, an STMPE811 ADC/touch controller, PWM
> LEDs generically accessible from user space and an LM95245 temperature
> sensor chip. The later three can also be found on the Colibri T30
> module.
> 
> While at it move the NEON entry down to its proper place to have it all
> nicely ordered again.
> 
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>

Applied for 3.17.


-Olof
