From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Jul 2018 08:16:21 +0200
Subject: [PATCH v3 01/23] thermal: armada: add a function that sanitizes
 the thermal zone name
In-Reply-To: <20180729212744.31cf0747@xps13>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-2-miquel.raynal@bootlin.com>
 <84f97022-a470-f314-ee75-e5afb733bea5@linaro.org>
 <20180727135230.3c7102c7@xps13>
 <f1d7e8bd-329f-0c9d-c296-0afbe871058f@linaro.org>
 <20180729212744.31cf0747@xps13>
Message-ID: <6c9315c1-7768-d1c3-bbed-770e56d115d4@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/2018 21:27, Miquel Raynal wrote:
> Hi Daniel,

[ ... ]

> That's exactly what is done later in the series actually, but for DT
> backward compatibility and in order to continue adding feature to this
> driver, we must ensure there won't be any drawback for people using old
> DT with deprecated thermal representation.
> 
> 
> Thanks for reviewing, if you don't mind I could copy you in future
> changes? 

Yes, sure.

> Unfortunately for this series it's already been applied and I
> would like not to do any deep changes before it's merged, but for sure
> this function could be enhanced.

Or find a way to remove it ? :)


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
