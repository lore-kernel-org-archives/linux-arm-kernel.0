From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 18 Aug 2017 11:40:30 +0200
Subject: [PATCH] arm64: dts: rockchip: Add basic DVFS support for RK3368
In-Reply-To: <10444104.mndukromaz@phil>
References: <20170818075053.8779-1-romain.perier@collabora.com>
 <10444104.mndukromaz@phil>
Message-ID: <f283f9de-e9ce-e2b9-645f-b5f0566ebccf@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


Le 18/08/2017 ? 10:20, Heiko Stuebner a ?crit :
> Am Freitag, 18. August 2017, 09:50:53 CEST schrieb Romain Perier:
>> This adds and enable the operating points that have been tested and are
>> currently supported by the SoC.
>>
>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>> ---
>>
>> Note: RK3288 is using operating-points binding v1, while RK3399 is using
>> binding v2. I can send another iteration for switching to binding v2,
>> if required.
> Yes please use v2 for _new_ operating points :-) .
>
> One more thing down below.

Ack, will do.

Thanks,
Romain
