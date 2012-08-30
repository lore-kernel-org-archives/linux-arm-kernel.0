From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 20:14:12 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120830183711.GY19437@titan.lakedaemon.net>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120830165224.GR19437@titan.lakedaemon.net>
 <20120830172304.GA18957@n2100.arm.linux.org.uk>
 <20120830183711.GY19437@titan.lakedaemon.net>
Message-ID: <20120830191412.GC18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 02:37:11PM -0400, Jason Cooper wrote:
> On Thu, Aug 30, 2012 at 06:23:04PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Aug 30, 2012 at 12:52:24PM -0400, Jason Cooper wrote:
> > > I've CC'd stable to see if they want to pick this up.
> > 
> > That's not how stable works - and you'll probably receive a standard form
> > whinge from them about that.  Please read up on the submission requirements
> > to the stable kernel trees.
> 
> Ah, thanks.  usually, I just add the Cc: line for fixes I send to
> arm-soc.  Since this patch affects more than just kirkwood/marvell, I
> didn't feel it was appropriate to pull it in through my tree.

Yes, you put the Cc: line in the commit, but you don't actually send it
to that address.  The only time that you do mail that address is when
the commit is _in_ mainline and it doesn't have the Cc: tag or the stable
team haven't picked it up.

> I submitted a patch six months ago for the exact same thing and was
> informed that others already had a pending patch in your queue for it.
> However, I can't for the life of me locate the thread atm.  I remember
> it because it was the first patch I did that needed to go into your
> queue instead of through arm-soc.  Obviously, I did something horribly
> wrong.  ;-)

I don't see anything in there for it - I tried searching for patches
containing 'dtbs' and the latest one it found was 7152/1 on 8th
November.  I also see no notifications from the patch system for a
patch from you...
