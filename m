From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2011 17:33:39 +0100
Subject: [PATCH] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <1301992655-8514-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110405073030.GI13963@pengutronix.de>
	<1301992655-8514-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110405163338.GA11832@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 10:37:35AM +0200, Uwe Kleine-K?nig wrote:
> +struct platform_device *__init gpio_led_register_device(
> +		const struct gpio_led_platform_data *pdata);

Please don't add __init annotations to declarations.
