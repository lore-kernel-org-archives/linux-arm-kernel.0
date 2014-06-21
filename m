From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 22:09:39 -0400
Subject: [PATCH] irqchip: brcmstb-l2: Level-2 interrupts are edge sensitive
In-Reply-To: <1402337102-19428-1-git-send-email-f.fainelli@gmail.com>
References: <1402337102-19428-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20140621020939.GB21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 11:05:02AM -0700, Florian Fainelli wrote:
> The driver was configuring the interrupt handler for the Level-2
> interrupts to be "level" triggered while they are in fact "edge"
> triggered. Fix this by using the correct handler.
> 
> Reported-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/irqchip/irq-brcmstb-l2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to irqchip/urgent

thx,

Jason.
