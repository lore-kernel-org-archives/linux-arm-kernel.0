From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Jul 2015 02:50:33 -0700
Subject: [PATCH 14/18] ARM/omap2/timer: Migrate to new 'set-state'
 interface
In-Reply-To: <559A9CAE.7020806@oracle.com>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
 <9231fc8eb977888f780a2bdc35681cf76b09ea42.1436178990.git.viresh.kumar@linaro.org>
 <559A9CAE.7020806@oracle.com>
Message-ID: <20150709095033.GY10705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* santosh shilimkar <santosh.shilimkar@oracle.com> [150706 08:22]:
> 
> 
> On 7/6/2015 3:54 AM, Viresh Kumar wrote:
> >Migrate omap2 driver to the new 'set-state' interface provided by
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
