From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 16 May 2018 20:58:35 +0000
Subject: [PATCH] pinctrl: mvebu: use correct MPP sel value for dev pins
References: <20180507022555.31645-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdbAaMrHJ8TjJTtNyVtoOSRAEf2Z8gRthFH0ze4RyybBag@mail.gmail.com>
Message-ID: <1ebc15b559d74ace9a1171548f79f978@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/18 00:55, Linus Walleij wrote:
> On Mon, May 7, 2018 at 4:25 AM, Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> 
>> The "dev" function is selected with the value 0x4 not 0x01.
>>
>> Fixes: commit d7ae8f8dee7f ("pinctrl: mvebu: pinctrl driver for 98DX3236 SoC")
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> Patch applied.
> 
> Does it need to go into fixes? Stable?

By "fixes" do you mean into 4.17? Yes please.

Stable would be good. Although all the boards I'm aware of rely on the 
pin configuration being done by the bootloader so I've not heard of 
anyone experiencing problems.
