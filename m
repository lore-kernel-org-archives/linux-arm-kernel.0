From: sr@denx.de (Stefan Roese)
Date: Thu, 16 Jun 2016 11:42:46 +0200
Subject: [PATCH v6] spi: orion.c: Add direct access mode
In-Reply-To: <87d1nhbi83.fsf@free-electrons.com>
References: <1461147068-4829-1-git-send-email-sr@denx.de>
 <87k2jswky0.fsf@free-electrons.com> <5717715D.6030701@denx.de>
 <87d1nhbi83.fsf@free-electrons.com>
Message-ID: <57627496.10302@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 16.06.2016 11:23, Gregory CLEMENT wrote:
>   On mer., avril 20 2016, Stefan Roese <sr@denx.de> wrote:
>
>
>>> As you don't submit any patch for the dtsi, I assume that you expect
>>> that this part will be done at board level. In this case as I wrote
>>> above we are sure that all the board continue working without any need
>>> to test them.
>>
>> No, this won't work without any changes to the Armada dtsi /
>> dts files. As the SPI controller node needs to get moved
>> for this 'reg' property to work (suggestion from Arnd).
>>
>> I've submitted 2 patches for the dtsi / dts files a short while
>> ago:
>>
>> http://www.spinics.net/lists/arm-kernel/msg495524.html
>> http://www.spinics.net/lists/arm-kernel/msg495523.html
>>
>> When this SPI driver patch gets accepted, I'll send an updated
>> patchset for the dtsi / dts files.
>
> Unless I am wrong the SPI driver patch got accepted,

Correct. Its in linux-next now.

> but I didn't see an
> updated patchset for the dtsi / dts files. Did I miss it?

No, you didn't miss it.

> Else would you ming to send them? Then I will be able to apply them on
> the mvebu tree.

Its on my list. Thanks for reminding me. I'll get to working on this
next week and will send an updated patch series then.

Thanks,
Stefan
