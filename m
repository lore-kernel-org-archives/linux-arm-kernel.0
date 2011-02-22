From: axel.lin@gmail.com (Axel Lin)
Date: Tue, 22 Feb 2011 09:12:55 +0800
Subject: [PATCH] ARM: pxa: support 806MHz operating points for PXA31x
	processors A2 stepping
In-Reply-To: <4D5AB09C.9000106@compulab.co.il>
References: <1297786849.2596.13.camel@phoenix>
	<4D5AB09C.9000106@compulab.co.il>
Message-ID: <AANLkTino2vLisNgKeyXppuHwDyhLMMAcOOZjA0hgmkj6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

> Also, there is one thing that is not related to this patch, but
> if you have the hardware, you need to be concerned with,
> is that the vcc_core voltage has to be 1.4V, otherwise your
> hardware will be unstable.

I don't see any unstable issue on my device.
But it seems the vcc_core and vcc_sram fields of pxa3xx_freq_info
are not used now.

Regards,
Axel
