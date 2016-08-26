From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 26 Aug 2016 17:07:07 +0200
Subject: arm: sys_oabi-compat: Use kmalloc_array() in two functions
In-Reply-To: <20160826134459.GR1041@n2100.armlinux.org.uk>
References: <5deba521-2dd4-cd2e-23d7-226a1a7728c3@users.sourceforge.net>
 <20160825224632.GL1041@n2100.armlinux.org.uk>
 <dd343c72-2ec7-2114-bee5-1d16fc6c04ac@users.sourceforge.net>
 <20160826134459.GR1041@n2100.armlinux.org.uk>
Message-ID: <6ed97ce3-4378-496f-848b-c66dcc05b21d@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It should at least make basic English sense.  I'm afraid the above
> doesn't convey any meaning what so ever, at least to me.  It doesn't
> matter how many times I read it, I still end up wondering "wtf is
> this trying to tell me?"

I have started to look a bit more on the usage of the following
function pairs in some Linux source files.

kmalloc() ? kmalloc_array()
kzalloc() ? kcalloc()

Can such combinations be extended anyhow?


Some update candidates can be found for this use case in several
software areas.

Regards,
Markus
