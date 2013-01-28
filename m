From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 13:59:22 -0700
Subject: [PATCH v4 3/7] ARM: Exynos: add device tree support for MCT
 controller driver
In-Reply-To: <1358762542-19008-4-git-send-email-thomas.abraham@linaro.org>
References: <1358762542-19008-1-git-send-email-thomas.abraham@linaro.org>
 <1358762542-19008-4-git-send-email-thomas.abraham@linaro.org>
Message-ID: <5106E6AA.3080801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 03:02 AM, Thomas Abraham wrote:
> Allow the MCT controller base address and interrupts to be obtained from
> device tree and remove unused static definitions of these. The non-dt support
> for Exynos5250 is removed but retained for Exynos4210 based platforms.

Patches 3 and later in this series, fairly quickly,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

Sorry for the slow review.

I'm not 100% sure if I like Mark's #global-interrupts suggestion or not,
but I'd be fine with the binding either way, so choose as you see fit.
