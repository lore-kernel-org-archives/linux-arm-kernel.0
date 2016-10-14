From: panand@redhat.com (Pratyush Anand)
Date: Fri, 14 Oct 2016 08:45:43 +0530
Subject: [PATCH 2/3] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <CAJt8pk8OOTbuNhN635kRCot89eLjXPQqd2AG2qJ_t7GComtZCw@mail.gmail.com>
References: <1474643941-109020-1-git-send-email-labath@google.com>
 <1474643941-109020-2-git-send-email-labath@google.com>
 <CAHB_GupyUp_s4nWq-QVnEoCZvmkrXyCcxs-XpH3x0Yugkknpzg@mail.gmail.com>
 <CAJt8pk9WOhebSXpbahbbLscqJcY1OOqHiA_9hHC0zmHruRPxWQ@mail.gmail.com>
 <CAHB_GupR4sJtAGYdRwvCwu7891KM8TEByZCgqMCrYrdt=cJuYw@mail.gmail.com>
 <CAJt8pk-HJYFUCxRuY5EV6KnM+kNP6mVBrFgPwiGfEkMKqGyjXw@mail.gmail.com>
 <CAHB_GupRgSgnQS+YKhKxWhf8+t+GP5+7_hoigKUQaYcnhwG8NA@mail.gmail.com>
 <CAJt8pk8OOTbuNhN635kRCot89eLjXPQqd2AG2qJ_t7GComtZCw@mail.gmail.com>
Message-ID: <16572d35-bf69-1680-717a-d2815b121c32@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 13 October 2016 10:33 PM, Pavel Labath wrote:
>> I think, its easier to go with your implementation. So, I have taken
>> > your patch and updated my perf/upstream_arm64_devel branch. May be you
>> > can give it a test for your test cases.
> I've checked out the new version of your branch, and it works great.
> I'll write a patch with additional test cases to go on top of your
> branch, as the tests there do not capture the bug I was fixing.

That would be great. We can send them all together as V2.

Thanks for your help.

~Pratyush
