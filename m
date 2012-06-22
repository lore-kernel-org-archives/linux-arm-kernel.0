From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 22 Jun 2012 12:35:06 -0600 (MDT)
Subject: [PATCH 07/11] w1: omap_hdq: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-8-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-8-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1206221234500.10198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the hdq clocks.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Evgeniy Polyakov <zbr@ioremap.net>

This one should not be needed soon:

http://marc.info/?l=linux-omap&m=134037453807275&w=2

- Paul
