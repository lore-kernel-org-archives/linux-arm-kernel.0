From: kumarrav@codeaurora.org (Ravi Kumar V)
Date: Tue, 17 Jan 2012 12:02:37 +0530
Subject: [PATCH v2 2/2] msm: DMAEngine: Add DMAEngine driver based on
 old MSM DMA APIs
In-Reply-To: <4F0ACB65.3040802@codeaurora.org>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
 <1325854052-21402-3-git-send-email-kumarrav@codeaurora.org>
 <1325901569.10425.14.camel@m0nster> <4F0ACB65.3040802@codeaurora.org>
Message-ID: <4F151605.4050700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/9/2012 4:41 PM, Ravi Kumar V wrote:
> On 1/7/2012 7:29 AM, Daniel Walker wrote:
>> On Fri, 2012-01-06 at 18:17 +0530, Ravi Kumar V wrote:
>>> Add DMAEngine based driver using the old MSM DMA APIs internally.
>>> The benefit of this approach is that not all the drivers
>>> have to get converted to DMAEngine APIs simultaneosly while
>>> both the drivers can stay enabled in the kernel. The client
>>> drivers using the old MSM APIs directly can now convert to
>>> DMAEngine one by one.
>>>
>>> Change-Id: I3647ed7b8c73b3078dfa8877a3560db3cb0a2373
>>> Signed-off-by: Ravi Kumar V<kumarrav@codeaurora.org>
>>> ---
>
> I will address the comments in next patch release, i will wait for
> sometime for vinod comments and release new patch v3.
>
> Ravi

Dan please can you review my patches and let me know your comments.

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
