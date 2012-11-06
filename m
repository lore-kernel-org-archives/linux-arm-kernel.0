From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2012 17:57:49 +0000
Subject: BUG: ARM build failures due to Xen
Message-ID: <20121106175749.GO28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My build system is giving me the following errors against an OMAP4
randconfig build against the latest Linus' kernel plus arm-soc:

ERROR: "privcmd_call" [drivers/xen/xen-privcmd.ko] undefined!
make[2]: *** [__modpost] Error 1
make[2]: Target `_modpost' not remade because of errors.
make[1]: *** [modules] Error 2
make: *** [sub-make] Error 2
make: Target `uImage' not remade because of errors.
make: Target `modules' not remade because of errors.

Full build results and configuration are here:

http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=2627
http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2627
