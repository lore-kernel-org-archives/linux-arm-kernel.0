From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Oct 2017 12:39:26 -0700
Subject: [PATCH] ARM: omap1: add const and initconst to omap_lcd_config
In-Reply-To: <1503383150-2363-1-git-send-email-bhumirks@gmail.com>
References: <1503383150-2363-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20171002193926.GO4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bhumika Goyal <bhumirks@gmail.com> [170821 23:26]:
> Make these const as they are only passed to a const argument of the function
> omapfb_set_lcd_config.
> Also, replace __initdata with __initconst to avoid section conflict error.
> Done using Coccinelle.

Applying into omap-for-v4.15/omap1 thanks.

Tony
