From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Jul 2015 17:40:36 +0200
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <alpine.DEB.2.11.1507031721390.3916@nanos>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
 <20150703150951.GC19284@katana>
 <alpine.DEB.2.11.1507031721390.3916@nanos>
Message-ID: <20150703154036.GD19284@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ok. One more check please. Does nohz=off on the command line fix/hide
> the issue as well?

Yes, it does. It boots to the prompt then.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150703/35b1fe30/attachment.sig>
