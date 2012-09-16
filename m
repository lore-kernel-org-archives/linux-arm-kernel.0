From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 16 Sep 2012 11:11:44 +0200
Subject: [PATCH v3 2/5] Documentation: add description of DT binding for
 the gpio-mvebu driver
In-Reply-To: <20120916075601.GN28177@lunn.ch>
References: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347551658-24449-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120916075601.GN28177@lunn.ch>
Message-ID: <505597D0.6030200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2012 09:56 AM, Andrew Lunn wrote:
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
>> @@ -0,0 +1,45 @@
>> +* Marvell EBU GPIO controller
>> ...
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +
>> +- #interrupt-cells: specifies the number of celles needed to encode an
>> +   interrupt source
>
> Hi Thomas
>
> Should this be #gpio-cells? The example below does not have
> #interrupt-cells?

It should be both. #gpio-cells to encode pin-offset within the gpio controller
and polarity, #interrupt-cells to encode irq number.

Sebastian
