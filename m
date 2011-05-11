From: jhnikula@gmail.com (Jarkko Nikula)
Date: Wed, 11 May 2011 18:38:58 +0300
Subject: [PATCH] ASoC: omap-mcbsp: Remove restrictive checks for cpu type
In-Reply-To: <1305122135-27938-1-git-send-email-premi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
Message-ID: <20110511183858.4ada5071.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 May 2011 19:25:35 +0530
Sanjeev Premi <premi@ti.com> wrote:

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
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
