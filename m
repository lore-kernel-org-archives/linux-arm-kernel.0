From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 29 Oct 2018 10:47:01 +0100
Subject: [PATCH v4 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <20181029104701.1bcdfbf3@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jianxin,

Jianxin Pan <jianxin.pan@amlogic.com> wrote
on Thu, 20 Sep 2018 16:50:49 +0800:

> From: Liang Yang <liang.yang@amlogic.com>
> 
> Add initial support for the Amlogic NAND flash controller which found
> in the Meson-GXBB/GXL/AXG SoCs.
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---

I lost track of what's ongoing there, can you remind me the status of
the whole clk/nand series?

If the clock driver is ready, can you resend the NAND controller driver
please? IIRC it was in a pretty good shape already.

Thanks,
Miqu?l
