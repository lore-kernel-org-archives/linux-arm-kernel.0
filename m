From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 7 Dec 2012 08:07:58 -0200
Subject: [PATCH v2] ARM: Kconfig: Do not force selection of ARCH_VEXPRESS
 by ARCH_MULTI_V7
In-Reply-To: <1353431918-9326-1-git-send-email-festevam@gmail.com>
References: <1353431918-9326-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5CQZbRub5ZWHzsNfewcRh5T7pPQuKNaTDYaFg-j1HzN0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Nov 20, 2012 at 3:18 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> When building a kernel using imx_v6_v7_defconfig, it is not possible to unselect
> ARCH_VEXPRESS due to the fact that it is automatically selected by ARCH_MULTI_V7.
>
> This is not good when someone wants to create a minimal kernel build, so let
> multi_v7_defconfig select ARCH_VEXPRESS instead.
>
> Also avoid build breakage when randconfig selects no platform.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Avoid build breakage on randconfig for the case that no platform is selected.

Does this version look good?

Regards,

Fabio Estevam
