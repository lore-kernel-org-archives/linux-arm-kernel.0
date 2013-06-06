From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Jun 2013 21:35:20 +0200
Subject: [PATCH 4/4] ARM: ux500: Remove call to u8500_of_init_devices() -
 again
In-Reply-To: <20130606165053.GU3370@gmail.com>
References: <1370517676-10909-1-git-send-email-lee.jones@linaro.org>
 <201306061758.25106.arnd@arndb.de> <20130606165053.GU3370@gmail.com>
Message-ID: <201306062135.21047.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 June 2013, Lee Jones wrote:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/commit/arch/arm/mach-ux500/cpu-db8500.c?h=next&amp;id=1e74043a29cdec67279d6e4f494dd1674a1b2365
> 
> For some reason (I suspect a merge error), u8500_of_init_devices
> reappeared.
> 

>From what I can see, that match you cited has never made it into the mainline kernel.

	Arnd
