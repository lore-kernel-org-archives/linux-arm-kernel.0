From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 00:44:32 +0100
Subject: [GIT PULL] omap fixes against v4.4-rc4
In-Reply-To: <20151210233907.GI23396@atomide.com>
References: <20151210233907.GI23396@atomide.com>
Message-ID: <1892295.pQZqt1gEpo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 15:39:08 Tony Lindgren wrote:
> Few fixes for omaps for v4.4-rc cycle:
> 
> - Fix clock source for ARM TWD and global timers on am437x
> 
> - Always select REGULATOR_FIXED_VOLTAGE for omap2+ instead of
>   when MACH_OMAP3_PANDORA is selected
> 
> - Fix SPI DMA handles for dm816x as only some were mapped
> 
> - Fix up mbox cells for dm816x to make mailbox usable
> 

Just when I had finished pulling in all other fixes and was about
to go to bed.

Pulled into fixes, too.

Thanks,

	Arnd
