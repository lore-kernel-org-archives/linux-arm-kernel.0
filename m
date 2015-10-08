From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 08 Oct 2015 16:46:27 +0900
Subject: [PATCHv3 1/2] ARM: exynos_defconfig: Enable rtl8152 ethernet
 driver for Odroid-XU4
In-Reply-To: <5077751.tKglqqEUaI@wuerfel>
References: <1444276117-3657-1-git-send-email-linux.amoon@gmail.com>
 <5077751.tKglqqEUaI@wuerfel>
Message-ID: <56161F53.50505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.10.2015 16:41, Arnd Bergmann wrote:
> On Thursday 08 October 2015 03:48:36 Anand Moon wrote:
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index 1ff2bfa..5d1937b 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -61,6 +61,7 @@ CONFIG_BLK_DEV_DM=y
>>  CONFIG_DM_CRYPT=m
>>  CONFIG_NETDEVICES=y
>>  CONFIG_SMSC911X=y
>> +CONFIG_USB_RTL8152=y
>>  CONFIG_USB_USBNET=y
>>  CONFIG_USB_NET_SMSC75XX=y
>>  CONFIG_USB_NET_SMSC95XX=y
> 
> Can we make that a loadable module for multi_v7_defconfig?

What about nfsroot boots? We were discussing this also here:
http://linux-arm-kernel.infradead.narkive.com/lG5g4hrB/patch-arm-multi-v7-defconfig-enable-usb3503

and actually I would be happy to see a confirmed policy about that.
Everything should be a module for multi_v7?

Best regards,
Krzysztof
