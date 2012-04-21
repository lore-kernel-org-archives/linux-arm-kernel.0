From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 21 Apr 2012 13:40:01 +0200
Subject: [PATCH] arm: at91: fix build-error for board-dt
In-Reply-To: <1335004105-3162-1-git-send-email-w.sang@pengutronix.de>
References: <1335004105-3162-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20120421114001.GC9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:28 Sat 21 Apr     , Wolfram Sang wrote:
> From: Wolfram Sang <wolfram@the-dreams.de>
> 
> When build-testing i2c-patches, I encountered:
> 
> arch/arm/mach-at91/built-in.o:(.arch.info.init+0x34): undefined reference to `at91sam926x_timer'
> 
> (using allnoconfig and roughly only MACH_AT91SAM_DT enabled)
> 
> Since this boardfile doesn't belong to a specific architecture, directly
> add the only supported timer to compilation.
> 
> Signed-off-by: Wolfram Sang <wolfram@the-dreams.de>
no this is selected by the soc

I do not want the timer be compiled un condtionally

Best Regards,
J.
