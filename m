From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Jul 2018 11:46:09 -0600
Subject: [PATCH v5 04/11] soc: mediatek: add MT6765 scpsys support
In-Reply-To: <1531817552-17221-5-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
 <1531817552-17221-5-git-send-email-mars.cheng@mediatek.com>
Message-ID: <20180720174609.GA679@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 04:52:25PM +0800, Mars Cheng wrote:
> This adds scpsys support for MT6765
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c        |   88 ++++++++++++++++++++++++++++++
>  include/dt-bindings/power/mt6765-power.h |   14 +++++

This file goes in the binding patch.

>  2 files changed, 102 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt6765-power.h
