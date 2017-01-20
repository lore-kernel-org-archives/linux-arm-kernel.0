From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 20 Jan 2017 18:40:43 +0200
Subject: [PATCH v3 03/13] soc: samsung: pmu: Remove messages for failed
 memory allocation
In-Reply-To: <1484833733-16082-4-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134905eucas1p2ed9d6baf6283528289a36a58ee6c978e@eucas1p2.samsung.com>
 <1484833733-16082-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170120164043.y243tf4lsvwa3wpy@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:48:43PM +0100, Marek Szyprowski wrote:
> Memory subsystem already prints message about failed memory
> allocation, there is no need to do it in the driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
