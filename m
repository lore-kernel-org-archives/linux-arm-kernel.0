From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Jul 2012 01:18:40 -0700
Subject: [PATCH v2 REPOST 4/4] ARM: OMAP2+: dmtimer: cleanup fclk usage
In-Reply-To: <1341492059-5544-1-git-send-email-tarun.kanti@ti.com>
References: <1341492059-5544-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <20120706081840.GM1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [120705 05:45]:
> With omap_hwmod_get_main_clk() now available, this can be passed to
> clk_get() to extract the fclk and thus avoid construction of fclk name.
> Corrected the timer fck name mis-match between clock44xx_data.c and
> omap_hwmod_44xx_data.c. For other platforms this is already taken care.

Thanks applying into cleanup-part2 branch.

Tony
