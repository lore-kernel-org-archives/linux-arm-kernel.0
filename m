From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Jul 2016 15:00:47 +0200
Subject: [PATCH 2/4] bindings: spi-samsung: add exynos5433 spi compatible
In-Reply-To: <20160708125648.GK23620@samsunx.samsung>
References: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
 <1467980304-14093-3-git-send-email-andi.shyti@samsung.com>
 <CGME20160708125125epcas1p25209218b03d625369dc9f9495a66b750@epcas1p2.samsung.com>
 <577FA1CB.30805@samsung.com> <20160708125648.GK23620@samsunx.samsung>
Message-ID: <577FA3FF.90208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 02:56 PM, Andi Shyti wrote:
>>>  
>>>  - reg: physical base address of the controller and length of memory mapped
>>>    region.
>>>
>>
>> Thanks for the patch, nice work. I see that you ignored parts of my
>> offline comments so I guess you leave that work to others (describe
>> required clock properties, deprecate exynos7-spi). I'll send the follow
>> up then.
> 
> I was actually doing the follow up, I think it's a different
> concept and therefore goes on a different patch.

Ah.... but the exynos5433-spi compatible is related to three clocks -
you even mention it in commit message.

BR,
Krzysztof
