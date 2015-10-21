From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Oct 2015 20:33:38 -0600
Subject: [PATCH] spi: bcm2835aux: change initialization order and switch
 to platform_get_irq
In-Reply-To: <1444903820-9223-1-git-send-email-kernel@martin.sperl.org>
References: <1444903820-9223-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <5626F982.4060102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 04:10 AM, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Change the initialization order of the HW so that the interrupt
> is only requested after the HW is initialized
> 
> Also the use of irq_of_parse_and_map is replaced by platform_get_irq.

Looks innocuous.
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
