From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 Nov 2011 12:01:38 -0800
Subject: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
In-Reply-To: <1320333428-23532-1-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Thu, 3 Nov 2011 20:47:08 +0530")
References: <1320333428-23532-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <8762iu1izh.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Ben Dooks

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Currently the fifo depth is set to zero for OMAP4 which disables
> the FIFO usage. This patch enables the FIFO usage for I2C transactions
> on OMAP4 also.
>
> Tested on omap4430 and 3430.
>
> Tested-and-Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Ben, please queue as a fix for the v3.2-rc.  It applies cleanly to
v3.2-rc1.

If you prefer a branch:
https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/fixes/i2c

Thanks,

Kevin
