From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Feb 2011 06:17:39 +0100
Subject: [PATCH 1/2] AT91: Use macros for gpio_to_irq/irq_to_gpio
In-Reply-To: <1297395844-21162-1-git-send-email-ryan@bluewatersys.com>
References: <1297395844-21162-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <20110211051739.GE11255@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:44 Fri 11 Feb     , Ryan Mallon wrote:
> Replace the static inline functions for gpio_to_irq/irq_to_gpio so that they
> can be used in static initialisers.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
