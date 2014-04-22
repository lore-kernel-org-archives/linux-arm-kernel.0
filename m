From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 22 Apr 2014 23:22:40 +0200
Subject: [PATCH] ARM: berlin: add CPU_V7 to Marvell Armada 1500-mini
 (BG2CD)
In-Reply-To: <CAL_JsqKvBWk3bD3=G=kY+8yitV6M7Gx=7JnwJeH=yns5dvXbnA@mail.gmail.com>
References: <1397587699-11023-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <5356B0C2.6010708@gmail.com>
 <CAL_JsqKvBWk3bD3=G=kY+8yitV6M7Gx=7JnwJeH=yns5dvXbnA@mail.gmail.com>
Message-ID: <5356DDA0.6060405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 08:29 PM, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 1:11 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>> On 04/15/2014 08:48 PM, Sebastian Hesselbarth wrote:
>>> This selects missing CPU_V7 for ARM Cortex-A9 based Marvell Armada
>>> 1500-mini (BG2CD).
>>>
>>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> ---
>>
>> Applied to berlin/soc.
>>
>>> ---
>>>  arch/arm/mach-berlin/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
>>> index d3c5f14dc142..0add8350faf4 100644
>>> --- a/arch/arm/mach-berlin/Kconfig
>>> +++ b/arch/arm/mach-berlin/Kconfig
>>> @@ -18,6 +18,7 @@ config MACH_BERLIN_BG2
>>>  config MACH_BERLIN_BG2CD
>>>       bool "Marvell Armada 1500-mini (BG2CD)"
>>>       select CACHE_L2X0
>>> +     select CPU_V7
> 
> This should not be needed. This gets selected by multi-platform with
> ARCH_MULTI_V7.

Dropped again, thanks for sending the cleanup :)

Sebastian
