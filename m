From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 07 Apr 2014 21:30:15 -0500
Subject: [PATCH 3/3] ARM: socfpga: dts: add reset-controller
In-Reply-To: <20140407224110.GA28399@pengutronix.de>
References: <1396629087-23727-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396629087-23727-4-git-send-email-s.trumtrar@pengutronix.de>
 <1396905121.25236.2.camel@linux-builds1>
 <20140407224110.GA28399@pengutronix.de>
Message-ID: <53435F37.7060301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 4/7/14 5:41 PM, Steffen Trumtrar wrote:
> On Mon, Apr 07, 2014 at 04:12:01PM -0500, Dinh Nguyen wrote:
>> On Fri, 2014-04-04 at 18:31 +0200, Steffen Trumtrar wrote:
>>> Add the necessary #reset-cells property to the rst-mgr node and
>>> provide a header-file with all possible resets specified.
>>>
>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>> ---
>>>  arch/arm/boot/dts/socfpga.dtsi           |  8 ++-
>>>  include/dt-bindings/reset/altr,rst-mgr.h | 90 ++++++++++++++++++++++++++++++++
>> Does this file belong under dt-bindings/reset/ or
>> dt-bindings/reset-controller/?
>>
> ATM there is no such directory, or is there ?
> So, reset seems appropriate I think.
commit [6b7f06 ARM: STi: STiH415: Add reset controller support.]
Seems more appropriate for this to go into reset-controller.

Dinh
>
> But this reminds me, that I wanted to move the binding documentation from
> Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt ->
> Documentation/devicetree/bindings/reset/socfpga-reset.txt
>
> I will have to add a patch for that to the series in v2.
>
> Thanks,
> Steffen
>
