From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jul 2010 21:03:45 +0100
Subject: [PATCH] arm: fix mach-versatile booting in qemu
In-Reply-To: <201007141716.09384.arnd@arndb.de>
References: <201007141716.09384.arnd@arndb.de>
Message-ID: <20100714200345.GB18138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 05:16:09PM +0200, Arnd Bergmann wrote:
> The versatile platform has not been able to boot in qemu since 2.6.34-rc2,
> because e388771 "ARM: Realview/Versatile: separate out common SP804
> timer code" changed the behavior of the versatile_set_mode function.

NAK.  qemu is broken.
