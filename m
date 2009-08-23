From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 23 Aug 2009 20:38:05 +0200
Subject: [alsa-devel] [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support for
	DMA channel self linking on OMAP1510
In-Reply-To: <20090823180543.GA6167@opensource.wolfsonmicro.com>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
	<200908231945.40187.jkrzyszt@tis.icnet.pl>
	<20090823180543.GA6167@opensource.wolfsonmicro.com>
Message-ID: <200908232038.05593.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sunday 23 August 2009 20:05:43 Mark Brown wrote:
> If none of your patches have been applied

Mark,

I did not say that. You have applied patches 2/3 [1] and 3/3 [2] from the 
series.

> then what are the other 
> patches that depend on this? Nobody reported any issues in testing with 
> the other OMAP patches.

Dependency on patch 1/3 is not compile time, but run time, and OMAP1510 
specific, that's probably why nobody has reported any issues.

> I don't really mind which tree these go via but I rather suspect that
> ALSA will be better given all the other changes and I also suspect that
> you'll need to regenerate your changes against a current tree due to
> those changes.

arch/arm/plat-omap/dma.c has not been touched since 2009-05-28 in yours [3] 
and since 2009-06-23 in Takashi's tree, so my patch, whether original or v2, 
should still be up to date. That may change if it is to be pushed via OMAP 
tree.

Sorry for all that noise.

Thanks,
Janusz

[1]http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=64844a6ac8ddd586cb832fea7cf2e93e5e7e03f4
[2]http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=471e3dec3abe2d41e8c742046353fcb01bc2459e
[3]http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=44169075e6eaa87bab6a296209d8d0610879b394
[4]http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=aecedb94b366d6fb5e2a17ca18a5dc78e593198e
