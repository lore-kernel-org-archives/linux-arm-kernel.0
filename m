From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 19 Mar 2014 13:05:55 +0100
Subject: [PATCH v2 7/7] sched: powerpc: Add SD_SHARE_POWERDOMAIN for SMT
 level
In-Reply-To: <1395165409-18055-8-git-send-email-vincent.guittot@linaro.org>
References: <1395165409-18055-1-git-send-email-vincent.guittot@linaro.org>
 <1395165409-18055-8-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140319120555.GL27632@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 06:56:49PM +0100, Vincent Guittot wrote:
> Set the power domain dependency at SMT level of Power8 but keep the flag
> clear at CPU level. The goal is to consolidate tasks on the threads of a
> core up to a level as decribed in the link below:
> https://lkml.org/lkml/2014/3/12/16

I've not yet looked at the link; but its best to avoid references and
have a Changelog that can stand on its own.
