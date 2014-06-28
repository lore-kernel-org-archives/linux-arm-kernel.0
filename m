From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 28 Jun 2014 16:23:02 +0200
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17
In-Reply-To: <20140627124655.GF23978@titan.lakedaemon.net>
References: <20140627124655.GF23978@titan.lakedaemon.net>
Message-ID: <20140628162302.48b6b835@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 27 Jun 2014 08:46:55 -0400, Jason Cooper wrote:

> ----------------------------------------------------------------
> mvebu SoC changes for v3.17
> 
>  - kirkwood
>     - add setup file for netxbig LEDs (non-trivial DT binding doesn't exist yet)
> 
>  - mvebu
>     - staticize where needed
>     - add CPU hotplug for Armada XP
>     - add public datasheet for Armada XP

It's actually Armada 370 that got a datasheet published.

>     - don't apply thermal quirk by default
>     - make Aramada 375 external abort logic a quirk
>     - update L2/PCIe deadlock workaround after L2CC cleanup

This patch is needed in 3.16, not in 3.17. They really are bug fixes,
fixing a complete system deadlock under PCI load.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
