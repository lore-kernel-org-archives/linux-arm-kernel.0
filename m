From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Jun 2010 11:35:45 +0100
Subject: [PATCH 0/2] add perf-probe support on ARM
In-Reply-To: <AANLkTimU1W0feaSKyKCFHdZSG_RE6G_sFiAZ6jtU434w@mail.gmail.com>
References: <1277285763-16213-1-git-send-email-will.deacon@arm.com>
	<AANLkTimU1W0feaSKyKCFHdZSG_RE6G_sFiAZ6jtU434w@mail.gmail.com>
Message-ID: <001401cb1452$2b409e40$81c1dac0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Will,

Hi Jean,

> Are more tests needed for ARMv7 (OMAP3430/3530/3517)? I hope to find some time to test it if required.

The patches don't do anything special for the different architectures
and I've tried it on a quad-core A9 board so I don't think you're required
to test it as well. Having said that, it's a pretty neat tool so you might
want to have a play :)

Thanks,

Will
