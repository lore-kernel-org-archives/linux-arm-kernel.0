From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 14 Apr 2012 08:50:07 -0700
Subject: [PATCH 0/4] ARM: Exynos4: NURI and UniversalC210 fixes for
 v3.4-rc2
In-Reply-To: <00c101cd17ae$4582f0d0$d088d270$%szyprowski@samsung.com>
References: <1333698206-12348-1-git-send-email-m.szyprowski@samsung.com>
 <4F84686D.60606@samsung.com>
 <00c101cd17ae$4582f0d0$d088d270$%szyprowski@samsung.com>
Message-ID: <4F899CAF.6080906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/12 23:42, Marek Szyprowski wrote:
> Hi Kukjin,
>
Hi Marek :)

> On Tuesday, April 10, 2012 7:06 PM Kukjin Kim wrote:
>
>>> I've just checked the support for Samsung NURI and UniversalC210 boards
>>> in v3.4-rc1 and found some issues. The attached patches fixes the
>>> leftovers from missing s3c-sdhci driver changes, fixes division by
>>> zero caused by missing initial value for xusbxti clock and removes broken
>>> optional configuration entries for touch screen driver. It would be great
>>> if the attached patches will get merged to v3.4-rcX series.
>>>
>> OK, looks good to me, applied.
>
> Huh, it doesn't look that easy...
>
> I've just noticed that v3.4-rc2 comes with missing s3c-sdhci driver patches
> (see commit 1ddca05743525), so you need a bit more work on your fixes branch
> to get sdhci working again. Please restore patches 'ARM: EXYNOS: use
> 'exynos4-sdhci' as device name for sdhci controllers' and 'ARM: SAMSUNG:
> remove all uses of clk_type member in sdhci platform data' as well as the
> other patches which fixes issues after changing the name of sdhci platform
> devices from s3c-sdhci to exynos4-sdhci. My patch 'ARM: EXYNOS: fix SDHCI
> support on NURI and UniversalC210 boards' should be dropped then.
>
> If you have any problems, let me know, I have them already collected and
> rebased onto v3.4-rc2, so I can resend an updated version.
>

Thanks for your reminder. I re-worked Thomas' patches you said for it 
and you can check it in my -next and -fixes-3 and I'm looking at that.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
