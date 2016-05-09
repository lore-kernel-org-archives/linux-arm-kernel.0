From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 16:29:03 +0200
Subject: [GIT PULL] soc/tegra: Add generic PM domain support
In-Reply-To: <1461946869-26124-1-git-send-email-thierry.reding@gmail.com>
References: <1461946869-26124-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <4251738.3YkFNHn2NH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2016 18:21:06 Thierry Reding wrote:
> soc/tegra: Add generic PM domain support
> 
> Implements generic PM domain support on top of the existing Tegra power-
> gate API. Drivers are thus allowed to move away from the Tegra-specific
> API and towards using generic power domains directly.
> 
> 

Merged into next/drivers, thanks!

	Arnd
