From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Jul 2010 19:55:00 +0200
Subject: [PATCH] arm: fix mach-versatile booting in qemu
In-Reply-To: <20100714172319.GA8933@debian>
References: <201007141716.09384.arnd@arndb.de> <20100714172319.GA8933@debian>
Message-ID: <201007141955.00607.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 July 2010 19:23:19 Rabin Vincent wrote:
> On Wed, Jul 14, 2010 at 05:16:09PM +0200, Arnd Bergmann wrote:
> > I also don't know if the same problem exists on actual versatile
> > hardware or if it's really a qemu bug.
> 
> It's a QEMU bug.  It was fixed with this patch to QEMU:
> 
> http://www.mail-archive.com/qemu-devel at nongnu.org/msg30785.html

Ok, thanks for the info. I was sure I was using the latest qemu
checkout, but apparently I made a mistake there.

	Arnd
