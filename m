From: oferh@marvell.com (Ofer Heifetz)
Date: Wed, 20 Jan 2010 22:39:04 +0200
Subject: Linux kernel crash dumps for ARM
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E8A745A68FB3@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am trying to get kexec/kdump work on ARMv5 2.6.31.8, managed to get the kexec load a new kernel but could not make the crashing kernel create an ELF dump file.

I see that CONFIG_PROC_VMCORE can not be configured for ARM and thus I guess there is no support for kdump for ARM.

Has anyone added support for kdump to arm arch?

-Ofer
