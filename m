From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 29 Jun 2015 11:21:24 +0200
Subject: [PATCH] clocksource: imx: define clocksource for mx27
In-Reply-To: <20150628044434.GC10332@tiger>
References: <1435439504-406-1-git-send-email-tremyfr@gmail.com>
 <20150628044434.GC10332@tiger>
Message-ID: <55910E14.5020906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2015 06:44 AM, Shawn Guo wrote:
> On Sat, Jun 27, 2015 at 11:11:44PM +0200, Philippe Reynes wrote:
>> The clocksource imx27 wasn't defined in timer-imx-gpt.c,
>> so the kernel no longer boot on imx27. Just define
>> clocksource imx27 as an imx21.
>>
>> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
>
> Daniel,
>
> Please help send this as a fix for 4.2-rc, thanks.

Ok.

stable@ ?

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
