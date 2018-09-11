From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Tue, 11 Sep 2018 21:41:55 +0530
Subject: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
In-Reply-To: <20180911151148.GI2651@arm.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20180911151148.GI2651@arm.com>
Message-ID: <2714af83-d2f7-473e-c234-428d2b8a84f0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/11/2018 8:41 PM, Will Deacon wrote:
> Hello,
> 
> On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
>> This patch series adds Event tracing support to pstore and is continuation
>> to the RFC patch introduced to add a new tracing facility for register
>> accesses called Register Trace Buffer(RTB). Since we decided to not introduce
>> a separate framework to trace register accesses and use existing framework
>> like tracepoints, I have moved from RFC. Details of the RFC in link below:
>>
>> Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan at codeaurora.org/
> 
> The arm64 backend bits look fine to be, but they're mixed up with core
> changes that I haven't looked at closely.
> 
Hi Will,

Thanks for the review. Let me know if you have any suggestions or points 
regarding this patch, I will be happy to incorporate it.
