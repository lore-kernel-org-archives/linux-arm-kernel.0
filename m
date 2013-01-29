From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 29 Jan 2013 21:27:56 +0800
Subject: [PATCH] ARM:common: deleting waste code which never execute
In-Reply-To: <5107CD3B.4080600@asianux.com>
References: <5107CD3B.4080600@asianux.com>
Message-ID: <5107CE5C.3060209@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  sorry, need send patch v2 (or report warning for temp when building)

? 2013?01?29? 21:23, Chen Gang ??:
> 
>   delete the waste code which never execute
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/common/scoop.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
> index a5c3dc3..6ef146e 100644
> --- a/arch/arm/common/scoop.c
> +++ b/arch/arm/common/scoop.c
> @@ -232,8 +232,6 @@ static int scoop_probe(struct platform_device *pdev)
> 
>  	return 0;
> 
> -	if (devptr->gpio.base != -1)
> -		temp = gpiochip_remove(&devptr->gpio);
>  err_gpio:
>  	platform_set_drvdata(pdev, NULL);
>  err_ioremap:
> 


-- 
Chen Gang

Asianux Corporation
