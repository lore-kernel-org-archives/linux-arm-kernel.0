From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Sep 2015 10:50:24 -0700
Subject: [PATCH] soc: qcom: Make qcom_smem_get() return a pointer
In-Reply-To: <20150901045055.GA13472@usrtlx11787.corpusers.net>
References: <1441071666-16156-1-git-send-email-sboyd@codeaurora.org>
 <20150901045055.GA13472@usrtlx11787.corpusers.net>
Message-ID: <55E5E560.6080507@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2015 09:50 PM, Bjorn Andersson wrote:
> On Mon 31 Aug 18:41 PDT 2015, Stephen Boyd wrote:
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> This is on top of the smd and smem big endian support.
>>
> How sneaky of you, then we need to approve those patches before we
> add new consumers of this API...

I was being explicit to remove any subterfuge. I actually rebased this
to the end of the series, so I suspect it will apply fine without the
big endian stuff. This was mostly making a note that I tested this on
top of those commits.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
