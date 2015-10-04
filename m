From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sun, 4 Oct 2015 23:31:06 +0200
Subject: [PATCH 1/2] pinctrl: at91-pio4: Use irq_set_handler_locked()
In-Reply-To: <560E8D4C.1000400@atmel.com>
References: <abf74f93ec58e3b321dce23af3fa5af1ffa2e070.1443793711.git.nicolas.ferre@atmel.com>
 <560E8D4C.1000400@atmel.com>
Message-ID: <56119A9A.3070507@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/10/2015 15:57, Nicolas Ferre a ?crit :
> Hi all,
> 
> Well it seems my cover letter is missing. So, here it is:
> 
> ---8<----
> pinctrl: at91-pio4: fixes for current linux-next (irq)
> 
> While testing the sama5d2 on today's linux-next I discovered that some
> adaptations were missing. So, I don't know if you were aware but here
> are my fixes in case you don't have them already.
> 
> +Cc: Thomas and Stephen in case these errors happen while building
> linux-next...

After seeing that Linus applied 2 patches by Ludovic, I realized that as
I had foreseen correctly: it was known and corrected.

Sorry for the noise. Bye,
-- 
Nicolas Ferre
