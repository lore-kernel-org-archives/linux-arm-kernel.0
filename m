From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Sep 2018 16:11:49 +0100
Subject: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <20180911151148.GI2651@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
> This patch series adds Event tracing support to pstore and is continuation
> to the RFC patch introduced to add a new tracing facility for register
> accesses called Register Trace Buffer(RTB). Since we decided to not introduce
> a separate framework to trace register accesses and use existing framework
> like tracepoints, I have moved from RFC. Details of the RFC in link below:
> 
> Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan at codeaurora.org/

The arm64 backend bits look fine to be, but they're mixed up with core
changes that I haven't looked at closely.

Will
