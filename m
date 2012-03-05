From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 14:13:57 -0800
Subject: [PATCH] arch/arm/mach-omap2/: included some headers twice
In-Reply-To: <1329403502-32494-1-git-send-email-danny.kukawka@bisect.de>
References: <1329403502-32494-1-git-send-email-danny.kukawka@bisect.de>
Message-ID: <20120305221357.GA12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Danny Kukawka <danny.kukawka@bisect.de> [120216 06:13]:
> arch/arm/mach-omap2/: included some headers tiwce:
> - arch/arm/mach-omap2/board-ldp.c: 'linux/gpio.h'
> - arch/arm/mach-omap2/io.c: 'common.h'
> - arch/arm/mach-omap2/omap_hwmod_44xx_data.c: 'plat/i2c.h'
> 
> Remove the duplicates.

Thanks applying this too.

Regards,

Tony
