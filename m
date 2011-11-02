From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 16:06:03 +0000
Subject: [PATCH v2 1/3] Add support for mini-box.com picoSAM9G45 board
In-Reply-To: <20111102154935.GC7136@game.jcrosoft.org>
References: <1320076396-6233-1-git-send-email-npavel@mini-box.com>
	<20111102142817.GH19187@n2100.arm.linux.org.uk>
	<20111102154935.GC7136@game.jcrosoft.org>
Message-ID: <20111102160603.GA12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 04:49:35PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:28 Wed 02 Nov     , Russell King - ARM Linux wrote:
> > Before Nicu puts these into the patch system (which is being attempted
> > right now)...
> As announce at the kernel summit no new board for 9gx series will be merged
> except pending one. The new board will have to go via DT.

Well, we now have patches for this board in the patch system:

   7148/1? Add picosam9g45 board to         3.1?                 14:25:18?
           Makefile
   7147/1? Add kernel configuration option  3.1?                 14:25:17?
           for picosam9g45 board
   7146/1? Add support for mini-box.com     3.1?                 14:25:16?
           picoSAM9G45 board

along with these old ones:

   6862/1? Add Board Support for Siemens L1 2.6.39-rc1?          04 Apr 2011?
           Board
   6861/1? Add Board Support for Siemens L0 2.6.39-rc1?          04 Apr 2011?
           Board

So, it sounds like I should just discard the three new ones - what about
the old ones?  Those too?  I've not seen/heard anything further on them.
