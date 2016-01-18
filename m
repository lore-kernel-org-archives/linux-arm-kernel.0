From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 18 Jan 2016 19:08:20 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix resume for cyclic transfers
In-Reply-To: <1453112084-4879-1-git-send-email-ludovic.desroches@atmel.com>
References: <1453112084-4879-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160118133820.GP11130@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 11:14:44AM +0100, Ludovic Desroches wrote:
> From: Songjun Wu <songjun.wu@atmel.com>
> 
> When having cyclic transfers, the channel was paused when performing
> suspend but was not correctly resumed.

Applied, thanks

-- 
~Vinod
