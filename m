From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Wed, 01 Feb 2017 12:15:01 -0800
Subject: irq_work_run called from armv8pmu_handle_irq
Message-ID: <762e1210e12fbc693b3d0e27361df53f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

we would like to understand why irq_work_run() is getting called from 
armv8pmu_handle_irq() irq handler for arm SoC.

Is this irq_work frame work designed to run works from ARMPMU irq 
handlers?  If there are no of drivers using the IRQ WORK frame work,  we 
may see that ARMPMU irq handler taking long time, right?

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
