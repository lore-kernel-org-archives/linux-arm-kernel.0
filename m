From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Jun 2011 04:49:29 -0700
Subject: [PATCH v2 1/2] ARM: OMAP4: MMC: increase delay for pbias
In-Reply-To: <1306926923-3398-2-git-send-email-balajitk@ti.com>
References: <1306926923-3398-1-git-send-email-balajitk@ti.com>
	<1306926923-3398-2-git-send-email-balajitk@ti.com>
Message-ID: <20110601114929.GB11352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Balaji T K <balajitk@ti.com> [110601 04:13]:
> 4 micro seconds is not enough for PBIAS if MMC regulator is
> enabled from MMC regulator OFF.
> Increase the delay for PBIAS to stabilize.
> Wait for PBIAS and timeout if not.
> 
> Resolves MMC/SD failure on OMAP4
> "Pbias Voltage is not same as LDO"

Thanks for updating this, applying to devel-fixes.

Tony
