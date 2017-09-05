From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  6 Sep 2017 00:32:51 +0200
Subject: [GIT PULL] ARM: actions: dt for v4.14
Message-ID: <20170905223252.9478-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's a (late) dt pull for Actions Semi.
This clock node is needed to make use of the new full serial driver.

Regards,
Andreas

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-dt-for-4.14

for you to fetch changes up to d06701290709fc5437d4bfa375ccf9776be48c45:

  ARM: dts: owl-s500-guitar-bb-rev-b: Add fake uart3 clock (2017-09-05 23:23:11 +0200)

----------------------------------------------------------------
Actions Semi ARM based SoC DT for v4.14

This updates the Guitar board DT with a clock node for the debug UART.
It also updates the S500 SoC DT with CPU power domains.

----------------------------------------------------------------
Andreas F?rber (2):
      ARM: dts: owl-s500: Set power domains for CPU2 and CPU3
      ARM: dts: owl-s500-guitar-bb-rev-b: Add fake uart3 clock

 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts | 7 +++++++
 arch/arm/boot/dts/owl-s500.dtsi                | 3 +++
 2 files changed, 10 insertions(+)
