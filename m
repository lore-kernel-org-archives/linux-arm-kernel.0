From: myungjoo.ham@samsung.com (=?UTF-8?B?TXl1bmdKb28gSGFt?=)
Date: Thu, 20 Oct 2016 02:22:46 +0000
Subject: =?UTF-8?B?UkU6IFtQQVRDSCAwLzRdIFBNIC8gZGV2ZnJlcTogRml4IG1v?=
 =?UTF-8?B?ZHVsZSBhdXRvbG9hZCBmb3IgcGxhdGZvcm0gZHJpdmVycw==?=
References: <CGME20161019210645epcas1p449463edf9c3cb3681b0a4e8116ccf7f2@epcas1p4.samsung.com>
Message-ID: <877108885.1462124.1476930166421.JavaMail.weblogic@ep1ml101a>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hello,
> 
> I noticed that module autoload won't be working in some of the defreq
> platform drivers. This patch series contains the fixes for these.
> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (4):
>   PM / devfreq: rk3399_dmc: Fix module autoload
>   PM / devfreq: exynos-nocp: Fix module autoload
>   PM / devfreq: rockchip-dfi: Fix module autoload
>   PM / devfreq: exynos-ppmu: Fix module autoload

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

All the four are not at for-4.9-rc branch.
https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=for-4.9-rc


Cheers,
MyungJoo

> 
>  drivers/devfreq/event/exynos-nocp.c  | 1 +
>  drivers/devfreq/event/exynos-ppmu.c  | 1 +
>  drivers/devfreq/event/rockchip-dfi.c | 1 +
>  drivers/devfreq/rk3399_dmc.c         | 1 +
>  4 files changed, 4 insertions(+)
> 
> -- 
> 2.7.4
