From: mirza.krak@gmail.com (Mirza Krak)
Date: Wed, 31 Aug 2016 11:23:13 +0200
Subject: [PATCH v2 0/6] Add support for Tegra GMI bus controller
In-Reply-To: <1472569295.5703.20.camel@toradex.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
 <1472569295.5703.20.camel@toradex.com>
Message-ID: <CALw8SCXgKcRPk8qk9GqPiL6sJV6gRt93eFHfxFHj3WJZNHgv7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcel.

2016-08-30 17:01 GMT+02:00 Marcel Ziswiler <marcel.ziswiler@toradex.com>:
> Hi Mirza
>
> Sorry, I long since wanted to give you some feedback on this as well.
>
> BTW: Thank you very much for taking this on!

It has been and still is a fun project. So gladly doing it.
>
> On Wed, 2016-08-24 at 15:37 +0200, Mirza Krak wrote:
>> From: Mirza Krak <mirza.krak@gmail.com>
>>
>> Hi.
>>
>> This is a follow up to my previous RFC to add support for Tegra GMI
>> bus
>> controller.
>>
>> I have tested this series on a Tegra30 using a Colibri T30 SOM on a
>> custom
>> carrier board which has multiple CAN controllers (SJA1000) connected
>> to the
>> GMI bus.
>
> We once did a nice GMI-Memory Board which mates with the extension
> connector X3 of our V3.x Colibri Evaluation boards and allows testing
> SRAM access not only in muxed but also in non-muxed mode albeit 16-bit
> only. I took your driver for a spin both on Colibri T20 as well as
> Colibri T30 both in muxed as well as non-muxed mode and it passed all
> tests being both manual devmem2 type reads/writes as well as memtester
> runs on the full 128K SRAM giving it the physical address using the -p
> argument.
>
> So you may add the following to the whole series:
>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board

Thank you very much for testing. Will add your tags in the upcoming V3.

Best Regards
Mirza
