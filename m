From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Mar 2017 14:53:48 -0700
Subject: [PATCH v3 1/2] ARM: dts: bcm5301x: Add TWD WD Support to DT
In-Reply-To: <1488817485-7503-2-git-send-email-jon.mason@broadcom.com>
References: <1488817485-7503-1-git-send-email-jon.mason@broadcom.com>
 <1488817485-7503-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <03eb99e1-f18c-d4a3-32bf-d90640b14ab1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2017 08:24 AM, Jon Mason wrote:
> From: Jon Mason <jonmason@broadcom.com>
> 
> Add support for the ARM TWD Watchdog to the bcm5301x device tree.  The
> ARM TWD timer allocated the register space for the WDT, so this patch
> necessitated shrinking that.  Also, the GIC masks were added for these.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>

There were some minor conflicts that have been resolved, applied, thanks!
-- 
Florian
