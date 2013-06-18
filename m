From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 00:13:18 -0700
Subject: [PATCH 0/8] ARM: OMAP: dma.h and legacy code removal
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <20130618071318.GB5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [130615 01:37]:
> Hi
> 
> This set gets rid off arch/arm/mach-omap1/dma.h and
> arch/arm/mach-omap2/dma.h by removing duplicated definitions,
> by using numeric values when setting hwmod and platform data and
> by removing legacy stuff.
> 
> Most cleanup is done by the scripts in commit logs and
> set has been build tested with omap1_defconfig and omap2plus_defconfig.

Thanks applying these into omap-for-v3.11/dma.

Regards,

Tony
