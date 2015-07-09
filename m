From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Jul 2015 02:48:49 -0700
Subject: [PATCH 12/18] ARM/omap1/time: Migrate to new 'set-state' interface
In-Reply-To: <559A9CC0.5070808@oracle.com>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
 <1680d1e2a6b9dd6b76e12c86bde5d84abcebe705.1436178990.git.viresh.kumar@linaro.org>
 <559A9CC0.5070808@oracle.com>
Message-ID: <20150709094849.GW10705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* santosh shilimkar <santosh.shilimkar@oracle.com> [150706 08:23]:
> On 7/6/2015 3:54 AM, Viresh Kumar wrote:
> >Migrate omap driver to the new 'set-state' interface provided by
> >clockevents core, the earlier 'set-mode' interface is marked obsolete
> >now.
> >
> >This also enables us to implement callbacks for new states of clockevent
> >devices, for example: ONESHOT_STOPPED.
> >
> >Cc: Santosh Shilimkar <ssantosh@kernel.org>
> >Cc: Tony Lindgren <tony@atomide.com>
> >Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >---
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Acked-by: Tony Lindgren <tony@atomide.com>
