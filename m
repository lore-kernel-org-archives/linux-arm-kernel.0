From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Jun 2010 13:22:16 +0100
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <20100610135609.GC4514@ucw.cz>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
	<20100526191425.GD6232@n2100.arm.linux.org.uk>
	<201005262115.57282.marek.vasut@gmail.com>
	<20100526201824.GA16418@n2100.arm.linux.org.uk>
	<20100610135609.GC4514@ucw.cz>
Message-ID: <1276258936.16663.39.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-06-10 at 14:56 +0100, Pavel Machek wrote:
> On Wed 2010-05-26 21:18:24, Russell King - ARM Linux wrote:
> > On Wed, May 26, 2010 at 09:15:57PM +0200, Marek Vasut wrote:
> > > You want me to fight your patch tracking system or will you just merge it into
> > > your tree ?
> >
> > What do you mean "fight" ?  Just send a standard git formatted patch
> > to the email address with an additional KernelVersion: tag.  It's
> > not at all hard.
> 
> You are linux kernel maintainer. Start acting as one. It is not at all
> hard.
> 
> Alternatively, just remove KernelVersion: checking in  your
> scripts.

BTW (and I'm not complaining about Russell's patch system here), how can
we get the linux-arm-kernel list subscribed to patchwork.kernel.org?
That would be useful for grabbing RFC/CFT patches.

-- 
Catalin
