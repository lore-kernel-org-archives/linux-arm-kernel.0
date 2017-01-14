From: fu.wei@linaro.org (Fu Wei)
Date: Sat, 14 Jan 2017 19:34:23 +0800
Subject: [PATCH v18 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <20170113192920.GF2472@leverpostej>
References: <20161208173319.6618-1-fu.wei@linaro.org>
 <20170113192920.GF2472@leverpostej>
Message-ID: <CADyBb7vF0v2DwXA8fNUOTQcqriJK1Hp57_G8DKi0WO9FnvrB5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 14 January 2017 at 03:29, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Fri, Dec 09, 2016 at 01:33:04AM +0800, fu.wei at linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Move some enums and marcos to header file;
>>         2. Add a new enum for spi type;
>>         3. Improve printk relevant code;
>>         4. Rename some enums and defines;
>>         5. Rework PPI determination;
>>         6. Rework counter frequency detection;
>>         7. Refactor arch_timer_needs_probing, move it into DT init call
>>         8. Introduce some new structs and refactor the MMIO timer init code
>>         for reusing some common code.
>>
>>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>     memory-mapped timer and SBSA Generic Watchdog timer.
>>     This driver can help to simplify all the relevant timer drivers,
>>     and separate all the ACPI GTDT knowledge from them.
>>
>>     (3)Simplify ACPI code for arm_arch_timer
>>
>>     (4)Add GTDT support for ARM memory-mapped timer.
>>
>> This patchset has been tested on the following platforms with ACPI enabled:
>>     (1)ARM Foundation v8 model
>
> Once v4.10-rc4 comes out this weekend, could you please rebase and
> repost this?

Yes, of course.

I have rebased v19 to the latest v4.10-rc3-e96f8f1, it dosen't need
any modification.
I will rebase it every day, and will repost it if it need any  modification.

But for now, V19 works well with the master branch of upstream kernel.
Do I need to re-post it even if it doesn't need any improvement or
modification? :-)

>
> Marc and I will be happy to take a look then.

Great thanks for your help!

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
