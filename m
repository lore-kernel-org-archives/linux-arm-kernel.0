From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 03:34:23 -0700
Subject: [PATCH v8 5/9] ARM: dts: am437x/am33xx/da850: Add new ECAP and
 EPWM bindings
In-Reply-To: <1462291015-1919-6-git-send-email-fcooper@ti.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-6-git-send-email-fcooper@ti.com>
Message-ID: <20160610103423.GT22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Franklin S Cooper Jr <fcooper@ti.com> [160503 08:58]:
> Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
> provide the various required clocks.
> 
> For AM437 and AM335x, add the required clocks explicitly to DT. The
> hwmod entries for ECAP and EPWM will be removed and this will prevent
> anything from breaking.

I've applying the first patch into omap-for-v4.8/soc, the rest into
omap-for-v4.8/dt. Note that this patch did not apply against d850.dtsi
so please resend that change as a separate patch to the davinci
maintainer.

Regards,

Tony
