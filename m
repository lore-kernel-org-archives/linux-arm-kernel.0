From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Aug 2017 14:12:26 +0200
Subject: [PATCH] irqchip/armada-370-xp: Enable MSI-X support
In-Reply-To: <0b8b249b-255a-6354-69cd-58f44fa7874d@denx.de>
References: <20170502072600.13380-1-sr@denx.de>
 <80f30724-20b6-b5a7-7218-93ff3fa23177@denx.de>
 <20170815160109.023842de@windsurf>
 <6a3e8bcc-19ef-cef1-180e-f4e194d5589b@denx.de>
 <0b8b249b-255a-6354-69cd-58f44fa7874d@denx.de>
Message-ID: <20170818141226.77e5719d@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 18 Aug 2017 12:18:28 +0200, Stefan Roese wrote:


> >>> Its been a while since this patch has been submitted - without any
> >>> comments so far. What's the current status with it? Is it someones
> >>> queue for upstreaming?  
> >>
> >> Sorry for the lack of feedback, very good idea to ping me on this
> >> topic. I don't have access to HW right now, so I can't give it a test.
> >> However, I don't think I have MSI-X capable hardware, only MSI capable.
> >>
> >> With which hardware did you test this? An off-the-shell PCIe card, or
> >> some custom FPGA logic?  
> > 
> > I tested this code with some Altera / Intel FPGA using their PCI-Express
> > IP core. It should be possible to test this with some MSI-X capable
> > desktop PCIe cards as well on AXP boards equipped with PCIe slots,
> > like the Marvell AXP development board (orange box).  
> 
> So what do you think about this patch? Can I get your Acked-by /
> Reviewed-by, or do you have some objections? Or do plan to first do
> some tests yourself?

I thought about testing it myself, but since I don't have any MSI-X
capable device, I'm not sure it would bring a lot.

Therefore:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
