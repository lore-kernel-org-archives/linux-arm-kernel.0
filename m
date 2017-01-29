From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 29 Jan 2017 20:30:34 +0000
Subject: [PATCHv5 0/5] Support for Marvell switches with integrated CPUs
References: <20170127032546.14657-1-chris.packham@alliedtelesis.co.nz>
 <87wpdgwj72.fsf@free-electrons.com> <20170127184745.GD8801@codeaurora.org>
Message-ID: <f8f6e8db585147d3adb025bed29694ab@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/17 07:47, Stephen Boyd wrote:
> On 01/27, Gregory CLEMENT wrote:
>> Hi all,
>>
>>  On ven., janv. 27 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>>
>>> The 98DX3236, 98DX3336 and 98DX4251 are a set of switch ASICs with
>>> integrated CPUs. They CPU block is common within these product lines and
>>> (as far as I can tell/have been told) is based on the Armada XP. There
>>> are a few differences due to the fact they have to squeeze the CPU into
>>> the same package as the switch.
>>>
>>> I've rebased this series against linux-pinctrl/devel to get access to
>>> mvebu_mmio_mpp_ctrl. Everything else still applies cleanly to
>>> v4.10.0-rc5.
>>
>> Just to let you know that I plan to apply the 3 arm patch once Chris
>> will have sent the new series with the minor fixes I asked on patch 3.
>>
>> I already applied them in the for-next branch to benefit of some build
>> test coverage.
>>
>> Stephen,
>>
>> you gave your Acked-by on the first patch, but don't you plan to apply
>> it on the clk branch?
>
> It must have not been clear if I should apply it, hence the ack.
> I'll apply it now.
>

Sorry my bad. I need all 5 together in one place to actually test the 
series.

I wasn't sure whether the series should go through mvebu with Acks from 
clk and pinctrl or if things should go to the separate maintainers and 
come together when they hit the main linux repo. Up until the latest 
pinctrl change either approach would have worked.
