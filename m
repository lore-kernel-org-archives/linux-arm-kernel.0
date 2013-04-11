From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Apr 2013 09:34:29 -0700
Subject: [GIT PULL 5/5] omap dt changes for v3.10 merge window
In-Reply-To: <20130411110645.GA8802@quad.lixom.net>
References: <pull-1365483063-475562>
 <51639e43.d294dc0a.2f07.03b4SMTPIN_ADDED_MISSING@mx.google.com>
 <20130411110645.GA8802@quad.lixom.net>
Message-ID: <20130411163428.GY10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130411 04:11]:
> Hi,
> 
> On Mon, Apr 08, 2013 at 09:51:03PM -0700, Tony Lindgren wrote:
> > The following changes since commit 5852264f9d6139751796853fdfca9d5230cbfb97:
> > 
> >   Merge tag 'omap-devel-b-for-3.10' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into for_3.10/dts_merged (2013-04-09 00:11:05 +0200)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dt-signed-v2
> > 
> > for you to fetch changes up to 161e89a689bb88004b757986eefda2402448eef7:
> > 
> >   ARM/dts: OMAP3: fix pinctrl-single configuration (2013-04-08 17:00:22 -0700)
> > 
> > ----------------------------------------------------------------
> > Device tree updates for omaps via Benoit Cousson <b-cousson@ti.com>.
> > 
> > Note that the branch has dependencies to two other branches:
> > 
> > - omap-devel-b-for-3.10 from Paul to get the AM33xx missing
> >   hwmod and thus avoid a regression with Santosh's hwmod
> >   cleanup including in this DT series [1]. It avoids breaking
> >   bisect if this series is merged before Paul's fixes.
> 
> Looks like this was part of omap/fixes-non-critical, the branch name from Paul
> just didn't percolate up. At least the topmost SHA from that merge in your
> history seems to be part of said branch. :)
> 
> 
> > - omap-for-v3.10/usb branch to avoid nasty merge conflict in
> >   omap3.dtsi and omap4.dtsi due to the DTS patches contained
> >   in the USB branch because of a screw up by the unnamed person
> >   typing this signed tag based on Benoit's comments.
> 
> 
> Ok, it looks like this one was merged in next/drivers as omap/usb.
> 
> 
> So based on the above, I've merged in omap/fixes-non-critical and omap/usb as
> a base, and merged this on top. All of this has gone into next/dt2.

OK thanks.

Tony
