From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Jan 2013 21:26:34 +0530
Subject: [PATCH v5 00/14] DMA Engine support for AM33XX
In-Reply-To: <1358281974-8411-1-git-send-email-mporter@ti.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
Message-ID: <50FEB6B2.5020303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 1/16/2013 2:02 AM, Matt Porter wrote:

> This series adds DMA Engine support for AM33xx, which uses
> an EDMA DMAC. The EDMA DMAC has been previously supported by only
> a private API implementation (much like the situation with OMAP
> DMA) found on the DaVinci family of SoCs.

Will you take this series through the OMAP tree? Only 1/14 touches
mach-davinci and I am mostly okay with it except some changes I just
requested Matt to make in another thread.

Thanks,
Sekhar
