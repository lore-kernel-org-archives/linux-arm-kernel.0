From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Sep 2014 22:13:09 -0700
Subject: [GIT PULL 5/5] omap dts changes for v3.18 merge window
In-Reply-To: <20140918201507.GO14505@atomide.com>
References: <pull-1410478051-378788> <pull-1410478051-378788-5>
 <20140918201507.GO14505@atomide.com>
Message-ID: <20140924051309.GB30340@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 01:15:08PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140911 16:29]:
> > The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:
> > 
> >   Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/dt-for-v3.18
> > 
> > for you to fetch changes up to d27704d1ec2f9ba06247b402c58a6f2febecef78:
> > 
> >   ARM: dts: OMAP2+: Add sub mailboxes device node information (2014-09-11 11:46:30 -0700)
> > 
> > ----------------------------------------------------------------
> > Changes for .dts files for omaps for v3.18 merge window:
> > 
> > - Updates for gta04 to add gta04a3 model
> > - Add support for Tehnexion TAO3530 boards
> > - Regulator names for beaglebone
> > - Pinctrl related updates for omap5, dra7 and am437
> > - Model name fix for sbc-t54
> > - Enable mailbox for various omaps
> 
> This can cause a minor merge conflict, here's the
> merge resolution for reference.

Thanks, merged all branches now.


-Olof
