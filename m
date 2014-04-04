From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 Apr 2014 18:15:58 +0200
Subject: [PATCH 2/2] ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the
 relevant defconfigs
In-Reply-To: <20140404154942.GD28334@titan.lakedaemon.net>
References: <1396626125-8631-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1396626125-8631-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140404154942.GD28334@titan.lakedaemon.net>
Message-ID: <20140404181558.5935738e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 4 Apr 2014 11:49:42 -0400, Jason Cooper wrote:

> My, you've been busy. :)

Yeah, patch day :)


> >  arch/arm/configs/multi_v7_defconfig | 1 +
> 
> Please make this a separate patch when you rebase against v3.15-rc1.
> arm-soc will take it directly since multi_v7_defconfig is so
> conflict-prone.

Sure, will do. Thanks for reporting this. Typically the kind of comment
I'm interested in when sending these patches early on, so that the next
iteration on top of 3.15-rc1 will hopefully be the right one :-)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
