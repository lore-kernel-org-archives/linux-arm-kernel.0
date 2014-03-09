From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Mar 2014 23:29:04 -0800
Subject: [GIT PULL 3/4] omap device tree changes for v3.15
In-Reply-To: <20140303001045.GC5000@atomide.com>
References: <pull-1393802089-910509>
 <20140303001045.GC5000@atomide.com>
Message-ID: <20140309072904.GK16310@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 02, 2014 at 04:10:49PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140302 15:55]:
> > The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:
> > 
> >   Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-signed
> > 
> > for you to fetch changes up to f777ba1780584b100ab9664cc06d04f3bb273a84:
> > 
> >   Merge tag 'for_3.15/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.15/dt (2014-03-02 14:22:03 -0800)
> > 
> > ----------------------------------------------------------------
> > 
> > Device tree related changes for omaps with minor code
> > changes also to platform data quirks that are still needed
> > for some features.
> 
> FYI, this probably causes a minor overlapping additions conflict
> with the recently merged fixes. My resolve below for reference.

D'oh, saw this after I did the merge. Yes, same resolution as I used.


-Olof
