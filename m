From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 13 Aug 2013 14:50:57 +0200
Subject: [GIT-PULL] cpuidle fixes for 3.12
In-Reply-To: <5208ADC9.2050309@linaro.org>
References: <5208ADC9.2050309@linaro.org>
Message-ID: <3149998.TPa4L6F06A@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 12, 2013 11:41:29 AM Daniel Lezcano wrote:
> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
> 
> Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
> 
> are available in the git repository at:
> 
> git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
> 
> for you to fetch changes up to 75d6137da195a1e059e1c814cb95635e168f85c0:
> 
> cpuidle: kirkwood: Make kirkwood_cpuidle_remove function static
> (2013-08-12 11:28:50 +0200)
> 
> This series fixes some compilation issues:
> 
> * for SH, a parameter is missing for the cpuidle_register function
> * for Calxeda, an _iomem annotation is missing for scu_base_addr variable
> * for kirkwood, a static declaration is missing for the
> kirkwood_cpuidle_remove function

Pulled, thanks Daniel!
