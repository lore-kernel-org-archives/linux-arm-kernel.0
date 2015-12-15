From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 18:14:07 +0100
Subject: [GIT PULL 1/4] Broadcom soc changes for v4.5
In-Reply-To: <1449532649-6471-4-git-send-email-f.fainelli@gmail.com>
References: <1449532649-6471-1-git-send-email-f.fainelli@gmail.com>
 <1449532649-6471-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <1504418.H3sAEoUMl3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 15:57:29 Florian Fainelli wrote:
> This pull request contains Broadcom SoC changes for 4.5, with the following changes:
> 
> - Lucas Stach removes the workaround for an imprecise fault for Broadcom
>   BCM5301x SoCs (Northstar) since this is now handled by the ARM/Linux kernel
>   directly
> 
> - Hauke Merthens enables a bunch of erratas for the Cortex-A9 and PL310 L2
>   cache present on early Northstar chips (BCM4708)
> 
> - Kapil Hali adds SMP support for the Northstar Plus SoCs by consolidating the
>   existing SMP code for Kona SoCs (mobile platforms), fixng the Device Tree
>   binding for the Kona platforms (wrong placement for 'enable-method' and
>   'secondary-reg') and then finally adds the functional code for the Northstar
>   Plus platforms to boot their secondary CPUs
> 
> - Jon Mason enables SMP on BCM4708/BCM5301X (Northstar SoCs) by building the generic
>   Northstar/Northstar Plus SMP code, and adding the relevant SMP Device Tree nodes
> 
> 


Pulled into next/soc, thanks!

	Arnd
