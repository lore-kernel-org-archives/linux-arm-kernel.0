From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Tue, 18 Sep 2018 18:13:33 +0530
Subject: [PATCH 5/6] arm64/io: Add header for instrumentation of io
 operations
In-Reply-To: <20180918114727.GE16498@arm.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <bb322d763aa6c58f036e5209a481c769be92ab9b.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20180917193940.3d68ef88@gandalf.local.home>
 <c6470671-3abf-c296-586e-cca5131cc437@codeaurora.org>
 <20180918114727.GE16498@arm.com>
Message-ID: <b3bc8d9b-9199-655e-bc62-4e37760fca14@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/18/2018 5:17 PM, Will Deacon wrote:
> On Tue, Sep 18, 2018 at 12:40:57PM +0530, Sai Prakash Ranjan wrote:
>> On 9/18/2018 5:09 AM, Steven Rostedt wrote:
>>> On Sun,  9 Sep 2018 01:57:06 +0530
>>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>>>> The new asm-generic/io-instrumented.h will keep arch code
>>>> clean and separate from instrumented version which traces
>>>> io register accesses. This instrumented header can later
>>>> be included in arm as well for tracing io register accesses.
>>>>
>>>
>>> Looks good to me.
>>>
>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>
>>> -- Steve
>>
>> Thanks for the ack Steve.
>>
>> @Will/Mark/Robin Let me know if you have any review comments, thanks.
> 
> As I said before, the arm64 bits looks fine to me. I just don't really want
> to Ack the thing because the patch also contains the asm-generic changes.
> 
> Will
> 

Ok thank you. Is there anyone else whom I should add for asm-generic?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
