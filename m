From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 May 2014 10:10:26 +0800
Subject: [PATCH 1/7] ARM: imx: fix function type for CLK_OF_DECLARE
In-Reply-To: <1399940993-1773-2-git-send-email-robherring2@gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
 <1399940993-1773-2-git-send-email-robherring2@gmail.com>
Message-ID: <20140513021024.GJ8330@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 07:29:47PM -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Adding function type checking to CLK_OF_DECLARE found a type mismatch with
> mx35_clocks_init_dt. The function should return void.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@freescale.com>
