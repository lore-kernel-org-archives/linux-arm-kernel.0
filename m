From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 7 Oct 2012 21:49:59 +0200
Subject: [PATCH 2/2] mtd: delete nomadik_nand driver
In-Reply-To: <1349335729-13438-1-git-send-email-linus.walleij@linaro.org>
References: <1349335729-13438-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121007194959.GF12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:28 Thu 04 Oct     , Linus Walleij wrote:
> The nomadik_nand driver is really just a subset of the FSMC
> NAND driver, and there are no users anymore so let's delete
> it.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I'm seeking the MTD maintainer(s) ACK for this patch so I can
> merge it through the ARM SoC tree just after switching the
> platform to using the FSMC driver.
I've test the fsmc driver on nomadik too

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
