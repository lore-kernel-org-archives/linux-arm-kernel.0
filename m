From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Nov 2017 12:30:27 -0700
Subject: Build failure with verify size in next-20171102
Message-ID: <20171102193027.GB28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russeell,

I think you're already aware of the build failure caused by commit
078c0927485e ("ARM: verify size of zImage"), but here's info just
in case.

arm-unknown-linux-musleabi-ld.bfd: error: zImage file size is incorrect
make[2]: *** [arch/arm/boot/compressed/Makefile:185: arch/arm/boot/compressed/vmlinux] Error 1
make[1]: *** [arch/arm/boot/Makefile:64: arch/arm/boot/compressed/vmlinux] Error 2
make: *** [arch/arm/Makefile:335: zImage] Error 2

Other than that I was surprised that next actually booted for me
after a few week break with Linux next! :)

Regards,

Tony
