From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 22 Oct 2010 13:21:29 +0800
Subject: [PATCH 4/9] drivers/rtc: typo fix of faild to failed
In-Reply-To: <4279ee540bfed9c40ba26698bfe7abddb8921ee4.1287724261.git.joe@perches.com>
References: <cover.1287724261.git.joe@perches.com>
	<4279ee540bfed9c40ba26698bfe7abddb8921ee4.1287724261.git.joe@perches.com>
Message-ID: <AANLkTikG+n_Z4gY9i0gpVk5M+MHW46Tzg_xSnjVgih_e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Joe,

Thanks for your help.

2010/10/22 Joe Perches <joe@perches.com>:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> ?drivers/rtc/rtc-nuc900.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
> index 62de66a..ddb0857 100644
> --- a/drivers/rtc/rtc-nuc900.c
> +++ b/drivers/rtc/rtc-nuc900.c
> @@ -274,7 +274,7 @@ static int __devinit nuc900_rtc_probe(struct platform_device *pdev)
> ? ? ? ?nuc900_rtc->rtcdev = rtc_device_register(pdev->name, &pdev->dev,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&nuc900_rtc_ops, THIS_MODULE);
> ? ? ? ?if (IS_ERR(nuc900_rtc->rtcdev)) {
> - ? ? ? ? ? ? ? dev_err(&pdev->dev, "rtc device register faild\n");
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "rtc device register failed\n");

Acked-by: Wan ZongShun <mcuos.com@gmail.com>

> ? ? ? ? ? ? ? ?err = PTR_ERR(nuc900_rtc->rtcdev);
> ? ? ? ? ? ? ? ?goto fail3;
> ? ? ? ?}
> --
> 1.7.3.1.g432b3.dirty
>
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
