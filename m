From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 4 Aug 2017 08:44:32 +0200
Subject: [PATCH RESEND v3 1/3] SoC: es8328-i2c: Add compatible for ES8323
In-Reply-To: <20170803190116.wo6siwstbkzd4ph7@rob-hp-laptop>
References: <20170726135526.475-1-romain.perier@collabora.com>
 <20170726135526.475-10-romain.perier@collabora.com>
 <20170803190116.wo6siwstbkzd4ph7@rob-hp-laptop>
Message-ID: <0febe9b7-724a-78fa-6ced-ec0874c5488f@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Le 03/08/2017 ? 21:01, Rob Herring a ?crit :
> On Wed, Jul 26, 2017 at 03:55:24PM +0200, Romain Perier wrote:
>> This commit adds a compatible string for everest,es8323. This is an
>> audio codec that is compatible with es8328 and can be found for example
>> on the Firefly-RK3288 board.
>>
>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>> ---
>>  Documentation/devicetree/bindings/sound/es8328.txt | 5 ++++-
>>  sound/soc/codecs/es8328-i2c.c                      | 2 ++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
> I acked the previous v3 at the end of the discussion. Please add acks 
> when posting new versions.
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> Rob

My bad! Thanks

Romain
