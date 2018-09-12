From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Sep 2018 17:42:52 -0700
Subject: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
In-Reply-To: <a10ae1a9-ed6a-468e-5a3e-8c120bab9acf@ti.com>
References: <20180910200624.4494-1-tony@atomide.com>
 <444bae18-9737-8e13-2a0f-c08863ae1336@ti.com>
 <20180911182419.GC5662@atomide.com>
 <a10ae1a9-ed6a-468e-5a3e-8c120bab9acf@ti.com>
Message-ID: <20180912004252.GH5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180912 00:27]:
> Thanks Tony, but it's still not completely clear -
> it's important to see values of CLKSTCTRL before/after idle for not working
> case and GPIO SYSC/SYSS registers. There are some combinations which may
> affect on this. So, if you can, pls.

Sure I'll do some reg dumps for you tomorrow as I just started
an overnight test with randomly pinging the wlan interface
from outside to make sure it wakes up and keeps idling.

Regards,

Tony
