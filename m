From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Wed, 20 Nov 2013 00:45:05 +0000
Subject: [PATCH v2 0/4] 
In-Reply-To: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
References: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7046449C8@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -----Original Message-----
>> From: Karicheri, Muralidharan
>> Sent: Tuesday, November 19, 2013 7:43 PM
>> To: linux-arm-kernel at lists.infradead.org; mturquette at linaro.org; Shilimkar, Santosh; linux-
>> keystone at list.ti.com - Linux developers for Keystone family of devices (May contain non-
>> TIers)
>> Cc: Karicheri, Muralidharan
>> Subject: [PATCH v2 0/4]
>> 
>> This patch series add a K2HK (K2 Hawking/Kepler) EVM dts file and make some updates to
>> the existing dts files and Keystone PLL clk driver.
>> 
>> Murali Karicheri (4):
>>   clk: keystone: use clkod register bits for postdiv
>>   keystone: dts: add a k2hk-evm specific dts file
>>   keystone: dts: fix typo in the ddr3 pllclk node name
>>   keystone: dts: add paclk divider clock node
>> 
>>  .../devicetree/bindings/clock/keystone-pll.txt     |    8 +--
>>  arch/arm/boot/dts/k2hk-evm.dts                     |   55 ++++++++++++++++++++
>>  arch/arm/boot/dts/keystone-clocks.dtsi             |   36 ++++++-------
>>  arch/arm/boot/dts/{keystone.dts => keystone.dtsi}  |    2 -
>>  drivers/clk/keystone/pll.c                         |   24 +++++++--
>>  5 files changed, 96 insertions(+), 29 deletions(-)  create mode 100644
>> arch/arm/boot/dts/k2hk-evm.dts  rename arch/arm/boot/dts/{keystone.dts =>
>> keystone.dtsi} (98%)
>> 
>> --
>> 1.7.9.5

Will resend. Subject is missing.
