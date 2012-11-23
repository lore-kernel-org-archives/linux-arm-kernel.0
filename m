From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sat, 24 Nov 2012 05:17:13 +0900
Subject: [PATCH] ARM: Kirkwood: Add support LED of OpenBlocks A6
In-Reply-To: <20121123065429.GG9177@lunn.ch>
References: <1353629160-6002-1-git-send-email-iwamatsu@nigauri.org>
 <20121123065429.GG9177@lunn.ch>
Message-ID: <CABMQnVLZJirEdg4+UKwvjPJ9DU=XGuYvv2E==XA++tH=c=Df9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Andrew.

Thank you for your review.

On Fri, Nov 23, 2012 at 3:54 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Nov 23, 2012 at 09:06:00AM +0900, Nobuhiro Iwamatsu wrote:
>> OpenBlocks A6 has three leds via GPIO. This supports them.
>> And this fix typo about led, because hardware manual has typo.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> ---
>>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   19 +++++++++++++++++++
>>  arch/arm/mach-kirkwood/board-openblocks_a6.c |    4 ++--
>>  2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
>> index 37dc3a7..183df04 100644
>> --- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
>> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
>> @@ -75,4 +75,23 @@
>>                       };
>>               };
>>       };
>> +
>> +     gpio_leds {
>
> Hi Nobuhiro
>
> Thanks for the patch, looks good except for a minor point. The
> convention is to use gpio-leds, not gpio_leds.
>

OK, I will fix.

> Thanks
>         Andrew
>

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
