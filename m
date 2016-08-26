From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Aug 2016 11:46:06 -0700
Subject: Bunch of CRC errors in next with arm: move exports to definitions
In-Reply-To: <20160826181910.ujtk325yqsmvfpbg@atomide.com>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
 <20160826181910.ujtk325yqsmvfpbg@atomide.com>
Message-ID: <20160826184605.4a4u4bxoknmdlgai@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160826 11:20]:
> * Tony Lindgren <tony@atomide.com> [160822 09:28]:
> > Hi Al,
> > 
> > Looks like starting with next-20160818 I'm now getting close to
> > 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> > make modules:
> ...
> > Reverting commit 4dd1837d7589 ("arm: move exports to definitions")
> > fixes it.
> 
> And not happening with multi_v7_defconfig for example. Adding Russell
> to Cc, maybe he already has a fix for this one?

And this issue does not seem to happen with omap2plus_defconfig when
compiled with:

gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29)

But does happen when compiled with:

gcc version 6.1.1 20160705 (Debian 6.1.1-9)

Regards,

Tony
