From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2016 16:20:38 -0700
Subject: [PATCH RESEND] ARM: AM43XX: Select OMAP_INTERCONNECT in Kconfig
In-Reply-To: <20161019204412.18607-1-d-gerlach@ti.com>
References: <20161019204412.18607-1-d-gerlach@ti.com>
Message-ID: <20161107232038.GE2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [161019 13:45]:
> AM437x makes use of the omap_l3_noc driver so explicitly select
> OMAP_INTERCONNECT in the Kconfig for SOC_AM43XX to ensure it gets enabled
> for AM43XX only builds.

Applying into omap-for-v4.9/fixes thanks.

Tony
