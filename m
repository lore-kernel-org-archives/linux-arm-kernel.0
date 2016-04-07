From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Thu, 07 Apr 2016 12:29:59 -0700
Subject: [PATCH 1/2] iommu: Support dynamic pgsize_bitmap
In-Reply-To: <5704E937.3020602@arm.com> (Robin Murphy's message of "Wed, 6 Apr
 2016 11:47:19 +0100")
References: <1459890090-16040-1-git-send-email-mitchelh@codeaurora.org>
 <5704E937.3020602@arm.com>
Message-ID: <vnkwzit5w72g.fsf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06 2016 at 11:47:19 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> How would you handle said restriction of page sizes under this scheme?

I have a custom io-pgtable implementation that gets wired up based on an
IOMMU domain attribute, which is set by yet another custom DMA mapper.
My main goal is to give clients a way to specify the page table format
they want to use.  It's a bit of a mess but hopefully I can clean it up
and send it out soon.

> I'll clean up what I have and try to get it posted this afternoon so
> we can compare.

Cool, I have some comments that I'll leave over there.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
