From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Fri, 14 Nov 2014 15:08:38 -0800
Subject: [PATCH 5/6] iommu/arm-smmu: support buggy implementations with
 invalidate-on-map
In-Reply-To: <20141113094826.GA13350@arm.com> (Will Deacon's message of "Thu,
 13 Nov 2014 09:48:26 +0000")
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-6-git-send-email-mitchelh@codeaurora.org>
 <20141112182642.GH26437@arm.com>
 <vnkwy4rg5jqu.fsf@mitchelh-linux.qualcomm.com>
 <20141113094826.GA13350@arm.com>
Message-ID: <vnkwtx21s7m1.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13 2014 at 01:48:26 AM, Will Deacon <will.deacon@arm.com> wrote:
> Ha, damn, then I don't have a user of the shiny new quirks field I added!
> I don't think I'll go as far as removing it altogether though...

I'm sure we'll be making liberal use of that field soon enough ;)



-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
