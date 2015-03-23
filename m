From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 23 Mar 2015 13:54:40 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <201503230654.40287.arnd@arndb.de>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150322165710.GO8656@n2100.arm.linux.org.uk>
 <HK2PR06MB056105B026481446243452FC8A0D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <201503230654.40287.arnd@arndb.de>
Message-ID: <HK2PR06MB0561E40AF1275259EA364BEF8A0D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> There are two different scenarios to consider here:
> 
> a) building a kernel for a single machine while CONFIG_ARCH_MULTIPLATFORM is
>    enabled
> b) actually enabling all sorts of machines
>
> This means that I would definitely want to see XIP_KERNEL being possible on your
> machine with a), but I agree that there is not much use for b) here.

Given that XIP_KERNEL on ARMv7 is not a very common build configuration, this seems reasonable.


Chris
