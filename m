From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 7 Oct 2012 11:23:39 +0000
Subject: [PATCH 0/4] arm-soc: vt8500: Cleanup patches for 3.7
In-Reply-To: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
References: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201210071123.39535.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 October 2012, Tony Prisk wrote:
> Minor cleanup patches for 3.7.
> 
> Tony Prisk (4):
>   vt8500: Remove unused headers from include/mach/
>   vt8500: Remove arm/boot/compressed/head-vt8500.S
>   vt8500: Fix header in mach-vt8500/timer.c
>   vt8500: Fix build warning when no framebuffer selected

Hi Tony,

The patches all look good, but they are late for 3.7 now. I would
still take the last one since that fixes a build warning, and the
separate patch that adds the .dtb files to the Makefile, but leave
the other ones for 3.8, unless there is a strong reason to
still include them.

	Arnd
