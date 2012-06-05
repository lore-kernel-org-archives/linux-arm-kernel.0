From: bill4carson@gmail.com (bill4carson)
Date: Tue, 05 Jun 2012 12:50:07 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <7281E51A-3008-49A5-8388-1F8B788B32A3@mvista.com>
References: <4FAA34A9.5020708@gmail.com>
 <7281E51A-3008-49A5-8388-1F8B788B32A3@mvista.com>
Message-ID: <4FCD8FFF.8040901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Geroge

thanks for your updates.


On 2012?06?05? 12:06, George G. Davis wrote:
> Hello,
>
> On May 9, 2012, at 5:11 AM, bill4carson wrote:
>
>> Hi, All
>>
>> I'm using ARM11 MPCore on linux-2.6.34, unfortunately I have random
>> panic/segment fault with task migration. I noticed a patch set
>> [ARM11 MPCore: preemption/task migration cache coherency fixups] to fix
>> such issues in here:
>>
>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069851.html
>>
>> It seems there is no follow ups, is there official patch to fix such
>> issues?
>
> Apologies for the delayed reply.  Yes, I believe those patches are still needed
> for ARM11 MPCore, even when not using PREEMPT.  I vaguely recall at least
> two cases where problems occurred w/o those patches, 1) LTP stress would
> randomly fail, and 2) parallel module loading would invariably oops with a
> random fault, with results similar to what you've reported later in this thread.
> The most reliable test case to reproduce the failure was the parallel module
> loading.  LTP stress test runs took a long time to trigger the errors.
>
> I'm dusting off the patches and trying to resurrect the test cases to see if I can
> reproduce the errors on latest kernel.org.  I'll followup with results in a day or
> so.  FWIW,   I've got LTP stress running on latest kernel.org now but probably
> should have resurrected the parallel module loading test case instead, as
> LTP stress may take awhile to reproduce the error, if at all.
>
> --
> Regards,
> George
>
>>
>>
>> thanks
>>
>> --
>> Love each day!
>>
>> --bill
>
>

-- 
Love each day!

--bill
