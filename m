From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Mar 2012 18:56:13 +0100
Subject: [PATCH] ARM: pxa: fix regulator related build fail in
 magician_defconfig
In-Reply-To: <20120328101852.GE3232@opensource.wolfsonmicro.com>
References: <1331084814.11802.YahooMailClassic@web29012.mail.ird.yahoo.com>
 <1331242494-3157-1-git-send-email-paul.gortmaker@windriver.com>
 <CAN1soZzDRR4XQ34WDL48=j+Ff8t5fsCFaccqZAKOQ1OAPeDXcA@mail.gmail.com>
 <4F608F4F.8020106@windriver.com>
 <20120314123236.GE3133@opensource.wolfsonmicro.com>
 <20120328094351.GB22414@n2100.arm.linux.org.uk>
 <20120328101852.GE3232@opensource.wolfsonmicro.com>
Message-ID: <20120328175613.GC22414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 11:18:52AM +0100, Mark Brown wrote:
> On Wed, Mar 28, 2012 at 10:43:51AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Mar 14, 2012 at 12:32:36PM +0000, Mark Brown wrote:
> 
> > > Yes, that's what you should do.  Calling dev_name() is only possible if
> > > you have the struct device and removing the need for the struct device
> > > is exactly what we're trying to avoid here.
> 
> > So what the hell is happening here to fix the breakage which the
> > regulator tree caused in mainline?  From this thread, it looks like
> > it's been known about since 8th March which is now twenty days ago,
> > and it's still broken.
> 
> Yes, please at least apply Paul's patches - honestly, given how old
> these boards are and the general lack of activity I'd rather expect that
> the only thing anyone's doing with them these days is build tests.

Is that a reason to push breakage to them upstream?  No.  Please take
Paul's patches to fix the breakage which was introduced through your
tree yourself.  I've got enough problems this merge window to deal with
without having to add further patches to my tree.

Thanks.
