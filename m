From: jason.hui@linaro.org (Jason Liu)
Date: Thu, 3 Nov 2011 17:31:25 +0800
Subject: [PATCH v2 0/2] ARM:i.MX: fix build errors
Message-ID: <1320312687-20987-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set fix the build errors on i.MX

Jason Liu (2):
  ARM:i.MX: fix build error in tzic/avic.c
  ARM:i.MX: fix build error in clock-mx51-mx53.c
---
v2:move #ifdef to cover the whole dt thing and remove last patch from v1

 arch/arm/mach-mx5/clock-mx51-mx53.c |    2 ++
 arch/arm/plat-mxc/avic.c            |    1 +
 arch/arm/plat-mxc/tzic.c            |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.4.1
