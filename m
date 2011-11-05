From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Nov 2011 22:28:32 +0000
Subject: [PATCH 0/2] Minor PXA fixes
In-Reply-To: <CAMPhdO-t0mJb2U+1eutKA4YRwCXsr2smLNKDw_a7T+TJXLbmvQ@mail.gmail.com>
References: <20111104113032.GY12913@n2100.arm.linux.org.uk>
 <CAMPhdO-t0mJb2U+1eutKA4YRwCXsr2smLNKDw_a7T+TJXLbmvQ@mail.gmail.com>
Message-ID: <20111105222832.GH12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 05, 2011 at 10:13:31PM +0800, Eric Miao wrote:
> On Friday, November 4, 2011, Russell King - ARM Linux <
> linux at arm.linux.org.uk> wrote:
> > Eric,
> >
> > Here's a couple of fixes I have queued in my tree for some PXA build
> > problems I found after kernel summit.  Do you want to pick them up,
> > or shall I send them to Linus in the next couple of days along with
> > the other fixes I have queued?
> >
> 
> Russell,
> 
> Please go ahead and send to Linus directly, really appreciated.
> 
> The patches are good, feel free to put my Acked-by.

Thanks.  Two more follow.  First is a build error with the latest kernel,
the second is one which is caused by touching mach/system.h (as the commit
log describes why including mach/system.h is wrong.)
