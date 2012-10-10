From: marex@denx.de (Marek Vasut)
Date: Wed, 10 Oct 2012 13:34:18 +0200
Subject: [PATCH] ARM: dts: mxs: add the "clock-names" for gpmi-nand
In-Reply-To: <1349864829-19565-1-git-send-email-b32955@freescale.com>
References: <201210101237.13640.marex@denx.de>
 <1349864829-19565-1-git-send-email-b32955@freescale.com>
Message-ID: <201210101334.18605.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> The current DT nodes for mx23/mx28 miss the `clocks-names` item for
> gpmi-nand. So the gpmi-nand driver could not find the proper clock.
> 
> This patch fixes this issue.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
[...]

Reviewed-by: Marek Vasut <marex@denx.de>

I will test later today.

Best regards,
Marek Vasut
