From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 8 Jul 2016 14:17:29 +0800
Subject: [PATCH v4 2/2] ARM: cpuidle: make arm_cpuidle_suspend() a bit
 more efficient
In-Reply-To: <20160707134628.GB20553@linaro.org>
References: <1467785755-3488-1-git-send-email-jszhang@marvell.com>
 <1467785755-3488-3-git-send-email-jszhang@marvell.com>
 <20160707134628.GB20553@linaro.org>
Message-ID: <20160708141729.3fa61c10@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel,

On Thu, 7 Jul 2016 15:46:28 +0200 Daniel Lezcano wrote:

> On Wed, Jul 06, 2016 at 02:15:55PM +0800, Jisheng Zhang wrote:
> > Currently, we check cpuidle_ops.suspend every time when entering a
> > low-power idle state. But this check could be avoided in this hot path
> > by moving it into arm_cpuidle_read_ops() to reduce arm_cpuidle_suspend
> > overhead a bit.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---  
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I'm not sure the upstream merging path this patch should follow, Per my
understanding, I need to put it into Russell's PATCH system.

Thanks in advance,
Jisheng
