From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Oct 2017 12:49:09 -0700
Subject: [PATCH] ARM: OMAP2+: make omap_dma_dev_info __initdata
In-Reply-To: <1505753230-14014-1-git-send-email-bhumirks@gmail.com>
References: <1505753230-14014-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20171002194909.GR4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bhumika Goyal <bhumirks@gmail.com> [170918 09:48]:
> Make this __initdata as it is only modified only during the initialisation
> phase in the function omap2_system_dma_init_dev and after this it is not
> referenced anywhere in the kernel.

Applying into omap-for-v4.15/soc thanks.

Tony
