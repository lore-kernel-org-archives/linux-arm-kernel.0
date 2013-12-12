From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 12 Dec 2013 10:55:00 +0900
Subject: [PATCH 11/12] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
In-Reply-To: <0f924b2ad771dd5c3486c81ed524a3f6e7d813b9.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <0f924b2ad771dd5c3486c81ed524a3f6e7d813b9.1386752447.git.mohit.kumar@st.com>
Message-ID: <002601cef6dd$2adbdb60$80939220$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 11, 2013 6:39 PM, Mohit Kumar wrote:
> 
> Add Mohit Kumar as maintainer for ST SPEAr13xx PCIe driver.
> 
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: linux-pci at vger.kernel.org

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8285ed4..fd03da6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6462,6 +6462,12 @@ L:	linux-pci at vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/host/pci-exynos.c
> 
> +PCIE DRIVER FOR ST SPEAR13XX
> +M:	Mohit Kumar <mohit.kumar@st.com>
> +L:	linux-pci at vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/pcie-spear13xx.c
> +
>  PCMCIA SUBSYSTEM
>  P:	Linux PCMCIA Team
>  L:	linux-pcmcia at lists.infradead.org
> --
> 1.7.0.1
