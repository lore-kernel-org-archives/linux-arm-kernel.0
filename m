From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Jan 2015 15:16:48 -0800
Subject: [PATCH 0/6] arm: boot: dts: am437x-sk: DTS pinmux fixes
In-Reply-To: <20141204170655.GM18045@saruman>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
 <20141204170415.GL18045@saruman> <20141204170655.GM18045@saruman>
Message-ID: <20150107231647.GG13010@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141204 09:09]:
> Hi,
> 
> On Thu, Dec 04, 2014 at 11:04:15AM -0600, Felipe Balbi wrote:
> > > Here's a small series of non-critical fixes and improvements
> > > for AM437x Starter Kit DTS.
> > > 
> > > Basically I'm removing unnecessary pulls and adding explicit
> > > pinmux for a couple interfaces which were missing.
> > > 
> > > All patches tested on top of commit 1ca7c60 (Add linux-next
> > > specific files for 20141204). Boot logs will be attached as
> > > a reply here.
> > 
> > boot log attached.
> 
> no idea why the thing says "-dirty". Just reboot and I get:
> 
> # uname -a
> Linux saruman 3.18.0-rc7-next-20141204-00009-g8ade679 #2348 SMP Thu Dec 4 11:04:44 CST 2014 armv7l GNU/Linux

Applying all these into omap-for-v3.20/dt thanks.

Tony
