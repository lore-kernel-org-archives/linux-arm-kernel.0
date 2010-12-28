From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 28 Dec 2010 15:55:09 +0530
Subject: [PATCH v11 0/6] Add Omapl138-Hawkboard support
In-Reply-To: <1293489793-23312-1-git-send-email-vm.rod25@gmail.com>
References: <1293489793-23312-1-git-send-email-vm.rod25@gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024806D75D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Victor,

On Tue, Dec 28, 2010 at 04:13:07, vm.rod25 at gmail.com wrote:
> From: Victor Rodriguez <vm.rod25@gmail.com>
>
> This patch adds
> EMAC, EDMA, MMC/SD and USB OHCI
> support for the Hawkboard-L138 system
> It is under the machine name "omapl138_hawkboard".
> This system is based on the da850 davinci CPU architecture.

These 6 patches look good to me. Thanks for your work on this.

For all the 6 patches:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

>
> Victor Rodriguez (6):
>   davinci: EMAC support for Omapl138-Hawkboard
>   davinci: EDMA support for Omapl138-Hawkboard
>   davinci: MMC/SD and USB-OHCI configuration for Omapl138-Hawkboard
>   davinci: MMC/SD support for Omapl138-Hawkboard
>   davinci: USB clocks for Omapl138-Hawkboard
>   davinci: USB1.1 support for Omapl138-Hawkboard
>
>  arch/arm/mach-davinci/board-omapl138-hawk.c |  284 +++++++++++++++++++++++++++
>  arch/arm/mach-davinci/da850.c               |   20 ++
>  arch/arm/mach-davinci/include/mach/mux.h    |    4 +
>  3 files changed, 308 insertions(+), 0 deletions(-)
>
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>
