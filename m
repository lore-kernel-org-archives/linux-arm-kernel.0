From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 May 2015 17:49:10 +0000 (UTC)
Subject: [PATCH 2/2] ARM: AM33xx+: hwmod: re-use omap4 implementations
 for reset functionality
In-Reply-To: <1430832785-1976-3-git-send-email-t-kristo@ti.com>
References: <1430832785-1976-1-git-send-email-t-kristo@ti.com>
 <1430832785-1976-3-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1505081748510.19833@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 May 2015, Tero Kristo wrote:

> The reset code functionality is mostly a copy paste between OMAP4+ and
> AM33xx+. Re-use the omap4 code where possible, and just keep the special
> implementation for de-asserting the hardreset lines for AM33xx, as
> AM33xx+ devices have slightly different register layouts compared to
> OMAP4+. This patch also fixes the hardreset issues faced on AM43xx.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Dave Gerlach <d-gerlach@ti.com>
> Reported-by: Anna Suman <s-anna@ti.com>

Thanks, queued for v4.1-rc fixes.


- Paul
