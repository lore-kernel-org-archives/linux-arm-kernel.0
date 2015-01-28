From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 28 Jan 2015 17:02:31 +0100
Subject: [REQUEST PULL] mvebu-fixes-5
Message-ID: <20150128160231.GA28862@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

Here is the 5th set of fixes for 3.19-rc. A single patch, which we need
to fix an issue introduced by a previous fix.

Thanks
	Andrew

The following changes since commit 38bdf45f4aa5cb6186d50a29e6cbbd9d486a1519:

  bus: mvebu-mbus: fix support of MBus window 13 (2015-01-19 15:40:53 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.19-5

for you to fetch changes up to 38bdf45f4aa5cb6186d50a29e6cbbd9d486a1519:

  bus: mvebu-mbus: fix support of MBus window 13 (2015-01-19 15:40:53 -0600)

----------------------------------------------------------------
The previous fix for Armada XP, disabling I/O coherency, broke Armada
375/38x.  Only switch the PL310 to I/O coherent mode if I/O coherency
is enabled.

----------------------------------------------------------------
