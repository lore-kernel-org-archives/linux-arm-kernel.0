From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 02:36:20 -0400
Subject: [PATCH] irqchip: atmel-aic5: sama5d3 has 48 IRQs
In-Reply-To: <1410446511-29477-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410446511-29477-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140914063620.GM21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 04:41:51PM +0200, Alexandre Belloni wrote:
> The FUSE and RAM controllers don't have any connected IRQs, reducing the number
> of IRQs to 48.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/irqchip/irq-atmel-aic5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to irqchip/atmel with Boris' and Nicolas' Acks.

thx,

Jason.
