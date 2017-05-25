From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 May 2017 20:33:47 +0200
Subject: [PATCH 7/8 v2] clocksource/drivers/fttmr010: Merge Moxa into
 FTTMR010
In-Reply-To: <CACRpkdZE-kG9ChQSsdbNDNUYgoAq3ZNHSR74GfG25XwQeKoV+A@mail.gmail.com>
References: <20170518201705.28790-1-linus.walleij@linaro.org>
 <20170518201705.28790-7-linus.walleij@linaro.org>
 <CACRpkdZE-kG9ChQSsdbNDNUYgoAq3ZNHSR74GfG25XwQeKoV+A@mail.gmail.com>
Message-ID: <25d9ee8a-2bef-bae0-0269-b3228254f477@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/2017 15:58, Linus Walleij wrote:
> On Thu, May 18, 2017 at 10:17 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
>> This merges the Moxa Art timer driver into the Faraday FTTMR010
>> driver and replaces all Kconfig symbols to use the Faraday
>> driver instead. We are now so similar that the drivers can
>> be merged by just adding a few lines to the Faraday timer.
> 
> OK Daniel, the series is tested clear by Joel and Jonas,
> feel free to merge these patches up to and including this #7
> when you feel they look good.
> 
> Patch #8 I will send to the ARM SoC people pronto.

Hi Linus,

patches 1-7 is applied for 4.13.

I assumed V1 Rob's ack applies also for the V2.

Fixed a trivial conflict with the Kconfig.

Thanks!

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
