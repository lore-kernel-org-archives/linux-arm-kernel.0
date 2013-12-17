From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 17 Dec 2013 12:37:51 +0100
Subject: [PATCH 2/2] ARM: device trees for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <1387221123-6794-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20131216190953.GB14866@pengutronix.de>
 <1387221123-6794-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131217113750.GB5307@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 08:12:03PM +0100, Uwe Kleine-K?nig wrote:

> +		cmu: cmu at 400c8000 {
> +			compatible = "efm32gg,cmu";

I was able to run this on the EFM32LG without problems.  Are you sure
this CMU node is specific to the GG, or can it be shared?

Thanks,
Richard

> +			reg = <0x400c8000 0x400>;
> +			interrupts = <32>;
> +			#clock-cells = <1>;
> +		};
