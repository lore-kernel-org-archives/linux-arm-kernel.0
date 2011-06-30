From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 30 Jun 2011 03:06:28 +0200
Subject: [PATCH] MTD: atmel_nand: fix wrong use of 0 as NULL
In-Reply-To: <1309365676-19210-1-git-send-email-nicolas.ferre@atmel.com>
References: <1309365676-19210-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20110630010628.GI17355@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:41 Wed 29 Jun     , Nicolas Ferre wrote:
> Fixing this error:
> atmel_nand.c:718:20: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
