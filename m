From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Aug 2012 23:29:17 -0700
Subject: [PATCH 2/4] ARM: OMAP: twl-common: Add helper function to
 register the omap-twl4030 audio driver
In-Reply-To: <1344419650-5389-3-git-send-email-peter.ujfalusi@ti.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
 <1344419650-5389-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120810062916.GP11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120808 02:54]:
> Since several OMAP3 based boards will be using the unified simple audio
> driver it is better to not have duplicated code in the board files for this
> purpose.
> Board files can call omap_twl4030_audio_init(); to set up the needed device
> for the audio support.
> 
> For example:
> omap_twl4030_audio_init("omap3beagle", 26000000);

Acked-by: Tony Lindgren <tony@atomide.com>
