From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 23 Mar 2015 01:41:21 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <201503222048.47779.arnd@arndb.de>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150322165710.GO8656@n2100.arm.linux.org.uk>
 <201503222048.47779.arnd@arndb.de>
Message-ID: <HK2PR06MB0561519BB48629153FC4F0D68A0D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If we can treat XIP_KERNEL as a special case that would only be used for special embedded systems,
>      -snip-
> or start with a working defconfig file that has it configured.

So far, it sounds like that's the only way XIP_KERNEL can be used.


Chris
