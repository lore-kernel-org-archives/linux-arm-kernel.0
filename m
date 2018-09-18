From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Tue, 18 Sep 2018 12:40:57 +0530
Subject: [PATCH 5/6] arm64/io: Add header for instrumentation of io
 operations
In-Reply-To: <20180917193940.3d68ef88@gandalf.local.home>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <bb322d763aa6c58f036e5209a481c769be92ab9b.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20180917193940.3d68ef88@gandalf.local.home>
Message-ID: <c6470671-3abf-c296-586e-cca5131cc437@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/18/2018 5:09 AM, Steven Rostedt wrote:
> On Sun,  9 Sep 2018 01:57:06 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> The new asm-generic/io-instrumented.h will keep arch code
>> clean and separate from instrumented version which traces
>> io register accesses. This instrumented header can later
>> be included in arm as well for tracing io register accesses.
>>
> 
> Looks good to me.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve

Thanks for the ack Steve.

@Will/Mark/Robin Let me know if you have any review comments, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
