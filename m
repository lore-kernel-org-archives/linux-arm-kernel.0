From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 17 Jan 2012 20:05:35 +0530
Subject: [PATCH v2 2/2] msm: DMAEngine: Add DMAEngine driver based on
 old MSM DMA APIs
In-Reply-To: <1325901569.10425.14.camel@m0nster>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
 <1325854052-21402-3-git-send-email-kumarrav@codeaurora.org>
 <1325901569.10425.14.camel@m0nster>
Message-ID: <1326810935.1540.162.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-01-06 at 17:59 -0800, Daniel Walker wrote:
> > +
> > +#define FORCED_FLUSH         0
> > +#define GRACEFUL_FLUSH          1
> 
> Could be an enum ..
Along with proper namespace...

-- 
~Vinod
