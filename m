From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Jul 2014 19:11:33 +0800
Subject: [PATCH 07/19] ARM64 / ACPI: Parse MADT to map logical cpu to
 MPIDR and get cpu_possible/present_map
In-Reply-To: <CAFoFrHYSYhv3cM_zSFA5Xg+Xfr8BszzRVFhd0GODFpduRPBrbQ@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>	<1406206825-15590-8-git-send-email-hanjun.guo@linaro.org>
 <CAFoFrHYSYhv3cM_zSFA5Xg+Xfr8BszzRVFhd0GODFpduRPBrbQ@mail.gmail.com>
Message-ID: <53D23B65.6070708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naresh,

On 2014-7-25 7:06, Naresh Bhat wrote:
> On 24 July 2014 18:30, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> MADT contains the information for MPIDR which is essential for
>> SMP initialization, parse the GIC cpu interface structures to
>> get the MPIDR value and map it to cpu_logical_map(), and add
>> enabled cpu with valid MPIDR into cpu_possible_map and
>> cpu_present_map.
[...]
>> +/**
>> + * acpi_register_gic_cpu_interface - register a gic cpu interface and
>> + * generates a logic cpu number
> 
> logic - logical

Thanks for all the typos you got, will fix them.

Best Regards
Hanjun
