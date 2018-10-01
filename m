From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 1 Oct 2018 17:58:06 +0200
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.20
In-Reply-To: <20181001072003.16238-5-shawnguo@kernel.org>
References: <20181001072003.16238-1-shawnguo@kernel.org>
 <20181001072003.16238-5-shawnguo@kernel.org>
Message-ID: <CAK8P3a1wMGK1TrquSw_g0TdugsET2o3MRKnx+dV96ZgY5yDqgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 9:21 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
>       ARM: imx_v6_v7_defconfig: Re-sync defconfig
>       ARM: mxs_defconfig: Re-sync defconfig
>       ARM: imx_v4_v5_defconfig: Re-sync defconfig

Hi Shawn, Fabio,

these patches introduce a couple of changes that should be split out
from 'Re-sync defconfig':

-CONFIG_USB_CHIPIDEA_ULPI=y
-CONFIG_USB_ULPI_BUS=y
-# CONFIG_ARM_UNWIND is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
-# CONFIG_ARM_THUMB is not set

Please add explanations for why we don't set those
any more, and keep them separate from patches that
just move options around.

        Arnd
