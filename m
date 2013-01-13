From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Jan 2013 01:05:35 +0000
Subject: [GIT PULL 2/4] ARM: mvebu: drivers for v3.9
In-Reply-To: <E1TuAWu-0004Jx-Hn@merlin.infradead.org>
References: <pull-1358033364-983365> <E1TuAWu-0004Jx-Hn@merlin.infradead.org>
Message-ID: <20130113010535.GR23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 11:29:16PM +0000, Jason Cooper wrote:
> Thomas Petazzoni (4):
>       mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
>       mmc: mvsdio: use slot-gpio for card detect gpio
>       mmc: mvsdio: implement a Device Tree binding
>       mmc: mvsdio: add pinctrl integration

Does this include the fixes for the really broken stuff in that driver?
If not, hold off on this until it's fixed.  The current state of the
driver is rather BROKEN and it needs fixing in -rc.  It would be best
to get it fixed there _then_ base development on top of that to avoid
conflicts.
