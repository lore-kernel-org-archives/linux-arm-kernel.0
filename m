From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 29 Aug 2017 13:42:47 +0200
Subject: [PATCH 9/9] clocksource/drivers/bcm2835: Remove message on memory
 allocation failure
In-Reply-To: <1822c0d4-8f5d-611c-21df-4945f298be0a@users.sourceforge.net>
References: <20170829093354.GA2572@mai>
 <1503999271-15712-1-git-send-email-daniel.lezcano@linaro.org>
 <1503999271-15712-9-git-send-email-daniel.lezcano@linaro.org>
 <1822c0d4-8f5d-611c-21df-4945f298be0a@users.sourceforge.net>
Message-ID: <01662951-8a60-5c1c-cc72-464af1d3950d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/2017 13:21, SF Markus Elfring wrote:
> I would prefer to use the wording ?for a? instead of ?on? in the commit subject.
> 
> 
>> The bcm2835_timer_init() function emits an error message in case of a memory
>> allocation failure. This is pointless as the mm core already do that.
> 
> Does this commit message contain a typo?
> Would a wording like ?? does that already.? be more appropriate here?

Yep. Fixed.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
