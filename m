From: khilman@ti.com (Kevin Hilman)
Date: Mon, 05 Mar 2012 13:33:20 -0800
Subject: [PATCH v7 0/9] Consolidate cpuidle functionality
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org> (Robert
 Lee's message of "Wed, 29 Feb 2012 18:42:49 -0600")
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Message-ID: <87y5reivhb.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Lee <rob.lee@linaro.org> writes:

> This patch series moves various functionality duplicated in platform 
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into 
> cpuidle_call_idle will have already called local_irq_disable().

Reviewed-by: Kevin Hilman <khilman@ti.com>
