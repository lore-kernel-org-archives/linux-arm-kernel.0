From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 May 2015 17:48:49 +0000 (UTC)
Subject: [PATCH 1/2] ARM: OMAP4+: PRM: add support for passing status
 register/bit info to reset
In-Reply-To: <1430832785-1976-2-git-send-email-t-kristo@ti.com>
References: <1430832785-1976-1-git-send-email-t-kristo@ti.com>
 <1430832785-1976-2-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1505081748360.19833@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 May 2015, Tero Kristo wrote:

> AM43xx has slightly different reset register layout compared to OMAP4+,
> with varying status bit shifts and status register offsets. Current
> code assumes static offsets and identical status / reset control bit
> shifts, which is wrong. This patch adds PRM core support for passing
> the actual implementations from hwmod code. AM43xx mappings will be fixed
> in subsequent patch.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Dave Gerlach <d-gerlach@ti.com>
> Reported-by: Anna Suman <s-anna@ti.com>

Thanks, queued for v4.1-rc fixes.


- Paul
