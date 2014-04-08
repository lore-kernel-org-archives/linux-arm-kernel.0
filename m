From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Apr 2014 09:54:46 +0200
Subject: Big endian working?
Message-ID: <20140408095446.0520dd28@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Taras,

I'm currently trying to get ARM BE to work on Armada XP. I'm pretty
sure it used to work on 3.13, but now I'm testing 3.13 and 3.14 and it
doesn't boot here (it hangs even before "Uncompressing kernel...",
apparently while relocating the kernel image before decompression).

Ben Dooks told me that the ARM BE kernel works for you. Can you confirm
which kernel version you're using, and if you've applied any patch?
Also, can you confirm which toolchain and toolchain version you're
using?

If needed, I'm on IRC, #armlinux on Freenode.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
