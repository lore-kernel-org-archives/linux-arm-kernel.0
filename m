From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 17 Dec 2012 21:03:39 +0000 (UTC)
Subject: [PATCH v4 16/23] ARM: OMAP2+: clock data: Merge utmi_px_gfclk
 into usb_host_hs_utmi_px_clk
In-Reply-To: <50CF47FF.2010002@ti.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com>
 <1355134833-5199-17-git-send-email-rogerq@ti.com>
 <20121214182855.GB4989@atomide.com>
 <alpine.DEB.2.00.1212141838130.5915@utopia.booyaka.com>
 <50CED412.7060407@ti.com> <50CF449F.7090708@ti.com>
 <50CF47FF.2010002@ti.com>
Message-ID: <alpine.DEB.2.00.1212172102010.29833@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Dec 2012, Benoit Cousson wrote:

> It was done for legacy reason but should disappear once the modulemode
> will be be removed from the clock nodes.

Here's a start at taking care of the low-hanging fruit:

http://marc.info/?l=linux-omap&m=135577685007813&w=2

Only lightly tested, so tests with Kconfigs with lots of OMAP drivers 
enabled would be appreciated.


- Paul
