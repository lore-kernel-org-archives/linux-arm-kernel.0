From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 8 Jul 2018 23:15:22 +0200
Subject: [PATCH] arm64: hikey960: update idle-states
In-Reply-To: <20180708140157.GA28878@leoy-ThinkPad-X240s>
References: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
 <20180708140157.GA28878@leoy-ThinkPad-X240s>
Message-ID: <948f033f-aef2-4d6c-170d-a1ff2113f258@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,


On 08/07/2018 16:01, leo.yan at linaro.org wrote:

[ ... ]

>> A simple test with a task waking up every 11,111ms shows improvement:
> 
> Should s/11,111ms/11.111ms ?

Actually the French notation is ',' for decimal :)

English and French are inverted.

For example one million is noted:

French  : 1.000.000 (or 1 000 000)
English : 1,000,000

And one milli is noted:

French  : 0,001
English : 0.001

:)

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
