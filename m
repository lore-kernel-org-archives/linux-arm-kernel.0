From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 21 Jul 2011 16:58:02 +0530
Subject: [PATCHV2 4/5] OMAP: I2C: Remove the SYSC register definition
In-Reply-To: <1311246554-22975-5-git-send-email-shubhrajyoti@ti.com>
References: <1311246554-22975-1-git-send-email-shubhrajyoti@ti.com>
	<1311246554-22975-5-git-send-email-shubhrajyoti@ti.com>
Message-ID: <4E280D42.9030808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/21/2011 4:39 PM, Shubhrajyoti D wrote:
> The SYSC register should not accessed in the driver removing the
> define from the driver.
>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>

Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
