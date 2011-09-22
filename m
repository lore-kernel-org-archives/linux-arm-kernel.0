From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 17:59:30 -0700
Subject: [PATCH v16 00/12] OMAP: dmtimer: adaptation to platform_driver
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110922005930.GN2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarun,

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> Adaptation of dmtimer code to platform driver using omap_device and
> omap_hwmod abstraction. It also include pm-runtime and off-mode support.

I've applied these into dmtimer branch with some changes to simplify
things further. I've also merged it into linux-omap master branch
for further testing.

I'll reply to your patches with the changes I've done. Care give the
dmtimer branch a try and see if I've missed something?

Regards,

Tony
