From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 9 Sep 2014 23:13:41 +0800
Subject: [PATCH 0/2] Two imx-drm oops fixes
In-Reply-To: <20140908190949.GB16374@kroah.com>
References: <20140901170712.GJ30401@n2100.arm.linux.org.uk>
 <20140908190859.GA16374@kroah.com> <20140908190949.GB16374@kroah.com>
Message-ID: <20140909151339.GA2341@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 12:09:49PM -0700, Greg Kroah-Hartman wrote:
> On Mon, Sep 08, 2014 at 12:08:59PM -0700, Greg Kroah-Hartman wrote:
> > On Mon, Sep 01, 2014 at 06:07:12PM +0100, Russell King - ARM Linux wrote:
> > > Greg,
> > > 
> > > Here's two oops fixes for imx-drm, which I've had queued up for a number
> > > of months now.  Shawn posted different fixes for the same oops recently
> > > as well.
> > 
> > So do I take your patches, or Shawn's?
> 
> Actually, yours are "smaller", so I'll defer to you and take yours...

Greg,

My patch is bigger than Russell's because I cleaned up the code a little
bit along the way of fixing the bug.

I will send you the cleanup as an incremental patch based on Russell's
fixes.

Shawn
