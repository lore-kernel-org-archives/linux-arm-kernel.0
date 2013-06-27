From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jun 2013 15:03:43 +0200
Subject: [GIT PULL] at91: non critical fixes (for early 3.11) #2
In-Reply-To: <1372254307-2063-1-git-send-email-nicolas.ferre@atmel.com>
References: <1372254307-2063-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201306271503.43864.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Nicolas Ferre wrote:
> Another fixes-non-critical pull-request for early 3.11. It is of course based
> on the patches that you already have in arm-soc/at91/fixes.
> 
> Thanks, best regards,
> 
> The following changes since commit 133e00116b5bc76110bcc41ded369489209b641f:
> 
>   ARM: at91: Change the internal SRAM memory type MT_MEMORY_NONCACHED (2013-06-18 10:20:30 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes
> 
> for you to fetch changes up to bd2da9ca138e446824a7542b381aed442fef4caa:
> 
>   ARM: at91/PMC: use at91_usb_rate() for UTMI PLL (2013-06-26 15:24:11 +0200)

All of these look simple enough, so I've pulled them into next/fixes-non-critical.

Thanks,

	Arnd
