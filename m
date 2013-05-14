From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 15 May 2013 00:02:57 +0200
Subject: hwrng: picoxcell: PICOXCELL_PC3X3?
Message-ID: <1368568977.1350.142.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0) Support for "Picochip picoXcell true random number generator[s]" was
added in commit 5efb94ee14 ("hwrng: pixocell - add support for picoxcell
TRNG"). Its Kconfig symbol (HW_RANDOM_PICOXCELL) depends on
PICOXCELL_PC3X3. But that symbol is not included in mainline. I found no
trace of it ever since support for this TRNG got added in v2.6.39. This
means this code has never been buildable in mainline.

Why does this code depend on PICOXCELL_PC3X3?

1) Slightly related: by what magic are picoxcell-pc7302-pc3x3.dts and
picoxcell-pc3x3.dtsi hooked into the build system? Or are dts and dtsi
files, well, special and not directly linked into the build system?


Paul Bolle
