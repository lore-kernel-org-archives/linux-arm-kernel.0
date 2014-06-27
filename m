From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 27 Jun 2014 09:55:51 +0200
Subject: [PATCH v5 12/14] clk: max77802: Add DT binding documentation
In-Reply-To: <53AD22D0.9000403@suse.de>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403806546-31122-13-git-send-email-javier.martinez@collabora.co.uk>
 <53AD22D0.9000403@suse.de>
Message-ID: <53AD2387.5090704@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andres,

Thanks a lot for your feedback.

On 06/27/2014 09:52 AM, Andreas F?rber wrote:
> Am 26.06.2014 20:15, schrieb Javier Martinez Canillas:
>> Add Device Tree binding documentation for the clocks
>> outputs in the Maxim 77802 Power Management IC.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>> 
>> Changes since v4: None
>> 
>> Changes since v3:
>>  - Don't use the same clock driver name in clock-names since it's a consumer
>>    concept and most probably will be different. Suggested by Doug Anderson.
>> 
>> Changes since v2:
>>  - Split the DT binding documentation in a separate patch.
>> 
>>  .../devicetree/bindings/clock/maxim,max77802.txt   | 42 ++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/maxim,max77802.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/maxim,max77802.txt b/Documentation/devicetree/bindings/clock/maxim,max77802.txt
>> new file mode 100644
>> index 0000000..26bc4f7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/maxim,max77802.txt
>> @@ -0,0 +1,42 @@
>> +Binding for Maxim MAX77802 32k clock generator block
>> +
>> +This is a part of device tree bindings of MAX77802 multi-function device.
>> +More information can be found in bindings/mfd/max77802.txt file.
>> +
>> +The MAX77802 contains two 32.768khz clock outputs that can be controlled
>> +(gated/ungated) over I2C.
>> +
>> +Following properties should be presend in main device node of the MFD chip.
> 
> "present"
>

Right, it's a typo. I'll wait for further feedback and will fix both issues you
pointed out in the next version of the series.

> Regards,
> Andreas
> 

Best regards,
Javier
