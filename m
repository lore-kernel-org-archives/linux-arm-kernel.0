From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 17 Sep 2012 15:21:41 +0530
Subject: [alsa-devel] [PATCH v3 00/15] ASoC: OMAP: Convert to use dmaengine
In-Reply-To: <5056E300.809@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347851866.1943.126.camel@vkoul-udesk3>  <5056E300.809@ti.com>
Message-ID: <1347875501.1943.142.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-09-17 at 11:44 +0300, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 09/17/2012 06:17 AM, Vinod Koul wrote:
> > On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
> >> Hello,
> > 
> > dmaengine parts look good to me. How do you want to get this merged,
> > dmaengine or ASoC tree?
> 
> Thank you, I would prefer it to go via ASoC if it is not a problem. It is
> possible to separate the dmaengine core related patches and the patches for
> the OMAP drivers but I think it is better to keep them together so we can have
> them in a same tree for testing it further.
Sure I think this is better way to do.

-- 
~Vinod
