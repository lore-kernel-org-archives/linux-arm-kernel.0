From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 5 Oct 2015 12:34:52 +0530
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable rtl8152 ethernet driver
 for Odroid-XU4
In-Reply-To: <56121AF4.6020202@samsung.com>
References: <1444026570-14076-1-git-send-email-linux.amoon@gmail.com>
 <56121AF4.6020202@samsung.com>
Message-ID: <CANAwSgSCfy_X+HD2NdoeGxSV5srv_a+vzw8Gs94PgVkwn2ZjwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Krzysztof,

On 5 October 2015 at 12:08, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On 05.10.2015 15:29, Anand Moon wrote:
>> Enable CONFIG_USB_RTL8152 for Odroid-XU4.
>
> Why?
>
> Best regards,
> Krzysztof
>
>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  arch/arm/configs/exynos_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
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
>>
>

Odroid XU4 supports RTL8152/RTL8153 Based USB 3.0 Ethernet Adapters.

Will send v2 version of the patch.

-Anand Moon
