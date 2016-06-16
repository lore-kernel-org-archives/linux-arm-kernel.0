From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Jun 2016 11:34:50 +0200
Subject: [PATCH 2/5] clk: Combine DT binding doc for max77686 and max77802
In-Reply-To: <a9a4bf3b-7ece-f92f-9d49-d4745f512e3c@osg.samsung.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-3-git-send-email-ldewangan@nvidia.com>
 <a9a4bf3b-7ece-f92f-9d49-d4745f512e3c@osg.samsung.com>
Message-ID: <576272BA.50800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 05:19 PM, Javier Martinez Canillas wrote:
>> Remove the separate DT binding document file for maxim,max77802 and
>> move all information to maxim,max77686 DT binding document.
>>
> 
> Now, I wonder if this is the correct approach. A system integrator is
> probably going to search for the bindings of the chip that is present
> in their system. For example there are different DT bindings docs for
> both the max77686 and max77802 PMIC even when support is implemented
> by the same driver (drivers/mfd/max77686.c).
> 
> But maybe I'm wrong so I'll let people with more DT experience to say
> if merging the bindings docs in a single one is the correct approach.

I personally prefer having one binding document for all devices because
essentially it is almost the same device. For looking up I use git grep
with compatible string (or device name) so it does not matter, IMHO.

Best regards,
Krzysztof
