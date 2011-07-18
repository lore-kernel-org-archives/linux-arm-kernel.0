From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Jul 2011 16:08:02 +0000
Subject: [GIT PULL] ARM: make mach/hardware.h optional
In-Reply-To: <4E20EE96.6020500@gmail.com>
References: <4E20EE96.6020500@gmail.com>
Message-ID: <201107181608.02697.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 July 2011, Rob Herring wrote:
> Here's the hardware.h clean-up in a git tree if you prefer to pull it.
> 
> git://git.jdl.com/software/linux-3.0.git for-arm-soc
> 
> The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:
> 
>   Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)
> 
> are available in the git repository at:
>   git://git.jdl.com/software/linux-3.0.git for-arm-soc
> 
> Rob Herring (6):
>       powerpc: rename ppc_pci_*_flags to pci_*_flags
>       pci: move microblaze and powerpc pci flag functions into asm-generic
>       ARM: remove unnecessary mach/hardware.h includes
>       ARM: pci: make pcibios_assign_all_busses use pci_has_flag
>       ARM: convert PCI defines to variables
>       ARM: set vga memory base at run-time

Ok, pulled into next/cross-platform.

Thanks!

	Arnd
