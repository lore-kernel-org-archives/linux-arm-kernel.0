From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 5 Jul 2017 06:51:26 +0200
Subject: [PATCH] ARM: dts: exynos: remove num-slots from exynos platforms
In-Reply-To: <1499160322-73008-1-git-send-email-shawn.lin@rock-chips.com>
References: <1499160322-73008-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20170705045126.GA2360@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 05:25:22PM +0800, Shawn Lin wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

I do not see this property deprecated here (yesterday's next):
Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
Something is not merged yet?

Also in separate patch, please update example here:
Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt

Best regards,
Krzysztof
