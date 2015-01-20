From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Jan 2015 16:22:10 +0100
Subject: [PATCHv2 0/3] ARM: mvebu: I/O coherency related fixes
In-Reply-To: <20150119223657.GI2938@lunn.ch>
References: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150119223657.GI2938@lunn.ch>
Message-ID: <20150120162210.087ce5bc@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 19 Jan 2015 23:36:57 +0100, Andrew Lunn wrote:
> On Fri, Jan 16, 2015 at 05:11:26PM +0100, Thomas Petazzoni wrote:
> > Arnd, Andrew,
> > 
> > As we discussed, here is a set of 3 patches related to HW I/O
> > coherency on mvebu:
> > 
> >  * The first patch disables HW I/O coherency entirely, and is meant to
> >    be backported to stable, until we do enough testing of the new HW
> >    I/O coherency stuff and backport it to stabel.
> 
> Added to mvebu/fixes-3
> 
> > 
> >  * The last two patches add the new HW I/O coherency strategy based on
> >    automatic I/O synchronization barriers, and obviously re-enable the
> >    HW I/O coherency.
> 
> Added to mvebu/sox. I also removed the comment you forgot to removed
> in 3/3.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
