From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 07 Sep 2010 13:49:09 +0100
Subject: [RFC PATCH 0/3] Convert RealView/Versatile platforms to physmap-flash
Message-ID: <20100907124702.7188.385.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've had this patches in my tree for some time but forgot about them. Is
there a reason why we need to use the integrator flash and not convert
to the physmap-flash? It gives us the same functionality. If converting
the Integrator boards, we can even remove the integrator flash support.

Thanks.


Catalin Marinas (3):
      RealView: Convert the platform code to use the physmap flash driver
      Versatile: Convert the platform code to use the physmap flash driver
      VExpress: Convert the platform code to use the physmap flash driver


 arch/arm/mach-realview/core.c  |   31 ++++---------------------------
 arch/arm/mach-versatile/core.c |   31 ++++---------------------------
 arch/arm/mach-vexpress/v2m.c   |   22 ++++------------------
 3 files changed, 12 insertions(+), 72 deletions(-)

-- 
Catalin
