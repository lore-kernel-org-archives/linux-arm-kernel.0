From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 17:18:24 +0200
Subject: [GIT PULL] Broadcom Device Tree changes for 4.2
In-Reply-To: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
References: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <3333546.1OGl7mTaon@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 15:34:11 Florian Fainelli wrote:
> This pull request contains the following Device Tree changes:
> 
> New devices:
> 
> - Felix adds support for the Buffalo WXR-1900DHP and adds the USB led on Buffalo
>   WZR-1750DHP
> 
> - Rafal adds support for the SmartRG SR400ac, Asus RT-AC68U and RT-AC56U
> 
> New peripheral support:
> 
> - Brian adds Device Tree nodes for the Broadcom NAND controller found on
>   BCM7xxx, BCM63138 and Cygnus SoCs
> 
> - Brian adds Device Tree nodes for the SATA AHCI and PHY controller found on
>   BCM7xxx
> 
> - I add the Device Tree nodes and bindings documents for bringing-up secondary
>   CPUs and timer/syscon-reboot on BCM63138
> 
> 

Pulled into next/dt, thanks!

	Arnd
