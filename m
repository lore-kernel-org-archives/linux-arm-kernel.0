From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 15 Dec 2013 18:09:29 +0530
Subject: [PATCH v6 3/6] gpio: davinci: remove unused variable intc_irq_num
In-Reply-To: <1385057731-4348-4-git-send-email-prabhakar.csengg@gmail.com>
References: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>
 <1385057731-4348-4-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <52ADA301.2080209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 November 2013 11:45 PM, Prabhakar Lad wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> As the davinci-gpio driver is migrated to use irqdomain
> there is no need to pass the irq base for the gpio driver.
> This patch removes this variable from davinci_gpio_platform_data
> and also the refrences from the machine file.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Queuing for v3.14 along with Linus's ack.

Thanks,
Sekhar
