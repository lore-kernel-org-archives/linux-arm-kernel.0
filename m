From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 Nov 2016 23:21:47 +0200
Subject: [RFC PATCH 00/10] ARM: dts: exynos: Fix invalid GIC interrupt
 flags
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <20161103212147.GA15161@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 09:42:41PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Marek (internally), Geert and Alban reported errors like:
> 	genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)
> The patchset fixes this issue.
> 
> Tested on:
> 1. Exynos4412: Odroid U3,
> 2. Exynos5410: Odroid XU,
> 3. Exynos5422: Odroid XU3.
> 
> Other platforms not tested so testing would be highly appreciated.

Applied entire patchset for v4.10. Let it boil for some time in
linux-next.

Best regards,
Krzysztof
