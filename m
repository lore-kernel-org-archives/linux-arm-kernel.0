From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Jan 2018 13:54:42 +0000
Subject: [PATCH v6 08/12] arm64: Add support for ACPI based firmware tables
In-Reply-To: <20180113005920.28658-9-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-9-jeremy.linton@arm.com>
Message-ID: <20180115135442.GF5473@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 06:59:16PM -0600, Jeremy Linton wrote:
> The /sys cache entries should support ACPI/PPTT generated cache
> topology information. Lets detect ACPI systems and call
> an arch specific cache_setup_acpi() routine to update the hardware
> probed cache topology.
> 
> For arm64, if ACPI is enabled, determine the max number of cache
> levels and populate them using the PPTT table if one is available.
> 

Looks good,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
