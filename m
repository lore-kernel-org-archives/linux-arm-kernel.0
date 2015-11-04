From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 04 Nov 2015 11:52:11 +0100
Subject: [PATCH 4/5] thermal: exynos: Remove unneeded semicolon
In-Reply-To: <1444282446-6419-4-git-send-email-k.kozlowski@samsung.com>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
 <1444282446-6419-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20151104115211.3ae5c0c0@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

> Remove semicolons after switch statement.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> b/drivers/thermal/samsung/exynos_tmu.c index
> eac6aebf82f3..1af7ea8dda71 100644 ---
> a/drivers/thermal/samsung/exynos_tmu.c +++
> b/drivers/thermal/samsung/exynos_tmu.c @@ -548,7 +548,7 @@ static int
> exynos5433_tmu_initialize(struct platform_device *pdev) default:
>  		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
>  		break;
> -	};
> +	}
>  
>  	dev_info(&pdev->dev, "Calibration type is %d-point
> calibration\n", cal_type ?  2 : 1);
> @@ -1356,7 +1356,7 @@ static int exynos_tmu_probe(struct
> platform_device *pdev) break;
>  	default:
>  		break;
> -	};
> +	}
>  
>  	/*
>  	 * data->tzd must be registered before calling
> exynos_tmu_initialize(),

Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Tested-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
