From: elder@linaro.org (Alex Elder)
Date: Mon, 07 Apr 2014 08:25:33 -0500
Subject: drivers/clk/bcm/clk-bcm281xx.c breaks on GCC 4.6.4 (and earlier)
In-Reply-To: <20140407092609.GY7528@n2100.arm.linux.org.uk>
References: <20140407092609.GY7528@n2100.arm.linux.org.uk>
Message-ID: <5342A74D.4030303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 04:26 AM, Russell King - ARM Linux wrote:
> So this greeted me this morning...

Russell, can you try the attached patch to verify it resolves
your errors?  If so I'll send it to Linus as an urgent update.

					-Alex

> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'offset' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'shift' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'frac_width' specified in initializer
> drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'scaled_div' specified in initializer

. . .


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-clk-bcm281xx-don-t-use-unnamed-structs-or-unions.patch
Type: text/x-patch
Size: 14869 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/28e91706/attachment.bin>
