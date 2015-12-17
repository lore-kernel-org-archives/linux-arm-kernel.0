From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 17 Dec 2015 15:26:17 +0200
Subject: [PATCH v2 0/2] spi: davinci: fix spurious i/o error
In-Reply-To: <cover.1449764266.git.nsekhar@ti.com>
References: <cover.1449764266.git.nsekhar@ti.com>
Message-ID: <5672B7F9.4050803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2015 06:29 PM, Sekhar Nori wrote:
> This patch series fixes a spurious I/O error with
> DaVinci SPI.
>
> v2:
> - Update to handle DMA case
> - add a patch to use dev_err() for error reporting
>
> Sekhar Nori (2):
>    spi: davinci: fix spurious i/o error
>    spi: davinci: use dev_err() for error reporting
>
>   drivers/spi/spi-davinci.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>

Looks good:
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
