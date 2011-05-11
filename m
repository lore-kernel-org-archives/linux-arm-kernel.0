From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 May 2011 15:57:08 +0200
Subject: [PATCH] ASoC: omap-mcbsp: Remove restrictive checks for cpu type
In-Reply-To: <1305122135-27938-1-git-send-email-premi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
Message-ID: <20110511135708.GE12469@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 07:25:35PM +0530, Sanjeev Premi wrote:
> Current checks for cpu type were too restrictive leading
> to failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
