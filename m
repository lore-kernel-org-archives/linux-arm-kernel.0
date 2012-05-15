From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 19:41:19 +0000
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB284FE.10203@wwwdotorg.org>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205151437.55286.arnd@arndb.de> <4FB284FE.10203@wwwdotorg.org>
Message-ID: <201205151941.19968.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Stephen Warren wrote:
> Thierry Redding was working on this (actually, perhaps PCIe as a
> platform driver rather than as a module, but I'm not sure) in the
> context of the Tegra PCIe driver. See some of the patches at
> http://patchwork.ozlabs.org/project/linux-tegra/list/, e.g. "PCI: Keep
> pci_fixup_irqs() around after init" and "ARM: pci: Keep
> pci_common_init() around after init" IIRC.

Ah, right. Thanks for the clarification.

	Arnd
