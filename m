From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 12 Feb 2018 09:10:29 -0600
Subject: [PATCH] acpi, spcr: Make SPCR available to x86
In-Reply-To: <7bd5897f-d6da-7e29-29c4-aa26d24f6355@redhat.com>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
 <7bd5897f-d6da-7e29-29c4-aa26d24f6355@redhat.com>
Message-ID: <50309183-d8e4-aa24-f37d-596e4334f50e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/18 8:49 AM, Prarit Bhargava wrote:
> That's true on ARM64.  I specifically did not enable the console by default on
> x86.  There are users who do not want a console active during boot & runtime.

Hmmmm... That's a good point.  On ARM systems with SPCR, you get a 
console whether you like it or not.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
