From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2012 16:30:09 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB26FC2.9050805@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB25FE9.3060209@codethink.co.uk> <20120515161655.504f1403@skate>
 <201205151425.30706.arnd@arndb.de> <4FB26E03.2030401@gmail.com>
 <4FB26FC2.9050805@codethink.co.uk>
Message-ID: <20120515153009.GD13860@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 04:01:22PM +0100, Ben Dooks wrote:
> It might be worth looking at changing ioremap() to work nicely with
> large page entries if it hasn't already been done.

It's already been done, but not for SMP systems.  There's issues there
which make that racy and horrible.
