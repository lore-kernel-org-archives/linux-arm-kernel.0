From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 5 Sep 2012 12:40:11 +0000
Subject: [PATCH v7 3/3] ARM: OMAP2+: gpmc: minimal driver support
In-Reply-To: <dd56963ba88d021f3c176c08d58e3a00df9946aa.1346829351.git.afzal@ti.com>
References: <cover.1346829350.git.afzal@ti.com>
 <dd56963ba88d021f3c176c08d58e3a00df9946aa.1346829351.git.afzal@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9DE61A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 05, 2012 at 14:20:09, Mohammed, Afzal wrote:
> Create a minimal driver out of gpmc code.
> Responsibilities handled by earlier gpmc
> initialization is now achieved in probe.

> +	if (GPMC_REVISION_MAJOR(l) > 0x4)
> +		gpmc_capability = GPMC_HAS_WR_ACCESS | GPMC_HAS_WR_DATA_MUX_BUS;

v8 of this series has been submitted leveraging gpmc capability
flag to determine whether wr_access and wr_data_mux_bus timing
fields has to be configured.

Regards
Afzal
