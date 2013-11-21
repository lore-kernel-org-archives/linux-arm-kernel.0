From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 21 Nov 2013 14:52:27 -0800
Subject: Patches from ARM folks solicited for the -stable tree
In-Reply-To: <alpine.DEB.2.02.1311212210150.9743@utopia.booyaka.com>
References: <alpine.DEB.2.02.1311210442560.30143@utopia.booyaka.com>
 <20131121153254.GA3422@kroah.com>
 <alpine.DEB.2.02.1311211818000.30143@utopia.booyaka.com>
 <20131121185021.GA15057@kroah.com>
 <alpine.DEB.2.02.1311212210150.9743@utopia.booyaka.com>
Message-ID: <20131121225227.GA12201@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 10:15:37PM +0000, Paul Walmsley wrote:
> On Thu, 21 Nov 2013, Greg Kroah-Hartman wrote:
> 
> > On Thu, Nov 21, 2013 at 06:20:29PM +0000, Paul Walmsley wrote:
> > > On Thu, 21 Nov 2013, Greg Kroah-Hartman wrote:
> > > 
> > > > On Thu, Nov 21, 2013 at 04:43:37AM +0000, Paul Walmsley wrote:
> > > >
> > > > > These days it seems like I have about one patch per merge window that 
> > > > > could be a stable candidate.
> > > > 
> > > > That's all?
> > > 
> > > The better we are at writing and testing our patches, the fewer -stable 
> > > candidates we'll have :-)  
> > 
> > No new device ids? quirks? 
> 
> It's true that the focus here for -stable has mostly been for fixes for 
> code that causes some kind of crash or failure, rather than new device 
> support.  Including new device support could probably increase the amount 
> of -stable patches by quite a bit.  The problem with this is that it could 
> cause hard-to-find regressions in the -stable kernel.  For example, on 
> OMAP, adding support for a new device could potentially cause PM 
> regressions on the rest of the system, depending on how the driver 
> operates.  So the bar for those types of patches seems pretty high if it's 
> really intended to be a "stable" kernel.

Then those "types" of patches are not device ids or quirks being added
to a table, so of course I wouldn't want to take those into the stable
tree...
