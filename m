From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 15 May 2015 11:14:43 +0200
Subject: [PATCH v2 03/10] reset: berlin: convert to a platform driver
In-Reply-To: <1431506288.3157.11.camel@pengutronix.de>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654328-26298-4-git-send-email-antoine.tenart@free-electrons.com>
 <1425896186.3152.25.camel@pengutronix.de> <20150310095713.GD23469@kwain>
 <20150512144313.GD32171@kwain> <1431506288.3157.11.camel@pengutronix.de>
Message-ID: <5555B903.1020008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.05.2015 10:38, Philipp Zabel wrote:
> Hi Antoine, Sebastian,
>
> Am Dienstag, den 12.05.2015, 16:43 +0200 schrieb Antoine Tenart:
>> On Tue, Mar 10, 2015 at 10:57:13AM +0100, Antoine Tenart wrote:
>>> On Mon, Mar 09, 2015 at 11:16:26AM +0100, Philipp Zabel wrote:
>>>>
>>>> Am Freitag, den 06.03.2015, 16:05 +0100 schrieb Antoine Tenart:
>>>>> The Berlin reset controller was introduced without being a platform
>>>>> driver because of a needed DT rework: the node describing the reset
>>>>> controller also describes the pinctrl and clk controllers...
>>>>>
>>>>> The DT issue being solved thanks to the addition of the Berlin
>>>>> controller mfd driver, it is now possible to convert the Berlin reset
>>>>> driver to a plaftorm driver.
>>>>>
>>>>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>>>>
>>>> Looks good to me. Do you want to merge this together with the rest of
>>>> the series, or should I queue the reset patch?
>>>
>>> I think we better wait for the simple-mfd patch to make it to ARM SoC
>>> first.
>>
>> simple-mfd just got pulled into next/drivers.
>>
>>> Once this is done, you can queue the reset patch (unless Sebastian wants
>>> to take it alongside the series).
>>
>> Antoine
>
> I just noticed that we'll create a small merge conflict in
> Documentation/devicetree/bindings/arm/marvell,berlin.txt if I were to
> merge patches 3 and 4.
> It would be nice to have the reset driver patch merged in the vicinity
> of this documentation change. Since there won't be any conflicting
> changes in drivers/reset/reset-berlin.c, I'd be in favor of keeping the
> series together. So patches 3 and 4
>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Philipp,

you already Acked that patch two months ago, so I was assuming to take
it though berlin tree anyway. But thanks for the Ack again ;)

Applied the series to berlin now.

Sebastian
