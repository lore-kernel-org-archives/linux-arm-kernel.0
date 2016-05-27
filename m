From: tony@atomide.com (Tony Lindgren)
Date: Fri, 27 May 2016 09:37:29 -0700
Subject: [PATCH v4 2/7] ARM: dts: omap3: Add clocks to McBSP nodes
In-Reply-To: <1464186061-28639-3-git-send-email-peter.ujfalusi@ti.com>
References: <1464186061-28639-1-git-send-email-peter.ujfalusi@ti.com>
 <1464186061-28639-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160527163728.GA5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160525 07:24]:
> Add clock properties to the McBSP nodes. McBSP2 and 3 need to have ick also
> since the Sidetone block of these modules are operating using the McBSP
> interface clock.

Sorry replied to the earlier thread putting this patch as the first
patch when committing against v4.17-rc1.

Regards,

Tony
