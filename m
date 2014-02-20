From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 20 Feb 2014 12:04:51 -0300
Subject: [PATCH v2 00/23] Move DT kirkwood into mach-mvebu
In-Reply-To: <20140219222103.GB17826@obsidianresearch.com>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <20140218185703.GI29304@obsidianresearch.com>
 <20140218190212.GE7862@titan.lakedaemon.net>
 <20140219222103.GB17826@obsidianresearch.com>
Message-ID: <20140220150450.GA2384@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 03:21:03PM -0700, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2014 at 02:02:12PM -0500, Jason Cooper wrote:
> > On Tue, Feb 18, 2014 at 11:57:03AM -0700, Jason Gunthorpe wrote:
> > > On Sat, Feb 15, 2014 at 11:19:58AM +0100, Andrew Lunn wrote:
> > > > The process of making most kirkwood boards boot using DT is nearly
> > > > complete. We can now move these boards into mach-mvebu, freeing them
> > > > of the legacy code needed for none-DT systems. At the same time, they
> > > > can become part of ARCH_MULTI_V5.
> > > 
> > > Do you have a GIT URL for this? I can test it if you make it easy :)
> > 
> > I believe this is it (web):
> > 
> >   https://github.com/lunn/linux/tree/v3.14-rc1-mvebu-v2
> 
> Thanks, I tested v3 of the patchset.
> 
> It boots, but I can't do very much because the watchdog driver doesn't
> build and my system is configured to watchdog timeout if there is no
> watchdog driver.
> 
> Presumably the watchdog patchset needs to be a dependency for this? Is
> there a git URL for it?
> 

I can take a look at preparing a merged branch for this today.
Or at least making sure the watchdog branches in mvebu, merge cleanly
with this.

After all, I also wanted to give this work a test... :)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
