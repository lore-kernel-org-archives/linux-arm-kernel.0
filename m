From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Jun 2015 12:10:50 -0700
Subject: [PATCH 17/41] clocksource: qcom: Migrate to new 'set-state'
 interface
In-Reply-To: <f3bbf91cc4244796291bff383ef24a182bb3b690.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <f3bbf91cc4244796291bff383ef24a182bb3b690.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <20150619191050.GF22132@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Viresh Kumar wrote:
> Migrate qcom driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> Periodic mode isn't supported by the driver and so the callback isn't
> provided anymore.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: David Brown <davidb@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
