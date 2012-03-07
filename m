From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Mar 2012 04:06:37 -0800
Subject: [PATCH v2 2/3] gpio/samsung: add support GPIOlib for EXYNOS5250
In-Reply-To: <1329341829-14403-3-git-send-email-kgene.kim@samsung.com>
References: <1329341829-14403-1-git-send-email-kgene.kim@samsung.com>
 <1329341829-14403-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <4F574F4D.5000708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/12 13:37, Kukjin Kim wrote:
> From: Sangsu Park<sangsu4u.park@samsung.com>
>
> This patch adds gpio_chips for EXYNOS5250 and replaces
> exynos4_xxx() with exynos_xxx() and variables to support
> exynos4 and exynos5 together.
> In addition, use ioreamp() for base address of gpios.
>
> Signed-off-by: Sangsu Park<sangsu4u.park@samsung.com>
> Cc: Grant Likely<grant.likely@secretlab.ca>

Hi Grant,

How about upstreaming this via samsung tree when sending EXYNOS5 stuff, 
I think, gpio-samsung needs still cleanup though? If any comments, 
please kindly let me know.

> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
>   drivers/gpio/gpio-samsung.c             |  439 +++++++++++++++++++++++++++++--
>   1 files changed, 411 insertions(+), 28 deletions(-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
