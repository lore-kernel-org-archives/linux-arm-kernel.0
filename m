From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Jun 2013 16:36:20 +0800
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
Message-ID: <20130612083619.GA13274@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 10:58:48AM +0100, Lorenzo Pieralisi wrote:
> Hi Russell, all,
> 
> even though I think this set is ready to get merged, it would be great
> if we can test it on as many platforms as possible since it touches core
> suspend/resume operations on ARM platforms relying on CONFIG_ARM_CPU_SUSPEND,
> and there are many.
> 
> I pushed out a branch:
> 
> git://linux-arm.org/linux-2.6-lp.git mpidr-linearization
> 
> if anyone has time to test the set that would be really great, thank you
> very much.

I tested the branch on imx6q, and system suspend/resume works fine with
it.

Shawn
