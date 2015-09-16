From: eric@anholt.net (Eric Anholt)
Date: Wed, 16 Sep 2015 10:02:32 -0400
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <20150914143459.GN21084@n2100.arm.linux.org.uk>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <87d1zj6fq2.fsf@eliezer.anholt.net> <55F5CD80.3020700@tronnes.org>
 <20150914090853.GF21084@n2100.arm.linux.org.uk>
 <87wpvtjcka.fsf@eliezer.anholt.net>
 <20150914143459.GN21084@n2100.arm.linux.org.uk>
Message-ID: <87613a31jb.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Sep 14, 2015 at 07:33:09AM -0700, Eric Anholt wrote:
>> So, while FIQ isn't used in upstream, I think it's worthwhile to merge.
>> It is another step to bringing the downstream developers into the fold.
>
> I want to see the code _first_.  Until then, I'm sorry, this patch can't
> go in.

If you just want to see "Yes, GPL-compatible code using this is
available", then that is:

https://github.com/raspberrypi/linux/blob/rpi-4.1.y/drivers/usb/host/dwc_otg/dwc_otg_fiq_stub.S
https://github.com/raspberrypi/linux/blob/rpi-4.1.y/drivers/usb/host/dwc_otg/dwc_otg_fiq_fsm.c

If not, I'm curious what exactly is the reason the patch can't go in.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150916/db54ec0e/attachment-0001.sig>
