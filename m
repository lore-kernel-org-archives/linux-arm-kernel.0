From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 14 Apr 2013 22:22:54 +0200
Subject: [V3 patch 17/19] ARM: kirkwood: cpuidle: use init/exit common
 routine
In-Reply-To: <20130414151429.GF5061@lunn.ch>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-18-git-send-email-daniel.lezcano@linaro.org>
 <20130414151429.GF5061@lunn.ch>
Message-ID: <516B101E.3040807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2013 05:14 PM, Andrew Lunn wrote:
> On Fri, Apr 12, 2013 at 02:36:03PM +0200, Daniel Lezcano wrote:
>> Remove the duplicated code and use the cpuidle common code for initialization.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

> Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew for testing.

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
