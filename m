From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 20:42:02 +0900
Subject: [PATCH 1/3] ARM: EXYNOS: Enable MDMA driver
In-Reply-To: <4F28A8BD.9000601@linaro.org>
References: <1328025437-5396-1-git-send-email-kgene.kim@samsung.com>
 <1328025437-5396-2-git-send-email-kgene.kim@samsung.com>
 <4F28A8BD.9000601@linaro.org>
Message-ID: <06a101cce71f$d747c870$85d75950$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera wrote:
> 
> On 01/31/2012 09:27 PM, Kukjin Kim wrote:
> > From: Boojin Kim <boojin.kim@samsung.com>
> >
> > This patch adds MDMA platform data and enables
> > MDMA for DMA memcpy operation for EXYNOS SoCs.

[...]

> > +static struct clk exynos4_clk_mdma1 = {
> 
> exynos4_clk_mdma ?
> 
Boojin, could you please explain why you used 'exynos4_clk_mdma1' instead of
just mdma here?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
