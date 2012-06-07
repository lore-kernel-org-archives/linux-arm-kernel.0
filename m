From: svenkatr@ti.com (S, Venkatraman)
Date: Thu, 7 Jun 2012 23:23:43 +0530
Subject: [CFT 03/11] mmc: omap_hsmmc: remove private DMA API implementation
In-Reply-To: <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
Message-ID: <CANfBPZ-wWpwf_AoZV1jToFr=44FYPDtoOQCdd+Hzy03u53POeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 4:37 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested this on 4430SDP with rootfs usage, untarring the kernel source
and compiling it natively.

Tested-by: Venkatraman S <svenkatr@ti.com>

> ---
> ?drivers/mmc/host/omap_hsmmc.c | ?265 ++++++++++-------------------------------
> ?1 files changed, 64 insertions(+), 201 deletions(-)
>
