From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Apr 2013 08:48:12 -0300
Subject: [PATCH 2/3] ARM:DTS:MVF600: add basic device tree source
In-Reply-To: <1365749825-20601-3-git-send-email-b35083@freescale.com>
References: <1365749825-20601-1-git-send-email-b35083@freescale.com>
 <1365749825-20601-3-git-send-email-b35083@freescale.com>
Message-ID: <CAOMZO5AwBXqBy8jAwLFEpbGh8FSVUKi_r-fZyY=ASwp=ZFb8MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 3:57 AM, Jingchang Lu <b35083@freescale.com> wrote:
> This patch adds basic device tree source for Freescale
> Vybrid Family platform and Tower development board.
>
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  arch/arm/boot/dts/imx-mvf600.dtsi   | 442 ++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx-mvf600twr.dts |  82 +++++++
>  2 files changed, 524 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx-mvf600.dtsi
>  create mode 100644 arch/arm/boot/dts/imx-mvf600twr.dts

Why add the 'imx' prefix here?

Wouldn't 'vybrid' makes more sense?
