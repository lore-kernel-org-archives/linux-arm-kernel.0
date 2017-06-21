From: kevin.wangtao@hisilicon.com (Wangtao (Kevin, Kirin))
Date: Wed, 21 Jun 2017 10:10:08 +0800
Subject: [PATCH 1/3] dt-bindings: Document the hi3660 thermal sensor
 bindings
In-Reply-To: <5948F89F.3070005@hisilicon.com>
References: <1497930035-60894-1-git-send-email-kevin.wangtao@hisilicon.com>
 <5948F89F.3070005@hisilicon.com>
Message-ID: <9cccdaad-df22-0e4e-3c29-69d80e04832c@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



e
( 2017/6/20 18:27, Wei Xu ei:
> Hi Tao,
> 
> On 2017/6/20 4:40, Tao Wang wrote:
>> This adds documentation of device tree bindings for the
>> thermal sensor controller of hi3660 SoC.
>>
>> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
>> ---
>>   .../devicetree/bindings/thermal/hi3660-thermal.txt |   17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
>> new file mode 100644
>> index 0000000..c034670
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
>> @@ -0,0 +1,17 @@
>> +* Temperature Sensor on hisilicon hi3660 SoC
>> +
>> +** Required properties :
>> +
>> +- compatible: "hisilicon,thermal-hi3660".
> 
> It is better to put the SoC name before the function string.
ok, I will fix it, thank you.
> 
> BR,
> Wei
> 
>> +- reg: physical base address of thermal sensor and length of memory mapped
>> +  region.
>> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
>> +
>> +Example :
>> +
>> +	tsensor: tsensor {
>> +		compatible = "hisilicon,thermal-hi3660";
>> +		reg = <0x0 0xfff30000 0x0 0x1000>;
>> +		#thermal-sensor-cells = <1>;
>> +		status = "ok";
>> +	 };
>>
> 
> 
> .
> 
