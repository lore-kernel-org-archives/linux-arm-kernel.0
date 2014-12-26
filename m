From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 26 Dec 2014 12:14:31 +0100
Subject: [PATCH v2] ALSA: atmel: fix building the ac97 driver for
 at91-multiplatform
In-Reply-To: <20141225104837.GH4194@piout.net>
References: <1419160689-20447-1-git-send-email-alexandre.belloni@free-electrons.com>
 <s5hppb8hw13.wl-tiwai@suse.de> <20141225104837.GH4194@piout.net>
Message-ID: <s5hk31eirxk.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Thu, 25 Dec 2014 11:48:37 +0100,
Alexandre Belloni wrote:
> 
> Hi,
> 
> On 25/12/2014 at 11:19:04 +0100, Takashi Iwai wrote :
> > At Sun, 21 Dec 2014 12:18:09 +0100,
> > Alexandre Belloni wrote:
> > > 
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > at91 will no longer export the mach/cpu.h and mach/hardware.h header files
> > > in the future, which would break building the atmel ac97c driver.
> > > 
> > > Since the cpu_is_* check is only used to find out whether we are running
> > > on avr32 or arm/at91, we can hardcode that check in the ARM case.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Link: http://www.spinics.net/lists/arm-kernel/msg382068.html
> > 
> > Is this targeted for 3.19 or 3.20?
> > 
> 
> It is not urgent, that is definitely for 3.20.

OK.  But I can't apply it now because your sign-off is missing.
If you submit a patch, you must give your own sign-off, too, even if
it's not written by you.


thanks,

Takashi
