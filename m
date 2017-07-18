From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jul 2017 16:26:15 +0200
Subject: [PATCH v2 0/7] staging: fsl-mc: make the driver compile on other
 architectures
In-Reply-To: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
References: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
Message-ID: <CAK8P3a39fpEHwCvR3TOL8u8W7TORSNpw27xwma70sxi-VfXhyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 3:37 PM,  <laurentiu.tudor@nxp.com> wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Apart from a small change (first patch) which adds a missing comment,
> this series make the bus driver compile on other architectures, as per
> GregKH comment [1].
> Compiled tested on:
>  - booke powerpc (corenet{32,64}_smp_defconfig) with this ppc patch [2]
>  - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
>  - arm64 (defconfig)
>
> [1] https://www.spinics.net/lists/linux-driver-devel/msg100585.html
> [2] https://patchwork.ozlabs.org/patch/789474/

Looks good overall. With the two minor questions addressed

Acked-by: Arnd Bergmann <arnd@arndb.de>
