From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 19 May 2011 14:13:38 +0300
Subject: [PATCH v5 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1305622141.30788.30.camel@e102391-lin.cambridge.arm.com>
References: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
	<1305557977-16871-2-git-send-email-marc.zyngier@arm.com>
	<1305610643.2630.15.camel@localhost>
	<1305611178.2630.21.camel@localhost>
	<20110517074348.GA26669@n2100.arm.linux.org.uk>
	<1305619989.2630.31.camel@localhost>
	<1305622141.30788.30.camel@e102391-lin.cambridge.arm.com>
Message-ID: <1305803618.2630.63.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-17 at 09:49 +0100, Marc Zyngier wrote:
> On Tue, 2011-05-17 at 11:13 +0300, Artem Bityutskiy wrote:
> > On Tue, 2011-05-17 at 08:43 +0100, Russell King - ARM Linux wrote:
> > > On Tue, May 17, 2011 at 08:46:18AM +0300, Artem Bityutskiy wrote:
> > > > On Tue, 2011-05-17 at 08:37 +0300, Artem Bityutskiy wrote:
> > > > > Sorry if this sounds like an attack, it is not. I just think that we
> > > > > carry crap for too long and should start forcing people to clean it up
> > > > > by not accepting changes :-)
> > > > 
> > > > Sorry, I forgot to note that I do not insist that you have to re-work
> > > > MTD partitions support - you already do a very good thing by killing a
> > > > redundant driver, and delaying this would be counter-productive. But I
> > > > anyway wanted to express my thoughts.
> > > 
> > > So, what's happening with this patch set?  I'd like to have an ack from
> > > the MTD people for the set.
> > 
> > David should answer, but from my POW the patches are OK. The "#ifdef
> > CONFIG_MTD_AFS_PARTS" is ugly. I think it can be just killed, it just
> > needs an additional patch to silence the kernel (completely untested,
> > Marc, could you please check it?):
> 
> Looks OK to me, as long as people don't miss the information (could make
> the "where's my partition gone?" question harder to answer...).

I've pushed my patch to my l2-mtd-2.6.git tree, if dwmw2 accepts it
it'll go upstream.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
