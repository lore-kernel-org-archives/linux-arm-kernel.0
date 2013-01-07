From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Jan 2013 20:09:26 +0000 (UTC)
Subject: [PATCH] omap: am33xx-hwmod: Fix wrongly terminated
 am33xx_usbss_mpu_irqs array
In-Reply-To: <20130107200338.GD14149@atomide.com>
References: <1357252342-6166-1-git-send-email-panto@antoniou-consulting.com>
 <20130107200338.GD14149@atomide.com>
Message-ID: <alpine.DEB.2.00.1301072009170.31833@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Jan 2013, Tony Lindgren wrote:

> * Pantelis Antoniou <panto@antoniou-consulting.com> [130103 14:35]:
> > The IRQ array must be terminated by -1 and not by -1+OMAP_INTC_START
> > This led to having a resource list of 100s of IRQs.
> 
> This is a bug for sure introduced with commit a2cfc509 (ARM: OMAP3+:
> hwmod: Add AM33XX HWMOD data). Anybody care to ack this one?

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
