From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 06 Jun 2016 08:52:54 -0400
Subject: 4.7-rc2: iptables broken on ARM 32 bits
Message-ID: <1465217574.9851.13.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pablo,

the issue with the broken iptables on 32 bits ARM platform
is still present in 4.7-rc2.

The issue was initially reported by John Stultz; please refer
to this link for details: https://lkml.org/lkml/2016/5/26/351

I tested the second solution and this fix the issue for me.

Is there any plan to include a fix in rc3?


Sylvain Lemieux
