From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 11 May 2011 17:44:01 +0300
Subject: [alsa-devel] [PATCH] ASoC: omap-mcbsp: Remove restrictive checks
	for cpu type
In-Reply-To: <1305122135-27938-1-git-send-email-premi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
Message-ID: <201105111744.01865.peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 May 2011 16:55:35 Premi, Sanjeev wrote:
> Current checks for cpu type were too restrictive leading
> to failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> cc: Liam Girdwood <lrg@ti.com>
> cc: Jarkko Nikula <jhnikula@gmail.com>
> ---

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
