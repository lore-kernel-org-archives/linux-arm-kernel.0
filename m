From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 17:42:40 +0200
Subject: [GIT PULL] Broadcom SoC changes for 4.2
In-Reply-To: <1431556453-11633-3-git-send-email-f.fainelli@gmail.com>
References: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
 <1431556453-11633-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <3823846.rnrmQS3Tny@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 15:34:13 Florian Fainelli wrote:
> This pull request contains the following changes:
> 
> - BCM63138 SMP support which pulls in code to control the PMB bus, secondary CPU initialization
>   sequence and small changes suggested by Russell King to allow platforms to disable VFP
> 
> ----------------------------------------------------------------
> Florian Fainelli (5):
>       ARM: BCM63xx: Add Broadcom BCM63xx PMB controller helpers
>       ARM: BCM63xx: Add secondary CPU PMB initialization sequence
>       ARM: vfp: Add include guards
>       ARM: vfp: Add vfp_disable for problematic platforms
>       ARM: BCM63xx: Add SMP support for BCM63138
> 
> 

Pulled into next/soc, thanks!

	Arnd
