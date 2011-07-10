From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 11:42:15 +0100
Subject: [PATCH V2 6/6] mpcore_wdt: Move declarations in a separate header
In-Reply-To: <201107061448.49092.arnd@arndb.de>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<201107061358.48496.arnd@arndb.de> <4E1456D9.8090003@mvista.com>
	<201107061448.49092.arnd@arndb.de>
Message-ID: <20110710104215.GC4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 02:48:48PM +0200, Arnd Bergmann wrote:
> An obvious choice would be arch/arm/include/asm/smp_twd.h.

Not if its moving out of arch/arm, but that's a separate debate to be
had.
