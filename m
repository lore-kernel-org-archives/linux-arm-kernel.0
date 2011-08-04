From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 04 Aug 2011 09:57:58 +0530
Subject: [PATCH] dmaengine: add helper function for slave_single
In-Reply-To: <20110725154739.GD14955@n2100.arm.linux.org.uk>
References: <1311608235.8206.24.camel@vkoul-mobl4>
	<20110725154739.GD14955@n2100.arm.linux.org.uk>
Message-ID: <1312432078.1536.561.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-25 at 16:47 +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 25, 2011 at 09:07:15PM +0530, Vinod Koul wrote:
> > >From af9afd16e9954edb45f0cf71834653133d75e79c Mon Sep 17 00:00:00 2001
> > From: Vinod Koul <vinod.koul@intel.com>
> > Date: Mon, 25 Jul 2011 19:57:52 +0530
> > Subject: [PATCH] dmaengine: add helper function for slave_single
> > 
> > For clients which require a single slave transfer and dont want to be bothered
> > about the scatterlist api, this helper gives simple API for this transfer and
> > creates single scatterlist for DMA API
> > 
> > Idea from Russel King
> 
> Please correct this, thanks.
Your wish, I recall you posting similar code in some other thread

I will apply this so that ppl can start using it

-- 
~Vinod
