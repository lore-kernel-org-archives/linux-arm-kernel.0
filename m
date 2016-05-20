From: sf84@laposte.net (Sebastian Frias)
Date: Fri, 20 May 2016 16:28:23 +0200
Subject: Sharing code between Linux and bootloader (U-boot) ?
Message-ID: <573F1F07.6040202@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some bootloaders (like U-boot) support several HW devices: serial, network, NAND, USB, etc. most of which are also supported by Linux.

So the question is: is code shared? I mean, I understand that the drivers need to talk to the appropriate API, and such API could be different between Linux and U-boot.
But putting that aside, would it be naive to imagine that some "core" functionality could be shared? Or would that part be so small it is not worth the effort?

Since many companies use both, U-boot and Linux, I would figure they try their best to optimize engineering resources and share code, right?
In that case, I also wonder how do they share DT descriptions that right now are being stored in the Linux kernel tree.

We'd like to share code/DT for obvious reasons, what would you guys suggest?

Best regards,

Sebastian
