From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jul 2014 04:11:34 -0700
Subject: [GIT PULL] omap n900 regression fix for v3.16 rc series
In-Reply-To: <3734846.Lhxg9X6PO8@wuerfel>
References: <20140729103223.GK29045@atomide.com> <3734846.Lhxg9X6PO8@wuerfel>
Message-ID: <20140729111134.GO29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [140729 04:08]:
> On Tuesday 29 July 2014 03:32:24 Tony Lindgren wrote:
> > The following changes since commit 33753cd2ba41c72a0756edc5dc094d91602deda5:
> > 
> >   ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable() (2014-07-23 01:48:24 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/n900-regression
> > 
> > for you to fetch changes up to d937678ab625b0f63ce54b2b9b3e1cbd1b4a1b15:
> > 
> >   ARM: dts: Revert enabling of twl configuration for n900 (2014-07-29 00:16:25 -0700)
> > 
> > ----------------------------------------------------------------
> > Minimal regression fix for n900 display that got broken with
> > enabling of twl4030 PM features. Turns out more work is needed
> > before we can enable twl4030 PM on n900.
> > 
> > I did not notice this earlier as I have my n900 in a rack
> > and the display did not get enabled for device tree based booting
> > until for v3.16.
> > 
> > 
> 
> Pulled into fixes branch, which I expect to send out later today.

Great thanks. No other fixes coming for the -rc series from me that
I'm aware of.

Regards,

Tony
