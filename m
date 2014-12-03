From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 03 Dec 2014 11:53:10 -0800
Subject: [PATCH] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1417438770-28696-1-git-send-email-sjoerd.simons@collabora.co.uk>
 (Sjoerd Simons's message of "Mon, 1 Dec 2014 13:59:30 +0100")
References: <1417438770-28696-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <7hzjb4y0gp.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sjoerd Simons <sjoerd.simons@collabora.co.uk> writes:

> Add DTS for the Hardkernel Odroid XU3. The name of the DTS file is kept the
> same as the vendors naming, which means it's prefixed with exynos5422
> instead of exynos5800 as the SoC name even though it includes the
> exyno5800 dtsi.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Tested-by: Kevin Hilman <khilman@linaro.org>

Tried this on top of linux-next (next-20141125 and next20141203) and
boots fine on my odroid-xu3. 

Thanks for doing this, I've been meaning to get a DTS upstream for this
platform myself.  I also noticed that the imprecise aborts I've been
seeing when booting this board with the smdk5420 DTS are gone, so I
don't have to dig into those now either.  Thanks!  :)

Kevin
