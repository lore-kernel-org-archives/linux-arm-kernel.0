From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Feb 2017 18:29:05 +0100
Subject: [GIT PULL] ARM: mvebu: late dt for v4.11
Message-ID: <8760kacae6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a late pull request for dt for mvebu for v4.11.

As explained in the tag, these 2 commits are just fixing typo.

If they can't be merged now then considered merging them as fix for
4.11.

Thanks,

Gregory

The following changes since commit 5cb13094484ba89d9a2623ddb72b36ea498e2bff:

  ARM: dts: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards (2017-01-31 14:45:04 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.11-4

for you to fetch changes up to 04be87a83db6cbb7586db95b591467c58ae09aee:

  ARM: dts: armada-385-linksys: fix DSA compatible property (2017-02-15 15:54:13 +0100)

----------------------------------------------------------------
mvebu dt for 4.11 (part 4)

Fix typos introduced during the preparation of the 4.11 merge window.

----------------------------------------------------------------
Chris Packham (1):
      ARM: dts: Fix typo in armada-xp-98dx4251

Ralph Sennhauser (1):
      ARM: dts: armada-385-linksys: fix DSA compatible property

 arch/arm/boot/dts/armada-385-linksys.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
