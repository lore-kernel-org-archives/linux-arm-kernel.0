From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 31 Jan 2017 11:17:28 +0100
Subject: [PATCH v2 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170131095622.ew56cyjrndu6wxwe@lukather>
References: <a4d90de597cfcfab5fddeeb538505774a980818b.1485180017.git-series.maxime.ripard@free-electrons.com>
 <20170127201913.jjhdw57jmxifqpxa@rob-hp-laptop>
 <20170130134824.u37svxphyy266tzz@lukather>
 <2a5e7d0a-e2ca-5cc7-5193-96be5bfe494b@baylibre.com>
 <20170131095622.ew56cyjrndu6wxwe@lukather>
Message-ID: <98b3515d-a2fd-67d4-e9c9-ad58e614363f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2017 10:56 AM, Maxime Ripard wrote:
> On Mon, Jan 30, 2017 at 05:24:06PM +0100, Neil Armstrong wrote:
>>>>> @@ -0,0 +1,79 @@
>>>>> +ARM Mali Utgard GPU
>>>>> +===================
>>>>> +
>>>>> +Required properties:
>>>>> +  - compatible
>>>>> +    * Must be one of the following:
>>>>> +      + "arm,mali-300"
>>>>> +      + "arm,mali-400"
>>>>> +      + "arm,mali-450"
>>>>> +    * And, optionally, one of the vendor specific compatible:
>>>>> +      + allwinner,sun4i-a10-mali
>>>>> +      + allwinner,sun7i-a20-mali
>>>>
>>>> And stericsson,db8500-mali?
>>>
>>> Good catch, I'll add it.
>>
>> I think you can safely add the following :
>>
>> amlogic,meson-gxbb-mali
>> amlogic,meson-gxl-mali
> 
> Ack. Do you need any extra properties?
> 
> Maxime
> 

Hi Maxime,

No, it's ok with the generic properties, there is not reset lines for mali on Meson GX SoCs.

Neil

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/e19f7f86/attachment.sig>
