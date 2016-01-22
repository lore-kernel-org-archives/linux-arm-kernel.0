From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Fri, 22 Jan 2016 16:59:01 +0800
Subject: [PATCH V3 1/3] arm64: dts: Add Hi6220 gpio configuration nodes
In-Reply-To: <569E3C0F.3040603@arm.com>
References: <1453200681-26406-1-git-send-email-zhongkaihua@huawei.com>
 <569E3C0F.3040603@arm.com>
Message-ID: <56A1EF55.5000909@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/19 21:37, Sudeep Holla wrote:
> 
> 
> On 19/01/16 10:51, Zhong Kaihua wrote:
>> arm64: dts: Add Hi6220 gpio configuration nodes
>>
>> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
>>                 Kong Xinwei <kong.kongxinwei@hisilicon.com>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/gpio/gpio-hi6220.txt       |  23 +
>>   arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   1 +
>>   arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 259 +++++++++
>>   arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi      | 607 +++++++++++++++++++++
>>   4 files changed, 890 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-hi6220.txt
>>   create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt b/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt
>> new file mode 100644
>> index 0000000..a9cbf21
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-hi6220.txt
>> @@ -0,0 +1,23 @@
>> +Hisilicon Hi6220 GPIO controller bindings
>> +
>> +Required properties:
>> +    - compatible: "arm,pl061","arm,primecell"
>> +    - gpio-controller: Marks the device node as a GPIO controller.
>> +    - #gpio-cells: Should be 2. See gpio.txt in this directory for a
>> +         description of    the cells format.
>> +    - interrupt-controller: Mark the device node as an interrupt controller
>> +
> 
> Why do you need extra binding document here as the compatible is same as
> [1] ? You can extend that if required and add example there IMO.
> 

Ok, I will remove the binding document in the next version. Thanks.
