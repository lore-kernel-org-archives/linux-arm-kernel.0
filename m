From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 28 Nov 2010 01:53:35 +0000
Subject: [PATCH] econet: Move to staging; remove from defconfig
In-Reply-To: <20101127.172644.226781076.davem@davemloft.net>
References: <1290897868.3292.59.camel@localhost>
	<20101128002135.GA4562@suse.de>
	<20101127.172644.226781076.davem@davemloft.net>
Message-ID: <1290909215.3292.230.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-11-27 at 17:26 -0800, David Miller wrote:
> From: Greg KH <gregkh@suse.de>
> Date: Sat, 27 Nov 2010 16:21:35 -0800
> 
> > And I need an ack from the networking maintainer to be able to accept
> > this also.
> 
> I'm not applying this, nor do I want anyone else to.
> 
> If people think this protocol is not maintained adequately
> right now, wait until you push it into staging.
> 
> Furthermore, once Phil Blundell was made aware of security
> holes in econet he fixed them within a few days.  Which is
> much better than I can say for some of the other protocols
> and filesystems in the tree.

Those bugs were present for years and would have been obvious to anyone
who cared to read the code.  While I very much appreciate Phil's quick
response, I don't think this reactive maintenance is enough.

> Moving this into staging, is therefore not appropriate.

Oh well, it's not enough as if many distributions bothered to build it
anyway, and we've learned our lesson now.  Whether it's labelled as
staging or not, it's dead, Jim.

Ben.

-- 
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101128/430d1d17/attachment.sig>
