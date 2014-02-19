From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Feb 2014 18:38:03 +0000 (UTC)
Subject: [PATCH] ARM: AM43x: hwmod data: register spinlock OCP
 interface
In-Reply-To: <1389397464-13345-1-git-send-email-s-anna@ti.com>
References: <1389397464-13345-1-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1402191837340.8777@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jan 2014, Suman Anna wrote:

> AM43xx has a spinlock module which is identical to the
> one present on AM33xx. Register the spinlock ocp_if link
> so that the spinlock hwmod and associated omap_device can
> be instantiated, and the runtime pm API could be used by
> the OMAP hwspinlock driver.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks, queued for v3.15.

Please remember to cc the linux-arm-kernel mailing list on all OMAP 
patches.  I've added it to this message.


- Paul
