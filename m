From: faiz_abbas@ti.com (Faiz Abbas)
Date: Mon, 4 Jun 2018 11:19:10 +0530
Subject: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
In-Reply-To: <152792116258.225090.5279546677198775320@swboyd.mtv.corp.google.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
 <152792116258.225090.5279546677198775320@swboyd.mtv.corp.google.com>
Message-ID: <19b3fa0b-ae8a-96d8-1a08-850d85a9ae74@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 02 June 2018 12:02 PM, Stephen Boyd wrote:
> Quoting Faiz Abbas (2018-05-30 07:11:32)
>> diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
>> index bfc82636999c..57b8dc0fe719 100644
>> --- a/arch/arm/boot/dts/dra76x.dtsi
>> +++ b/arch/arm/boot/dts/dra76x.dtsi
>> @@ -11,6 +11,25 @@
>>  / {
>>         compatible = "ti,dra762", "ti,dra7";
>>  
>> +       ocp {
>> +
>> +               target-module at 0x42c00000 {
> 
> Drop the 0x on unit address. Also, it should match the first register
> property. And what is a "target-module"?
> 

Will fix it. And please see
Documentation/devicetree/bindings/bus/ti-sysc.txt


Thanks,
Faiz
