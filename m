From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 10:06:19 -0700
Subject: [GIT PULL 1/3] omap non critical fixes for v3.10 merge window
In-Reply-To: <201304081824.35663.arnd@arndb.de>
References: <pull-1364923751-842943>
 <201304081824.35663.arnd@arndb.de>
Message-ID: <20130408170619.GN10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130408 09:29]:
> On Tuesday 02 April 2013, Tony Lindgren wrote:
> > The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> > 
> >   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-non-critical-signed
> > 
> > for you to fetch changes up to 105612489bf59386b46b3f9f034e03f70e57aee6:
> > 
> >   Merge branch 'for_3.10/omap5_generic_updates' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/fixes-non-critical (2013-04-01 09:30:47 -0700)
> > 
> 
> Pulled all three branches, thanks a lot!
> 
> The cleanup branch conflicted with a bug fix from Paul Walmsley that Linus
> already merged, see below for the resolution that I used, adding a modified
> line from the one Paul submitted.

Yes looks good thanks. I think I had the same resolve in one
of the other branches, but that should not cause issues with
your branches I presume.

Regards,

Tony
