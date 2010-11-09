From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 10 Nov 2010 01:20:55 +0900
Subject: [PATCH 6/6 v3] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <201011091433.45387.arnd@arndb.de>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101109110407.GE2869@n2100.arm.linux.org.uk>
	<AANLkTinWNoGJoDu6Ok8Ni5OuAXN29H7Bd3YMyUq6qfFq@mail.gmail.com>
	<201011091433.45387.arnd@arndb.de>
Message-ID: <20101109162055.GA22740@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 02:33:45PM +0100, Arnd Bergmann wrote:
> On Tuesday 09 November 2010, Geert Uytterhoeven wrote:
> > >
> > > It looks to me like the only arch in the kernel which doesn't support
> > > generic irq is sh.
> > 
> > IIRC, m68k, sparc32, and s390.
> 
> Yes, and among those, no driver in s390 should need asm/irq.h either because
> they do not have interrupt numbers -- every device on s390 has an implicit
> interrupt.
> 
Which is exactly what I stated in my original response. Moving along
then..
