From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 21 Nov 2012 16:06:33 -0500
Subject: [PATCH] arm: orion5x: convert Netgear WNR854T to device tree
In-Reply-To: <20121120122828.GO22106@titan.lakedaemon.net>
References: <1353342451-27180-1-git-send-email-kaloz@openwrt.org>
 <20121119204641.GK22106@titan.lakedaemon.net>
 <op.wn19dwpw2s3iss@ecaz>
 <20121120122828.GO22106@titan.lakedaemon.net>
Message-ID: <20121121210633.GF15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 07:28:28AM -0500, Jason Cooper wrote:
> On Tue, Nov 20, 2012 at 08:21:22AM +0100, Imre Kaloz wrote:
> > Jason,
> > 
> > On Mon, 19 Nov 2012 21:46:41 +0100, Jason Cooper <jason@lakedaemon.net> wrote:
> > 
> > >On Mon, Nov 19, 2012 at 05:27:31PM +0100, Imre Kaloz wrote:
> > >>This commit converts the Netgear WNR854T to device tree
> > >>
> > >>Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> > >>---
> > >> arch/arm/boot/dts/Makefile                    |    3 +-
> > >> arch/arm/boot/dts/orion5x-netgear-wnr854t.dts |   83 +++++++++++++++++++++++++
> > >> arch/arm/mach-orion5x/Kconfig                 |    7 +-
> > >> arch/arm/mach-orion5x/Makefile                |    2 +-
> > >> arch/arm/mach-orion5x/board-dt.c              |    3 +
> > >> arch/arm/mach-orion5x/common.h                |    5 ++
> > >> arch/arm/mach-orion5x/wnr854t-setup.c         |   59 +-----------------
> > >> 7 files changed, 99 insertions(+), 63 deletions(-)
> > >> create mode 100644 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
> > >
> > >One last thing, could you use savedefconfig and update orion5x_defconfig
> > >to include your new board?  It can be a part of the same patch.
> > 
> > Would you prefer it to be included in this one or in a later patch if I'm done adding some more boards?
> 
> All in one.  It prevents chicken-egg merge conflicts on my end. :)

Sorry, I should have read more carefully.  I meant you should do one
patch per board, and each patch should include updating defconfig for
that board.

thx,

Jason.
