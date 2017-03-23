From: cl@rock-chips.com (=?UTF-8?B?6ZmI5Lqu?=)
Date: Thu, 23 Mar 2017 10:15:20 +0800
Subject: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
In-Reply-To: <7240249b-690a-5800-0b46-fb93a49e2af1@arm.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-5-git-send-email-cl@rock-chips.com>
 <7240249b-690a-5800-0b46-fb93a49e2af1@arm.com>
Message-ID: <58D32FB8.9070909@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

? 2017?03?23? 02:09, Sudeep Holla ??:
>
> On 16/03/17 13:17, cl at rock-chips.com wrote:
>> From: Liang Chen <cl@rock-chips.com>
>>
>> This patch adds core dtsi file for Rockchip RK3328 SoCs.
>>
>> Signed-off-by: Liang Chen <cl@rock-chips.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1362 ++++++++++++++++++++++++++++++
>>   1 file changed, 1362 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> new file mode 100644
>> index 0000000..a92955c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> [...]
>
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +			clocks = <&cru ARMCLK>;
> Why "clocks" property is present only for cpu0 ?
>
I will add "clocks" property for each cpu node next version, thanks for 
the comment.
