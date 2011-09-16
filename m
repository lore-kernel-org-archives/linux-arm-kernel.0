From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Sep 2011 12:44:05 +0100
Subject: [GIT PULL] Perf, PMU and hw_breakpoint updates for 3.2
In-Reply-To: <20110901210614.GA5209@e102144-lin.cambridge.arm.com>
References: <20110901210614.GA5209@e102144-lin.cambridge.arm.com>
Message-ID: <20110916114405.GB31334@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Sep 01, 2011 at 10:06:14PM +0100, Will Deacon wrote:
> Please pull these perf/pmu/hw_breakpoint updates for 3.2. Note that the
> patch entitled "perf: provide PMU when initing events" is a cherry-pick
> from tip/master.
> 
> I would have waited until -rc5 to send this, but I'm on holiday without
> internet for the next couple of weeks. Instead this is taken against
> the recent merge commit of your fixes branch by Linus.

[...]

> The following changes since commit 90e93648c41bd29a72f6ec55ce27a23c209eab8c:
> 
>   Merge branch 'fixes' of master.kernel.org:/home/rmk/linux-2.6-arm (2011-08-29 16:34:07 -0700)
> 
> are available in the git repository at:
> 
>   git://linux-arm.org/linux-2.6-wd.git for-rmk

I can't see these in your for-next branch, so would you like me to rebase
onto -rc6 now that it's around or are you happy to take this as-is?

Cheers,

Will
