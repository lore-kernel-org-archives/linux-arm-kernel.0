From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 15 Oct 2012 15:52:36 +0200
Subject: [PATCH RESEND] serial/amba-pl011: use devm_* managed resources
In-Reply-To: <1350300961-7036-1-git-send-email-linus.walleij@stericsson.com>
References: <1350300961-7036-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121015135236.GX12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:36 Mon 15 Oct     , Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This switches a bunch of allocation and remapping to use the
> devm_* garbage collected methods and cleans up the error
> path and remove() paths consequently.
> 
> devm_ioremap() is only in <linux/io.h> so fix up the
> erroneous <asm/*> include as well.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
