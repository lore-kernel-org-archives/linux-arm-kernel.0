From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 22 Sep 2015 10:46:43 -0700
Subject: [PATCH v2 2/5] PM / OPP: Support adjusting OPP voltages at runtime
In-Reply-To: <20150922165041.GG24314@linux>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
 <1442623929-4507-3-git-send-email-sboyd@codeaurora.org>
 <20150922165041.GG24314@linux>
Message-ID: <20150922174643.GJ23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22, Viresh Kumar wrote:
> On 18-09-15, 17:52, Stephen Boyd wrote:
> >  /**
> > + * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
> > + * @dev:		device for which we do this operation
> > + * @freq:		OPP frequency to adjust voltage of
> > + * @u_volt:		new OPP voltage
> > + *
> > + * Change the voltage of an OPP with an RCU operation.
> > + *
> > + * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> > + * copy operation, returns 0 if no modifcation was done OR modification was
> 
>                                       modification
> 
> > + * successful.
> 
> Otherwise,
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

This typo is all over the file! I'll send a patch for that too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
