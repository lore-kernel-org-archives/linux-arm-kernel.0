From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Jul 2015 18:00:22 +0200
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <alpine.DEB.2.11.1507031746550.3916@nanos>
References: <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
 <20150703150951.GC19284@katana>
 <alpine.DEB.2.11.1507031721390.3916@nanos>
 <20150703154036.GD19284@katana>
 <alpine.DEB.2.11.1507031746550.3916@nanos>
Message-ID: <20150703160022.GE19284@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Can you try the patch below, whether it makes a difference?

It doesn't. Board locks again.

> -	clockevents_config_and_register(ced, 1, 2, 0xffffffff);
> +	clockevents_config_and_register(ced, 1, 100, 0xffffffff);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150703/38eaf954/attachment.sig>
