From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 19 Mar 2014 13:28:50 +0100
Subject: [PATCH v2 5/7] sched: add a new SD_SHARE_POWERDOMAIN for
 sched_domain
In-Reply-To: <20140319115904.GJ27632@laptop.programming.kicks-ass.net>
References: <1395165409-18055-1-git-send-email-vincent.guittot@linaro.org>
 <1395165409-18055-6-git-send-email-vincent.guittot@linaro.org>
 <20140319115904.GJ27632@laptop.programming.kicks-ass.net>
Message-ID: <CAKfTPtD-_u6WsiV_NJmJxe3iqL_Vw6Xu8wtkgGsB3yAFpbdbKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2014 12:59, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 18, 2014 at 06:56:47PM +0100, Vincent Guittot wrote:
>
>
>> @@ -5946,7 +5948,8 @@ static int sched_domains_curr_level;
>>       (SD_SHARE_CPUPOWER |            \
>>        SD_SHARE_PKG_RESOURCES |       \
>>        SD_NUMA |                      \
>> -      SD_ASYM_PACKING)
>> +      SD_ASYM_PACKING |              \
>> +      SD_SHARE_POWERDOMAIN)
>
> You forgot to update the pretty comment above that :-)

yes, i'm going to update it

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
