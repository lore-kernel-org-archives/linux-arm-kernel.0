From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Aug 2012 06:55:28 -0700
Subject: [PATCH v3 5/7] ARM: OMAP4+: thermal: introduce bandgap
 temperature sensor
In-Reply-To: <4FEB4B4F.9040709@dev.rtsoft.ru>
References: <4FEB4B4F.9040709@dev.rtsoft.ru>
Message-ID: <20120808135527.GE11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120627 11:09]:
> +
> +module_platform_driver(omap_bandgap_sensor_driver);
> +early_platform_init("early_omap_temperature", &omap_bandgap_sensor_driver);

Why does this need to be early_platform_init?

Tony
