From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 13 Jun 2012 14:50:13 +0200
Subject: [RFC 3/4] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <1339591666.8980.26.camel@twins>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
 <CAORVsuWqWt0pJfewymh_ydAH61-uPsO0M7m7Gs4N3zJY=Vo9ZA@mail.gmail.com>
 <CAKfTPtBc-KuDg_1qe04TfYS4+66qQoiHCJQbCF9gnhga5ociow@mail.gmail.com>
 <CAP245DXEOGLe1jq2Wj0rNW5qea63UyJu2jOvwV65Y4B9LLoQtg@mail.gmail.com>
 <1339591666.8980.26.camel@twins>
Message-ID: <CAORVsuXBOHrhx=AFVgdC01=1YFfBgCDpwBH_cn7LBujLfc0rcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit, Peter,

On Wed, Jun 13, 2012 at 2:47 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, 2012-06-13 at 18:14 +0530, Amit Kucheria wrote:
>> Various discussions around power-aware scheduling have amplified the
>> need for the scheduler to have some knowledge of DVFS. This would then
>> require the scheduler to track 'cpu_power' ( = max power) and perhaps
>> a new variable 'current_power' that is changed by the DVFS framework.
>
> Note that capacity is in fact a better term -- not to be confused with
> the capacity as currently in use within the load-balancer. Luckily
> there's no way to read that an not be confused.. uhmm :-)
>>
>> The first goal, though, is to make sure that the scheduler can handle
>> different cpu_power values due to asymmetric cores.
>
> I would think the very first goal was to do a simple packing balancer
> before doing silly things with asymmetric setups.. but what do I know.
Sure! First things first ;p

Thanks for the details!

Regards,
Jean
