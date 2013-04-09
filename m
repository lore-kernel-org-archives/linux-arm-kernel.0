From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 14:36:41 +0200
Subject: [GIT PULL 3/5] omap board changes for v3.10 merge window
In-Reply-To: <0Lgo4c-1UueHv2nOo-00naI8@mx.kundenserver.de>
References: <0Lgo4c-1UueHv2nOo-00naI8@mx.kundenserver.de>
Message-ID: <201304091436.42046.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Tony Lindgren wrote:
> The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:
> 
>   Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/board-signed
> 
> for you to fetch changes up to 06993d6a8a51b90fc78c8c3cb7a81c9b4b88c683:
> 
>   ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight (2013-04-08 14:01:05 -0700)
> 
> ----------------------------------------------------------------
> Board related changes for v3.10 merge window. These are pretty
> much all non-critical fixes for platform device initialization
> that will be needed until we can drop the board-*.c files and
> move to DT based boot.
> 

Pulled into next/boards branch

	Arnd
