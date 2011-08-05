From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 5 Aug 2011 17:18:37 +0200
Subject: [RFC PATCH] mmc: at91_mci: remove the use of irq_to_gpio
In-Reply-To: <1312472943-13839-1-git-send-email-nicolas.ferre@atmel.com>
References: <1312472943-13839-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20110805151837.GA19633@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:49 Thu 04 Aug     , Nicolas Ferre wrote:
> Remove the use of irq_to_gpio() in the card detection interrupt
> handler. The information is available in the board structure and
> we can avoid using a function that has little meaning.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
