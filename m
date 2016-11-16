From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 16 Nov 2016 18:58:37 +0200
Subject: [PATCH 4/8] ARM: s3c64xx: Drop unused DMA fields from struct
 s3c64xx_spi_csinfo
In-Reply-To: <1478791076-19528-5-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
 <1478791076-19528-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161116165837.GC3727@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:17:52PM +0100, Sylwester Nawrocki wrote:
> There is no drivers using those fields so remove them and
> the remaining initializations.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-samsung/devs.c              | 24 ------------------------
>  include/linux/platform_data/spi-s3c64xx.h |  3 ---
>  2 files changed, 27 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
