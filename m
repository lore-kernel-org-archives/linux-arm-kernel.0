From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 28 May 2012 09:07:44 +0200
Subject: [PATCH] ARM: at91: aic can use fast eoi handler type
In-Reply-To: <1337950511-2049-1-git-send-email-ludovic.desroches@atmel.com>
References: <1337950511-2049-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120528070744.GN3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:55 Fri 25 May     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> The Advanced Interrupt Controller allows to use the fast EOI handler type.
> It lets remove the Atmel specific workaround into arch/arm/kernel/irq.c used
> to indicate to the AIC the end of the interrupt treatment.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>


Best Regards,
J.
