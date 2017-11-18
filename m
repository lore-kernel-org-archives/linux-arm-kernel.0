From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 18 Nov 2017 14:04:11 +0100
Subject: [PATCH 0/2] ARM: bcm283x: Add missing interrupt for RNG block
Message-ID: <1511010253-5006-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

i do not know your plans for V3 of your RNG consolidation series, but
there is the wish of the FreeBSD guys to add the interrupt property to
the DTS file [1].

There is no high prio, so feel free to squash it into your series or
i could rebase on your next version.

[1] - https://github.com/raspberrypi/linux/issues/2195

Stefan Wahren (2):
  dt-binding: rng: Add interrupt property for BCM2835
  ARM: bcm283x: Add missing interrupt for RNG block

 Documentation/devicetree/bindings/rng/brcm,bcm2835.txt | 9 +++++++--
 arch/arm/boot/dts/bcm283x.dtsi                         | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.7.4
