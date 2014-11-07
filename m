From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 07 Nov 2014 11:41:43 +0100
Subject: [GIT PULL] ARM DT idle states updates
In-Reply-To: <20141104123013.GA16832@red-moon>
References: <20141104123013.GA16832@red-moon>
Message-ID: <545CA1E7.5050203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2014 01:30 PM, Lorenzo Pieralisi wrote:
> Hi Daniel,
>
> please consider pulling the three patches below for 3.19.
>
> First two are updates on idle states bindings and parsing code to add
> states descriptions and status property, the last one is just a clean-up
> patch, to remove leftovers from the last merge window.

Hi Lorenzo,

could you please send these three patches along with this pull request ?

Thanks

   -- Daniel

>
> Thanks a lot,
> Lorenzo
>
> The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:
>
>    Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)
>
> are available in the git repository at:
>
>    git://linux-arm.org/linux-2.6-lp.git for-upstream/dt-idle-states-updates
>
> for you to fetch changes up to 6e13873494078ac26862144ca2345546ca905c41:
>
>    drivers: cpuidle: remove cpuidle-arm64 duplicate error messages (2014-11-04 12:09:27 +0000)
>
> ----------------------------------------------------------------
> Lorenzo Pieralisi (3):
>        drivers: cpuidle: add status property to ARM idle states
>        drivers: cpuidle: add idle-state-name description to ARM idle states
>        drivers: cpuidle: remove cpuidle-arm64 duplicate error messages
>
>   .../devicetree/bindings/arm/idle-states.txt          | 20 ++++++++++++++++++++
>   drivers/cpuidle/cpuidle-arm64.c                      | 13 ++-----------
>   drivers/cpuidle/dt_idle_states.c                     | 10 +++++++++-
>   3 files changed, 31 insertions(+), 12 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
