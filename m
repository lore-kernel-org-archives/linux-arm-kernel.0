From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 8 Feb 2017 20:00:15 +0000
Subject: [PATCH 4/4] clk: mvebu: Expand mv98dx3236-core-clock support
References: <20170203034012.29399-1-chris.packham@alliedtelesis.co.nz>
 <5a974d9d7260432087619486bf5d79ed@svr-chch-ex1.atlnz.lc>
 <6149d4126a214ac8b0b0184bd818bea6@svr-chch-ex1.atlnz.lc>
 <9294933.cXSW0amFbE@wuerfel>
Message-ID: <aabc6853d7934507a4507b0ad4354b72@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/17 23:53, Arnd Bergmann wrote:
> On Tuesday, February 7, 2017 3:07:37 AM CET Chris Packham wrote:
>>>
>>> Actually I wonder if I can try a bit harder to keep a system booting.
>>> The following might work
>>> 1) add the compatible strings to the existing armada clock drivers.
>>> 2) update the dts to use the new compatible strings.
>>> 3) add the new driver and remove the compatible strings from the armada
>>> drivers.
>>>
>>> #1 would still upset checkpatch.pl because the documentation would only
>>> arrive in #2.
>>
>> Actually upon testing #1 is unnecessary. I lose some of the gated clocks
>> but nothing that prevents booting.
>
> Just to be sure: this means we can merge 2) and 3) independently and
> having just one of them will not cause regressions over what we have
> today?
>

Correct. And that's what I sent out as v2.

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/486467.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/486471.html
