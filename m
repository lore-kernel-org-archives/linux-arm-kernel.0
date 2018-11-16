From: valdis.kletnieks@vt.edu (valdis.kletnieks at vt.edu)
Date: Fri, 16 Nov 2018 11:46:18 -0500
Subject: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu>
 <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu>
 <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
Message-ID: <5997.1542386778@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018 20:10:28 +0530, Pintu Agarwal said:

> > Look at the code controlled by '#ifdef CONFIG_DEBUG_STACK_USAGE'

> For example: is it possible to keep storing the irq_stack_usage (for
> each cpu in a variable) information from boot time, and then use this
> variable to dump the irq_stack information, after the system booted,
> may be from proc entry ?

Congrats. You just re-invented DEBUG_STACK_USAGE, which just keeps a high-water mark
for stack usage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 486 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/b7037c0c/attachment.sig>
