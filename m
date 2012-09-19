From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 15:26:33 +0000
Subject: [PATCH v2] of: dma: fix typos in generic dma binding definition
In-Reply-To: <1348066188-17937-1-git-send-email-mporter@ti.com>
References: <1348066188-17937-1-git-send-email-mporter@ti.com>
Message-ID: <201209191526.33642.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 September 2012, Matt Porter wrote:
> 
> Some semicolons were left out in the examples.
> 
> The #dma-channels and #dma-requests properties have a prefix
> that is, by convention, reserved for cell size properties.
> Rename those properties to dma-channels and dma-requests.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
