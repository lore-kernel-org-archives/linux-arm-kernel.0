From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Mon, 19 Dec 2016 18:59:08 +0530
Subject: [PATCH v8 1/8] soc: samsung: add exynos chipid driver support
In-Reply-To: <ceba534d-108d-9ac4-d29c-c2a55af49849@fivetechno.de>
References: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
 <1481375323-29724-2-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161219120000epcas1p1904dfec707de0ce20341279f354d74dc@epcas1p1.samsung.com>
 <ceba534d-108d-9ac4-d29c-c2a55af49849@fivetechno.de>
Message-ID: <9b64f5c0-e289-9091-c784-ae4bfad3caf5@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Monday 19 December 2016 05:29 PM, Markus Reichl wrote:
> Hi Pankaj,
> 
> tested your patches 1/8 and 2/8 + Javiers diff for verbose output: 
> https://www.spinics.net/lists/linux-samsung-soc/msg56576.html
> 
> on Odroid U3:
> [    0.080178] Exynos: CPU[UNKNOWN] CPU_REV[0x20] PKG_ID[0x602d058] AUX_INFO[0x0] 
> on Odroid X:
> [    0.080169] Exynos: CPU[UNKNOWN] CPU_REV[0x11] PKG_ID[0x1b0f6008] AUX_INFO[0x0] 
> 
> XU4:	 [    0.080039] Exynos: CPU[EXYNOS5800] CPU_REV[0x1] PKG_ID[0x1c04832a] AUX_INFO[0x43] 
> XU3:	 [    0.080034] Exynos: CPU[EXYNOS5800] CPU_REV[0x1] PKG_ID[0x1604832a] AUX_INFO[0x43] 
> XU3-lite:[    0.080033] Exynos: CPU[EXYNOS5800] CPU_REV[0x1] PKG_ID[0x5a12832a] AUX_INFO[0x13000054] 
> 
> Regards,
> --
> Markus Reichl

Thanks for testing and letting us know.

Hopefully this driver will be of more use in near future, as Javiers
pointed out it can help us to select better ASV tables based on PKG_ID
and AUX_INFO. Even though these fields are not part of the driver in my
patch, it can be extended as per need.

Thanks,
Pankaj Dubey
