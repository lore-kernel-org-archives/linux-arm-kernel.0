From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 5 Sep 2016 20:56:41 +0200
Subject: [PATCH 3/3] ARM: dts: efm32: remove skeleton.dtsi include and fix
 unit address warnings
In-Reply-To: <20160905075650.exmgxv6ulrbeqw45@pengutronix.de>
References: <20160830205250.15616-1-manabian@gmail.com>
 <20160830205250.15616-4-manabian@gmail.com>
 <20160905075650.exmgxv6ulrbeqw45@pengutronix.de>
Message-ID: <CAGhQ9Vytu7BtRsfH62XD04CpMrjOG9a2XGbg=JvP9a017x0-gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 5 September 2016 at 09:56, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Aug 30, 2016 at 10:52:50PM +0200, Joachim Eastwood wrote:
>> Removale of skeleton.dtsi allows us also to fix the following
>> warning from the dts compiler:
>>   Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>>
>> by adding proper unit addresses to the memory nodes. Also add missing
>> device_type to the memory node while at it.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>> Hi Uwe,
>>
>> If you want I can take this through the lpc18xx tree. There doesn't seem
>> too be many patches for efm32 lately (last one dates from 2014).
>
> That's fine for me.
>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks.

Could you also ack patch number 1 that touches armv7-m.dtsi?
I would like to have your ack since you are the originale author of
that file and it touches efm32 as well.


regards,
Joachim Eastwood
