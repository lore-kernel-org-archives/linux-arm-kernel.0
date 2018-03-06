From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 6 Mar 2018 17:23:28 +0000
Subject: [PATCH v7 08/13] arm64: Add support for ACPI based firmware tables
In-Reply-To: <20180228220619.6992-9-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-9-jeremy.linton@arm.com>
Message-ID: <362fcf8a-44f8-7eb5-0f17-a7763f6236e4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/02/18 22:06, Jeremy Linton wrote:
> The /sys cache entries should support ACPI/PPTT generated cache
> topology information. Lets detect ACPI systems and call
> an arch specific cache_setup_acpi() routine to update the hardware
> probed cache topology.
> 
> For arm64, if ACPI is enabled, determine the max number of cache
> levels and populate them using the PPTT table if one is available.
> 

I fail to understand the kbuild failure report association with this
patch(most likely the previous patch could be culprit, I am looking at
it in detail now), but for this patch

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
