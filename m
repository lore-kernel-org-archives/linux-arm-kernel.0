From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 May 2010 22:53:28 +0100
Subject: How to allocate a new machine type?
In-Reply-To: <x2xe7bd23c31005041432k6c846fc2p90afbd8ec370d3df@mail.gmail.com>
References: <x2xe7bd23c31005041432k6c846fc2p90afbd8ec370d3df@mail.gmail.com>
Message-ID: <20100504215328.GK30601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 02:32:15PM -0700, Corbin Simpson wrote:
> So, I noticed that there's a Pollux entry, POLLUX_WIZ (1950), in the
> mach-types list already. Does anybody know if that covers all Pollux
> devices, or just the Wiz? Also, what do I have to do to allocate a new
> type?

It's for "GamePark Holdings GP2X Wiz".  So it seems its only for the Wiz.

   Machine name:     GamePark Holdings GP2X Wiz
   Web site:         http://www.gp2xwiz.com/
   Description:      The GP2X Wiz is a handheld video game machine using the
                     MagicEyes Pollux SoC.

For information on machines, including registering new ones, etc, see
the bottom of Documentation/arm/README in the kernel tree.
