From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Sep 2016 10:28:12 +0200
Subject: [GIT PULL] ARM: at91: dt for 4.9
Message-ID: <20160914082812.tmlrrqwkeudcybui@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Only a single DT patch for this release:

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.9-dt1

for you to fetch changes up to e46f48ad86f4483dfaa5947a7b7dbd4a63b0398a:

  ARM: dts: at91: sama5d2: add ETM and ETB nodes (2016-08-08 12:08:00 +0200)

----------------------------------------------------------------
DT Changes for 4.9:
 - add ETM and ETB nodes on sama5d2

----------------------------------------------------------------
Olivier Schonken (1):
      ARM: dts: at91: sama5d2: add ETM and ETB nodes

 arch/arm/boot/dts/sama5d2.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
