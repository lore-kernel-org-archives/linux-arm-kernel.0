From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Apr 2014 08:15:41 +0100
Subject: [PATCH v4 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
In-Reply-To: <5355A349.50908@semaphore.gr>
References: <534DB213.7080802@semaphore.gr>
 <5355A349.50908@semaphore.gr>
Message-ID: <20140422071541.GA17657@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The cpufreq core now supports the cpufreq_for_each_entry macro helper
> for iteration over the cpufreq_frequency_table, so use it.
> 
> It should have no functional changes.

> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---

It would be good to have a changelog which describes the differences
between the versions, so we can keep track.

>  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

So it looks like I already applied v2 of this patch to my tree. What
changed in v3 and v4? Should I remove that patch from MFD and apply
this one instead?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
