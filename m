From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 04 Mar 2015 15:34:06 +0100
Subject: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
In-Reply-To: <3654949.JbH3Ca4PON@vostro.rjw.lan>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com>
 <54F5CC0D.6060509@libero.it> <54F5D13A.1020002@linaro.org>
 <3654949.JbH3Ca4PON@vostro.rjw.lan>
Message-ID: <54F717DE.80106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2015 03:53 PM, Rafael J. Wysocki wrote:
> On Tuesday, March 03, 2015 04:20:26 PM Daniel Lezcano wrote:
>> On 03/03/2015 03:58 PM, Fulvio wrote:

[ ... ]

>> The fix is correct. The cpu_pm_enter/exit symmetry must be kept because
>> we don't know what the notifier clients are doing.
>>
>> The point is : can we send it to stable@ as a bug fix or not ?
>
> Yes, we can, unless there's a risk of breaking things that cannot be
> ignored.

Ok, I added the stable@ tag.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
