From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Oct 2012 20:50:58 -0600
Subject: [PATCH 2/2] ARM: bcm2835: enable GPIO/pinctrl
In-Reply-To: <1348805412-7804-2-git-send-email-swarren@wwwdotorg.org>
References: <1348805412-7804-1-git-send-email-swarren@wwwdotorg.org>
 <1348805412-7804-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5089FA92.9090908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2012 10:10 PM, Stephen Warren wrote:
> Enable GPIO and pinctrl in Kconfig.
> 
> Add required <mach/gpio.h> for gpiolib.
> 
> Instantiate the BCM2835 GPIO module in bcm2835.dtsi.
> 
> Add a pinctrl definition to bcm2835-rpi-b.dts that sets up all of the
> board's required pinmux configuration. GPIO aren't specified; that's
> left to gpio_request().

Applied to rpi's for-3.8/soc branch.
