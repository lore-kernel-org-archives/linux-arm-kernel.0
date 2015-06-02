From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 2 Jun 2015 12:54:21 -0700
Subject: [PATCH 3/6] PM / OPP: Support adjusting OPP voltages at runtime
In-Reply-To: <20150602045026.GC10443@linux>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <1433209679-31389-4-git-send-email-sboyd@codeaurora.org>
 <20150602045026.GC10443@linux>
Message-ID: <20150602195421.GA11764@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02, Viresh Kumar wrote:
> On 01-06-15, 18:47, Stephen Boyd wrote:
> > +int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
> > +		   unsigned long u_volt);
> 
> > +static inline int dev_pm_opp_adjust_voltage(struct device *dev,
> > +		unsigned long freq, unsigned long u_volt)
> 
> The 'u' of 'unsigned' isn't aligned to the opening curly brace. Try
> running with checkpatch --strict and you will see some warnings.
> 
> Otherwise,
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Will do. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
