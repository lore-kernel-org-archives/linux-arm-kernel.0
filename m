From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 4 Jul 2016 18:17:12 +0530
Subject: [PATCH] ARM: dts: da850: Add new ECAP and EPWM bindings
In-Reply-To: <1467036842-20913-1-git-send-email-fcooper@ti.com>
References: <1467036842-20913-1-git-send-email-fcooper@ti.com>
Message-ID: <577A5AD0.7070906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 June 2016 07:44 PM, Franklin S Cooper Jr wrote:
> From: "Cooper Jr., Franklin" <fcooper@ti.com>
> 
> Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
> provide the various required clocks.

there is nothing called hwmod on da850, so this need rewording to make
sense for that platform.

> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>

Also, documentation needs update as well since it says:

"
for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm"
"

Thanks,
Sekhar
