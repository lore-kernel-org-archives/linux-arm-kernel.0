From: agraf@suse.de (Alexander Graf)
Date: Thu, 14 Mar 2013 01:58:59 +0100
Subject: [PATCH 0/3] ARM: EXYNOS5250: Enable KVM support
Message-ID: <1363222742-15220-1-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to run 3.9 on Arndale with KVM, I ran across a few minor
issues. These patches resolve them, but I'm not 100% sure they are
correct.

I'd be very happy if someone who's deeply into the respective code
paths could take a look here and either ack the patches or suggest
alternative patches to fix the issues at hand.

Alex

Alexander Graf (3):
  ARM: EXYNOS5250: dts: Declare the gic as a15 compatible
  ARM: EXYNOS5250: dts: Add architected timer nodes
  ARM: EXYNOS5250: Register architected timers

 arch/arm/boot/dts/exynos5250.dtsi |   18 +++++++++++++++---
 arch/arm/mach-exynos/mct.c        |    4 ++++
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
1.7.10.4
