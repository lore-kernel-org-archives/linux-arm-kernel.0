From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 4 Jul 2016 16:16:54 +0200
Subject: [GIT PULL] ARM: at91: dt for 4.8 #2 bis
In-Reply-To: <20160621171108.GA16256@piout.net>
Message-ID: <20160704141654.GA9355@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please disregard the previous DT pull request, it had an issue...
I'm including the corrected change in this one with two fixes for the
sam9_l9260 and on fix for the sama5d2 xplained.
Also, adding the PMU node to the sama5d2 doesn't seem too risky.

The following changes since commit 64c0703e269d442f0406b34e64e23744151ea276:

  ARM: dts: at91: calao: remove leftovers clock definition (2016-06-10 16:59:30 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-dt2

for you to fetch changes up to b8bca7eaef9eeda4876b8ded1f49862b0b85181c:

  ARM: dts: at91: sama5d2_xplained: Update the pmic node (2016-07-04 15:59:46 +0200)

----------------------------------------------------------------
DT Changes for 4.8 #2:
 - New board: at91sam9260ek
 - Fixes for the sam9_l9260
 - Sama5d2 Xplained PMIC fix
 - Addition of the PMU node for the sama5d2

----------------------------------------------------------------
Nicolas Ferre (1):
      ARM: dts: at91: add at91sam9260ek board DT

Olivier Schonken (1):
      ARM: dts: at91: sama5d2: add PMU node

Raashid Muhammed (2):
      ARM: dts: at91: sam9_l9260: Add pinctrl information to ethernet node.
      ARM: dts: at91: sam9_l9260: Modify information in LED nodes.

Wenyou Yang (1):
      ARM: dts: at91: sama5d2_xplained: Update the pmic node

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-sam9_l9260.dts       |  14 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  41 ++++--
 arch/arm/boot/dts/at91sam9260ek.dts         | 211 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              |   5 +
 5 files changed, 259 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9260ek.dts

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160704/8b0ac4eb/attachment-0001.sig>
