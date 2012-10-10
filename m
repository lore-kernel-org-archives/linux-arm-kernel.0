From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Oct 2012 16:18:49 +0100
Subject: [PATCH 0/6] Provide basic support for the u9540
Message-ID: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After this patch-set has been applied the Mainline kernel
successfully boots on the u9540 development board. It is
by no means fully enabled, but it does provide solid
foundations for further development.

 arch/arm/boot/dts/u9540.dts      |   47 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/cpu-db8500.c |   15 +++++++++++-
 drivers/mfd/db8500-prcmu.c       |    8 +++++--
 3 files changed, 67 insertions(+), 3 deletions(-)
