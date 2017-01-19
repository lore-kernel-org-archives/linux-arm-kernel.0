From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 19 Jan 2017 03:24:35 +0000
Subject: [PATCHv4 1/5] clk: mvebu: support for 98DX3236 SoC
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-2-chris.packham@alliedtelesis.co.nz>
 <20170118222508.prn5xk63nuc3ocr7@rob-hp-laptop>
Message-ID: <e9cd1318dfe04d7ca3bad0e2073587d8@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/17 11:25, Rob Herring wrote:
> On Fri, Jan 13, 2017 at 10:12:16PM +1300, Chris Packham wrote:
>> The 98DX3236, 98DX3336, 98DX4521 and variants have a different TCLK from
>> the Armada XP (200MHz vs 250MHz). The CPU core clock is fixed at 800MHz.
>>
>> The clock gating options are a subset of those on the Armada XP.
>>
>> The core clock divider is different to the Armada XP also.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>
>> Notes:
>>     Changes in v2:
>>     - Update devicetree binding documentation for new compatible string
>>     Changes in v3:
>>     - Add 98dx3236 support to mvebu/clk-corediv.c rather than creating a new
>>       driver.
>>     - Document mv98dx3236-corediv-clock binding
>>     Changes in v4:
>>     - None
>>
>>  .../bindings/clock/mvebu-corediv-clock.txt         |  1 +
>>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |  1 +
>
> Please add acks when posting new versions.
>
> Acked-by: Rob Herring <robh@kernel.org>
>

Thanks Rob. I must have missed the earlier ack. Will be in v5.
