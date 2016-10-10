From: panand@redhat.com (Pratyush Anand)
Date: Mon, 10 Oct 2016 22:38:40 +0530
Subject: [PATCH 2/3] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <CAJt8pk9WOhebSXpbahbbLscqJcY1OOqHiA_9hHC0zmHruRPxWQ@mail.gmail.com>
References: <1474643941-109020-1-git-send-email-labath@google.com>
 <1474643941-109020-2-git-send-email-labath@google.com>
 <CAHB_GupyUp_s4nWq-QVnEoCZvmkrXyCcxs-XpH3x0Yugkknpzg@mail.gmail.com>
 <CAJt8pk9WOhebSXpbahbbLscqJcY1OOqHiA_9hHC0zmHruRPxWQ@mail.gmail.com>
Message-ID: <149b6faf-8643-3b9b-8cd4-8ec6d59e328f@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 07 October 2016 10:54 PM, Pavel Labath wrote:
> However, I did notice that it does not work if we watch an address
>> which is at some offset from address programmed. For example, it works
>> when byte_mask is 0x3, but it does not work if byte_mask if 0x2 (which
>> is supported by hardware).
>>
>> I do have some patches to resolve that.
>>
>> https://github.com/pratyushanand/linux/commits/perf/upstream_arm64_devel
>>
>> I will send them for review comment after some testing.

This branch has been updated with a test code as well. So far they work 
fine at my end. Planning to send them tomorrow for review.

~Pratyush
