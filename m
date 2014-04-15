From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 21:40:21 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Select
 CONFIG_MACH_BERLIN_BG2Q
In-Reply-To: <532CB266.6050800@gmail.com>
References: <1395430757-8677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395430757-8677-2-git-send-email-alexandre.belloni@free-electrons.com>
 <532CB266.6050800@gmail.com>
Message-ID: <534D8B25.3070103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 10:43 PM, Sebastian Hesselbarth wrote:
> On 03/21/2014 08:39 PM, Alexandre Belloni wrote:
>> Now that we support Berlin BG2Q, select CONFIG_MACH_BERLIN_BG2Q so
>> that we can
>> boot BG2Q based boards like the BG2Q DMP.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Applied to berlin/soc, Thanks!

After talking to Arnd on IRC, I found out it is not my business
taking patches for multi_v7_defconfig.

Instead of me taking it, you get my

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

>> ---
>>   arch/arm/configs/multi_v7_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig
>> b/arch/arm/configs/multi_v7_defconfig
>> index ee6982976d66..8b09b72fb688 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -15,6 +15,7 @@ CONFIG_ARCH_BCM_MOBILE=y
>>   CONFIG_ARCH_BERLIN=y
>>   CONFIG_MACH_BERLIN_BG2=y
>>   CONFIG_MACH_BERLIN_BG2CD=y
>> +CONFIG_MACH_BERLIN_BG2Q=y
>>   CONFIG_GPIO_PCA953X=y
>>   CONFIG_ARCH_HIGHBANK=y
>>   CONFIG_ARCH_HI3xxx=y
>>
> 
