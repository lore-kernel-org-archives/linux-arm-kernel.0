From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Dec 2011 11:38:29 -0800
Subject: [PATCH v3 8/9] OMAP4: omap4panda: Enable audio support
In-Reply-To: <1324582474-18181-9-git-send-email-peter.ujfalusi@ti.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
 <1324582474-18181-9-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20111222193829.GS24444@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [111222 11:03]:
> PandaBoard has twl6040 codec for audio.
> Register the omap4-abe-twl6040 platform device.
> Add platform data to enable the twl6040 codec.
> Since there is a difference in audio between  PandaBoard 4430
> and PandaBoard ES (4460):
> Use different name for the sound card:
> "OMAP4-Panda" for PandaBoard 4430
> "OMAP4-PandaES" for PandaBoard ES
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: David Anders <x0132446@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
