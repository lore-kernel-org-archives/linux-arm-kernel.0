From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Dec 2015 10:56:05 -0800
Subject: [PATCH 2/2] OMAP: RX51: save ATAGS data in the early boot stage
In-Reply-To: <201512241849.11704@pali>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450975076-7411-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201512241849.11704@pali>
Message-ID: <20151224185604.GU2793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [151224 09:49]:
> On Thursday 24 December 2015 17:37:56 Ivaylo Dimitrov wrote:
> > Nokia N900 (RX51) legacy userspace needs various ATAGS passed by the
> > bootloader (boot reason, device serial, boot mode, various GPIO
> > swithes, etc). Save that data early enough in the boot process, so
> > it can be exported later in /proc/atags
> > 
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> 
> Working fine in qemu.
> 
> Tested-by: Pali Roh?r <pali.rohar@gmail.com>

Maybe update the description to say "This fixes a regression with
device tree based booting compared to legacy booting for n900 to
make the n900 legacy user space to also work with device tree based
booting".

It would be nice to get these two in as fixes after -rc1 assuming
people have no objections to it. So please upload this one also
into Russell's patch system after no more comments:

Acked-by: Tony Lindgren <tony@atomide.com>
