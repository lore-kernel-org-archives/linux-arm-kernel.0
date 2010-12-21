From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Dec 2010 17:14:44 -0800
Subject: [PATCH] omap: pandora: fix wifi support
In-Reply-To: <1292798016-11098-1-git-send-email-notasas@gmail.com>
References: <1292798016-11098-1-git-send-email-notasas@gmail.com>
Message-ID: <20101221011444.GG5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [101219 14:33]:
> After commit ed919b0 "mmc: sdio: fix runtime PM anomalies by introducing
> MMC_CAP_POWER_OFF_CARD" it is required to specify MMC_CAP_POWER_OFF_CARD
> to have runtime PM support. As the wl1251 driver expects card to be
> powered down when it's not used, wifi will no longer work after interface
> is brought down at least once without functioning runtime PM.
> 
> Fix this by declaring MMC_CAP_POWER_OFF_CARD for MMC3.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> this is a fix but can go for 2.6.38 as wl1251 runtime PM support
> is only queued for .38 .

Thanks queuing for the merge window.

Regards,

Tony
