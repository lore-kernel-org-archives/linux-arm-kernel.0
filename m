From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 Nov 2009 01:22:58 +0100
Subject: [PATCH] Use ST vendor enum instead of numeral
In-Reply-To: <1257799387-12335-1-git-send-email-linus.walleij@stericsson.com>
References: <1257799387-12335-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20091110002258.GB4394@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:43 Mon 09 Nov     , Linus Walleij wrote:
> This fixes a leftover instance of using the 0x80 numeral instead
> of the new AMBA_VENDOR_ST enum in the MMCI/PL180 driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/mmc/host/mmci.c |    2 +-
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
