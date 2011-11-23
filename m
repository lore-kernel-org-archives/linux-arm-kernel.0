From: plaes@plaes.org (plaes at plaes.org)
Date: Wed, 23 Nov 2011 16:26:57 +0200
Subject: [PATCH] ARM: mach-orion5x: Use hex2bin that is present in kernel lib
Message-ID: <1322058417.2472.9.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey!

I noticed there was some duplicate code under arm/mach-orion5x directory
so I ended up with a patch that uses existing library function present
in kernel code.

I regretfully have to admit that this patch is NOT even compile-tested,
but I hope that it still useful in case it happens to break something...

P?ikest,
Priit ;)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-mach-orion5x-Use-hex2bin-that-is-present-in-kern.patch
Type: text/x-patch
Size: 3160 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/fc6de17f/attachment.bin>
