From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 11 Jan 2014 17:30:24 -0500 (EST)
Subject: [PATCH v4 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <52D0799B.3030401@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1401111728150.16586-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jan 2014, Hans de Goede wrote:

> Hi,
> 
> On 01/11/2014 12:50 AM, Sergei Shtylyov wrote:
> > Hello.
> >
> > On 01/11/2014 01:46 AM, Hans de Goede wrote:
> >
> >> Here is v4 of my ohci and ehci-platform clks, phy and dt support patch-set,
> >> this version should be 100% ready for merging upstream.
> >
> >     I see you've decided to completely ignore my opinion. NAK, FWIW.
> 
> I'm sorry but the whole prefix thing has become a thing of -ETOOMUCHBIKESHEDDING,
> everyone except you seems to be fine with mmio and and one point in time we
> need to make a decision and move forward.

If this isn't beating a dead horse...  Maybe everyone can agree on a
name like ohci-generic or generic-ohci.  That seems like a pretty good
description of the hardware that the platform driver can handle.

Alan Stern
