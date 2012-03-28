From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 19:10:06 +0100
Subject: [PATCH] ARM: pxa: fix regulator related build fail in
 magician_defconfig
In-Reply-To: <20120328175613.GC22414@n2100.arm.linux.org.uk>
References: <1331084814.11802.YahooMailClassic@web29012.mail.ird.yahoo.com>
 <1331242494-3157-1-git-send-email-paul.gortmaker@windriver.com>
 <CAN1soZzDRR4XQ34WDL48=j+Ff8t5fsCFaccqZAKOQ1OAPeDXcA@mail.gmail.com>
 <4F608F4F.8020106@windriver.com>
 <20120314123236.GE3133@opensource.wolfsonmicro.com>
 <20120328094351.GB22414@n2100.arm.linux.org.uk>
 <20120328101852.GE3232@opensource.wolfsonmicro.com>
 <20120328175613.GC22414@n2100.arm.linux.org.uk>
Message-ID: <20120328181005.GC3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 06:56:13PM +0100, Russell King - ARM Linux wrote:
> On Wed, Mar 28, 2012 at 11:18:52AM +0100, Mark Brown wrote:

> > Yes, please at least apply Paul's patches - honestly, given how old
> > these boards are and the general lack of activity I'd rather expect that
> > the only thing anyone's doing with them these days is build tests.

> Is that a reason to push breakage to them upstream?  No.  Please take
> Paul's patches to fix the breakage which was introduced through your
> tree yourself.  I've got enough problems this merge window to deal with
> without having to add further patches to my tree.

Well, I'd expect this stuff to be going via the pxa tree to arm-soc
rather than via your tree anyway (which seems to be what's happening at
this point) - half the point with arm-soc was to ensure you didn't have
to deal with things like this.

Quite frankly I thought the fixes had already been applied, they were
posted and reviewed in good time for the merge window and the issues
weren't being reported in -next any more; had someone asked I'd have
applied them as I did with the equivalent stuff for u300.  If they were
being totally ignored I'd probably have applied them too, though perhaps
not.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/6f4abb48/attachment.sig>
