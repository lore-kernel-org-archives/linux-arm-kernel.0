From: cjb@laptop.org (Chris Ball)
Date: Tue, 11 Sep 2012 11:42:02 -0400
Subject: [PATCH 09/16] ARM: tegra: move platform_data definitions
In-Reply-To: <1347368390-31252-9-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Tue, 11 Sep 2012 14:59:43 +0200")
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-9-git-send-email-arnd@arndb.de>
Message-ID: <871ui8y3at.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Sep 11 2012, Arnd Bergmann wrote:
> diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h
> b/include/linux/platform_data/mmc-sdhci-tegra.h
> similarity index 100%
> rename from arch/arm/mach-tegra/include/mach/sdhci.h
> rename to include/linux/platform_data/mmc-sdhci-tegra.h

Looks like you aren't renaming the idempotency guards, so e.g.
include/linux/platform_data/mmc-sdhci-tegra.h will contain:

#ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
#define __ASM_ARM_ARCH_TEGRA_SDHCI_H

Is that intentional?  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
