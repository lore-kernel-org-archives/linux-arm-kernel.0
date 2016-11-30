From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Thu, 1 Dec 2016 00:40:22 +0300
Subject: [PATCH] dt-bindings: document how to setup rockchip timers as
 clocksource
In-Reply-To: <20161130213006.p6totahjga7546s6@rob-hp-laptop>
References: <1480025536-6837-1-git-send-email-al.kochet@gmail.com>
 <20161130213006.p6totahjga7546s6@rob-hp-laptop>
Message-ID: <F0C2F3CA-7A29-46B5-B420-A672696236BF@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 1 ???. 2016 ?., ? 0:30, Rob Herring <robh@kernel.org> ???????(?):
> 
> 1st and 2nd are ambiguous. Plus this is an OS implementation detail that 
> doesn't belong in the binding.
> 
>> +If you want to bind specific timer as clockevent (i.e. one from alive subsystem)
>> +and specific timer as clocksource, you can number the timers in "aliases" node.
> 
> No. 
> 
> Use and/or describe what are the features of a timer to make the 
> decision. There has to be some reason you care which one. One has an 
> interrupt and the other doesn't. One is always on. Etc.

Thank you, Rob.

Eventually I abandoned this decision.
I left only one patch, which you confirmed recently.

And sorry for making noise with duplicate patches.

Alexander.
