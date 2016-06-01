From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 1 Jun 2016 16:54:41 -0400
Subject: [PATCH v5 13/22] ARM: dts: exynos: Enable UART3 on Exynos5410
In-Reply-To: <e9a103cc-a5cf-95d8-ee49-d44542dbcb1e@osg.samsung.com>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
 <1464429273-23457-14-git-send-email-krzk@kernel.org>
 <CAOi56cXeRjGgE+=psk7K45oeAgZ27HFxbi+an-ELnA3-_Z_BTA@mail.gmail.com>
 <CAJKOXPcDZFaqL7+wT9d9iD7Y4QbZWPFQw2hTR3AzyU4K099WYA@mail.gmail.com>
 <e9a103cc-a5cf-95d8-ee49-d44542dbcb1e@osg.samsung.com>
Message-ID: <cabfd6c2-fc7e-622a-36e6-5be0b674cdd2@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 04:52 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,

[snip]

>>
>> I left the commit in my tree as it is correct (strictly speaking).
>> Sorry for any trouble it makes.
>>
> 
> Kevin pointed me to this issue over IRC and I was able to reproduce it in
> my Peach Pi by removing the UART3 clocks from the Exynos5420 clock driver.
> 
> Your patch indeed fixes the issue, I'll add a Reviewed-by on that thread.
> 

err, I meant a Tested-by tag... but yes I've also reviewed the patch :)

Best regards, 
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
