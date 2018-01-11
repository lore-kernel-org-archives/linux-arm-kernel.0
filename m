From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 11 Jan 2018 20:06:01 +0000
Subject: [PATCH v2 0/3] ARM: mvebu: dts: updates to enable EDAC
References: <20180111015903.11322-1-chris.packham@alliedtelesis.co.nz>
 <87a7xk7o5t.fsf@free-electrons.com>
Message-ID: <d2460bc23c4d4ff2adbd05821e86aea9@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/18 22:14, Gregory CLEMENT wrote:
> Hi Chris,
>   
>   On jeu., janv. 11 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> 
>> I've split this off from my earlier series[1] this is just the dts changes that
>> will enable support for the EDAC series when it lands.
>>
>> The Armada 38x as well as the 98dx3236 and similar switch chips with integrated
>> CPUs use the same SDRAM controller block as the Armada XP. The key difference
>> is the width of the DDR interface.
>>
>> [1] - https://marc.info/?l=linux-kernel&m=151545124505964&w=2
> 
> The series is looks good now. For patch 1 I still wait for that
> the "marvell,,ecc-enable" property was accepted before merging it.
> 
> So I can either wait for that it was accepted before applying the series,
> or just applying patch 2 and 3 for now, as you want.

I'm happy either way. If it's easier for you to keep the 3 patches 
together that's fine by me.

> 
> Thanks,
> 
> Gregory
> 
> 
>>
>> Changes in v2:
>> - update commit message
>> - add labels to dts
>>
>> Chris Packham (3):
>>    ARM: dts: armada-xp: enable L2 cache parity and ecc on db-xc3-24g4xg
>>    ARM: dts: armada-xp: add label to sdram-controller node
>>    ARM: dts: mvebu: add sdram controller node to Armada-38x
>>
>>   arch/arm/boot/dts/armada-38x.dtsi             | 5 +++++
>>   arch/arm/boot/dts/armada-xp-98dx3236.dtsi     | 2 +-
>>   arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
>>   arch/arm/boot/dts/armada-xp.dtsi              | 2 +-
>>   4 files changed, 12 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.15.1
>>
> 
