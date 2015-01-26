From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 26 Jan 2015 11:26:45 +0100
Subject: [PATCH v4 2/2] clocksource: driver for Conexant Digicolor SoC
 timer
In-Reply-To: <20150126101511.GC3148@tarshish>
References: <cover.1422256855.git.baruch@tkos.co.il>
 <d2d06d04f8ee8acb62e7748b42c3177229de478a.1422256855.git.baruch@tkos.co.il>
 <54C60C4F.50507@linaro.org> <20150126101511.GC3148@tarshish>
Message-ID: <54C61665.1000300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2015 11:15 AM, Baruch Siach wrote:
> Hi Daniel,

[ ... ]

>>
>> What do you think ?
>
> OK. I'll give it a try.
>
> Thanks for your prompt response and thorough review.

Maxime Ripard just sent a patchset (patch 4/5) with some changes 
suggested above :)

http://www.spinics.net/lists/arm-kernel/msg394704.html

As you may see, the enable/disable is passing the timer channel as 
parameter while I suggested to store it in the structure. It is up to 
you to choose what fits better for your future needs.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
