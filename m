From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Thu, 22 Nov 2012 12:59:28 +0200
Subject: [PATCH 2/5] ASoC: OMAP: mcbsp fixes for enabling ARM
 multiplatform support
In-Reply-To: <20121121174225.25576.54891.stgit@muffinssi.local>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
 <20121121174225.25576.54891.stgit@muffinssi.local>
Message-ID: <20121122125928.755ace5bd34f8a3c40ff4abe@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Nov 2012 09:42:25 -0800
Tony Lindgren <tony@atomide.com> wrote:

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
> ---
>  sound/soc/omap/mcbsp.c      |    4 +---
>  sound/soc/omap/mcbsp.h      |    6 ++++++
>  sound/soc/omap/omap-mcbsp.c |    5 ++---
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
