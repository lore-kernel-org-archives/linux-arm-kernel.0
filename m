From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 25 Jan 2012 12:05:18 -0700 (MST)
Subject: [PATCH] ARM: OMAP4: clock: fix mult and div mask for USB_DPLL
In-Reply-To: <1327455315-19464-1-git-send-email-ameya.palande@ti.com>
References: <4F1E7F8A.4010805@ti.com>
 <1327455315-19464-1-git-send-email-ameya.palande@ti.com>
Message-ID: <alpine.DEB.2.00.1201251204480.5324@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

one important question first:

On Tue, 24 Jan 2012, Ameya Palande wrote:

> According to OMAP4 TRM Table 3-1183, CM_CLKSEL_DPLL_USB register defines
> following fields for multiplication and division factors:
> 
> DPLL_MULT (bits 19:8) DPLL multiplier factor (2 to 4095)
> DPLL_DIV (bits 7:0) DPLL divider factor (0 to 255)
> 
> Acked-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Ameya Palande <ameya.palande@ti.com>

Have the scripts been updated?


- Paul
