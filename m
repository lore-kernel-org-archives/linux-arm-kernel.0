From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Mon, 9 Jul 2018 07:26:17 +0800
Subject: [PATCH] arm64: hikey960: update idle-states
In-Reply-To: <948f033f-aef2-4d6c-170d-a1ff2113f258@linaro.org>
References: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
 <20180708140157.GA28878@leoy-ThinkPad-X240s>
 <948f033f-aef2-4d6c-170d-a1ff2113f258@linaro.org>
Message-ID: <20180708232617.GA21469@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 08, 2018 at 11:15:22PM +0200, Daniel Lezcano wrote:
> Hi Leo,
> 
> 
> On 08/07/2018 16:01, leo.yan at linaro.org wrote:
> 
> [ ... ]
> 
> >> A simple test with a task waking up every 11,111ms shows improvement:
> > 
> > Should s/11,111ms/11.111ms ?
> 
> Actually the French notation is ',' for decimal :)
> 
> English and French are inverted.
> 
> For example one million is noted:
> 
> French  : 1.000.000 (or 1 000 000)
> English : 1,000,000
> 
> And one milli is noted:
> 
> French  : 0,001
> English : 0.001
> 
> :)

Ah, interesting.  Thanks for explaination, Daniel. :)

Thanks,
Leo Yan
