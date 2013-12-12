From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 12 Dec 2013 10:05:33 +0900
Subject: [PATCH 07/12] pcie: designware: add dw_pcie prefix before
 cfg_read/write
In-Reply-To: <11157a3462fcad1067bddd27dcd580bbeb2c289e.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <11157a3462fcad1067bddd27dcd580bbeb2c289e.1386752447.git.mohit.kumar@st.com>
Message-ID: <002001cef6d6$423d7040$c6b850c0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 11, 2013 6:39 PM, Mohit Kumar wrote:
> 
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> cfg_read/write function are designware pcie specific. Add dw_pcie prefix
> to avoid collision in global name space.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: spear-devel at list.st.com
> Cc: linux-pci at vger.kernel.org

Acked-by: Jingoo Han <jg1.han@samsung.com>

It looks good. Also, I tested this patch on Exynos platform.

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-exynos.c      |    5 +++--
>  drivers/pci/host/pcie-designware.c |   23 ++++++++++++++---------
>  drivers/pci/host/pcie-designware.h |    4 ++--
>  3 files changed, 19 insertions(+), 13 deletions(-)
