From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 18 Sep 2012 10:30:55 +0200
Subject: [GIT PULL] at91: one fix for 3.6
Message-ID: <5058313F.8060704@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

We have one last minute fix. It can help us to use the device tree for 
GPIO interrupt attached devices. I have based my tag on top of the "fixes" pull 
request that I've already sent to you.
I hope that it could make it for 3.6-final.

The following changes since commit 51a6149b89b822cacf572b2ca2a15cb6f2232b11:

  ARM: at91/feature-removal-schedule: delay at91_mci removal (2012-08-27 09:59:36 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 51ac51a6a5ab5f0aff46c4757ba4c32f3f8f7a2e:

  ARM: at91: fix missing #interrupt-cells on gpio-controller (2012-09-17 10:25:01 +0200)

----------------------------------------------------------------
Modify AT91 device tree files for making the GPIO interrupts work.

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: fix missing #interrupt-cells on gpio-controller

 arch/arm/boot/dts/at91sam9260.dtsi | 3 +++
 arch/arm/boot/dts/at91sam9263.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi | 5 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi | 4 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++++
 5 files changed, 21 insertions(+)

Thanks, best regards,
-- 
Nicolas Ferre
