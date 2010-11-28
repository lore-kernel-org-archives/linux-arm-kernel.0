From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 28 Nov 2010 02:02:23 +0000
Subject: [PATCH] econet: Move to staging; remove from defconfig
In-Reply-To: <20101128013923.GA9285@suse.de>
References: <1290897868.3292.59.camel@localhost>
	<20101128002135.GA4562@suse.de>
	<20101127.172644.226781076.davem@davemloft.net>
	<20101128013923.GA9285@suse.de>
Message-ID: <1290909743.3292.248.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-11-27 at 17:39 -0800, Greg KH wrote:
> On Sat, Nov 27, 2010 at 05:26:44PM -0800, David Miller wrote:
> > From: Greg KH <gregkh@suse.de>
> > Date: Sat, 27 Nov 2010 16:21:35 -0800
> > 
> > > And I need an ack from the networking maintainer to be able to accept
> > > this also.
> > 
> > I'm not applying this, nor do I want anyone else to.
> > 
> > If people think this protocol is not maintained adequately
> > right now, wait until you push it into staging.
> > 
> > Furthermore, once Phil Blundell was made aware of security
> > holes in econet he fixed them within a few days.  Which is
> > much better than I can say for some of the other protocols
> > and filesystems in the tree.
> > 
> > Moving this into staging, is therefore not appropriate.
> 
> Agreed.
> 
> Ben, why are you trying to remove these protocols that people use and
> maintain?  This is the third one that has been shot down recently...

Moving to staging is a step toward removal, but not removal itself.  I
already stated the reasons I picked those three protocols; I'm not going
to push the issue if David disagrees.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101128/6356790c/attachment.sig>
