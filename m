From: dmurphy@ti.com (Murphy, Dan)
Date: Thu, 21 Aug 2014 18:30:40 +0000
Subject: [PATCH 1/2] doc: dt/bindings: input: introduce TI DRV2667
 haptic driver description
References: <1408645143-25690-1-git-send-email-dmurphy@ti.com>
 <1408645143-25690-2-git-send-email-dmurphy@ti.com>
 <53F63A68.1080002@cogentembedded.com>
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49DF0933@DFLE09.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei

On 08/21/2014 01:29 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/21/2014 10:19 PM, Dan Murphy wrote:
> 
>> DRV2667 is a haptic/vibrator driver for Linear Resonant Actuators.
>> Adding dt binding for this part
> 
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../devicetree/bindings/input/ti,drv2667.txt       |   18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/input/ti,drv2667.txt
> 
>> diff --git a/Documentation/devicetree/bindings/input/ti,drv2667.txt b/Documentation/devicetree/bindings/input/ti,drv2667.txt
>> new file mode 100644
>> index 0000000..525216d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/ti,drv2667.txt
>> @@ -0,0 +1,18 @@
>> +Texas Instruments - drv2667 Haptics driver
>> +
>> +The drv2667 uses serial control bus communicates through I2C protocols
> 
>     I can't parse that.
> 

Hmmm.. It made sense when I typed it.  Will fix

>> +
>> +Required properties:
>> +	- compatible - "ti,drv2667" - DRV2667
>> +	- reg -  I2C slave address
>> +	- vbat-supply - Required supply regulator
>> +
>> +Example:
>> +
>> +drv2667: drv2667 at 59 {
>> +		compatible = "ti,drv2667";
>> +		reg = <0x59>;
> 
>     You say "vbat-supply" is mandatory, yet you don't have it in your example?

I will add this as well.

> 
> WBR, Sergei
> 
> 


-- 
------------------
Dan Murphy
