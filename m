From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jun 2011 06:49:43 -0700
Subject: [PATCH] omap: pandora: fix NAND support
In-Reply-To: <1307132643-17432-1-git-send-email-notasas@gmail.com>
References: <1307132643-17432-1-git-send-email-notasas@gmail.com>
Message-ID: <20110613134943.GF3352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [110603 13:20]:
> Commit d5ce2b65 "omap3630: nand: fix device size to work in polled mode"
> changed values for .devsize in nand platform data, now we have to pass
> NAND_BUSWIDTH_16 instead of '1' to select 16bit NAND.
> 
> Update pandora's platform data accordingly, also specify appropriate
> transfer type.

Thanks adding to fixes.

Tony
