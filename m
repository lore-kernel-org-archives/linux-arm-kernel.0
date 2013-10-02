From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 2 Oct 2013 17:25:48 -0300
Subject: Armada XP doesn't boot in v3.12-rc3
In-Reply-To: <CAFJTrDsTmSzFEX7XVqnw4=vYiBdqNeLDQuWFotSEZqGsFxT9sA@mail.gmail.com>
References: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
 <20131002124320.GL31178@titan.lakedaemon.net>
 <CAFJTrDsTmSzFEX7XVqnw4=vYiBdqNeLDQuWFotSEZqGsFxT9sA@mail.gmail.com>
Message-ID: <20131002202547.GA10645@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthew:

On Wed, Oct 02, 2013 at 04:55:25PM +0100, Matthew Minter wrote:
[...]
> 
> I have tried a number of configurations including the defaults for the
> mach and various settings including turning CONFIG_HAVE_ARM_ARCH_TIMER
> on and off.
> 
> Some configurations result in no output after uBoot's booting kernel
> line, but some reach theline "calibrating timer loop" then hang
> indefinitely.
> 

Yup, that's the two different bugs the patches should fix.

> I am now trying the fixes branch at
> git://git.infradead.org/linux-mvebu.git (thanks Ezequiel) to see if
> that contains a solution. Once I have tried that I shall see what
> changes it made and mail back any results. (I am talking to the board
> down a serial over USB connection so can get a fair amount of
> diagnostics from the early printk system).
> 

Please test git://git.infradead.org/linux-mvebu.git or some recent
linux-next. You should be able to boot with/without CONFIG_HAVE_ARM_ARCH_TIMER.

I expect all the fixes land in -rc4, which means mainline should be
fixed by next week.

Let me know any problems!

Thanks a lot for reporting!

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
