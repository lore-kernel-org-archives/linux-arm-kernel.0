From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Nov 2015 15:31:29 -0800
Subject: [PATCH V2] clocksource/drivers/timer_sun5i: Replace code by
 clocksource_mmio_init
In-Reply-To: <1447353613-18778-1-git-send-email-daniel.lezcano@linaro.org>
References: <1447353613-18778-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20151112233129.GH32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 07:40:13PM +0100, Daniel Lezcano wrote:
> The current code to initialize, register and read the clocksource is
> already factored out in mmio.c via the clocksource_mmio_init function.
> 
> The only difference is the readl vs readl_relaxed.
> 
> Factor out the code with the clocksource_mmio_init function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151112/b84f0cd4/attachment-0001.sig>
