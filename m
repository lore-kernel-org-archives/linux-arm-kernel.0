From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Dec 2012 22:21:06 +0000
Subject: [PATCH V3 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <201212102208.52347.arnd@arndb.de>
References: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
 <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
 <201212102208.52347.arnd@arndb.de>
Message-ID: <201212102221.06614.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 December 2012, Arnd Bergmann wrote:
> The build bug is not the problem however, but the abuse of the
> API is. Andy, are you sure you understood what this does when
> you gave you Reviewed-by comment?
> 

Ah, I just saw that Andy had the right intuition when commenting on
it at first, but Viresh managed to convince him otherwise, and appearently
neither had followed the discussion about the dmaengine bindings...

	Arnd
