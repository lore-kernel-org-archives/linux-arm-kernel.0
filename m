From: panand@redhat.com (Pratyush Anand)
Date: Thu, 20 Oct 2016 11:23:49 +0530
Subject: [PATCH 2/3] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <20161019120714.GM9193@arm.com>
References: <1474643941-109020-1-git-send-email-labath@google.com>
 <1474643941-109020-2-git-send-email-labath@google.com>
 <CAHB_GupyUp_s4nWq-QVnEoCZvmkrXyCcxs-XpH3x0Yugkknpzg@mail.gmail.com>
 <CAJt8pk9WOhebSXpbahbbLscqJcY1OOqHiA_9hHC0zmHruRPxWQ@mail.gmail.com>
 <CAHB_GupR4sJtAGYdRwvCwu7891KM8TEByZCgqMCrYrdt=cJuYw@mail.gmail.com>
 <CAJt8pk-HJYFUCxRuY5EV6KnM+kNP6mVBrFgPwiGfEkMKqGyjXw@mail.gmail.com>
 <CAHB_GupRgSgnQS+YKhKxWhf8+t+GP5+7_hoigKUQaYcnhwG8NA@mail.gmail.com>
 <CAJt8pk8OOTbuNhN635kRCot89eLjXPQqd2AG2qJ_t7GComtZCw@mail.gmail.com>
 <16572d35-bf69-1680-717a-d2815b121c32@redhat.com>
 <20161019120714.GM9193@arm.com>
Message-ID: <00a971a1-983a-b631-a982-ea29e8daa2c9@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wednesday 19 October 2016 05:37 PM, Will Deacon wrote:
> On Fri, Oct 14, 2016 at 08:45:43AM +0530, Pratyush Anand wrote:
>>
>>
>> On Thursday 13 October 2016 10:33 PM, Pavel Labath wrote:
>>>> I think, its easier to go with your implementation. So, I have taken
>>>>> your patch and updated my perf/upstream_arm64_devel branch. May be you
>>>>> can give it a test for your test cases.
>>> I've checked out the new version of your branch, and it works great.
>>> I'll write a patch with additional test cases to go on top of your
>>> branch, as the tests there do not capture the bug I was fixing.
>>
>> That would be great. We can send them all together as V2.
>
> Did you send a v2? I've been holding off reviewing this, but I just want
> to make sure I didn't miss the update.

I just posted V2.

http://www.spinics.net/lists/arm-kernel/msg537194.html

~Pratyush
