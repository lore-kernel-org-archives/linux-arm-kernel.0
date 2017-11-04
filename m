From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat,  4 Nov 2017 19:09:37 +0800
Subject: [GIT PULL] arm: actions: dt for v4.15
In-Reply-To: <20171104110938.9019-1-afaerber@suse.de>
References: <20171104110938.9019-1-afaerber@suse.de>
Message-ID: <20171104110938.9019-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's a (late) dt pull for Actions Semi.
This clock node is needed to make use of the full serial driver merged in 4.14.
CubieBoard6 is new for 4.15.

Regards,
Andreas

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-dt-for-4.15

for you to fetch changes up to 7f6a78fe34f041da317e46813254abab776d46f7:

  ARM: dts: owl-s500: Add CubieBoard6 (2017-11-04 18:12:45 +0800)

----------------------------------------------------------------
Actions Semi ARM based SoC DT for v4.15

This updates the Guitar board DT with a clock node for the debug UART
and adds a new DT for the CubieBoard6.
It also updates the S500 DT with CPU power domains.

----------------------------------------------------------------
Andreas F?rber (4):
      ARM: dts: owl-s500: Set power domains for CPU2 and CPU3
      ARM: dts: owl-s500-guitar-bb-rev-b: Add fake uart3 clock
      dt-bindings: arm: actions: Add CubieBoard6
      ARM: dts: owl-s500: Add CubieBoard6

 Documentation/devicetree/bindings/arm/actions.txt |  1 +
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/owl-s500-cubieboard6.dts        | 44 +++++++++++++++++++++++
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts    |  7 ++++
 arch/arm/boot/dts/owl-s500.dtsi                   |  3 ++
 5 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-cubieboard6.dts
