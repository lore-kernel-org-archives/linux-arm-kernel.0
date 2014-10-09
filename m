From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Oct 2014 11:01:15 +0100
Subject: [PATCH 4/4] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
In-Reply-To: <1412760810-23199-5-git-send-email-lee.jones@linaro.org>
References: <1412760810-23199-1-git-send-email-lee.jones@linaro.org>
 <1412760810-23199-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20141009100115.GD3869@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "syscfg-type");

This wasn't mentioned in the binding. A comment mentioned "type", but
there was no explicit mention of "syscfg-type" in reg-names.

Mark.
