From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 27 Mar 2013 14:53:26 +0100
Subject: IMX: board hardware macro
In-Reply-To: <20130327123359.GD2674@S2101-09.ap.freescale.net>
References: <515221BE.8050808@linaro.org>
 <20130327063306.GC2767@r65073-Latitude-E6420> <5152B82D.8080505@linaro.org>
 <20130327123359.GD2674@S2101-09.ap.freescale.net>
Message-ID: <5152F9D6.1010500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2013 01:34 PM, Shawn Guo wrote:
> On Wed, Mar 27, 2013 at 10:13:17AM +0100, Daniel Lezcano wrote:
>> Do these macros exist ?
> 
> There is cpu_is_mx51(), but no cpu_is_mx6() stuff.  I do not understand
> why these are needed.  The cpuidle initialization should be done in SoC
> specific hook like how it's done for imx6q right now.  So why do you
> need such macros?

Well I am sure that will fit, but I wanted to create a single cpuidle
init function for all the platforms in order to encapsulate the cpuidle
drivers and then with the incoming patchset, factor out the code.

I will send a RFC for the changes, so we can discuss about it and choose
the direction you think more convenient to unify the code across the
different cpuidle drivers.

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
