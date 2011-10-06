From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 12:51:34 -0700
Subject: [PATCH] OMAP2: Devkit8000: Remove double omap_mux_init_gpio
In-Reply-To: <1315321909-5593-1-git-send-email-weber@corscience.de>
References: <1315321909-5593-1-git-send-email-weber@corscience.de>
Message-ID: <20111006195134.GN6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Weber <weber@corscience.de> [110906 07:38]:
> Remove the init of card detect pin because
> omap_mux_init_gpio() is called during hsmmc initialization
> for the write protect and card detect pin.

Thanks, adding this into fixes-part2 branch.

Tony
