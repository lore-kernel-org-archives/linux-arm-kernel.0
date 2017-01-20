From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 20 Jan 2017 18:40:13 +0200
Subject: [PATCH v3 02/13] soc: samsung: pmu: Use of_device_get_match_data
 helper
In-Reply-To: <1484833733-16082-3-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134904eucas1p1cc044892728a1716acc2f77f32180c42@eucas1p1.samsung.com>
 <1484833733-16082-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170120164013.6wvbmma3imis5jpr@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:48:42PM +0100, Marek Szyprowski wrote:
> Replace custom code with generic helper to retrieve driver data.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
