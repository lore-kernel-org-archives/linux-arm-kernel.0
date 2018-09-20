From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2018 14:23:54 -0700
Subject: [PATCH] ARM: OMAP1: ams-delta-fiq: Use
 <linux/platform_data/gpio-omap.h>
In-Reply-To: <20180910174722.15679-1-jmkrzyszt@gmail.com>
References: <20180910174722.15679-1-jmkrzyszt@gmail.com>
Message-ID: <20180920212354.GT5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180910 10:50]:
> Instead of defining symbols already defined in
> linux/platform_data/gpio-omap.h, use that header file.
> 
> Since we include the header into an assembler code, prevent C only bits
> from being read in.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks applying into omap-for-v4.20/omap1.

Regards,

Tony
