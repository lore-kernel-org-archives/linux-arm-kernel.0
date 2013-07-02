From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 2 Jul 2013 15:14:07 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130702124639.GI19937@titan.lakedaemon.net>
References: <87fvvzfh70.fsf@natisbad.org>
 <20130702124639.GI19937@titan.lakedaemon.net>
Message-ID: <20130702151407.01680d21@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 2 Jul 2013 08:46:39 -0400, Jason Cooper wrote:

> > In the end, the main missing part is the NAND but I guess this is the
> > same for all Aramda 370/XP boards and this is not a big issue as it is
> > still possible to interact w/ it via u-boot and install a set of
> > uImage/uInitramfs that way. 
> 
> What's the big blocker for this?  Once this is done, debian should be
> able to add support for this board.  After all, upgrading the kernel and
> initrd from userspace is a desirable option.

The big blocker is that no-one has written  the driver for it. It is
still on our (Free Electrons) TODO-list, but not as a top-priority item
for the moment.

Ezequiel had started to do some preliminary cleanup work on the
pxa3xx-nand driver, with the ultimate goal of making it support Armada
370/XP (because the IP in the Armada 370/XP is apparently an evolution
of the PXA3xx NAND controller), but our priorities shifted to those
other topics. We will back on it some day, but I can't say when at the
moment.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
