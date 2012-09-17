From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 17 Sep 2012 22:12:01 +0000 (UTC)
Subject: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
In-Reply-To: <20120917212605.GC11762@atomide.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
 <alpine.DEB.2.00.1209162033400.698@utopia.booyaka.com>
 <20120917212605.GC11762@atomide.com>
Message-ID: <alpine.DEB.2.00.1209172208540.16117@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Sep 2012, Tony Lindgren wrote:

> That's good news. Does that mean we should try to merge these patches
> for v3.7 then? Or do we still have issues remaining?

There are still problems with the OMAP4 CCF implementation.  Power 
management is broken on some bootloaders that the original data works fine 
with.   It's still under debug.


- Paul
