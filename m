From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 16 Apr 2014 19:05:53 +0530
Subject: [PATCH v2 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
In-Reply-To: <20140416105121.GR4754@lee--X1>
References: <534DB213.7080802@semaphore.gr>
	<20140416105121.GR4754@lee--X1>
Message-ID: <CAKohpongiw9kZJDBsnp4U5obzX_W-sWHX3GoKd3STtQmsw6GcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2014 16:21, Lee Jones <lee.jones@linaro.org> wrote:
>> The cpufreq core now supports the cpufreq_for_each_entry macro helper
>> for iteration over the cpufreq_frequency_table, so use it.
>>
>> It should have no functional changes.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
>>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> Applied untested by me.

Wouldn't build. Let it go via Rafael.
