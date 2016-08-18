From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 Aug 2016 14:55:49 +0530
Subject: [PATCH v3 3/4] ARM: dts: da850,da850-evm: Add an aemif node and
 use it for the NAND
In-Reply-To: <20160816223338.20776-4-kbeldan@baylibre.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
 <20160816223338.20776-4-kbeldan@baylibre.com>
Message-ID: <8c37b7bd-0c8b-cd1f-c937-4d5cdaae2dce@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 August 2016 04:03 AM, Karl Beldan wrote:
> Currently the davinci da8xx boards use the mach-davinci aemif code.
> Instantiating an aemif node into the DT allows to use the ti-aemif
> memory driver and is another step to better DT support.
> This change adds an aemif node in the dtsi while retiring the nand_cs3
> node. The NAND is now instantiated in the dts as a subnode of the aemif
> one along with its pins.
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>

Applied to v4.9/dts branch of my tree.

Regards,
Sekhar
