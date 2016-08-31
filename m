From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 31 Aug 2016 09:51:31 +0530
Subject: [PATCH V3 3/3] dmaengine: qcom_hidma: add error reporting for
 tx_status
In-Reply-To: <de65e834-03bf-49bc-422b-141c1c4d6100@codeaurora.org>
References: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
 <1471927691-28827-4-git-send-email-okaya@codeaurora.org>
 <20160830170422.GN9355@localhost>
 <d3c5e9ca-2381-71e0-5b03-5bad68868b97@codeaurora.org>
 <de65e834-03bf-49bc-422b-141c1c4d6100@codeaurora.org>
Message-ID: <20160831042131.GP9355@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 01:51:02PM -0400, Sinan Kaya wrote:
> On 8/30/2016 1:37 PM, Sinan Kaya wrote:
> > On 8/30/2016 1:04 PM, Vinod Koul wrote:
> >> On Tue, Aug 23, 2016 at 12:48:11AM -0400, Sinan Kaya wrote:
> >>
> >>>  	spin_lock_init(&lldev->lock);
> >>> -	tasklet_init(&lldev->rst_task, hidma_ll_abort, (unsigned long)lldev);
> >>
> >> ??
> >>
> >> This is not described in changlog? If you are not using in anywhere else,
> >> then rst_task variable should be removed too..
> >>
> > 
> > Sure, I can add more description. I thought I did mention that we are no longer
> > resetting the hardware in ISR. 
> > 
> > I can certainly mention that rst_task variable is removed and can get rid of it.
> > It is no longer in use.
> > 
> 
> It looks like I mentioned this in the cover letter only not in the commit message.
> I'll pull the description into the commit message too.

Sounds good to me, thanks

-- 
~Vinod
