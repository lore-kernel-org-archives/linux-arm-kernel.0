From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 1 Nov 2016 18:48:42 +0100
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161101153326.GA6193@obsidianresearch.com>
References: <20161028154740.GC10441@obsidianresearch.com>
 <5ea0e77e-11c5-b4f7-00a9-9c5425ffac5a@suse.com>
 <20161028165555.GA17998@obsidianresearch.com>
 <20161028182308.GB18325@live.com>
 <20161028202619.GA29625@obsidianresearch.com>
 <20161028210015.GA19901@live.com>
 <20161028220546.GA19693@obsidianresearch.com>
 <20161029000926.GA30169@live.com>
 <20161031162327.GA28817@obsidianresearch.com>
 <7117d821-a1b1-7c07-806a-483be99131e6@xilinx.com>
 <20161101153326.GA6193@obsidianresearch.com>
Message-ID: <4e2c7e1c-7c33-a552-5b91-dbdefac58e37@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1.11.2016 16:33, Jason Gunthorpe wrote:
> On Tue, Nov 01, 2016 at 07:39:22AM +0100, Michal Simek wrote:
> 
>> Regarding BIT and BIN format. This support is in vivado for a long time
>> and it is up2you what you want to support. We have removed that BIT
>> support and not doing any swap by saying only BIN format is supported.
> 
> BIN is not supported, it needs a swap as well.
> 
> Moritz has it right, you have to use vivado to create a PROM image to be
> compatible with the driver.

hm than that's bad.

Thanks,
Michal
