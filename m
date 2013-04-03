From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 14:03:59 -0700
Subject: [PATCH v2 13/18] ARM: OMAP: CPUidle: Unregister drivere on device
 registration failure
In-Reply-To: <1364205910-32392-14-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:05 +0530")
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-14-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <871uartjgg.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> If the CPUidle device registration fails for some reason, we should
> unregister the driver on error path.
>
> Fix the code accordingly. Also when at it, check of the driver registration
> failure too.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Adding to my for_3.10/fixes/cpuidle branch.

Kevin
