From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Aug 2015 16:22:50 +0200
Subject: [PATCH] pinctrl-zynq.c: Fix typos in smc0_nand_grp and
 smc0_nor_grp
In-Reply-To: <1439389332-9373-1-git-send-email-mike.looijmans@topic.nl>
References: <1439389332-9373-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <CACRpkdbv63vTZEDncPc4BPK09xNiWRd=+1xtvRVZr7kN4ncZ=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 4:22 PM, Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Group names should be smc0_nand_grp and smc0_nor_grp, otherwise you'll
> get errors like this if you try to pinmux them via the devicetree:
> zynq-pinctrl 700.pinctrl: invalid group "smc0_nand_grp" for function "smc0_nand"
>
> Probably a typo while creating these tables.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

Patch applied with Moritz' ACK.

Yours,
Linus Walleij
