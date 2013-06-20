From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Jun 2013 18:12:09 +0200
Subject: Initial big-endian support series
In-Reply-To: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130620181209.646db8db@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Wed, 19 Jun 2013 13:36:36 +0100, Ben Dooks wrote:
> This updates the kernel support for building big-endian kernels
> and updating the core drivers to deal with the endian swap as
> needed.
> 
> This series does not include the fixups for ATAGs so it will require
> being booted with fdt. As a note, we do not currently disable the
> ATAGs options for the system (although we could) as there will be a
> set of patches following on to deal with booting BE kernel on LE
> systems.

I have tested both series on an Armada XP based platform and I confirm
that I'm able to boot successfully with a BE8 kernel and into a BE8
userspace. Nice!

Would it be possible to get this merged?

> I have not had time to test it on THUMB2 kernels. There is still
> fixup work to be done for these which will require more time.

I might have some time in the near future to look at that, if you don't
do it in the mean time, of course.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
