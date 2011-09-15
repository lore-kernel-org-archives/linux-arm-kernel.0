From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 15 Sep 2011 17:10:33 +0200
Subject: [PATCH 0/6] mc13783 cleanup
In-Reply-To: <20110824132740.GA28197@pengutronix.de>
References: <20110824132740.GA28197@pengutronix.de>
Message-ID: <20110915151033.GD32263@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Aug 24, 2011 at 03:27:40PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this series removes the long obsolte mc13783 API after fixing all
> remaining users.
> 
> The patches touch many subsystems and have some interdependencies:
> 
>  - patches 3 and 5 depend on patch 2
>  - patch 6 depends on patches 1-5
> 
> So we have to think about how to merge them when everyone is OK that
> they are merged.
I am merging them, unless someone objects here.
I have applied all 6 patches now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
