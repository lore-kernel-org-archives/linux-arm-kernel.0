From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 10 Apr 2013 20:05:25 +0200
Subject: [PATCH 10/18] ARM: tegra1: cpuidle: use init/exit common routine
In-Reply-To: <5165A165.3000105@wwwdotorg.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-11-git-send-email-daniel.lezcano@linaro.org>
 <5165A165.3000105@wwwdotorg.org>
Message-ID: <5165A9E5.1070107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 07:29 PM, Stephen Warren wrote:
> On 04/10/2013 08:22 AM, Daniel Lezcano wrote:
>> Subject: ARM: tegra1: cpuidle: use init/exit common routine
> 
> The tag there should be just ARM: tegra: - Tegra1 isn't something that's
> supported upstream. Same comment for the other two Tegra patches.

Ok.

>> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Other than that, the 3 Tegra patches look reasonable assuming the
> patches that implement the new common APIs are accepted, so the 3 Tegra
> patches,
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks for review

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
