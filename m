From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Tue, 16 Aug 2016 16:20:27 +0800
Subject: [PATCH v12 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1470645093-13309-3-git-send-email-hs.liao@mediatek.com>
References: <1470645093-13309-1-git-send-email-hs.liao@mediatek.com>
 <1470645093-13309-3-git-send-email-hs.liao@mediatek.com>
Message-ID: <1471335627.22752.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Sorry to disturb you.
Do you have any further comment on CMDQ v12?

Thanks.
HS

On Mon, 2016-08-08 at 16:31 +0800, HS Liao wrote:
> This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> CMDQ is used to help write registers with critical time limitation,
> such as updating display configuration during the vblank. It controls
> Global Command Engine (GCE) hardware to achieve this requirement.
> Currently, CMDQ only supports display related hardwares, but we expect
> it can be extended to other hardwares for future requirements.
> 
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig    |  11 +
>  drivers/soc/mediatek/Makefile   |   1 +
>  drivers/soc/mediatek/mtk-cmdq.c | 948 ++++++++++++++++++++++++++++++++++++++++
>  include/soc/mediatek/cmdq.h     | 179 ++++++++
>  4 files changed, 1139 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
>  create mode 100644 include/soc/mediatek/cmdq.h
> 
[...]
