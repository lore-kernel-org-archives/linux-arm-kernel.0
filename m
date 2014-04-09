From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 09 Apr 2014 10:37:13 +0200
Subject: [PATCH 3/3] ARM: socfpga: dts: add reset-controller
In-Reply-To: <53435F37.7060301@gmail.com>
References: <1396629087-23727-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396629087-23727-4-git-send-email-s.trumtrar@pengutronix.de>
 <1396905121.25236.2.camel@linux-builds1>
 <20140407224110.GA28399@pengutronix.de> <53435F37.7060301@gmail.com>
Message-ID: <73mwfu3nly.fsf@unicorn.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dinh Nguyen <dinh.linux@gmail.com> writes:

> On 4/7/14 5:41 PM, Steffen Trumtrar wrote:
>> On Mon, Apr 07, 2014 at 04:12:01PM -0500, Dinh Nguyen wrote:
>>> On Fri, 2014-04-04 at 18:31 +0200, Steffen Trumtrar wrote:
>>>> Add the necessary #reset-cells property to the rst-mgr node and
>>>> provide a header-file with all possible resets specified.
>>>>
>>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>>> ---
>>>>  arch/arm/boot/dts/socfpga.dtsi           |  8 ++-
>>>>  include/dt-bindings/reset/altr,rst-mgr.h | 90 ++++++++++++++++++++++++++++++++
>>> Does this file belong under dt-bindings/reset/ or
>>> dt-bindings/reset-controller/?
>>>
>> ATM there is no such directory, or is there ?
>> So, reset seems appropriate I think.
> commit [6b7f06 ARM: STi: STiH415: Add reset controller support.]
> Seems more appropriate for this to go into reset-controller.
>

Okay, the current mainline master now has include/dt-bindings/reset and
include/dt-bindings/reset-controller.

I think one of those directories shouldn't be there, but be merged in
the other instead. But which one? Where shall I put my precious code?


Regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
