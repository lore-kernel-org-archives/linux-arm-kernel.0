From: marex@denx.de (Marek Vasut)
Date: Wed, 10 Oct 2012 12:37:13 +0200
Subject: [PATCH] ARM: dts: mxs: add the `clock-names` for gpmi-nand
In-Reply-To: <1349849740-14090-1-git-send-email-b32955@freescale.com>
References: <CAOMZO5A0UX6y3MtHdzZ8V2Z52qsH8Yy-BVtOYEN_OpBezEsvQw@mail.gmail.com>
 <1349849740-14090-1-git-send-email-b32955@freescale.com>
Message-ID: <201210101237.13640.marex@denx.de>
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

One more rant: Can you discard that weird backtick in the patch subject? Maybe 
use '' ?

Best regards,
Marek Vasut
