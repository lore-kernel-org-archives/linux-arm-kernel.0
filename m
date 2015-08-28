From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 28 Aug 2015 15:23:20 -0700
Subject: arm64: how to check endianness of Image file?
Message-ID: <CAMAWPa8EW92OAAVn7FOkBzPbtsQLQDpU1F0TM3uuTFa9P6bYOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will, Catalin,

Any suggestions on a quick way to check if an arm64 kernel Image file
is big-endian?

We're adding more boot support for arm64 defconfig +
CONFIG_CPU_BIG_ENDIAN=y to kernelci.org, and are looking for a
reliable way to check the endianness of the kernel Image file, we
don't have the vmlinux around to check the ELF headers.

On arm32, the zImage has some magic fields set from
arch/arm/boot/compressed/head.S, but arm64 doesn't have the
equivalent.

Kevin
