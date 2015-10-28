From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 28 Oct 2015 15:49:17 +0900
Subject: [PATCH v3] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <BLUPR03MB134DA9E483023953813E03783220@BLUPR03MB134.namprd03.prod.outlook.com>
References: <1445243465-7727-1-git-send-email-yao.yuan@freescale.com>
 <20151027020035.GC11691@vkoul-mobl.iind.intel.com>
 <BLUPR03MB134DA9E483023953813E03783220@BLUPR03MB134.namprd03.prod.outlook.com>
Message-ID: <20151028064915.GD3041@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 03:58:31AM +0000, Yao Yuan wrote:
> Hi Vinod,
> 

Please do not top post

> Thanks for your review.
> I did the test and it seems that it should be ok when CONFIG_PM is not defined.
> So I removed the protection code to make it more readable.
> Do you think is it ok?

Yes I did check, this seems okay, pls ignore this comment. You still need to
explain why you use late/early calls

-- 
~Vinod
