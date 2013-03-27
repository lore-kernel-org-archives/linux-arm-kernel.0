From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 27 Mar 2013 09:51:14 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <51527A08.8060207@intel.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301443.5053.9.camel@laptop> <5152768B.3020306@linux.vnet.ibm.com>
 <51527A08.8060207@intel.com>
Message-ID: <1364374274.5053.60.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-27 at 12:48 +0800, Alex Shi wrote:
> 
> Yes, the new forked runnable load was set as full utilisation in V5
> power aware scheduling. PJT, Mike and I both agree on this. PJT just
> discussion how to give the full load to new forked task. and we get
> agreement in my coming V6 power aware scheduling patchset.

Great!, means I can mark the v5 thread read! :-)
