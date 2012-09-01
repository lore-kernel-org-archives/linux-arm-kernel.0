From: ben@decadent.org.uk (Ben Hutchings)
Date: Sat, 01 Sep 2012 15:20:16 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120831223219.GA6906@n2100.arm.linux.org.uk>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120830165224.GR19437@titan.lakedaemon.net>
 <20120830172304.GA18957@n2100.arm.linux.org.uk>
 <20120830183711.GY19437@titan.lakedaemon.net>
 <20120830191412.GC18957@n2100.arm.linux.org.uk>
 <1346447515.13980.19.camel@deadeye.wl.decadent.org.uk>
 <20120831223219.GA6906@n2100.arm.linux.org.uk>
Message-ID: <1346509216.13980.23.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-31 at 23:32 +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 31, 2012 at 02:11:55PM -0700, Ben Hutchings wrote:
> > On Thu, 2012-08-30 at 20:14 +0100, Russell King - ARM Linux wrote:
> > > On Thu, Aug 30, 2012 at 02:37:11PM -0400, Jason Cooper wrote:
> > > > On Thu, Aug 30, 2012 at 06:23:04PM +0100, Russell King - ARM Linux wrote:
> > > > > On Thu, Aug 30, 2012 at 12:52:24PM -0400, Jason Cooper wrote:
> > > > > > I've CC'd stable to see if they want to pick this up.
> > > > > 
> > > > > That's not how stable works - and you'll probably receive a standard form
> > > > > whinge from them about that.  Please read up on the submission requirements
> > > > > to the stable kernel trees.
> > > > 
> > > > Ah, thanks.  usually, I just add the Cc: line for fixes I send to
> > > > arm-soc.  Since this patch affects more than just kirkwood/marvell, I
> > > > didn't feel it was appropriate to pull it in through my tree.
> > > 
> > > Yes, you put the Cc: line in the commit, but you don't actually send it
> > > to that address.
> > [...]
> > 
> > It's OK to cc the stable address when submitting to the relevant
> > subsystem maintainer *as well as* including the cc: line in the commit
> > message.  It just can't be used as a substitute for the commit line.
> 
> No it is not.  It seems you also need to read
> Documentation/stable_kernel_rules.txt
[...]

None of which contradicts what I said above.  There is no need for
people to specifically filter out stable at vger.kernel.org from mail
recipients.  I never see any complaints from Greg or others when patches
have it cc'd in both the commit message and the mail header; only when
it is in the mail header *only*.

Ben.

-- 
Ben Hutchings
Theory and practice are closer in theory than in practice.
                                - John Levine, moderator of comp.compilers
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120901/484b5bae/attachment.sig>
