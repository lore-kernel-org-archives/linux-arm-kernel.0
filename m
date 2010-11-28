From: davem@davemloft.net (David Miller)
Date: Sat, 27 Nov 2010 17:26:44 -0800 (PST)
Subject: [PATCH] econet: Move to staging; remove from defconfig
In-Reply-To: <20101128002135.GA4562@suse.de>
References: <1290897868.3292.59.camel@localhost>
	<20101128002135.GA4562@suse.de>
Message-ID: <20101127.172644.226781076.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg KH <gregkh@suse.de>
Date: Sat, 27 Nov 2010 16:21:35 -0800

> And I need an ack from the networking maintainer to be able to accept
> this also.

I'm not applying this, nor do I want anyone else to.

If people think this protocol is not maintained adequately
right now, wait until you push it into staging.

Furthermore, once Phil Blundell was made aware of security
holes in econet he fixed them within a few days.  Which is
much better than I can say for some of the other protocols
and filesystems in the tree.

Moving this into staging, is therefore not appropriate.
