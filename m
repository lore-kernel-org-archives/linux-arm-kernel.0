From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 22 Jan 2015 01:40:03 +0100
Subject: [Request pull] mvebu/fixes #3
Message-ID: <20150122004003.GA9533@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

One more fix for 3.19-rc for mvebu, making this the fourth incremental
pull request.

Thanks
	Andrew

The following changes since commit 8f1e8ee28660018a935c7576b9af8ffe1feab54c:

  ARM: mvebu: completely disable hardware I/O coherency (2015-01-17 11:46:55 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.19-4

for you to fetch changes up to 38bdf45f4aa5cb6186d50a29e6cbbd9d486a1519:

  bus: mvebu-mbus: fix support of MBus window 13 (2015-01-19 15:40:53 -0600)

----------------------------------------------------------------
mvebu fixes for 3.19. (Part 4)

bus: mvebu-mbus: fix support of MBus window 13

----------------------------------------------------------------
Andrew Lunn (1):
      bus: mvebu-mbus: fix support of MBus window 13

 drivers/bus/mvebu-mbus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)
