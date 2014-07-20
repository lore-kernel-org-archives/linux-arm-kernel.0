From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 20 Jul 2014 10:08:01 +0800
Subject: [GIT PULL] ARM: imx: SoC changes for 3.17
In-Reply-To: <20140719191152.GD4265@quad.lixom.net>
References: <20140718092140.GB5485@dragon>
 <20140719191152.GD4265@quad.lixom.net>
Message-ID: <20140720020800.GE8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 19, 2014 at 12:11:52PM -0700, Olof Johansson wrote:
> Nice diffstat. I would have liked to see the cleanups split off in a separate
> preceding branch (and the soc updates build on top if needed), so please keep
> that in mind in the future.

Okay, noted.

> The slightly bigger hassle is the defconfig update, since you touched
> multi_v7_defconfig: we tend to want to merge or apply that separately since
> they tend to cause a lot of conflicts between our branches.

Yes, I should have asked people to submit multi_v7_defconfig change
separately to you guys.

> Still, I'll give you a pass this time, it's a small change so we can manage it.
> Please separate more in the future though.
> 
> Merged.

Thanks, Olof.

Shawn
