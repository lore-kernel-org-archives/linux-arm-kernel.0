From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Aug 2012 23:31:06 -0700
Subject: [PATCH 3/4] ARM: OMAP3: Switch to use the unified audio driver
 (omap-twl4030) for selected boards
In-Reply-To: <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
 <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120810063105.GQ11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120808 02:54]:
> These boards have similar audio setup and they can all use the same driver
> for audio support if it is enabled in the kernel config.

After the naming changes suggested by Igor:

Acked-by: Tony Lindgren <tony@atomide.com>
