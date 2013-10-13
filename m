From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 13 Oct 2013 12:17:17 +0200
Subject: [PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
In-Reply-To: <20131013111945.0251a3cc@skate>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>	<1381593099-1184-2-git-send-email-daniel.lezcano@linaro.org>
 <20131013111945.0251a3cc@skate>
Message-ID: <525A732D.3080708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2013 11:19 AM, Thomas Petazzoni wrote:
> Dear Daniel Lezcano,
>
> On Sat, 12 Oct 2013 17:51:39 +0200, Daniel Lezcano wrote:
>
>> +config ARM_AT91_CPUIDLE
>> +        bool "Cpu Idle Driver for the AT91 processors"
>
> Nitpick: indentation is done with spaces here, while it should be one
> tab.

Ah, right. Fixed for the V2.

Thanks !
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
