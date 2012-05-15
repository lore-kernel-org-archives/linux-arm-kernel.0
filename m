From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 11:06:46 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201205151106.46761.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Thomas Petazzoni wrote:
> You'll find in this patch set the initial support for a new family of
> ARMv7-compatible Marvell SoCs, that we have choosen to support in the
> arch/arm/mach-armada/ directory.
> 
> At the moment, both the Armada 370 and the Armada XP SoCs are
> supported in this directory, and we are able to build a single kernel
> image that boots on both SoCs. Both SoCs use the PJ4B processor, a
> Marvell-developed ARM core that implements the ARMv7 instruction
> set. We are currently using Marvell evaluation boards for both of
> those SoCs, and the support for those boards is added in this patch
> set.
> 
> This preliminary support only includes the necessary code for timer
> and IRQ support, the serial controller is a standard 16550-compatible
> one. The diffstat looks like:

Hi Thomas,

The code looks reasonable overall, but I fear your timing is unfortunate
and we can't expect to complete the review before the merge window opens.
Things would have been much easier if you had posted preliminary versions
a few weeks earlier, but my feeling is that this should be treated
as v3.6 material.

	Arnd
