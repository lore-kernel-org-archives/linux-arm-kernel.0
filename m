From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Nov 2010 15:28:24 -0800
Subject: [PATCH v7 11/11] OMAP: GPIO: Remove omap_gpio_init()
In-Reply-To: <1290524213-395-12-git-send-email-charu@ti.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<1290524213-395-12-git-send-email-charu@ti.com>
Message-ID: <20101124232824.GY31536@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Varadarajan, Charulatha <charu@ti.com> [101123 06:47]:
> Remove the usage of omap_gpio_init() from all omap board files
> since omap_gpio_init() does nothing, after gpio is implemented
> as a platform device.

Great, glad to see these go!

Tony
