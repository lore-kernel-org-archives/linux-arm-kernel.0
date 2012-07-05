From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jul 2012 01:11:34 -0700
Subject: [GIT PULL] ARM: OMAP AM33xx: clock data for 3.6
In-Reply-To: <alpine.DEB.2.00.1207040323500.6760@utopia.booyaka.com>
References: <alpine.DEB.2.00.1207040323500.6760@utopia.booyaka.com>
Message-ID: <20120705081134.GS1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120704 02:29]:
> Hi Tony
> 
> The following changes since commit 6fd8246b1c1167c983b089f9eaafa13ef9ca7adf:
> 
>   Merge tag 'omap-devel-a-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-am33xx (2012-06-22 01:50:22 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-e-for-3.5
> 
> for you to fetch changes up to e30384abd63dfa11508a38243e1d78f1d70486b1:
> 
>   ARM: OMAP3+: clock33xx: Add AM33XX clock tree data (2012-06-29 16:16:40 -0600)
> 
> ----------------------------------------------------------------
> OMAP AM33xx clock data
> 
> ----------------------------------------------------------------

Thanks pulled into devel-am33xx-part2 and fixed up cpu_is_am33xx to
use soc_is_am33xx.

Tony
