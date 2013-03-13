From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Wed, 13 Mar 2013 22:15:47 +0200
Subject: [RFC 0/2] ARM: OMAP: dma.h cleanup
Message-ID: <1363205749-9905-1-git-send-email-jarkko.nikula@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't know is this good or bad idea, thus RFC.

I got this idea after noticing that McBSP DMA channel definitions are no
longer used for OMAP2 and EAC DMA channel were never used in upstream.
Scripts here are used to remove all of those unused ones.

Build tested with omap1_defconfig and omap2plus_defconfig.

-- 
Jarkko
