From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Jan 2017 12:05:59 +0100
Subject: [PATCH v6 5/5] arm: mvebu: Add device tree for db-dxbc2 and
 db-xc3-24g4xg boards
In-Reply-To: <25e75991d565411fa9bccb6d2f71babf@svr-chch-ex1.atlnz.lc> (Chris
 Packham's message of "Mon, 30 Jan 2017 22:02:38 +0000")
References: <20170129232035.25189-1-chris.packham@alliedtelesis.co.nz>
 <20170129232035.25189-6-chris.packham@alliedtelesis.co.nz>
 <87vaswtycu.fsf@free-electrons.com>
 <25e75991d565411fa9bccb6d2f71babf@svr-chch-ex1.atlnz.lc>
Message-ID: <877f5b1obs.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On lun., janv. 30 2017, Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> Hi Gregory,
>
> On 31/01/17 03:29, Gregory CLEMENT wrote:
>> Hi Chris,
>>
>>  On lun., janv. 30 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>>
>>> These boards are Marvell's evaluation boards for the 98DX4251 and
>>> 98DX3336 SoCs.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>
>> Applied on mvebu/dt
>>
>
> I just noticed that I hadn't updated arch/arm/boot/dts/Makefile. The way 
> I've been building things (explicitly running 'make 
> armada-xp-db-xc3-24g4xg.dtb') it hasn't mattered to me but I'm wondering 
> if I should have?

As I didn't make a Pull request yet, I was able to fix it on the fly.

Gregory

>
>>> ---
>>>
>>> Notes:
>>>     Changes in v5:
>>>     - update license text
>>>     - use node labels
>>>     Changes in v6:
>>>     - Rename dts files to include 'armada-xp-' prefix
>>>
>>>  arch/arm/boot/dts/armada-xp-db-dxbc2.dts      | 151 ++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 142 ++++++++++++++++++++++++
>>>  2 files changed, 293 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/armada-xp-db-dxbc2.dts
>>>  create mode 100644 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
>>>
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
