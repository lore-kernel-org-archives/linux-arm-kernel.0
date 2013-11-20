From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Nov 2013 20:40:27 +0800
Subject: [PATCH v8 0/4] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <1384937151-11160-1-git-send-email-mpa@pengutronix.de>
References: <1384937151-11160-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131120124025.GB22308@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 09:45:47AM +0100, Markus Pargmann wrote:
> Hi,
> 
> This version has some commit message updates. It still depends on the pinctrl driver patch [1].

Linus,

I'm about to apply the series.  Is it okay for me to pull in your
'devel' branch at commit 5fab718 (pinctrl: imx1-core populate
subdevices) now?  Or should I at least wait a few days for you to
rebase your branch on 3.13-rc1 after it becomes available?

Actually, you can still rebase your branch before I send my branches to
arm-soc folks around -rc6.  But you need to let me know, so that I can
rebuild my branches.

Shawn

> [1] [PATCH] pinctrl: imx1-core populate subdevices
>     <1384193987-20740-1-git-send-email-mpa@pengutronix.de>
>     http://thread.gmane.org/gmane.linux.drivers.devicetree/51584
