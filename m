From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 19 Aug 2014 12:28:44 -0700
Subject: [PATCH 1/6] iommu/arm-smmu: add support for specifying clocks
In-Reply-To: <20140819125833.GO23128@arm.com> (Will Deacon's message of "Tue,
 19 Aug 2014 13:58:34 +0100")
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-2-git-send-email-mitchelh@codeaurora.org>
 <20140819125833.GO23128@arm.com>
Message-ID: <vnkwha18nus3.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19 2014 at 05:58:34 AM, Will Deacon <will.deacon@arm.com> wrote:
> I also assume that the clk API ignores calls to clk_enable_prepare
> for a clk that's already enabled? I couldn't find that code...

That's clk_prepare_enable, not clk_enable_prepare. It's in
<linux/clk.h>.


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
