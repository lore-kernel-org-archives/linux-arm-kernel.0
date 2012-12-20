From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Dec 2012 22:48:04 +0000 (UTC)
Subject: [PATCH] ARM: OMAP3: Add missing enable/disable for EMU clock
In-Reply-To: <1356043426-7381-1-git-send-email-jon-hunter@ti.com>
References: <1356043426-7381-1-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1212202247531.20441@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Dec 2012, Jon Hunter wrote:

> The ETM/ETB drivers for OMAP3, enable the emu_src_ck clock in order
> to access the ETM/ETB hardware. The emu_src_ck should enable the EMU
> clock domain so that the ETM/ETB hardware is accessible. However,
> currently when enabling the emu_src_ck the EMU clock domain is not
> being enabled and so the ETM/ETB drivers are failing. Add enable/disable
> clock functions to enable the EMU clock domain when enabling the
> emu_src_ck.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks Jon, queued for 3.8-rc. 


- Paul
