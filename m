From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 23 Jul 2013 16:34:36 +0100
Subject: [PATCH 4/5] ARM: highbank: remove redundant smp_init_cpus
 definition
In-Reply-To: <51EE9B38.5030003@gmail.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374579164-30255-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51EE9B38.5030003@gmail.com>
Message-ID: <51EEA28C.9070506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/13 16:03, Rob Herring wrote:
> On 07/23/2013 06:32 AM, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> arm_dt_init_cpu_maps is called before smp_init_cpus, which sets the
>> cpu_possible_mask appropriately. Since highbank_smp_init_cpus does
>> nothing extra, it can be removed.
> 
> This is all going to get removed in my PSCI support series. Trying to
> get an updated version out soon.
> 
Thanks for the update.

Regards,
Sudeep
