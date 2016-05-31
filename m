From: julien.grall@arm.com (Julien Grall)
Date: Tue, 31 May 2016 12:41:20 +0100
Subject: [PATCH 0/3] drivers/perf: arm_pmu: Small bug fixes in the driver
Message-ID: <1464694883-26298-1-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

This patch series contains a series of small bug fixes for the arm_pmu
drivers.

I think all the patch should be backported to stable but I have not figured
out up to which version.

Julien Grall (3):
  drivers/perf: arm_pmu: Fix reference count of a device_node in
    of_pmu_irq_cfg
  drivers/perf: arm_pmu: Defer the setting of __oprofile_cpu_pmu
  drivers/perf: arm_pmu: Avoid leaking pmu->irq_affinity on error

 drivers/perf/arm_pmu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
1.9.1
