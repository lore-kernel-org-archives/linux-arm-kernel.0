From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 Apr 2014 11:51:21 +0100
Subject: [PATCH v2 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
In-Reply-To: <534DB213.7080802@semaphore.gr>
References: <534DB213.7080802@semaphore.gr>
Message-ID: <20140416105121.GR4754@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The cpufreq core now supports the cpufreq_for_each_entry macro helper
> for iteration over the cpufreq_frequency_table, so use it.
> 
> It should have no functional changes.
> 
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Applied untested by me.

Linus if you could find the time to do the honours I'd me much obliged.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
