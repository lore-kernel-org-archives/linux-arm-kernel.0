From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Mar 2012 08:31:06 +0000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20120316174941.40421ba160741a0f6aab6611@canb.auug.org.au>
References: <20120316174941.40421ba160741a0f6aab6611@canb.auug.org.au>
Message-ID: <201203160831.07305.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-msm/timer.c between commit f8e56c42e4e3 ("msm: timer:
> Support sched_clock()") from the arm tree and commit 5ca709c16d0f ("ARM:
> local timers: convert MSM to runtime registration interface") from the
> arm-soc tree.

We've had a few conflicts with localtimer patches already and the
solution might be very different and nonobvious. Stephen B, please
check if linux-next still works for you with localtimer enabled.

The fix does look correct to me though.

> I fixed it up (see below) and can carry the fax as necessary.

The fax? I think email will do fine ;-)

Thanks Stephen R,

	Arnd
