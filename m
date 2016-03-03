From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 11:53:38 +0100
Subject: [RFC 04/15] irqchip: st: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-5-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <2506651.J2Z42d81nD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 17:03:30 Krzysztof Kozlowski wrote:
>  config ST_IRQCHIP
>         bool
>         select REGMAP
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select MFD_SYSCON
>         help
>           Enables SysCfg Controlled IRQs on STi based platforms.
> 

Not user visible.

	Arnd
