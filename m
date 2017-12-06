From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 06 Dec 2017 12:52:20 +0100
Subject: [PATCH 2/6] cpufreq: ARM: sort the Kconfig menu
In-Reply-To: <20171204084124.mchpmw3kta5tddgh@vireshk-mac-ubuntu> (Viresh
 Kumar's message of "Mon, 4 Dec 2017 14:11:24 +0530")
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
 <20171201112508.14121-3-gregory.clement@free-electrons.com>
 <20171204084124.mchpmw3kta5tddgh@vireshk-mac-ubuntu>
Message-ID: <87shcot6ob.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,
 
 On lun., d?c. 04 2017, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 01-12-17, 12:25, Gregory CLEMENT wrote:
>> +config ARM_VEXPRESS_SPC_CPUFREQ
>> +        tristate "Versatile Express SPC based CPUfreq driver"
>> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
>> +        help
>> +          This add the CPUfreq driver support for Versatile Express
>> +	  big.LITTLE platforms using SPC for power management.
>> +
>> +config ARM_SCPI_CPUFREQ
>
> The order of above two must be reversed ?

Right, I will fix it.

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
