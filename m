From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Apr 2012 10:08:18 +0800
Subject: [PATCH 1/3] ARM: imx: Add common imx cpuidle init functionality.
In-Reply-To: <20120419064308.GH3852@pengutronix.de>
References: <1334620214-25803-1-git-send-email-rob.lee@linaro.org>
 <1334620214-25803-2-git-send-email-rob.lee@linaro.org>
 <20120417074301.GM20478@pengutronix.de>
 <CAMXH7KH41kWMPu_dEpetZc8OUD3C0-mtxGbXX0Vqd4EODPWJUg@mail.gmail.com>
 <20120417174213.GD3852@pengutronix.de>
 <CAMXH7KFYA24sPUcwgKfwVLNPA0jWQ-QG02y+SfPNnAqdiv0+gg@mail.gmail.com>
 <CAMXH7KGgSmvfqUTC1bufBz0QXbt01dHsPo1cbRA9jLj9mGmfjg@mail.gmail.com>
 <20120419064308.GH3852@pengutronix.de>
Message-ID: <20120420020816.GH22219@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 08:43:08AM +0200, Sascha Hauer wrote:
> > Sascha or Shawn, any further comments on my question?
> 
Sorry for the late response, Rob.

> I don't think we need a cpu_is_imx6q(), but having some i.MX6 specific
> hook at device_initcall time can't be too wrong. Shawn?
> 
Yep, it works for me.

-- 
Regards,
Shawn
