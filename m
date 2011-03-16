From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 16 Mar 2011 15:11:14 +0100
Subject: [PATCH 4/8] ARM: PXA: Z2: Add mtd partition with logo
In-Reply-To: <20110315143957.GA1361@ucw.cz>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103120105.50159.marek.vasut@gmail.com>
	<20110315143957.GA1361@ucw.cz>
Message-ID: <201103161511.14377.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 March 2011 15:39:57 Pavel Machek wrote:
> On Sat 2011-03-12 01:05:50, Marek Vasut wrote:
> > On Friday 11 March 2011 23:31:28 Vasily Khoruzhick wrote:
> > > On Friday 11 March 2011 23:39:36 Marek Vasut wrote:
> > > > On Friday 11 March 2011 11:23:39 Vasily Khoruzhick wrote:
> > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > 
> > > > I guess you can rather supply the MTD layout on kernel command line
> > > > (see Drivers/MTD).
> > > 
> > > Yeah, I know, just want to make default layout look like this.
> > 
> > Why not like what's already there ? I don't see any point in changing
> > this, NAK, use command line partitioning.
> 
> Of course, you can use command line.
> 
> But, the default kernel partitioning should match what hw expects.

But of course ... it matches the mainline uboot. I know what I let in there :)
