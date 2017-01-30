From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 30 Jan 2017 17:24:06 +0100
Subject: [PATCH v2 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170130134824.u37svxphyy266tzz@lukather>
References: <a4d90de597cfcfab5fddeeb538505774a980818b.1485180017.git-series.maxime.ripard@free-electrons.com>
 <20170127201913.jjhdw57jmxifqpxa@rob-hp-laptop>
 <20170130134824.u37svxphyy266tzz@lukather>
Message-ID: <2a5e7d0a-e2ca-5cc7-5193-96be5bfe494b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2017 02:48 PM, Maxime Ripard wrote:
> Hi Rob,
> 
> On Fri, Jan 27, 2017 at 02:19:13PM -0600, Rob Herring wrote:
>> On Mon, Jan 23, 2017 at 03:00:45PM +0100, Maxime Ripard wrote:
>>> The ARM Mali Utgard GPU family is embedded into a number of SoCs from
>>> Allwinner, Amlogic, Mediatek or Rockchip.
>>>
>>> Add a binding for the GPU of that family.
>>>
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>>
>>> ---
>>>
>>> Changes from v1:
>>>   - Dropped the arm,mali-utgard compatible
>>>   - Made the clocks mandatory
>>>   - Added Linus Walleij Reviewed-by, and the ST compatible for the Mali
>>> ---
>>>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 79 ++++++++-
>>>  1 file changed, 79 insertions(+), 0 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> new file mode 100644
>>> index 000000000000..ba0edcdd1b00
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> @@ -0,0 +1,79 @@
>>> +ARM Mali Utgard GPU
>>> +===================
>>> +
>>> +Required properties:
>>> +  - compatible
>>> +    * Must be one of the following:
>>> +      + "arm,mali-300"
>>> +      + "arm,mali-400"
>>> +      + "arm,mali-450"
>>> +    * And, optionally, one of the vendor specific compatible:
>>> +      + allwinner,sun4i-a10-mali
>>> +      + allwinner,sun7i-a20-mali
>>
>> And stericsson,db8500-mali?
> 
> Good catch, I'll add it.

I think you can safely add the following :

amlogic,meson-gxbb-mali
amlogic,meson-gxl-mali

Neil


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/7ef90662/attachment-0001.sig>
