From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 23 Dec 2011 22:02:50 +0530
Subject: [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
In-Reply-To: <20111223162826.GA28036@opensource.wolfsonmicro.com>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
 <1324656420.1633.15.camel@vkoul-udesk3>
 <20111223162826.GA28036@opensource.wolfsonmicro.com>
Message-ID: <1324657970.1633.22.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-12-23 at 16:28 +0000, Mark Brown wrote:
> On Fri, Dec 23, 2011 at 09:37:00PM +0530, Vinod Koul wrote:
> 
> > Has this been applied in soc tree? I don't see it in linux-next or do
> > you want this to go thru slave-dma?
> 
> I reverted it, it needs to go with the commit that introduces the new
> API otherwise it breaks bisection.
Okay thanks,

Those are is in my next so I will apply this one to my next as well.

-- 
~Vinod
