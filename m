From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 02 Jun 2014 10:00:03 -0600
Subject: [PATCH 1/3] arm: multi_v7: enable igb, stmpe, spidev, lm95245,
 pwm leds
In-Reply-To: <cc612cd3f24f01cfc8fd3e81b1027ff94862e8b4.1401700579.git.marcel@ziswiler.com>
References: <cc612cd3f24f01cfc8fd3e81b1027ff94862e8b4.1401700579.git.marcel@ziswiler.com>
Message-ID: <538C9F83.1010800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 03:43 AM, Marcel Ziswiler wrote:
> The NVIDIA Tegra 3 based Apalis T30 module contains an Intel i210 resp.
> i211 gigabit Ethernet controller, an STMPE811 ADC/touch controller,
> SPI bus and PWM LEDs generically accessible from user space and an
> LM95245 temperature sensor chip. The later four can also be found on
> the Colibri T30 module.
> 
> While at it move the NEON entry down to its proper place to have it all
> nicely ordered again.
> 
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> ---
> BTW: How about TEGRA_EMC_SCALING_ENABLE

I thought a patch was sent to remove that. Perhaps the patch was only
sent to tegra_defconfig.

> ... MTD_M25P80 which depends on MTD_SPI_NOR

I've seen patches to fix that too.
