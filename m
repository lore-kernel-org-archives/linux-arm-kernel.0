From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Nov 2013 11:40:08 +0900
Subject: [PATCH v2] ARM: shmobile: Fix r8a7790 GPIO resources in DTS
In-Reply-To: <2488980.PvOPQv8Pxa@avalon>
References: <20131121051929.16956.72693.sendpatchset@w520>
 <2488980.PvOPQv8Pxa@avalon>
Message-ID: <20131125024008.GA813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 09:29:49AM +0100, Laurent Pinchart wrote:
> Hi Magnus,
> 
> Thank you for the patch.
> 
> On Thursday 21 November 2013 14:19:29 Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > The r8a7790 GPIO resources are currently incorrect. Fix that
> > by making them match the English r8a7790 v0.6 data sheet.
> > 
> > Tested with GPIO LED using Lager DT reference.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Just before I go and hide for such an obvious mistake,
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> :-)

Hi, I would like to queue this up as a fix for v3.12 with the following
amended changelog.

I would also like to take this opportunity state that my preferred
subject format is: ARM: shmobile: soc or board: description

Could you cook up something similar for the r8a7791 variant of this patch?


[PATCH v2] ARM: shmobile: r8a7790: Fix GPIO resources in DTS

From: Magnus Damm <damm@opensource.se>

The r8a7790 GPIO resources are currently incorrect. Fix that
by making them match the English r8a7790 v0.6 data sheet.

Tested with GPIO LED using Lager DT reference.

This problem has been present since GPIOs were added to the r8a7790 SoC by
f98e10c88aa95bf7 ("ARM: shmobile: r8a7790: Add GPIO controller devices to
device tree") in v3.12-rc1.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
