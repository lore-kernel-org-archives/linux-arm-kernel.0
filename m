From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 15 Nov 2018 17:43:10 +0100
Subject: [PATCH 1/4] dt-bindings: pwm: update bindings for MT7629 SoC
In-Reply-To: <1542263704.7928.2.camel@mtkswgap22>
References: <1dc7b27cbad59c413d7076ff7d16b6757014d727.1542262833.git.ryder.lee@mediatek.com>
 <1542263704.7928.2.camel@mtkswgap22>
Message-ID: <b96ef8a5-ea09-2d24-23a1-ca9192e29ab5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/11/2018 07:35, Ryder Lee wrote:
> On Thu, 2018-11-15 at 14:26 +0800, Ryder Lee wrote:
>> This updates bindings for MT7629 pwm controller.
>>
>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>> index 991728c..4a2885b 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>> @@ -6,6 +6,7 @@ Required properties:
>>     - "mediatek,mt7622-pwm": found on mt7622 SoC.
>>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>> +   - "mediatek,mt7629-pwm": found on mt7629 SoC.
>>   - reg: physical base address and length of the controller's registers.
>>   - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
>>     the cell format.
> 
> Please ignore this PWM patch. Sorry for the inconvenience :(
> 

Right, this would at least need a fallback compatible :)

Regards,
Matthias
