From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 9 Oct 2014 11:50:07 +0100
Subject: [PATCH 4/4] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
In-Reply-To: <20141009100115.GD3869@leverpostej>
References: <1412760810-23199-1-git-send-email-lee.jones@linaro.org>
 <1412760810-23199-5-git-send-email-lee.jones@linaro.org>
 <20141009100115.GD3869@leverpostej>
Message-ID: <20141009105007.GO20647@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Oct 2014, Mark Rutland wrote:

> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "syscfg-type");
> 
> This wasn't mentioned in the binding. A comment mentioned "type", but
> there was no explicit mention of "syscfg-type" in reg-names.

Thanks Mark, I'll fixup.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
