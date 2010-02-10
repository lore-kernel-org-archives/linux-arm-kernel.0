From: bradshaw.laurie@googlemail.com (Laurie Bradshaw)
Date: Wed, 10 Feb 2010 16:10:43 +0000
Subject: [PATCH] mach-orion5x: D-link DNS-323 revision A1 power LED
Message-ID: <369e77651002100810w13bbfbcbg2931895504e28b69@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the power LED on DNS-323 revision A1, and adds timer
support for (hopefully) both A1 and B1 revisions.

Power LED on revision A1 is active low and also requires GPIO 4 to be
low to work.

Tested on my DNS-323 revision A1.

I have set the default trigger to timer as that replicates the
behaviour of the original firmware, userspace can change the trigger
at the end of the boot process providing a useful indication that
booting has completed.

--
Laurie Bradshaw
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dns323-power-led.patch
Type: text/x-diff
Size: 2095 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100210/9005b3da/attachment.bin>
