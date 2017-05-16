From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 May 2017 08:19:14 -0700
Subject: [PATCH V5 2/7] ARM: TI: Use - instead of @ for DT OPP entries
In-Reply-To: <5f0656140309d53a45058c048ca059c4ba294756.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <5f0656140309d53a45058c048ca059c4ba294756.1492685450.git.viresh.kumar@linaro.org>
Message-ID: <20170516151913.GE31418@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Viresh Kumar <viresh.kumar@linaro.org> [170420 03:58]:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.

Applying into omap-for-v4.13/dt thanks.

Tony
