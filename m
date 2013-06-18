From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Jun 2013 09:51:56 +0100
Subject: [PATCH 0/3] ARM: ux500: mop500_snowball_ethernet_clock_enable()
 removal
Message-ID: <1371545519-27119-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

As requested by you, this gets rid of  mop500_snowball_ethernet_clock_enable()
which is no longer in use. It also straightens out a bug which ensures the
SMSC911x's regulator is turned on at start-up when using Device Tree.

This is based on your test-merge-20130615 branch.

Kind regards,
Lee

 arch/arm/boot/dts/dbx5x0.dtsi      |  5 +++++
 arch/arm/boot/dts/snowball.dts     | 13 +++++++------
 arch/arm/mach-ux500/board-mop500.c | 11 -----------
 arch/arm/mach-ux500/board-mop500.h |  1 -
 arch/arm/mach-ux500/cpu-db8500.c   |  1 -
 5 files changed, 12 insertions(+), 19 deletions(-)
