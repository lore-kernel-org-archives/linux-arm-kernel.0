From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 11 Sep 2014 13:17:54 +0200
Subject: [PATCH v5 09/11] sched: add usage_load_avg
In-Reply-To: <1409816079-10131-1-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-10-git-send-email-vincent.guittot@linaro.org>
 <1409816079-10131-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140911111754.GW3190@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 09:34:39AM +0200, Vincent Guittot wrote:
> The update of update_rq_runnable_avg interface is missing for
> CONFIG_FAIR_GROUP_SCHED in the original patch
> "[PATCH v5 09/12] sched: add usage_load_avg"
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> Hi Peter,
> 
> Do you prefer that I sent a new version of 
> "[PATCH v5 09/12] sched: add usage_load_avg" patch with the fix or this fix is
> enough ?

This is fine, I hand edited the previous patch.
