From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2011 15:21:37 -0800
Subject: [PATCH] ARM: OMAP: McSPI: Remove unused flag from struct
 omap2_mcspi_device_config
In-Reply-To: <1323681317-8447-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1323681317-8447-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <20111212232137.GL32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [111212 00:45]:
> Flag single_channel in struct omap2_mcspi_device_config is not used
> by drivers/spi/spi-omap2-mcspi.c so we may remove it from include/plat/mcspi.h
> and affected board files.

Thanks applying into cleanup branch.

Regards,

Tony
