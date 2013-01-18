From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 18 Jan 2013 20:27:56 +0000 (UTC)
Subject: [PATCH v8 19/22] ARM: OMAP3: clock data: get rid of unused USB
 host clock aliases and dummies
In-Reply-To: <1358511445-26656-20-git-send-email-rogerq@ti.com>
References: <1358511445-26656-1-git-send-email-rogerq@ti.com>
 <1358511445-26656-20-git-send-email-rogerq@ti.com>
Message-ID: <alpine.DEB.2.00.1301182027040.19470@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Fri, 18 Jan 2013, Roger Quadros wrote:

> We don't need multiple aliases for the OMAP USB host clocks and neither
> the dummy clocks so remove them.
> 
> CC: Paul Walmsley <paul@pwsan.com>
> CC: Rajendra Nayak <rnayak@ti.com>
> CC: Benoit Cousson <b-cousson@ti.com>
> CC: Mike Turquette <mturquette@linaro.com>
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Paul Walmsley <paul@pwsan.com>

Per Tony's earlier request, you can drop this patch and patch 20 from your 
series now.  I've got them queued for 3.10 or late 3.9 merge window.

- Paul
