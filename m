From: jason.hui@linaro.org (Jason Liu)
Date: Wed, 2 Nov 2011 19:03:51 +0800
Subject: [PATCH v3 0/3] ARM:i.MX fix compile errors and warnings
Message-ID: <1320231836-9555-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set fix the compile errors and warnings on i.MX

Jason Liu (3):
  ARM:i.MX: fix build error in tzic/avic.c
  ARM:i.MX: fix the build error in clock-mx51-mx53.c
  ARM:i.MX: fix the compile warnings in clock-mx51-mx53.c

 arch/arm/mach-mx5/clock-mx51-mx53.c |    4 ++++
 arch/arm/plat-mxc/avic.c            |    1 +
 arch/arm/plat-mxc/tzic.c            |    1 +
 3 files changed, 6 insertions(+), 0 deletions(-)

-- 
1.7.4.1
