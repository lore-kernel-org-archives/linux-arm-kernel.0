From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Dec 2015 10:36:28 -0800
Subject: [PATCH 0/2] ARM: OMAP1/2+: DO not create omap-pcm-audio device
In-Reply-To: <1449838220-24309-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449838220-24309-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151217183627.GA23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151211 04:51]:
> Hi,
> 
> The ASoC omap-pcm has been converted to be non platform device a long time ago,
> so it is no longer needed to create the device for it since there will be no
> driver to be loaded for it.

OK, applying into omap-for-v4.5/soc-v2 thanks.

Tony
