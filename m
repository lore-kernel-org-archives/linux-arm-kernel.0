From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 13 May 2015 08:57:47 +0200
Subject: [PATCH] ARM: sti: fix documentation reference
In-Reply-To: <20150512185649.GB2558@tarshish>
References: <d0f22751247391d5f7f1b8ebec507a8e0c4b4943.1430395589.git.baruch@tkos.co.il>
 <20150512185649.GB2558@tarshish>
Message-ID: <5552F5EB.6020604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch

On 05/12/2015 08:56 PM, Baruch Siach wrote:
> Hi STi maintainers,
>
> On Thu, Apr 30, 2015 at 03:06:29PM +0300, Baruch Siach wrote:
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>   arch/arm/mach-sti/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
>> index 3b1ac463a494..f7d42ddf95f6 100644
>> --- a/arch/arm/mach-sti/Kconfig
>> +++ b/arch/arm/mach-sti/Kconfig
>> @@ -17,7 +17,7 @@ menuconfig ARCH_STI
>>   	help
>>   	  Include support for STiH41x SOCs like STiH415/416 using the device tree
>>   	  for discovery
>> -	  More information at Documentation/arm/STiH41x and
>> +	  More information at Documentation/arm/sti and
>>   	  at Documentation/devicetree
> Ping?
>
> baruch
>
Sorry for the late answer

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
