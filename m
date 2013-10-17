From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Oct 2013 09:39:44 -0400
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.13 (round 2)
Message-ID: <20131017133944.GF22434@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's the next round of driver changes for mvebu.  As previously
arranged with Bjorn, we're taking the pci-mvebu.c changes this time
around since the previous pull request had pci changes depending on
changes in irqchip.

thx,

Jason.


The following changes since commit 96ae0b548672adc12431312718835e77472f5bf0:

  ARM: mvebu: fix gated clock documentation (2013-10-08 15:17:56 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/drivers-3.13-2

for you to fetch changes up to f5072dfbac053200c8865c4fb15e4f020b7b5d1d:

  PCI: mvebu: make local functions static (2013-10-08 17:57:40 +0000)

----------------------------------------------------------------
mvebu driver changes for v3.13 (round 2)

 - mvebu
    - pcie
       - dynamic link up detection
       - add IO wrappers
       - declare some local functions static

----------------------------------------------------------------
Jason Gunthorpe (1):
      PCI: mvebu: Dynamically detect if the PEX link is up to enable hot plug

Jingoo Han (1):
      PCI: mvebu: make local functions static

Seungwon Jeon (1):
      PCI: mvebu: add I/O access wrappers

 drivers/pci/host/pci-mvebu.c | 128 +++++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 59 deletions(-)
