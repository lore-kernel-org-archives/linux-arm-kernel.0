From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 20 Oct 2015 21:37:03 +0900
Subject: [PATCH v5 6/8] drivers: soc: add support for exynos SROM driver
In-Reply-To: <1445332540-12814-7-git-send-email-pankaj.dubey@samsung.com>
References: <1445332540-12814-1-git-send-email-pankaj.dubey@samsung.com>
 <1445332540-12814-7-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5626356F.4030805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 20.10.2015 o 18:15, Pankaj Dubey pisze:
> This patch adds Exynos SROM controller driver which will handle
> save restore of SROM registers during S2R.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/soc/Kconfig               |   1 +
>  drivers/soc/Makefile              |   1 +
>  drivers/soc/samsung/Kconfig       |  13 +++
>  drivers/soc/samsung/Makefile      |   1 +
>  drivers/soc/samsung/exynos-srom.c | 175 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/samsung/exynos-srom.h |  51 +++++++++++
>  6 files changed, 242 insertions(+)
>  create mode 100644 drivers/soc/samsung/Kconfig
>  create mode 100644 drivers/soc/samsung/Makefile
>  create mode 100644 drivers/soc/samsung/exynos-srom.c
>  create mode 100644 drivers/soc/samsung/exynos-srom.h
> 

Looks good to me, thanks:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
