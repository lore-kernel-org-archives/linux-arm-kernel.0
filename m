From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 08 Oct 2012 07:14:52 +1300
Subject: [PATCH 0/4] arm-soc: vt8500: Cleanup patches for 3.7
In-Reply-To: <201210071123.39535.arnd@arndb.de>
References: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
 <201210071123.39535.arnd@arndb.de>
Message-ID: <1349633692.9507.7.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-10-07 at 11:23 +0000, Arnd Bergmann wrote:
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
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Just to clarify,

Is it only bug-fixes, not cleanup that are being accepted during the
merge-window?

Regards
Tony P
