From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Wed, 5 Oct 2016 14:08:54 +0200
Subject: [PATCH 08/14] dt-bindings: sound: Add sun8i analog codec
 documentation
In-Reply-To: <CAGb2v67gT9j6-NYj04+et2PNHRGFUzhgCnVgX+eoPGybArL60A@mail.gmail.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <06ea14939405c3eb0fb9be655d26ee564a04a53d.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004162430.GQ5228@lukather>
 <CAGb2v67gT9j6-NYj04+et2PNHRGFUzhgCnVgX+eoPGybArL60A@mail.gmail.com>
Message-ID: <b94e3b11-8edb-a632-f7f1-217a594f310c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On 05/10/2016 04:59, Chen-Yu Tsai wrote:
> On Wed, Oct 5, 2016 at 12:24 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi,
>>
>> On Tue, Oct 04, 2016 at 11:46:21AM +0200, Myl?ne Josserand wrote:
>>> Add the documentation for dt-binding of the analog audiocodec
>>> driver for SUN8I SoC.
>>>
>>> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
>>> ---
>>>  .../devicetree/bindings/sound/sun8i-codec-analog.txt | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>>> new file mode 100644
>>> index 0000000..a03ec20
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>>> @@ -0,0 +1,20 @@
>>> +* Allwinner A23/A33 Analog Codec
>>> +
>>> +This codec must be handled as a PRCM subnode.
>>
>> Like Mark was saying, you should probably reference the sun6i-prcm.txt
>> binding here


Okay, I will explain more how it works.


>>
>>> +Required properties:
>>> +- compatible: must be either "allwinner,sun8i-codec-analog"
>>
>> Our compatible prefix is <family>-<soc>, and using the older SoC that
>> introduced that block.
>>
>> In this case, that would be sun6i-a31, I think?
>
> sun6i-a31s actually, but a31s has extra line out controls,
> so the right one would be sun8i-a23. Both are listed in my
> original driver.


It is noted.

Thanks!


-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
