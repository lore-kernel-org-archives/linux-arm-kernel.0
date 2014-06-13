From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 13 Jun 2014 19:40:37 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: hwmod: Change hardreset soc_ops for
 AM43XX
In-Reply-To: <1402347553-26029-1-git-send-email-d-gerlach@ti.com>
References: <1402347553-26029-1-git-send-email-d-gerlach@ti.com>
Message-ID: <alpine.DEB.2.02.1406131939180.340@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Jun 2014, Dave Gerlach wrote:

> am43xx reset register layout is more similar to am33xx than omap4 so
> use the am33xx functions for hwmod hardreset soc_ops rather than the
> currently used omap4 functions. Without this, assert_hardreset and
> deassert_hardreset will not work on am43xx.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Makes sense to me; queued for v3.16-rc.


- Paul
