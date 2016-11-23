From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 23 Nov 2016 12:15:37 +0000
Subject: [PATCH 1/3] of: base: add support to get machine compatible string
In-Reply-To: <11467504-c700-cbfa-a945-be9ec8776144@ti.com>
References: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
 <1479811311-3080-2-git-send-email-bgolaszewski@baylibre.com>
 <5ce9fb9f-459a-562b-2e9f-85d35f9ec035@arm.com>
 <67a3c2c7-0cb9-9764-2710-6ee66fc4dde4@ti.com>
 <fdb93150-9089-c7bb-2b0a-21ded241a647@arm.com>
 <ae92e013-b41b-6caa-b32f-284ffb6f5aa0@ti.com>
 <2a644b8c-d91e-5ab1-200b-00f749a36307@arm.com>
 <ff1ea88a-87c6-6721-8e63-ddb05900cc58@ti.com>
 <f0ba1a7a-8948-21c3-8a96-d46bf105bb7e@arm.com>
 <11467504-c700-cbfa-a945-be9ec8776144@ti.com>
Message-ID: <b47cd425-ea89-31ff-5b99-dea27bea2d14@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/11/16 12:13, Sekhar Nori wrote:
> On Wednesday 23 November 2016 05:37 PM, Sudeep Holla wrote:
>>> So, the if(!of_node_get()) is just an expensive NULL pointer check. I
>>> think
>>> it is better to be explicit about it by not using of_node_get/put() at
>>> all.
>>> How about:
>>>
>>
>> Are we planning to use this in any time sensitive paths? Anyways I am
>> fine removing them.
>
> Not worried about the time taken as much as it serving as a bad example
> and getting carried over to other places where the impact might actually
> be real.
>

Ah OK, sure.

-- 
Regards,
Sudeep
