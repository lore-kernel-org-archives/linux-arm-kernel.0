From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Thu, 31 Dec 2009 11:36:48 +0100
Subject: arm-unknown-linux-gnu-ld: no machine record defined
Message-ID: <20091231113648.c438503d.kristoffer.ericson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

Im adding support for the Dell AXIM X30. Ive created the machine file with relevant makefile/Kconfig option
and everything compiles nicely up to the linker that spits out no machine record defined.

Kconfig contains
config MACH_X30
       bool "AximX30 platform"
       select PXA27x
       select IWMMXT
       select PXA_HAVE_BOARDS_IRQ

and aximx30.c got
MACHINE_START(X30, "Axim X30")
.......


Shouldnt that be enough for it to find the machine record?

mach-types got
X30	MACH_X30	X30	655

Maybe im using too old toolchain? Using gcc-3.4.5 + glibc 2.3.5

Best wishes
Kristoffer Ericson
-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>
