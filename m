From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 13:36:36 +0100
Subject: Initial big-endian support series
Message-ID: <1371645406-16873-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the kernel support for building big-endian kernels
and updating the core drivers to deal with the endian swap as
needed.

This series does not include the fixups for ATAGs so it will require
being booted with fdt. As a note, we do not currently disable the
ATAGs options for the system (although we could) as there will be a
set of patches following on to deal with booting BE kernel on LE
systems.

I have not had time to test it on THUMB2 kernels. There is still
fixup work to be done for these which will require more time.

It is on git://git.baserock.org:/delta/linux on branch baserock/311/be/core
