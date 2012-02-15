From: khilman@ti.com (Kevin Hilman)
Date: Wed, 15 Feb 2012 11:46:35 -0800
Subject: [PATCH v2] ARM: OMAP: clock: cleanup CPUfreq leftovers
In-Reply-To: <CAORVsuUvv0Z36FK19J90uj8g16T9tvWzubpEF5s==wm_fXBB3w@mail.gmail.com>
 (Jean Pihet's message of "Wed, 15 Feb 2012 11:23:22 -0800")
References: <1329333165-29646-1-git-send-email-khilman@ti.com>
 <CAORVsuUvv0Z36FK19J90uj8g16T9tvWzubpEF5s==wm_fXBB3w@mail.gmail.com>
Message-ID: <87lio398x0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> HI Kevin,
>
> On Wed, Feb 15, 2012 at 11:12 AM, Kevin Hilman <khilman@ti.com> wrote:
>> --- a/arch/arm/plat-omap/include/plat/clock.h
>> +++ b/arch/arm/plat-omap/include/plat/clock.h
>> @@ -272,7 +272,7 @@ struct clk {
>> ?#endif
>> ?};
>>
>> -struct cpufreq_frequency_table;
>> +/* struct cpufreq_frequency_table; */
> This needs to be removed.

Oops, thanks for catching.

Kevin
