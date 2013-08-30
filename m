From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:17:56 +0100
Subject: 3.11-rc7 big endian - atags and bootloader updates
Message-ID: <1377890281-10757-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is to better support older bootloaders, especially the
ones that still pass some information in the ATAGS structure used
by pre-fdt booting. The series is available at:

	git://git.baserock.org/delta/linux baserock/311-rc7/be/atags-v2
