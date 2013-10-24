From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Oct 2013 15:13:28 +0000 (UTC)
Subject: [PATCH 2/3] ARM: OMAP3: use CLK_SET_RATE_PARENT for dss clocks
In-Reply-To: <1381324359-28825-2-git-send-email-tomi.valkeinen@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
 <1381324359-28825-2-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1310241513180.6544@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Tomi Valkeinen wrote:

> Set CLK_SET_RATE_PARENT flag for dss1_alwon_fck_3430es2,
> dss1_alwon_fck_3430es1 and dpll4_m4x2_ck so that the DSS's fclk can be
> configured without the need to get the parent's parent of the fclk.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued.

- Paul
