From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Wed, 16 Jun 2010 15:34:46 +0200
Subject: SSP and SA1111 misbehaving
Message-ID: <20100616133445.GA1124@boggieman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

Im having great difficulty deciding where the error exists, if its
inside kernel or bootloader.
What Im seeing is problems initializing hardware when using
Flashrom + U-boot + 2.6.32:
SA1111 fails to set trigger mode 3
SSP seems fine but doesnt work when trying to use it, it just times out.

Ive configured u-boot to essentially only configure memory
and standard booting policy (d-cache off, no irqs).

Grateful for any feedback/advice on this.

Best wishes
Kristoffer




-------------- next part --------------
A non-text attachment was scrubbed...
Name: dump.me
Type: application/x-troff-me
Size: 17039 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100616/7b43f6bf/attachment-0001.me>
