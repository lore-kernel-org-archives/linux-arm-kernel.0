From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Mon, 1 Sep 2014 13:30:21 +0530
Subject: [PATCH 5/5] phy: exynos5-usbdrd: Adding Kconfig dependency for
 Exynos7
In-Reply-To: <CAN_we7MQAqEsRaQc_pkRE_KXx9zZNLDBR2aHUrazM30Nv3udmQ@mail.gmail.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
 <1409212920-28526-6-git-send-email-gautam.vivek@samsung.com>
 <CAN_we7MQAqEsRaQc_pkRE_KXx9zZNLDBR2aHUrazM30Nv3udmQ@mail.gmail.com>
Message-ID: <CAFp+6iHsfg6Ru0LBN=JviV=-mSdmuSo9Te3EXYF+X8jssD_BYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 8:36 PM, Daniele Forsi <dforsi@gmail.com> wrote:
> 2014-08-28 10:02 GMT+02:00 Vivek Gautam:
>
>> This USB 3.0 PHY controller is also present on Exynos7
>> platform, so adding the dependency on ARCH_EXYNOS7 for this driver.
>
>> +++ b/drivers/phy/Kconfig
>> @@ -186,7 +186,7 @@ config PHY_EXYNOS5250_USB2
>>
>>  config PHY_EXYNOS5_USBDRD
>>         tristate "Exynos5 SoC series USB DRD PHY driver"
>> -       depends on ARCH_EXYNOS5 && OF
>> +       depends on (ARCH_EXYNOS5 || ARCH_EXYNOS7) && OF
>
> shouldn't that prompt and its help text be updated to mention also Exynos7?

Right, even that has to be updated accordingly. Will update the same in next
version of the patch. Thanks for pointing this.



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
