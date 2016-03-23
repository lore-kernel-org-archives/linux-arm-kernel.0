From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 23 Mar 2016 09:37:58 +0100
Subject: [PATCH v2 16/18] dt-bindings: Add OXNAS bindings
In-Reply-To: <20160317172738.GA7293@rob-hp-laptop>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-17-git-send-email-narmstrong@baylibre.com>
 <20160317172738.GA7293@rob-hp-laptop>
Message-ID: <56F255E6.2030905@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2016 06:27 PM, Rob Herring wrote:
> On Wed, Mar 09, 2016 at 11:24:18AM +0100, Neil Armstrong wrote:
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/arm/oxnas.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
>> new file mode 100644
>> index 0000000..f6032d2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/oxnas.txt
>> @@ -0,0 +1,9 @@
>> +PLX Technology OXNAS SoCs Family device tree bindings
>> +-------------------------------------------
>> +
>> +Boards with the OX810SE Soc SoC shall have the following properties:
> 
> s/Soc SoC/SoC/

OK
> 
>> +  Required root node property:
>> +    compatible: "oxsemi,ox810se"
>> +
>> +Board compatible values:
>> +  - "wd,mbwe" (OX810SE)
> 
> Seems kind of generic. Only one version?

There is a My Book World Edition II, which seems to be the same (they share the same firmware) but with two SATA ports, the original kernel does not make any differences between the two models.

I'm not aware of different versions and the firmware does not contain any specific code for different board revisions.

Neil
