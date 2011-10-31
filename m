From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 31 Oct 2011 12:59:22 +0100
Subject: config ARCH_AT91SAM9X5
Message-ID: <1320062362.14409.58.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0) Since the commits
    9baeb7e4 ("at91: Add ARCH_ID and basic cpu macros [...]"),
    b9e379bc ("net/can: allow CAN_AT91 on AT91SAM9X5"), and
    8c3583b6 ("at91: use structure to store the current soc")

the mainline kernel tree uses the Kconfig symbol ARCH_AT91SAM9X5 and the
preprocessor macro CONFIG_ARCH_AT91SAM9X5.

1) But there's currently no Kconfig entry ARCH_AT91SAM9X5. (Neither is
there a direct definition of the macro CONFIG_ARCH_AT91SAM9X5.)
Shouldn't a Kconfig entry for ARCH_AT91SAM9X5 be added (to
arch/arm/mach-at91/Kconfig)?


Paul Bolle
