From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 2 Feb 2011 21:43:51 +0530
Subject: [PATCH v1 0/9] pruss mfd drivers
In-Reply-To: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302487783A6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 20:17:38, Subhasish Ghosh wrote:

>  arch/arm/mach-davinci/board-da850-evm.c     |   75 ++
>  arch/arm/mach-davinci/da850.c               |   12 +
>  arch/arm/mach-davinci/devices-da8xx.c       |   65 ++
>  arch/arm/mach-davinci/include/mach/da8xx.h  |    2 +
>  arch/arm/mach-davinci/include/mach/mux.h    |    5 +
>  drivers/mfd/Kconfig                         |   10 +
>  drivers/mfd/Makefile                        |    1 +
>  drivers/mfd/da8xx_pru.c                     |  403 +++++++++
>  drivers/net/can/Kconfig                     |    1 +
>  drivers/net/can/Makefile                    |    1 +
>  drivers/net/can/da8xx_pruss/Kconfig         |   73 ++
>  drivers/net/can/da8xx_pruss/Makefile        |    7 +
>  drivers/net/can/da8xx_pruss/pruss_can.c     |  759 +++++++++++++++++
>  drivers/net/can/da8xx_pruss/pruss_can_api.c | 1224 

The MFD and netdev lists need to be copied on this submission
as this cannot be merged without an ack from the maintainers
of those subsystems.

To automate copying the right folks on each patch, please use:

git-send-email --to <davinci list> --cc-cmd=scripts/get_maintainer.pl  [...]

Thanks,
Sekhar
