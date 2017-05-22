From: robert.richter@cavium.com (Robert Richter)
Date: Mon, 22 May 2017 17:49:17 +0200
Subject: [PATCH v2 1/2] ACPICA: IORT: Update SMMU models for IORT rev. C
In-Reply-To: <11ef7d28c535c01d42b7b3c8e632934f0e0f1048.1495459319.git.robin.murphy@arm.com>
References: <11ef7d28c535c01d42b7b3c8e632934f0e0f1048.1495459319.git.robin.murphy@arm.com>
Message-ID: <20170522154917.GA16981@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.05.17 16:06:37, Robin Murphy wrote:
> IORT revision C has been published with a number of new SMMU
> implementation identifiers. Since IORT doesn't have any way of falling
> back to a more generic model code, we really need Linux to know about
> these before vendors start updating their firmware tables to use them.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Robert Moore <robert.moore@intel.com>
> CC: Lv Zheng <lv.zheng@intel.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Robin, the stable tag is missing here, but we will need it for #2.

Thanks,

-Robert
