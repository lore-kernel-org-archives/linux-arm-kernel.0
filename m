From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 12:57:50 -0600
Subject: [PATCH v2 2/3] arm: tegra: enable igb, stmpe, i2c chardev, lm95245,
 pwm leds
In-Reply-To: <dadd07f9ed693d6bcf541764b62a2caf4cc38630.1402353627.git.marcel@ziswiler.com>
References: <dadd07f9ed693d6bcf541764b62a2caf4cc38630.1402353627.git.marcel@ziswiler.com>
Message-ID: <539F3E2E.8060602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2014 04:52 PM, Marcel Ziswiler wrote:
> The NVIDIA Tegra 3 based Apalis T30 module contains an Intel i210 resp.
> i211 gigabit Ethernet controller, an STMPE811 ADC/touch controller, I2C
> buses and PWM LEDs generically accessible from user space and an
> LM95245 temperature sensor chip. The later four can also be found on
> the Colibri T30 module.

I've applied this patch to Tegra's for-3.17/defconfig branch.
