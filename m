From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 02:37:13 -0400
Subject: [PATCHv2 1/8] irqchip: atmel-aic5: Add sama5d4 support
In-Reply-To: <1410536587-24607-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410536587-24607-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410536587-24607-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140914063713.GN21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 05:43:00PM +0200, Alexandre Belloni wrote:
> Add sama5d4 support to irq-atmel-aic5.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
>  .../devicetree/bindings/interrupt-controller/atmel,aic.txt     |  2 +-
>  drivers/irqchip/irq-atmel-aic5.c                               | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

Applied to irqchip/atmel

thx,

Jason.
