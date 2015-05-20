From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 20 May 2015 11:41:50 -0700
Subject: [PATCH 0/5] ARM: shmobile: dts: Replace "nor-jedec" by
 "jedec,spi-nor"
In-Reply-To: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
References: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150520184150.GG11598@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ linux-mtd, FYI

On Wed, May 20, 2015 at 08:16:49PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series replaces the recently introduced "nor-jedec"
> compatible value by "jedec,spi-nor" in all shmobile dts files,
> cfr. commit 8947e396a8296c52 ('Documentation: dt: mtd: replace
> "nor-jedec" binding with "jedec,spi-nor"'), which was applied in
> v4.1-rc4.
> 
> As the "bad" compatible values are already in -next for v4.2, these
> updates should be applied and queued for v4.2, too.
> 
> Thanks for applying!

For the series:

Acked-by: Brian Norris <computersforpeace@gmail.com>

Thanks Geert!
