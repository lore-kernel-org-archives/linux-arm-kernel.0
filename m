From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 13 Jan 2015 15:48:12 +0100
Subject: [GIT PULL] mvebu: SoC for 3.20
Message-ID: <20150113144812.GA13100@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

Here is the first pull request for SoC for mvebu for v3.20.

     Andrew

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.20

for you to fetch changes up to c6574542149dede8093e326d2c358ba447e30f33:

  ARM: mvebu: Update the SoC ID and revision definitions (2015-01-09 09:22:53 -0600)

----------------------------------------------------------------
mvebu SoC changes for v3.20 (part #1)

- Update the SoC ID and revision definitions
- Add UART1 as DEBUG_LL possible target
- Rename DEBUG_LL to indicate UART index

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: Update the SoC ID and revision definitions

Maxime Ripard (2):
      ARM: mvebu: Rename DEBUG_LL to indicate UART index
      ARM: mvebu: Add UART1 as DEBUG_LL possible target

 arch/arm/Kconfig.debug             | 35 ++++++++++++++++++++++++++---------
 arch/arm/mach-mvebu/mvebu-soc-id.h | 18 ++++++++++++++++++
 2 files changed, 44 insertions(+), 9 deletions(-)
