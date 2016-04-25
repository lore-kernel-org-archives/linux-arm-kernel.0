From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 22:55:03 +0200
Subject: [GIT PULL 2/4] Broadcom devicetree-arm64 changes for 4.7
In-Reply-To: <1461441540-5095-2-git-send-email-f.fainelli@gmail.com>
References: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
 <1461441540-5095-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <5101865.3yRqpuY0jb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 April 2016 12:58:58 Florian Fainelli wrote:
> This pull request contains Broadcom ARM64-based SoC Device Tree changes:
> 
> - Anup enables a bunch of standard peripherals in the Northstar 2 DTS: PL330
>   DMA, GIC maintenance interrupt, PL022 SPI controller
> 
> - Anup also re-orgnanizes the clock Device Tree fragments into a separate file
>   for consistency with how other Broadcom SoCs are doing this
> 
> - Luke switches the SMP enable-method and reboot from a spin-table + syscon to
>   the standard PSCI 1.0 firmware interface
> 

Pulled into next/dt64, thanks!

	Arnd
