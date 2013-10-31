From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 Oct 2013 11:56:27 -0400
Subject: [GIT PULL V2] ARM: mvebu: dt changes for v3.13 (really, last one!)
In-Reply-To: <20131031133550.GM26784@titan.lakedaemon.net>
References: <20131031133550.GM26784@titan.lakedaemon.net>
Message-ID: <20131031155627.GP26784@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Thu, Oct 31, 2013 at 09:35:50AM -0400, Jason Cooper wrote:
> Olof,
> 
> At your request, here's Thomas' patch adding the Openblocks A7 board.
> It made it through -next last night.

Small amendment.  In all the hussle of KS last week, I forgot there was
one other dts-only board addition that I had held off.  Doesn't seem
right to push Thomas' without Arnaud's. :)

Thanks for the gentle reminder, Arnaud!

thx,

Jason.


The following changes since commit f039dfb51b36a2d7e4ac25e65ffbd03e3ac77a0c:

  ARM: mvebu: Add the core-divider clock to Armada 370/XP (2013-10-23 11:04:31 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dt-3.13-5

for you to fetch changes up to 45e8815fc1b7ed66729bbbc9464228ee1769b580:

  ARM: mvebu: Add Netgear ReadyNAS 104 board (2013-10-31 15:42:07 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.13 (round 5)

 - kirkwood
    - add the Openblocks A7 board

 - mvebu
    - add Netgear ReadyNAS 104 board

----------------------------------------------------------------
Arnaud Ebalard (1):
      ARM: mvebu: Add Netgear ReadyNAS 104 board

Thomas Petazzoni (1):
      ARM: kirkwood: add support for OpenBlocks A7 platform

 arch/arm/boot/dts/Makefile                     |   6 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 193 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts   | 223 +++++++++++++++++++++++++
 3 files changed, 420 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-netgear-rn104.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-openblocks_a7.dts
