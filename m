From: kamalesh@linux.vnet.ibm.com (Kamalesh Babulal)
Date: Wed, 27 Aug 2014 19:02:28 +0530
Subject: [PATCH v5 06/12] sched: add per rq cpu_capacity_orig
In-Reply-To: <1409051215-16788-7-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-7-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140827133033.GC13808@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vincent Guittot <vincent.guittot@linaro.org> [2014-08-26 13:06:49]:

> This new field cpu_capacity_orig reflects the available capacity of a CPUs
> unlike the cpu_capacity which reflects the current capacity that can be altered
> by frequency and rt tasks.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
