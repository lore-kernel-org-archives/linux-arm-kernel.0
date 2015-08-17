From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Aug 2015 13:56:46 +0530
Subject: [PATCH] dma: pxa_dma: don't use config direction parameter
In-Reply-To: <1439324192-9148-1-git-send-email-robert.jarzmik@free.fr>
References: <1439324192-9148-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150817082646.GO13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 10:16:32PM +0200, Robert Jarzmik wrote:
> From: Robert Jarzmik <rj@valbob.noip.me>
> 
> Don't use the direction passed in the configuration, and rely on each
> transfer's direction to prepare the transfers. This will enable
> future removal of direction parameter from dma_slave_config.

Applied now with right subsystem name

-- 
~Vinod
