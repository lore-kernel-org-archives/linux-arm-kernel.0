From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 12:33:46 -0700
Subject: [GIT PULL] omap dss board clean-up for v3.10 merge window
In-Reply-To: <20130419184518.GA30836@quad.lixom.net>
References: <20130418033936.GC10155@atomide.com>
 <20130419184518.GA30836@quad.lixom.net>
Message-ID: <20130419193346.GO10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130419 11:50]:
> Hi,
> 
> On Wed, Apr 17, 2013 at 08:39:37PM -0700, Tony Lindgren wrote:
> > The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> > 
> >   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dss-signed
> 
> 
> Merged, but not happy about it.
> 
> As mentioned on IRC, I was going to let this one be until 3.11, but it sounds
> like it will cause regressions in DSS if we don't merge it.
> 
> This is an indication that the work wasn't done right on the DSS rework.
> Ideally the old configurations through platform_data should have been left in
> for a release to give the boards a window to convert over without regressing
> functionality. Tomi, please don't do it this way in the future since it's
> painful for everybody to deal with.

Yes sorry this should have been done already few weeks ago when these
patches hit linux next via Tomi's tree. In the future, let's plan on doing
the shared branches early on between -rc2 and -rc4 so we don't all have to
scramble just before the merge window.

> I've queued this with late/cleanup. I noticed some conflicts with the previous
> omap/fixes-non-critical and omap/boards branches that I brought in as a base so
> I could fix it up in my merge instead of having it go all the way up to Linus
> to resolve.

OK thanks.

Tony
