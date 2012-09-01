From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Sep 2012 16:25:44 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <1346509216.13980.23.camel@deadeye.wl.decadent.org.uk>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120830165224.GR19437@titan.lakedaemon.net>
 <20120830172304.GA18957@n2100.arm.linux.org.uk>
 <20120830183711.GY19437@titan.lakedaemon.net>
 <20120830191412.GC18957@n2100.arm.linux.org.uk>
 <1346447515.13980.19.camel@deadeye.wl.decadent.org.uk>
 <20120831223219.GA6906@n2100.arm.linux.org.uk>
 <1346509216.13980.23.camel@deadeye.wl.decadent.org.uk>
Message-ID: <20120901152544.GB24085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2012 at 03:20:16PM +0100, Ben Hutchings wrote:
> On Fri, 2012-08-31 at 23:32 +0100, Russell King - ARM Linux wrote:
> > On Fri, Aug 31, 2012 at 02:11:55PM -0700, Ben Hutchings wrote:
> > > On Thu, 2012-08-30 at 20:14 +0100, Russell King - ARM Linux wrote:
> > > > On Thu, Aug 30, 2012 at 02:37:11PM -0400, Jason Cooper wrote:
> > > > > On Thu, Aug 30, 2012 at 06:23:04PM +0100, Russell King - ARM Linux wrote:
> > > > > > On Thu, Aug 30, 2012 at 12:52:24PM -0400, Jason Cooper wrote:
> > > > > > > I've CC'd stable to see if they want to pick this up.
> > > > > > 
> > > > > > That's not how stable works - and you'll probably receive a standard form
> > > > > > whinge from them about that.  Please read up on the submission requirements
> > > > > > to the stable kernel trees.
> > > > > 
> > > > > Ah, thanks.  usually, I just add the Cc: line for fixes I send to
> > > > > arm-soc.  Since this patch affects more than just kirkwood/marvell, I
> > > > > didn't feel it was appropriate to pull it in through my tree.
> > > > 
> > > > Yes, you put the Cc: line in the commit, but you don't actually send it
> > > > to that address.
> > > [...]
> > > 
> > > It's OK to cc the stable address when submitting to the relevant
> > > subsystem maintainer *as well as* including the cc: line in the commit
> > > message.  It just can't be used as a substitute for the commit line.
> > 
> > No it is not.  It seems you also need to read
> > Documentation/stable_kernel_rules.txt
> [...]
> 
> None of which contradicts what I said above.  There is no need for

I really can't believe you just said that.  You have not read the document.
Further discussion is pointless until you do, and I suggest everyone ignores
your comments on this subject until you have read the document, because you
are currently misleading people.
