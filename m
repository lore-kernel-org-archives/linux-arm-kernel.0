From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Jul 2010 09:20:41 +0100
Subject: [PATCH] regulator: MAX8998: set_voltage bugfix. ramp_up delay
	and min/max voltage
In-Reply-To: <1279267760-6971-1-git-send-email-myungjoo.ham@samsung.com>
References: <1279267760-6971-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100716082041.GB9082@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 05:09:20PM +0900, MyungJoo Ham wrote:
> Two issues are addressed for max8998_set_voltage function.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Ideally you should've submitted this as two separate patches.
