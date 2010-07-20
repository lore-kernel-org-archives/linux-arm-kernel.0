From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jul 2010 22:19:22 +0100
Subject: [RFC] arm: versatile: enable PCI I/O space
In-Reply-To: <201007202312.18353.arnd@arndb.de>
References: <AANLkTikiim-a8zM0PRDVVN078xBWeZt7ElwbC4oZsfXy@mail.gmail.com>
	<201007202312.18353.arnd@arndb.de>
Message-ID: <20100720211921.GC10553@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 11:12:17PM +0200, Arnd Bergmann wrote:
> We also have two platforms (integrator and shark) that use a
> higher value of 0x6000 but do not document why they do so.

On Integrator, it's fairly arbitary, and could be 0x1000 too.
