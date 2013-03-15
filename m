From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Mar 2013 13:43:45 +0800
Subject: [PATCH] i.MX: Add GPT devicetree nodes
In-Reply-To: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130315054343.GC31734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 01:08:55PM +0100, Sascha Hauer wrote:
> The GPT is the general purpose timer found on i.MX SoCs. The bindings
> are used on i.MX25 and i.MX6 already. The remaining i.MX SoCs still
> use a platform based timer. This is a first step to change this: We
> add the devicetree nodes for the other DT enabled SoCs (i.MX27, i.MX31,
> i.MX51 and i.MX53).
> 
> This series also adds the missing binding documentation for the GPT.
> 
> The series is based on Shawns imx/dt branch.
> 
> The last patch adds the clocks to the i.MX27 GPT. This is not applicable
> right now since it depends on the patch changing i.MX27 to devicetree
> based clock lookups.
> 
I just applied Fabio's clock lookup patch and the series to imx/dt
branch.

Shawn
