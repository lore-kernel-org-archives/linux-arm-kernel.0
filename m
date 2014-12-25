From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 25 Dec 2014 11:48:37 +0100
Subject: [PATCH v2] ALSA: atmel: fix building the ac97 driver for
 at91-multiplatform
In-Reply-To: <s5hppb8hw13.wl-tiwai@suse.de>
References: <1419160689-20447-1-git-send-email-alexandre.belloni@free-electrons.com>
 <s5hppb8hw13.wl-tiwai@suse.de>
Message-ID: <20141225104837.GH4194@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/12/2014 at 11:19:04 +0100, Takashi Iwai wrote :
> At Sun, 21 Dec 2014 12:18:09 +0100,
> Alexandre Belloni wrote:
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > at91 will no longer export the mach/cpu.h and mach/hardware.h header files
> > in the future, which would break building the atmel ac97c driver.
> > 
> > Since the cpu_is_* check is only used to find out whether we are running
> > on avr32 or arm/at91, we can hardcode that check in the ARM case.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Link: http://www.spinics.net/lists/arm-kernel/msg382068.html
> 
> Is this targeted for 3.19 or 3.20?
> 

It is not urgent, that is definitely for 3.20.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
