From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 25 Jan 2013 08:10:23 +0000 (UTC)
Subject: [PATCH] ARM: omap4: clock data: Add missing clkdm association
 for dpll_usb
In-Reply-To: <1359095795-9538-1-git-send-email-rnayak@ti.com>
References: <1359095795-9538-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1301250810090.471@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Jan 2013, Rajendra Nayak wrote:

> dpll_usb needs the clkdm association so the clkdm can be
> turned on before a relock. All other dplls for omap4 belong
> to the ALWON (always on) domain.
> 
> The association was present as part of the older data file
> (clock44xx_data.c) but looks like was accidently dropped with
> the common clk convertion.

Thanks, queued for v3.8-rc fixes.

- Paul
