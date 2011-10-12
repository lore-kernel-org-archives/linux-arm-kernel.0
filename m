From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 12 Oct 2011 12:59:46 +0900
Subject: [PATCH v6 10/10] ARM: S5PV210: Modify platform data for pl330
	driver
In-Reply-To: <1318270538-30450-11-git-send-email-thomas.abraham@linaro.org>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-4-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-5-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-6-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-7-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-8-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-9-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-10-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-11-git-send-email-thomas.abraham@linaro.org>
Message-ID: <000801cc8893$61a36510$24ea2f30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:

> Sent: Tuesday, October 11, 2011 3:16 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org; kgene.kim at samsung.com;
> vinod.koul at intel.com; Jassi Brar; Boojin Kim
> Subject: [PATCH v6 10/10] ARM: S5PV210: Modify platform data for pl330
> driver
>
> With the 'struct dma_pl330_peri' removed, the platfrom data for dma
> driver can be simplified to a simple list of peripheral request ids.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-s5pv210/dma.c |  241 ++++++++++++-----------------------
> -------
>  1 files changed, 69 insertions(+), 172 deletions(-)
>
Looks good to me.
Acked-by: Boojin Kim <boojin.kim@samsung.com>
