From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Mon,  2 May 2011 11:29:57 +0530
Subject: ARM: pxa168: Add board support for gplugD
Message-ID: <1304316000-869-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GuruPlug Display (gplugD) is dropped from arch/arm/tools/mach-types as of now.
So, it will not build until it's back in 'mach-types'. For now, one can build
kernel for gplugD by adding below line in arch/arm/tools/mach-types

gplugd                 MACH_SHEEVAD            SHEEVAD                 2625

Patches tested on Linux 2.6.39-rc4 after adding above line in 'mach-types'.
