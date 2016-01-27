From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jan 2016 07:54:23 -0800
Subject: [PATCH] dmaengine: edma: Remove dynamic TPTC power management
 feature
In-Reply-To: <1453885906-17652-1-git-send-email-peter.ujfalusi@ti.com>
References: <1453885906-17652-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160127155422.GH19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160127 01:12]:
> The dynamic or on demand pm_runtime does not work correctly on am335x and
> am437x due to interference with hwmod.

Hmm care expand a bit what is the problem with this "interference"?

Regards,

Tony
