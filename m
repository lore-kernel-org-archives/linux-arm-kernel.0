From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Mon, 22 Mar 2010 13:54:09 -0400
Subject: Can physical flash initramfs cpio address be given to bootm?
In-Reply-To: <20100322090854.GB10684@pengutronix.de>
References: <3d1967ab1003171209j43a9a005l4be5d2faf38fec31@mail.gmail.com>
	<20100319123616.GC21280@n2100.arm.linux.org.uk>
	<20100322090854.GB10684@pengutronix.de>
Message-ID: <3d1967ab1003221054l102b1638veb5d2086a07c681a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In my research it appears other ports allow this but patches have been
submitted to ARM kernel to keep from having to do a useless copy from
flash to RAM only to have the Kernel relocate the ramdisk yet again
... but the patches have not been accepted.

I can do it, it just appears like a wasted step that wastes time
booting a embedded system.

I'm currently investigating some of the patches that have been
submitted regarding this issue.

Regards,

Brian
