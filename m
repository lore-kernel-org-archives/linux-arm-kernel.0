From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 27 May 2015 14:38:57 +0200
Subject: [PATCH v2.1 02/12] clocksource: sti: Provide support for the
 ST LPC Clocksource IP
In-Reply-To: <20150526123943.GI11677@x1>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
 <1431435500-22899-3-git-send-email-lee.jones@linaro.org>
 <20150526123943.GI11677@x1>
Message-ID: <5565BAE1.1000704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2015 02:39 PM, Lee Jones wrote:
> clocksource: sti: Provide support for the ST LPC Clocksource IP
>
> This IP is shared with Watchdog and RTC functionality.  All 3 of
> these devices are mutually exclusive from one another i.e. Only 1
> IP can be used at any given time.  We use the device-driver model
> combined with a DT 'mode' property to enforce this.
>
> The ST LPC Clocksource IP can be used as the system (tick) timer.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
