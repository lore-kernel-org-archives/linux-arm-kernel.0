From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 11 Jun 2015 21:57:27 +0530
Subject: [PATCH 3/6] clocksource: bcm2835: Migrate to new 'set-state'
 interface
In-Reply-To: <5579B3C7.5030305@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <b0bf70d911dffe170b0d2b2b3e680bb445c15fc4.1433768426.git.viresh.kumar@linaro.org>
 <5579A864.5010500@linaro.org> <20150611160048.GC4386@linux>
 <5579B3C7.5030305@linaro.org>
Message-ID: <20150611162726.GE4386@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 11-06-15, 18:13, Daniel Lezcano wrote:
> Yes, I think it would make sense to ignore NULL callback in
> __clockevents_set_state, otherwise we will end up to fill the
> different drivers with duplicated noop functions.

Do you suggest the same ?

Thanks.

-- 
viresh
