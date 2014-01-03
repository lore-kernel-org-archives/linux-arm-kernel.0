From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 14:21:36 +0000
Subject: [PATCH 1/2] zynq: Do not explicitely enable icache
In-Reply-To: <201401031352.51392.arnd@arndb.de>
References: <521bc636ed31ff2958f8c95417b09036a523782c.1388742126.git.michal.simek@xilinx.com>
 <201401031352.51392.arnd@arndb.de>
Message-ID: <20140103142136.GM7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 01:52:51PM +0100, Arnd Bergmann wrote:
> On Friday 03 January 2014, Michal Simek wrote:
> > icache is already enabled by default.
> > 
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> > 
> >  board/xilinx/zynq/board.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> You had me confused for a bit. Please mark u-boot patches as such
> when you send them to the kernel mailing list, and vice-versa.

Better still, they shouldn't be sent to the kernel mailing lists in the
first place - they're off-topic here.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
