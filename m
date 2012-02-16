From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 14:24:20 +0900
Subject: [PATCH v2 06/11] ARM: EXYNOS: add support uart for EXYNOS4 and
 EXYNOS5
In-Reply-To: <1328981685-8602-7-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-7-git-send-email-kgene.kim@samsung.com>
Message-ID: <054701ccec6b$3c563440$b5029cc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:

[...]

> +struct s3c24xx_uart_resources exynos4_uart_resources[] __initdata = {
> +	[0] = {
> +		.resources	= exynos4_uart0_resource,
> +		.nr_resources	= ARRAY_SIZE(exynos4_uart0_resource),
> +	},
> +	[1] = {
> +		.resources	= exynos4_uart1_resource,
> +		.nr_resources	= ARRAY_SIZE(exynos4_uart0_resource),

Ooops, should be...

		.nr_resources	= ARRAY_SIZE(exynos4_uart1_resource),


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
