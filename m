From: balbi@ti.com (Felipe Balbi)
Date: Tue, 11 Sep 2012 08:51:08 +0300
Subject: [PATCH 05/17] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
In-Reply-To: <20120911053052.29637.74323.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
 <20120911053052.29637.74323.stgit@muffinssi.local>
Message-ID: <20120911055106.GA17865@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 10, 2012 at 10:30:53PM -0700, Tony Lindgren wrote:
> We can't use hardcoded interrupts for SPARSE_IRQ, and can replace
> the hardcoded gpio_base with twl_gpiochip.base after it's been
> allocated.

not related to $SUBJECT, but ideally we would also have SPARSE_GPIO
kinda thing to avoid this sort of issues. I have tried starting that
work, but ran out of steam/time...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/1409262a/attachment.sig>
