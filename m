From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 14 Sep 2017 10:26:35 +0300
Subject: [PATCH v3 2/3] mmc: sdhci-omap: Add OMAP SDHCI driver
In-Reply-To: <20170906114556.32532-3-kishon@ti.com>
References: <20170906114556.32532-1-kishon@ti.com>
 <20170906114556.32532-3-kishon@ti.com>
Message-ID: <cdb5251f-e725-e5ca-0c36-a3b2544ffbdc@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/17 14:45, Kishon Vijay Abraham I wrote:
> Create a new sdhci-omap driver to configure the eMMC/SD/SDIO controller
> in TI's OMAP SoCs making use of the SDHCI core library. For OMAP specific
> configurations, populate sdhci_ops with OMAP specific callbacks and use
> SDHCI quirks.
> Enable only high speed mode for both SD and eMMC here and add other
> UHS mode support later.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
