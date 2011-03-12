From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Mar 2011 10:59:33 +0100
Subject: [PATCH 07/10] ux500: added snowball-digio.c
In-Reply-To: <1299884892-6766-8-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-8-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201103121059.33395.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:09 mathieu.poirier at linaro.org wrote:
> +static int snowball_digio_init(void)
> +{
> +        nmk_config_pins(snowball_pins, ARRAY_SIZE(snowball_pins));
> +       platform_device_register(&snowball_led_dev);
> +       platform_device_register(&snowball_key_dev);
> +       return 0;
> +}

Whitespace damaged.

Also platform_device_register_data() here.

	Arnd
