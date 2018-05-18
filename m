From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 May 2018 07:01:19 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: prm44xx: Introduce context save/restore
 for am43 PRCM IO
In-Reply-To: <1526632822-26049-1-git-send-email-j-keerthy@ti.com>
References: <1526632822-26049-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20180518140119.GV98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180518 08:42]:
> From: Dave Gerlach <d-gerlach@ti.com> 
> 
> There are two registers on am43x needed for IO daisy chain wake to work
> properly, however currently after an RTC+DDR cycle they are lost. We
> must take care to save and restore these before and after entering RTC
> mode otherwise IO daisy chain wake will stop working from DeepSleep
> after resuming.

OK applying these two also into omap-for-v4.18/soc.

Regards,

Tony
