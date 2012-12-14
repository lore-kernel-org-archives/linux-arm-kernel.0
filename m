From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 14 Dec 2012 18:44:31 +0000 (UTC)
Subject: [PATCH v4 16/23] ARM: OMAP2+: clock data: Merge utmi_px_gfclk
 into usb_host_hs_utmi_px_clk
In-Reply-To: <20121214182855.GB4989@atomide.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com>
 <1355134833-5199-17-git-send-email-rogerq@ti.com>
 <20121214182855.GB4989@atomide.com>
Message-ID: <alpine.DEB.2.00.1212141838130.5915@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 14 Dec 2012, Tony Lindgren wrote:

> Paul, what about this patch? Looks like you've acked the other clock 
> patches in this series but not this one?

I commented on it briefly here:

https://patchwork.kernel.org/patch/1838111/

Maybe Beno?t could comment here, but it looks to me (based on a 
superficial look at the hardware clock tree data) that these clock nodes 
should exist.  In an ideal world, we'd be able to get back to the 
autogeneration of this clock data.

Roger, is it a requirement for the driver to remove these clock nodes, or 
is it possible to stick with the existing nodes?


- Paul
