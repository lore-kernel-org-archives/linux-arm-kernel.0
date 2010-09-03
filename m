From: deepak.sikri@st.com (deepaksi)
Date: Fri, 3 Sep 2010 11:50:50 +0530
Subject: [PATCH 49/74] SPEAr CPU freq: Adding support for CPU
	Freq	framework
In-Reply-To: <20100902102407.GQ26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<95e9f2e2d8e2a23629760a7dcb7cbab098ff7412.1283161023.git.viresh.kumar@st.com>
	<20100902102407.GQ26319@n2100.arm.linux.org.uk>
Message-ID: <4C8093C2.2010204@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 3:54 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 30, 2010 at 04:09:13PM +0530, Viresh KUMAR wrote:
>   
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index c4d1df3..ef92faa 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -822,6 +822,8 @@ config PLAT_SPEAR
>>  	select COMMON_CLKDEV
>>  	select GENERIC_CLOCKEVENTS
>>  	select HAVE_CLK
>> +	select ARCH_HAS_CPUFREQ
>> +
>>     
> You should avoid this blank line.
>   

Ok..
>>  	help
>>  	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
>>     
> .
>
>   
