From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Oct 2013 15:13:15 +0000 (UTC)
Subject: [PATCH 1/3] ARM: OMAP4: use CLK_SET_RATE_PARENT for
 dss_dss_clk
In-Reply-To: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1310241512480.6544@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Tomi Valkeinen wrote:

> Set CLK_SET_RATE_PARENT flag for dss_dss_clk so that the DSS's fclk can
> be configured without the need to get the parent of the fclk.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued.

- Paul
