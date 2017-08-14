From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 14 Aug 2017 16:03:45 +0200
Subject: [PATCH 8/8] gpio: zynq: Fix driver function parameters alignment
In-Reply-To: <CACRpkdbMRgR3=dNpKJMC+vm=DPK6ay9bjMATtKLmxapvAkrTjw@mail.gmail.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <67e187a3dbc2ef8b6bacd1b173ae9e91c18aa429.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdbMRgR3=dNpKJMC+vm=DPK6ay9bjMATtKLmxapvAkrTjw@mail.gmail.com>
Message-ID: <7d741f71-2e7b-35b4-1c73-729896811b7e@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.8.2017 16:01, Linus Walleij wrote:
> On Mon, Aug 7, 2017 at 1:02 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> Fix function parameters alignment reported by checkpatch.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Patch applied.
> 
> Now you just need to rebase and figure out the two patches
> I had comments on.

Looking at that. That level one first and then the irq one.
This came from 3rd party that's why it will require some time to look at it.

Thanks,
Michal
