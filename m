From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 15 Sep 2016 21:50:30 +0530
Subject: [PATCH v9 00/19] Add support for FDMA DMA controller and slim
 core rproc found on STi chipsets
In-Reply-To: <20160914130739.GE13920@localhost>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
 <20160913093107.GA10953@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160913180616.GD21438@tuxbot> <20160914130739.GE13920@localhost>
Message-ID: <20160915162030.GX13920@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 06:37:40PM +0530, Vinod Koul wrote:
> On Tue, Sep 13, 2016 at 11:06:16AM -0700, Bjorn Andersson wrote:
> > > I hate to send a ping,
> > 
> > Sorry about that.
> > 
> > > but do you think we can merge this fdma series? It has gone
> > > through quite a few review rounds now.
> > > 
> > 
> > I think the remoteproc part looks good.
> 
> yeah I was waiting for ack on other patches. But looks like at least
> remoteproc ones have it
> 
> 
> > Vinod, I don't have any changes queued in remoteproc that should cause
> > merge issues. If you want to you could take the remoteproc patch
> > through your tree.
> 
> I rechecked the dma part, they look good to me, so I should be able to apply
> these. I will wait a day for ack/nacks. It is the time to speak up :)

And I have applied thru 9th patch. Others are applied by Patrice.

Btw you should send drm ones to drm folks separately and not in this
series..

Thanks
-- 
~Vinod
