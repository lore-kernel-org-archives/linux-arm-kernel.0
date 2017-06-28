From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 28 Jun 2017 09:30:58 +0200
Subject: [RESEND PATCH v6 2/8] mfd: retu: Drop -mfd suffix from I2C device
 ID name
In-Reply-To: <20170619145423.w7zaeboy7iq2usmt@dell>
References: <20170615184928.12007-1-javier@dowhile0.org>
 <20170615184928.12007-3-javier@dowhile0.org>
 <20170619145423.w7zaeboy7iq2usmt@dell>
Message-ID: <CABxcv=nmP=JYmwCnRDzMS1BnFwfSNyRtyf8BdZLgGJUqqJCH3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On Mon, Jun 19, 2017 at 4:54 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 15 Jun 2017, Javier Martinez Canillas wrote:
>
>> It's not correct to encode the subsystem in the I2C device name, so
>> drop the -mfd suffix. To maintain bisect-ability, change driver and
>> platform code / DTS users in the same patch.
>>
>> Suggested-by: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
>>
>> ---
>>
>> Changes in v6:
>> - Add Wolfram Sang's Reviewed-by tag.
>>
>> Changes in v5:
>> - Add Rob Herring's Acked-by tag.
>> - Add Aaro Koskinen's Acked-by tag.
>> - Add Tony Lindgren's Acked-by tag.
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 ++--
>>  arch/arm/mach-omap1/board-nokia770.c        | 4 ++--
>>  drivers/mfd/retu-mfd.c                      | 4 ++--
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks for the ack, but the idea is you to take the whole series since
the platform maintainers have already acked the patches :)

Best regards,
Javier
