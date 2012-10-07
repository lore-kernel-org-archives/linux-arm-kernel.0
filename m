From: olof@lixom.net (Olof Johansson)
Date: Sun, 7 Oct 2012 07:19:19 -0700
Subject: [PATCH 0/4] arm-soc: vt8500: Cleanup patches for 3.7
In-Reply-To: <201210071123.39535.arnd@arndb.de>
References: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
 <201210071123.39535.arnd@arndb.de>
Message-ID: <20121007141919.GB26196@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 11:23:39AM +0000, Arnd Bergmann wrote:
> On Sunday 07 October 2012, Tony Prisk wrote:
> > Minor cleanup patches for 3.7.
> > 
> > Tony Prisk (4):
> >   vt8500: Remove unused headers from include/mach/
> >   vt8500: Remove arm/boot/compressed/head-vt8500.S
> >   vt8500: Fix header in mach-vt8500/timer.c
> >   vt8500: Fix build warning when no framebuffer selected
> 
> Hi Tony,
> 
> The patches all look good, but they are late for 3.7 now. I would
> still take the last one since that fixes a build warning, and the
> separate patch that adds the .dtb files to the Makefile, but leave
> the other ones for 3.8, unless there is a strong reason to
> still include them.

Yep, agreed. I applied the last one to fixes and will include it in the next
pull. The rest we can bring in once -rc1 is out and we start staging branches
for 3.8.

Thanks Tony!


-Olof
