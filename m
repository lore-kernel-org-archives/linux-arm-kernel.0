From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 31 Jan 2012 11:39:11 +0530
Subject: [PATCH v2 0/2] Add Qualcomm MSM ADM DMAEngine driver
In-Reply-To: <4F278341.4020600@codeaurora.org>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
 <1326807902.1540.116.camel@vkoul-udesk3> <4F195E4C.6080805@codeaurora.org>
 <1327066287.517.4.camel@vkoul-udesk3> <4F1D4052.3070701@codeaurora.org>
 <1327326713.517.32.camel@vkoul-udesk3> <4F1FFF7E.3000802@codeaurora.org>
 <1327911315.1527.8.camel@vkoul-udesk3>  <4F278341.4020600@codeaurora.org>
Message-ID: <1327990151.1527.80.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-01-31 at 11:29 +0530, Ravi Kumar V wrote:
> > [1]: https://lkml.org/lkml/2011/10/24/275
> > [2]: https://lkml.org/lkml/2012/1/26/405
> >
> 
> Yes if we follow the above RFC and add extra context parameter also
> in 
> device_prep_dma_sg() & device_prep_interleaved_dma() then it supports 
> our hardware and our work will be completed.
> 
> can we follow above RFC and implement our driver.
> Is above RFC finalized and included in mainline?
Alexandre will post an updated one soon, but the idea is same

-- 
~Vinod
