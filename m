From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Mar 2012 23:51:05 -0700 (MST)
Subject: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and
 board data
In-Reply-To: <20120309054608.647473E0901@localhost>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
 <1329998490-27555-5-git-send-email-rnayak@ti.com>
 <20120223185718.GZ18185@atomide.com> <4F470B71.1020308@ti.com>
 <20120224184859.GN18185@atomide.com> <20120309054608.647473E0901@localhost>
Message-ID: <alpine.DEB.2.00.1203082348200.26656@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Mar 2012, Grant Likely wrote:

> Yes, absolutely use separate compatible values.  It is always important
> to be specific as to the silicon implementing the IP.

In that case, it is probably best to use the full chip name in the 
compatible string, e.g., omap2420 or omap2430 rather than just "omap2".  
Particularly in the case of "OMAP3," which is a largely meaningless group 
these days with AM33xx, OMAP34xx, OMAP36xx, and AM3517, many of which are 
quite different from each other...


- Paul
