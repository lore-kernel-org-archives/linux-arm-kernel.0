From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 13:00:24 +0000
Subject: [PATCH V4 0/4] Add SPI clkdev support
In-Reply-To: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
References: <1320268004-4545-1-git-send-email-padma.v@samsung.com>
Message-ID: <20111102130024.GC19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 05:06:40PM -0400, Padmavathi Venna wrote:
> This patchset modifies the existing clkdev to make SPI driver
> independent of the clock names send from platform data.

No it does not.  It modifies the clkdev lookup tables.

When I read this I thought 'why are you modifying the clkdev stuff'.  Only
when I read the diffstat did it become clear that this was not the case.

Please be more careful about describing your changes.
