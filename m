From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Aug 2016 20:26:21 +0530
Subject: [PATCH v3 2/4] ARM: davinci_all_defconfig: Enable AEMIF as a
 module
In-Reply-To: <20160816223338.20776-3-kbeldan@baylibre.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
 <20160816223338.20776-3-kbeldan@baylibre.com>
Message-ID: <b507c69d-4fdd-f1dd-e7ed-12ed3a589ca8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 August 2016 04:03 AM, Karl Beldan wrote:
> This enables the use of the memory/ti-aemif.c driver.
> ATM most davinci boards use the mach-davinci aemif code which gets in
> the way of genericity and proper DT boot.
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>

Applied to v4.9/defconfig.

Regards,
Sekhar
