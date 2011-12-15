From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 13:23:26 +0800
Subject: [PATCH 2/9] irq: check domain hwirq range for DT translate
In-Reply-To: <1323876538-20406-3-git-send-email-robherring2@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
 <1323876538-20406-3-git-send-email-robherring2@gmail.com>
Message-ID: <20111215052314.GA21815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:28:51AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> A DT node may have more than 1 domain associated with it, so make sure
> the hwirq number is within range when doing DT translation.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
