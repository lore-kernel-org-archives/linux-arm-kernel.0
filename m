From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Jan 2015 19:02:37 +0100
Subject: [PULL REQUEST] mvebu fixes #3
Message-ID: <20150117180237.GA19604@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

Another fixes pull request for mvebu. A single patch which disables
hardware I/O coherency.

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.19-3

for you to fetch changes up to 8f1e8ee28660018a935c7576b9af8ffe1feab54c:

  ARM: mvebu: completely disable hardware I/O coherency (2015-01-17 11:46:55 -0600)

----------------------------------------------------------------
mvebu fixes for 3.19-rc (part #3)

mvebu: completely disable hardware I/O coherency

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: mvebu: completely disable hardware I/O coherency

 arch/arm/mach-mvebu/coherency.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
