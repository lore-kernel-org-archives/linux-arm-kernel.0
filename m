From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Aug 2016 11:19:10 -0700
Subject: Bunch of CRC errors in next with arm: move exports to definitions
In-Reply-To: <20160822162512.mptzbiaozx2fz42l@atomide.com>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
Message-ID: <20160826181910.ujtk325yqsmvfpbg@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160822 09:28]:
> Hi Al,
> 
> Looks like starting with next-20160818 I'm now getting close to
> 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> make modules:
...
> Reverting commit 4dd1837d7589 ("arm: move exports to definitions")
> fixes it.

And not happening with multi_v7_defconfig for example. Adding Russell
to Cc, maybe he already has a fix for this one?

Regards,

Tony
