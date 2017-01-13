From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 13 Jan 2017 15:20:41 +0200
Subject: [PATCH v4 1/4] dmaengine: pl330: remove pdata based initialization
In-Reply-To: <1484292400-29730-2-git-send-email-m.szyprowski@samsung.com>
References: <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170113072651eucas1p214662327fe5a3dfbaa79d11c2a0b195a@eucas1p2.samsung.com>
 <1484292400-29730-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170113132041.3k7sr7ciy46dd42q@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 08:26:37AM +0100, Marek Szyprowski wrote:
> This driver is now used only on platforms which support device tree, so
> it is safe to remove legacy platform data based initialization code.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/plat-samsung/devs.c |  1 -

For plat-samsung:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
