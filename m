From: pc.liao@mediatek.com (PC Liao)
Date: Mon, 18 Apr 2016 19:36:20 +0800
Subject: [PATCH v3] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
In-Reply-To: <1460014517-20359-1-git-send-email-pc.liao@mediatek.com>
References: <1460014517-20359-1-git-send-email-pc.liao@mediatek.com>
Message-ID: <1460979380.17045.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, 2016-04-07 at 15:35 +0800, PC Liao wrote:
> This patch adds second I2S connection to rt5650 codec for capture path on
> mt8173-rt5650 machine driver.
> 
> Signed-off-by: PC Liao <pc.liao@mediatek.com>
> ---
> Changes since v2:
> Use sound-dai to determine the capture path.
> ---
>  .../devicetree/bindings/sound/mt8173-rt5650.txt    |    6 +++
>  sound/soc/mediatek/mt8173-rt5650.c                 |   42 ++++++++++++++++++--
>  2 files changed, 44 insertions(+), 4 deletions(-)
> 

Could you please give some comments or suggestions?
Thanks!
