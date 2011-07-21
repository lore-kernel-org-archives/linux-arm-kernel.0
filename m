From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 21 Jul 2011 17:00:33 +0530
Subject: [PATCHV2 5/5] OMAP: I2C: Restore only if context is lost
In-Reply-To: <1311246554-22975-6-git-send-email-shubhrajyoti@ti.com>
References: <1311246554-22975-1-git-send-email-shubhrajyoti@ti.com>
	<1311246554-22975-6-git-send-email-shubhrajyoti@ti.com>
Message-ID: <4E280DD9.4020304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/21/2011 4:39 PM, Shubhrajyoti D wrote:
> Currently restore is done always.
> Adding conditional restore. The restore is done only if the context is lost.
>
Minor comment. You may want to say 'i2c register restore'
instead of just 'restore'

> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
o.w
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
