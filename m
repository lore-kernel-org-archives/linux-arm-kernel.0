From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 8 Oct 2012 16:27:20 +0530
Subject: [PATCH v4 0/7] uio_pruss cleanup and platform support
In-Reply-To: <1349456686-22736-1-git-send-email-mporter@ti.com>
References: <1349456686-22736-1-git-send-email-mporter@ti.com>
Message-ID: <5072B190.1060200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/5/2012 10:34 PM, Matt Porter wrote:

> This series enables uio_pruss on DA850 and removes use of the
> private SRAM API by the driver. The driver previously was not
> enabled by any platform and the private SRAM API was accessing
> an invalid SRAM bank.
> 
> It is regression tested on AM180x EVM with suspend/resume due
> to the new use of the shared SRAM for both PM and PRUSS. The
> uio_pruss driver is tested on the same platform using the
> PRU_memAccessPRUDataRam and PRU_memAccessL3andDDR examples from
> the PRU userspace tools available from http://www.ti.com/tool/sprc940

I applied patches 2/7, 3/7 and 6/7 of this series for v3.8. I have some
comments on the board patch. Rest of the patches depend on acceptance of
1/7 so I will take them only after that is accepted.

Thanks,
Sekhar
