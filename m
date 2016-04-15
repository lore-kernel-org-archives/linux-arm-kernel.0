From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 15 Apr 2016 10:37:26 +0200
Subject: [PATCH v2 1/8] PM / devfreq: event: Add new Exynos NoC probe
 driver
In-Reply-To: <1460701975-24178-2-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
 <1460701975-24178-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <5710A846.1020304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 08:32 AM, Chanwoo Choi wrote:
> This patch adds NoC (Network on Chip) Probe driver which provides
> the primitive values to get the performance data. The packets that the Network
> on Chip (NoC) probes detects are transported over the network infrastructure.
> Exynos542x bus has multiple NoC probes to provide bandwidth information about
> behavior of the SoC that you can use while analyzing system performance.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../bindings/devfreq/event/exynos-nocp.txt         |  26 ++
>  drivers/devfreq/event/Kconfig                      |   8 +
>  drivers/devfreq/event/Makefile                     |   2 +
>  drivers/devfreq/event/exynos-nocp.c                | 304 +++++++++++++++++++++
>  drivers/devfreq/event/exynos-nocp.h                |  78 ++++++
>  5 files changed, 418 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
>  create mode 100644 drivers/devfreq/event/exynos-nocp.c
>  create mode 100644 drivers/devfreq/event/exynos-nocp.h
> 

Looks good now.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
