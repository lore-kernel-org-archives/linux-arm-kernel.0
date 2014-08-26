From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 26 Aug 2014 15:15:18 +0200
Subject: [PATCH 2/9] PM / Domains: Add generic OF-based power domain
 look-up
In-Reply-To: <1409054837-5667-3-git-send-email-ulf.hansson@linaro.org>
References: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
 <1409054837-5667-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1409058918.2911.55.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

Am Dienstag, den 26.08.2014, 14:07 +0200 schrieb Ulf Hansson:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> This patch introduces generic code to perform power domain look-up using
> device tree and automatically bind devices to their power domains.
> Generic device tree binding is introduced to specify power domains of
> devices in their device tree nodes.
> 
> Backwards compatibility with legacy Samsung-specific power domain
> bindings is provided, but for now the new code is not compiled when
> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
> will change as soon as Exynos power domain code gets converted to use
> the generic framework in further patch.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you for updating this series. I've tested patches 1-4
using the PU power domain on i.MX6.

Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
