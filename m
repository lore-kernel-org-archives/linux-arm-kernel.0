From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Jul 2010 09:54:59 +0100
Subject: [PATCH v2] regulator: MAX8998: set_voltage bugfix. ramp_up
	delay and min/max voltage
In-Reply-To: <1279606027-18345-1-git-send-email-m.szyprowski@samsung.com>
References: <1279391048.3070.11.camel@odin>
	<1279606027-18345-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100720085459.GG10222@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 08:07:07AM +0200, Marek Szyprowski wrote:
> From: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> Two issues are addressed for max8998_set_voltage function.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but as IIRC I said last time it would be nicer to fix one issue per
patch.
