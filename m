From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 18 Aug 2015 22:12:51 +0530
Subject: [PATCH 0/4] PL08x DT bindings and LPC18xx DMA support
In-Reply-To: <1436616727-4847-1-git-send-email-manabian@gmail.com>
References: <1436616727-4847-1-git-send-email-manabian@gmail.com>
Message-ID: <20150818164251.GW13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 11, 2015 at 02:12:03PM +0200, Joachim Eastwood wrote:
> Hi Vinod,
> 
> This is the non-RFC version of the patch set with only a few changes.
> Hope this can go in for 4.3. Changes to the DT for LPC18xx/43xx will
> go thru arm-soc once this get accepted.
> 
> 
> This patch set aims to add support for DMA on the NXP LPC18xx/43xx
> (Cortex-M3/M4) platform. The platform has a PL080 controller with a
> mux in front of the DMA request lines. This setup is quite common
> and can be found on most other, if not all, NXP LPC devices.
> 
> Patch set adds DT support for the PL08x dmaengine driver and a DMA
> router driver for the LPC18xx/43xx DMA multiplexer.

Applied, thanks

-- 
~Vinod
