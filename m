From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 17:55:45 +0200
Subject: [GIT PULL 2/8] ARM: tegra: Memory controller updates for v4.2-rc1
In-Reply-To: <1431524980-13599-3-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
 <1431524980-13599-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <3160798.564a94qVqR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 15:49:34 Thierry Reding wrote:
> ----------------------------------------------------------------
> ARM: tegra: Memory controller updates for v4.2-rc1
> 
> Adds support for Tegra132 (which is mostly the same as for Tegra124,
> except for cache maintenance). debugfs support is also introduced for
> the SMMU part of the memory controller, which allows users to inspect
> the translation state for SWGROUPs and memory clients.
> 
> 

Pulled into next/drivers, thanks!

	Arnd
