From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Jul 2015 17:09:52 +0200
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <alpine.DEB.2.11.1507031640060.3916@nanos>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
Message-ID: <20150703150951.GC19284@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ok. So it's unrelated to deep idle states. Any chance of poking with
> JTAG at the frozen box? If not, are there GPIOs which you could use to
> monitor certain state?

No JTAGger here at the moment. And no manual/schematics for this board
:(

I'll ask around...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150703/1815e4c8/attachment.sig>
