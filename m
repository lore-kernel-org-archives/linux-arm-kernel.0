From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 1 Mar 2015 23:53:03 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4+: PRM: fix omap4 version of
 prm_save_and_clear_irqen
In-Reply-To: <1425045566-19580-1-git-send-email-t-kristo@ti.com>
References: <1425045566-19580-1-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1503012352490.9987@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Feb 2015, Tero Kristo wrote:

> This was incorrectly reading the irq status registers during the save
> and clear, instead of the irq enable. This worked because there is only
> one user for the prcm interrupts currently, namely the io-chain. Whenever
> the function was called, an io-chain interrupt was both pending and
> enabled.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>

Thanks queued for v4.0-rc fixes.


- Paul
