From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 30 Jul 2018 11:53:31 +0300
Subject: [PATCH v2 0/3] add support to non-uniform SFDP SPI NOR flash
 memories
In-Reply-To: <20180712173235.7901-1-tudor.ambarus@microchip.com>
References: <20180712173235.7901-1-tudor.ambarus@microchip.com>
Message-ID: <1a3a29a7-abdd-cfb4-b955-48dad6417cca@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a side note, the SFDP code increases its size, it would make sense to move
all SFDP logic into a spi-nor-sfdp.c file. I'm volunteering to do this after
this patch set gets applied.

Best,
ta
