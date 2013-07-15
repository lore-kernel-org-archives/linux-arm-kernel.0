From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jul 2013 15:17:12 +0200
Subject: v3.10 - big endian core support
In-Reply-To: <51E3CE41.5010807@codethink.co.uk>
References: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
 <20130712134726.0a909165@skate> <51DFEF75.8080600@codethink.co.uk>
 <20130714215325.GB7382@mudshark.cambridge.arm.com>
 <51E3ACD0.8040209@codethink.co.uk> <20130715103658.068ac6b7@skate>
 <51E3CE41.5010807@codethink.co.uk>
Message-ID: <20130715151712.69f2cf8d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Mon, 15 Jul 2013 11:26:09 +0100, Ben Dooks wrote:

> I've pushed out two new branches on git.baserock.org/delta/linux.git
> as:
> 	baserock/311/be/core-v2
> 	baserock/311/be/atags-v2

I've tested baserock/311/be/core-v2, after rebasing it on top of
3.11-rc1. I've tested the following combination on an Armada XP board:
little endian ARM, big endian ARM, little endian Thumb2 and big endian
Thumb2. They all worked fine.

There were minor conflicts in arch/arm/kernel/sleep.S and
arch/arm/mach-mvebu/headsmp.S when doing the rebase on top of 3.11-rc1,
but nothing major.

Ben, do you have the time to rebase on 3.11-rc1 and post the patches
for merging?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
