From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 23:20:13 -0700
Subject: [PATCH V3 07/16] PM / OPP: Add support to parse
 "operating-points-v2" bindings
In-Reply-To: <20150731055806.GN17794@linux>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <6d8d9cd0c3ae2d3fa8c3aadedb5ac403785b7675.1438166099.git.viresh.kumar@linaro.org>
 <20150731055106.GJ3159@codeaurora.org>
 <20150731055806.GN17794@linux>
Message-ID: <20150731062013.GR3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31, Viresh Kumar wrote:
> On 30-07-15, 22:51, Stephen Boyd wrote:
> > > +	opp->u_volt = microvolt[0];
> > > +	opp->u_volt_min = microvolt[1];
> > > +	opp->u_volt_max = microvolt[2];
> > 
> > Should the default be 0 and ULONG_MAX for volt_min/volt_max when
> > there's on element?
> 
> I am not still sure how the regulator API is going to look like for
> this target/min/max thing. So, lets defer it until that is resolved.
> For now they are initialized to 0.
> 
> And, because the user has just passed in a target voltage, maybe all
> three must be == u_volt. :)
> 

Ok. Sounds fair enough.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
