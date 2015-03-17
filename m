From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 17 Mar 2015 03:48:38 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
Message-ID: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been running XIP_KERNEL with linux-3.14 on a Renesas RZ/A1 (ARCH_R7S72100) for a while now (with some bug fixes of course) so I thought I'd see if my fixes should be pushed back upstream.

However, I see that all the Renesas parts are being moved to ARCH_MULTIPLATFORM, which by means of arch/arm/Kconfig disallows XIP_KERNEL.

Looking back through the mailing list archives I see that there was some discussion on this, but never really a conclusion.

So my question is basically: What is the correct configuration to use XIP_KERNEL with a Renesas SoC? Is the idea that I need to go carve up my own config and do everything outside the normal tree from here on out?

Thanks,
Chris
