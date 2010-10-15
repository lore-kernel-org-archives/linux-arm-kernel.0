From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Oct 2010 14:29:02 +0200
Subject: [PATCH 1/5] Fix AT91SAM9G20 reset as per the errata in the
	data sheet
In-Reply-To: <29a192a1f4f98dd05b72ed8eafe67bd6aadd8432.1287076894.git.nicolas.ferre@atmel.com>
References: <20100528153725.GA5102@axolotl.localnet>
	<29a192a1f4f98dd05b72ed8eafe67bd6aadd8432.1287076894.git.nicolas.ferre@atmel.com>
Message-ID: <20101015122902.GF11127@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +at91sam9g20_reset:	mov	r0, #0
> +			mcr	p15, 0, r0, c7, c5, 0	@ flush I-cache
do we really need to flush the I-cache again

Best Regards,
J.
