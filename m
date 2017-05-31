From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 31 May 2017 14:05:07 +0200
Subject: [PATCH v4 1/2] dt-bindings: i2c: Add Mediatek MT2701 i2c binding
In-Reply-To: <1496197469.930.17.camel@mhfsdcap03>
References: <1495784107-6711-1-git-send-email-jun.gao@mediatek.com>
 <1495784107-6711-2-git-send-email-jun.gao@mediatek.com>
 <1d073e6a-e275-24e1-7954-f1af913bd03b@gmail.com>
 <20170530213828.pxmexdzfv6u5db6m@rob-hp-laptop>
 <1496197469.930.17.camel@mhfsdcap03>
Message-ID: <ab1e1baf-a30f-97e1-e232-d479eaf52acc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31/05/17 04:24, Jun Gao wrote:
> On Tue, 2017-05-30 at 16:38 -0500, Rob Herring wrote:
>> On Mon, May 29, 2017 at 05:30:26PM +0200, Matthias Brugger wrote:
>> g>
>>>
>>> On 26/05/17 09:35, Jun Gao wrote:
>>>> From: Jun Gao <jun.gao@mediatek.com>
>>>>
>>>> Add MT2701 i2c binding to i2c-mt6577.txt and there is no need to
>>>> modify i2c driver.
>>>>
>>>> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/i2c/i2c-mt6577.txt | 11 ++++++-----
>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
>>>> index 0ce6fa3..52f2023 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
>>>> @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
>>>>    Required properties:
>>>>      - compatible: value should be either of the following.
>>>> -      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
>>>> -      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
>>>> -      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
>>>> -      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
>>>> -      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
>>>> +	"mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek MT2701
>>>
>>> I send a cleanup patch for the file, which fixes all the other SoCs.
>>> I can fold this one into it, a soon as I got a Signed-off from the DT
>>> maintainers.
>>
>> I already acked it on the prior versions.
>>
>> Rob
> 
> Hi Matthias,
> 
> Which patch should I use now? Or you help to modify dt-binding, I only
> send dtsi file patch ?  Thanks!
> 

Don't worry, I fixed the commit and took both of them.
