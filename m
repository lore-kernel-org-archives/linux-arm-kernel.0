From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Mon, 7 Dec 2015 09:29:59 +0800
Subject: [PATCH RESEND net-next 3/3] arm64: hip05-d02: Document devicetree
 bindings for Hisilicon D02 Board
In-Reply-To: <2441219.omPQqZs8vd@wuerfel>
References: <1449302218-54374-1-git-send-email-yankejian@huawei.com>
 <1449302218-54374-4-git-send-email-yankejian@huawei.com>
 <2441219.omPQqZs8vd@wuerfel>
Message-ID: <5664E117.6060105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/6 6:13, Arnd Bergmann wrote:
> On Saturday 05 December 2015 15:56:58 yankejian wrote:
>> +Required properties:
>> +- compatible : "hisilicon,peri-c-subctrl", "syscon";
>> +- reg : Register address and size
>> +
>> +The HiP05 PERISUB system controller is shared by peripheral controllers in
>> +HiP05 Soc to implement some basic configurations. the peripheral
>> + controllers include mdio, ddr, iic, uart, timer and so on.
>> +
>> +Example:
>> +       /* for HiP05 PCIe-SAS system */
>> +       pcie_sas: system_controller at 0xb0000000 {
>> +               compatible = "hisilicon,pcie-sas-subctrl", "syscon";
>> +               reg = <0xb0000000 0x10000>;
>> +       };
>>
> The compatible string in the example does not match the required properties.
>
> 	Arnd
>
> .
Hi, Arnd
Thanks for your suggestions. i will fixes it later.
