From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Jun 2016 00:22:45 -0700
Subject: [PATCH] ARM: OMAP2+: Select OMAP_INTERCONNECT for SOC_AM43XX
In-Reply-To: <4af329be31b140a7cd71351cf8f2d2006194e42b.1464105749.git.d-gerlach@ti.com>
References: <4af329be31b140a7cd71351cf8f2d2006194e42b.1464105749.git.d-gerlach@ti.com>
Message-ID: <20160609072245.GM22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [160524 09:14]:
> AM43XX SoCs make use of the omap_l3_noc driver so explicitly select
> OMAP_INTERCONNECT in the Kconfig for SOC_AM43XX to ensure it always gets
> enabled for AM43XX only builds.

Applying into omap-for-v4.7/fixes thanks.

Tony
