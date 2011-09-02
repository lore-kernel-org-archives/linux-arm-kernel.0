From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Sep 2011 13:53:26 +0300
Subject: [PATCH V2 00/16] omap_hsmmc patches
In-Reply-To: <CANOLnOPGay+jQaeBAVD5-B3WQaWMSiPFirvhrPkeS0_ZgmX-BQ@mail.gmail.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<CANOLnONWmYn4FpuF-UAKQR4rAA6LOgWdMfu2bMN46nna6rOxAw@mail.gmail.com>
	<m2k4bm2nwl.fsf@bob.laptop.org>
	<CANOLnOPGay+jQaeBAVD5-B3WQaWMSiPFirvhrPkeS0_ZgmX-BQ@mail.gmail.com>
Message-ID: <20110902105325.GT3548@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [110715 12:27]:
> On Wed, Jul 13, 2011 at 6:36 PM, Chris Ball <cjb@laptop.org> wrote:
> > Hi,
> >
> > On Wed, Jul 13 2011, Grazvydas Ignotas wrote:
> >> it seems this series got lost in time, at least patches 01, 02, 03,
> >> 04, 05, 06, 07, 08, 12 look like valid standalone fixes and
> >> improvements to me, they don't touch other trees and still apply
> >> cleanly, so would be good to have.
> >
> > Yeah. ?I didn't merge them because Tony still has unanswered comments on
> > the OMAP side of the patches, and they're submitted as a single patchset.
> >
> > I've applied {2, 3, 5, 6, 7, 8, 12} to mmc-next for 3.1 now. ?1 doesn't
> > apply because the function doesn't exist anymore. ?4 doesn't apply
> > because iclk doesn't exist anymore.
> >
> > If someone wants to look at rebasing the rest of these against mmc-next
> > and resubmitting, I think that'd be useful.
> 
> Thanks! 1 and 4 seem to be unneeded any more (I was trying them on
> linux-next, not noticing it was not updated for a while), and others
> have comments pending, so it's all done.

So I guess that means I don't need to look at anything, right?

Tony
