From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 2 Sep 2014 12:39:13 +0200
Subject: mx28 battery charger support
Message-ID: <20140902103913.GA9417@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm having a look at the battery charger on i.mx28. Is there any
mainline driver or any attempt at mainlining a driver? The IP is not
documented in the i.MX28 Applications Processor Reference Manual but
there is an existing driver in the Linux 2.6.35 sources from Freescale [1].

I would love not being stuck with such an old version ;)

[1] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/power/mxs?h=imx_2.6.35_maintain

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
