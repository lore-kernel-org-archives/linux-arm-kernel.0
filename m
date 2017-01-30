From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 30 Jan 2017 22:02:38 +0000
Subject: [PATCH v6 5/5] arm: mvebu: Add device tree for db-dxbc2 and
 db-xc3-24g4xg boards
References: <20170129232035.25189-1-chris.packham@alliedtelesis.co.nz>
 <20170129232035.25189-6-chris.packham@alliedtelesis.co.nz>
 <87vaswtycu.fsf@free-electrons.com>
Message-ID: <25e75991d565411fa9bccb6d2f71babf@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 31/01/17 03:29, Gregory CLEMENT wrote:
> Hi Chris,
>
>  On lun., janv. 30 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>
>> These boards are Marvell's evaluation boards for the 98DX4251 and
>> 98DX3336 SoCs.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>
> Applied on mvebu/dt
>

I just noticed that I hadn't updated arch/arm/boot/dts/Makefile. The way 
I've been building things (explicitly running 'make 
armada-xp-db-xc3-24g4xg.dtb') it hasn't mattered to me but I'm wondering 
if I should have?

>> ---
>>
>> Notes:
>>     Changes in v5:
>>     - update license text
>>     - use node labels
>>     Changes in v6:
>>     - Rename dts files to include 'armada-xp-' prefix
>>
>>  arch/arm/boot/dts/armada-xp-db-dxbc2.dts      | 151 ++++++++++++++++++++++++++
>>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 142 ++++++++++++++++++++++++
>>  2 files changed, 293 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/armada-xp-db-dxbc2.dts
>>  create mode 100644 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
>>
