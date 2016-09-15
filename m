From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Sep 2016 14:01:29 -0700
Subject: [PATCH] ARM: dts: am57xx-beagle-x15-common: Fix wrong pinctrl
 selection for mmc2
In-Reply-To: <20160915191059.18190-1-nm@ti.com>
References: <20160915191059.18190-1-nm@ti.com>
Message-ID: <20160915210126.jpuslamqltlahimv@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160915 12:11]:
> Commit d20f997b4d1f ("ARM: dts: am57xx-beagle-x15: Remove pinmux
> configurations for erratum i869") fat fingered a change in which
> basically replaced mmc2_pinctrl_default with mmc1_pinctrl_default. And
> kernel dutifully reports conflict of usage.

Thanks applying into omap-for-v4.9/dt-v2.

Tony
