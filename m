From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Sep 2011 13:36:57 -0700
Subject: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
In-Reply-To: <CAC83ZvKa7R_rUe-Fa15m0_5P-GE4WC2thazQ+iqF-HAqn8cE1w@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Thu, 22 Sep 2011 20:57:34 +0530")
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<CAC83ZvKa7R_rUe-Fa15m0_5P-GE4WC2thazQ+iqF-HAqn8cE1w@mail.gmail.com>
Message-ID: <87fwjotity.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarun,

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Tue, Sep 13, 2011 at 6:32 PM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
>> This series is continuation of cleanup of OMAP GPIO driver and fixes.
>> The cleanup include getting rid of cpu_is_* checks wherever possible,
>> use of gpio_bank list instead of static array, use of unique platform
>> specific value associated data member to OMAP platforms to avoid
>> cpu_is_* checks. The series also include PM runtime support.*
>>
>> Baseline: git://gitorious.org/khilman/linux-omap-pm.git
>> Branch: for_3.2/gpio-cleanup
>> Commit: 8323374
> Thanks Tony for ack'ing the patches.
> Kevin,
> Since Tony's has acked the patches, can you please pull them?

Before merging, I still need to review and test this version, and I
*might* still get to it this week.

Based on the dbclk aliases you added, I assume this has now been tested
on platforms using some GPIOs with debounce enabled?

Kevin
