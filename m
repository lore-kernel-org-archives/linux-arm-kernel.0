From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 17 May 2016 11:14:45 +0200
Subject: [PATCH v4 12/18] arm: use of_platform_default_populate() to
 populate
In-Reply-To: <1463054775-18170-13-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463054775-18170-13-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <573AE105.7080200@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/05/2016 14:06, Kefeng Wang a ?crit :
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm/mach-at91/at91rm9200.c          | 2 +-
>  arch/arm/mach-at91/at91sam9.c            | 2 +-
>  arch/arm/mach-at91/sama5.c               | 2 +-

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Best regards,
-- 
Nicolas Ferre
