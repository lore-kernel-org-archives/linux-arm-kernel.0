From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Nov 2012 15:02:00 +0100
Subject: [PATCH 2/5] ASoC: OMAP: mcbsp fixes for enabling ARM multiplatform
 support
In-Reply-To: <20121121174225.25576.54891.stgit@muffinssi.local>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
 <20121121174225.25576.54891.stgit@muffinssi.local>
Message-ID: <50AE3058.1080204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 06:42 PM, Tony Lindgren wrote:
> We cannot include any plat or mach headers for the multiplatform
> support.
> 
> Fix the issue by defining local mcbsp_omap1().
> 
> cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> cc: Liam Girdwood <lrg@ti.com>
> cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> cc: Jaroslav Kysela <perex@perex.cz>
> cc: Takashi Iwai <tiwai@suse.de>
> cc: alsa-devel at alsa-project.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
