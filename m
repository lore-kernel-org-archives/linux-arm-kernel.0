From: jgarzik@pobox.com (Jeff Garzik)
Date: Mon, 14 Mar 2011 10:50:46 -0400
Subject: [RFC PATCH 1/2] AHCI Add the AHCI SATA feature on MX53 platforms
In-Reply-To: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <4D7E2B46.6010605@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2011 05:55 AM, Richard Zhu wrote:
> Signed-off-by: Richard Zhu<Hong-Xing.Zhu@freescale.com>
> ---
>   arch/arm/mach-mx5/clock-mx51-mx53.c             |   11 +++++
>   arch/arm/mach-mx5/devices-imx53.h               |    4 ++
>   arch/arm/plat-mxc/devices/Kconfig               |    4 ++
>   arch/arm/plat-mxc/devices/Makefile              |    1 +
>   arch/arm/plat-mxc/devices/platform-ahci-imx.c   |   55 +++++++++++++++++++++++
>   arch/arm/plat-mxc/include/mach/ahci_sata.h      |   51 +++++++++++++++++++++
>   arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++++
>   7 files changed, 136 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
>   create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h

Acked-by: Jeff Garzik <jgarzik@redhat.com>
