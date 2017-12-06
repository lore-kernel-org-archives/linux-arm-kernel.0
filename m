From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 06 Dec 2017 13:09:17 +0100
Subject: [PATCH 3/6] cpufreq: sort the drivers in ARM part
In-Reply-To: <20171204091850.iamq5uslv3hv6bez@vireshk-mac-ubuntu> (Viresh
 Kumar's message of "Mon, 4 Dec 2017 14:48:50 +0530")
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
 <20171201112508.14121-4-gregory.clement@free-electrons.com>
 <20171204091850.iamq5uslv3hv6bez@vireshk-mac-ubuntu>
Message-ID: <87o9nct5w2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,
 
 On lun., d?c. 04 2017, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 01-12-17, 12:25, Gregory CLEMENT wrote:
>> Keep the driver files alphabetically sorted.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/cpufreq/Makefile | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 812f9e0d01a3..d762e76887e7 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -53,22 +53,24 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
>>  obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
>>  
>>  obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
>> +obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
>
> Shouldn't we add them in ascending order of the whole config name and not just
> CPPC_CPUFREQ ?

Here it is the object name that are sorted not the CONFIG_ name. So
cppc_cpufreq comes after brcmstb-avs-cpufreq.

Thanks,

Gregory

>
> -- 
> viresh

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
