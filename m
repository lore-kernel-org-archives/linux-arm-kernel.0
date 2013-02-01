From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 11:18:10 -0800
Subject: [PATCH v2 3/6] ARM: OMAP: USB: Add phy binding information
In-Reply-To: <1359081206-5602-4-git-send-email-kishon@ti.com>
References: <1359081206-5602-1-git-send-email-kishon@ti.com>
 <1359081206-5602-4-git-send-email-kishon@ti.com>
Message-ID: <20130201191810.GS22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [130124 18:36]:
> This is w.r.t the changes in PHY library to support adding and getting
> multiple PHYs of the same type. In the new design, the
> binding information between the PHY and the USB controller should be
> specified in the platform specific initialization code. So it's been
> done here for OMAP platforms.

This looks OK to me, but should be queued by Felipe in his
minimal USB platform_data changes branch that I can pull in too
to avoid pointless merge conflicts.

Regards,

Tony
