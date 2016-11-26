From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 26 Nov 2016 10:43:26 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.10 (#2)
Message-ID: <87k2bqink1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second (and late) pull request for dt for mvebu for v4.10.
It only contains the support for the Turris Omnia.

It is a little late but quoting Uwe Kleine-K?nig: "can we still get it
into 4.10? This would help me to put this in the Debian kernel for the
next release."

Gregory

The following changes since commit 2f7132852038deb8e364bee155f51cb477c8d2f4:

  ARM: dts: armada-375: Fixup ethernet child DT warning (2016-11-19 09:16:52 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.10-2

for you to fetch changes up to 26ca8b52d6e18c10109cabda0f775dd9345bbfdf:

  ARM: dts: add support for Turris Omnia (2016-11-25 17:11:34 +0100)

----------------------------------------------------------------
mvebu dt for 4.10 (part 1)

Add Turris Omnia support, an open hardware router Armada 385 based

----------------------------------------------------------------
Uwe Kleine-K?nig (2):
      devicetree: Add vendor prefix for CZ.NIC
      ARM: dts: add support for Turris Omnia

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-385-turris-omnia.dts      | 340 +++++++++++++++++++++
 3 files changed, 342 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-turris-omnia.dts
