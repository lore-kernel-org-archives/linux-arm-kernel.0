From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 07 Nov 2013 14:40:49 +0100
Subject: [PATCH v2 2/2] clocksource: sh_tmu: Add clk_prepare/unprepare
 support
In-Reply-To: <20131031052406.GN1603@verge.net.au>
References: <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057097-22689-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131031052406.GN1603@verge.net.au>
Message-ID: <527B9861.1020606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2013 06:24 AM, Simon Horman wrote:
> On Tue, Oct 29, 2013 at 03:31:37PM +0100, Laurent Pinchart wrote:
>> Prepare the clock at probe time, as there is no other appropriate place
>> in the driver where we're allowed to sleep.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Thanks, I have queued this up.

Ok, so those patches go through your tree, right ?

I have been out for the Linaro connect but I saw you picked them. In the 
future, I would prefer to take them in my tree as they fall under the 
drivers/clocksource maintainer's umbrella.

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
